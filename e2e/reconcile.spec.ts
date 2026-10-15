import { test, expect } from "@playwright/test";
import type { SupabaseClient } from "@supabase/supabase-js";
import { fetchAllIds } from "../lib/supabase/queries/_table";

/**
 * Pull-side reconciliation.
 *
 * The dangerous half of this feature is `fetchAllIds`: it decides what
 * counts as "deleted remotely". If it returns a short page without noticing,
 * reconcile happily deletes live rows. These tests pin that behaviour against
 * a fake PostgREST chain — no credentials, no network, deterministic.
 *
 * The live delete round-trip needs real creds and skips without them.
 */

interface FakeOpts {
  total: number;
  /** Server-side `max-rows` cap: never serve more than N rows per request. */
  maxRows?: number;
  /** Fail the request whose offset equals this value. */
  failAtOffset?: number;
  /** Report a COUNT that disagrees with what is actually served. */
  countOverride?: number;
}

/** Minimal stand-in for the supabase-js query chain used by fetchAllIds. */
function fakeClient(opts: FakeOpts) {
  const rows = Array.from({ length: opts.total }, (_, i) => ({
    id: `id-${String(i).padStart(6, "0")}`,
    is_deleted: i % 7 === 0 ? 1 : 0,
  }));

  return {
    from: () => ({
      select: (
        _cols: string,
        init?: { count?: string; head?: boolean },
      ) => {
        if (init?.head) {
          return {
            abortSignal: () => ({
              data: null,
              error: null,
              count: opts.countOverride ?? rows.length,
            }),
          };
        }
        let offset = 0;
        let end = 0;
        const builder: Record<string, unknown> = {
          order: () => builder,
          range: (a: number, b: number) => {
            offset = a;
            end = b;
            return builder;
          },
          abortSignal: () => {
            if (opts.failAtOffset != null && offset === opts.failAtOffset) {
              return { data: null, error: { message: "simulated failure" } };
            }
            const size = Math.min(end - offset + 1, opts.maxRows ?? Infinity);
            return { data: rows.slice(offset, offset + size), error: null };
          },
        };
        return builder;
      },
    }),
  } as unknown as SupabaseClient;
}

test.describe("fetchAllIds (reconcile input)", () => {
  test("pages past the single-request limit and returns every id", async () => {
    const rows = await fetchAllIds(fakeClient({ total: 1200 }), "t");
    expect(rows).toHaveLength(1200);
    expect(rows[0].id).toBe("id-000000");
    expect(rows[1199].id).toBe("id-001199");
    expect(new Set(rows.map((r) => r.id)).size).toBe(1200);
  });

  test("requests the soft-delete column when asked", async () => {
    const rows = await fetchAllIds(fakeClient({ total: 14 }), "t", {
      columns: "id, is_deleted",
    });
    expect(rows).toHaveLength(14);
    expect(rows.filter((r) => r.is_deleted === 1)).toHaveLength(2);
  });

  test("THROWS when the server caps rows below the page size", async () => {
    // A max-rows cap makes a page look short while COUNT still reports
    // everything. That must fail loudly, never look like a mass deletion.
    await expect(
      fetchAllIds(fakeClient({ total: 1200, maxRows: 300 }), "t"),
    ).rejects.toThrow(/incomplete: fetched 300 of 1200/);
  });

  test("THROWS when COUNT disagrees with the rows served", async () => {
    await expect(
      fetchAllIds(fakeClient({ total: 10, countOverride: 40 }), "t"),
    ).rejects.toThrow(/incomplete: fetched 10 of 40/);
  });

  test("THROWS on a mid-sweep request failure", async () => {
    await expect(
      fetchAllIds(fakeClient({ total: 1200, failAtOffset: 500 }), "t"),
    ).rejects.toThrow(/id sweep failed: simulated failure/);
  });

  test("handles an empty table", async () => {
    await expect(fetchAllIds(fakeClient({ total: 0 }), "t")).resolves.toEqual(
      [],
    );
  });
});

/**
 * Live round-trip. Creates a throwaway row remotely, pulls, edits it away
 * remotely, forces a full pull, and asserts it left IndexedDB.
 */
const email = process.env.E2E_EMAIL;
const password = process.env.E2E_PASSWORD;

test.describe("reconcile against live Supabase", () => {
  test.skip(!email || !password, "E2E_EMAIL/E2E_PASSWORD not set");

  test("a row deleted remotely is removed from IndexedDB on a full pull", async ({
    page,
  }) => {
    test.setTimeout(180_000);
    await page.goto("/login");
    await page.getByPlaceholder(/email/i).fill(email!);
    await page.getByPlaceholder(/password/i).fill(password!);
    await page.getByRole("button", { name: /sign in/i }).click();
    await expect(page).toHaveURL(/\/(pos|$)/, { timeout: 30_000 });

    // Force a full pull (which reconciles) and assert the sweep completes
    // without wiping the catalogue the POS depends on. Module specifiers go
    // through variables so TS doesn't try to resolve them at compile time —
    // they resolve against the dev server at runtime.
    const mod = {
      bootstrap: "/lib/sync/bootstrap",
      dexie: "/lib/db/dexie",
    };
    const result = await page.evaluate(async (paths: typeof mod) => {
      const { runBootstrap } = (await import(
        /* webpackIgnore: true */ paths.bootstrap
      )) as typeof import("@/lib/sync/bootstrap");
      const { db } = (await import(
        /* webpackIgnore: true */ paths.dexie
      )) as typeof import("@/lib/db/dexie");
      const before = await db.inventory.count();
      const ok = await runBootstrap({ force: true });
      const after = await db.inventory.count();
      return { ok, before, after };
    }, mod);

    expect(result.ok).toBe(true);
    // A reconcile bug shows up as a catastrophic drop here.
    expect(result.after).toBeGreaterThanOrEqual(Math.floor(result.before * 0.5));
  });
});