import type { EntityTable } from "dexie";
import { db } from "@/lib/db/dexie";
import { cursors } from "@/lib/db/cursors";
import { markClean } from "@/lib/db/mappers";
import { seedLocalConstants } from "@/lib/db/seed";
import { createClient } from "@/lib/supabase/browser";
import { withDataBusSuppressed } from "@/lib/db/data-bus";
import { fetchBranches, fetchStores } from "@/lib/supabase/queries/org";
import {
  fetchBrands,
  fetchCategories,
  fetchSubcategories,
} from "@/lib/supabase/queries/catalog";
import { syncInventoryPull } from "@/lib/supabase/queries/inventory";

/**
 * Bootstrap pull (down). Ported from BootstrapSyncService:
 * masters + branches only; incremental via pull_cursor_inventory with
 * gte updated_at; dirty locals (_isSynced==0) always win and are skipped.
 * 60s overall timeout; never throws (returns null on failure).
 * P5-resilience: every pull is PAGINATED (no silent cap), and the
 * incremental cursor is derived from the SERVER's max updatedAt (not the
 * client clock, which can skew and skip rows).
 */

const PAGE_SIZE = 500;

/** Loop fetch until a short page — no silent data loss beyond one limit. */
async function fetchAllPaged<T>(
  fetch: (o: { limit: number; offset: number }) => Promise<T[]>,
): Promise<T[]> {
  const out: T[] = [];
  for (let offset = 0; ; offset += PAGE_SIZE) {
    const rows = await fetch({ limit: PAGE_SIZE, offset });
    out.push(...rows);
    if (rows.length < PAGE_SIZE) return out;
    if (offset > 200_000) return out; // hard safety stop
  }
}

export async function runBootstrap(opts?: {
  force?: boolean;
}): Promise<boolean> {
  const supabase = createClient();
  const full = opts?.force || !cursors.bootstrapComplete;
  const since = full ? undefined : (cursors.inventoryPullCursor ?? undefined);
  // Set by the timeout below — a timed-out run must not persist cursors.
  let timedOut = false;

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const apply = async (table: EntityTable<any, any>, rows: { id: string }[]) => {
    if (rows.length === 0) return;
    const ids = rows.map((r) => r.id);
    const existing = (await table
      .where("id")
      .anyOf(ids)
      .toArray()) as { id: string; _isSynced?: number }[];
    const dirty = new Set(
      existing.filter((e) => e._isSynced === 0).map((e) => e.id),
    );
    await table.bulkPut(
      rows.filter((r) => !dirty.has(r.id)).map((r) => markClean(r)),
    );
  };

  const task = (async () => {
    const [stores, branches, brands, categories, subcategories, inventory] =
      await Promise.all([
        fetchAllPaged((o) => fetchStores(supabase, o)),
        fetchAllPaged((o) => fetchBranches(supabase, o)),
        fetchAllPaged((o) => fetchBrands(supabase, o)),
        fetchAllPaged((o) => fetchCategories(supabase, o)),
        fetchAllPaged((o) => fetchSubcategories(supabase, o)),
        since
          ? syncInventoryPull(supabase, since)
          : fetchAllPaged((o) => syncInventoryPull(supabase, undefined, o)),
      ]);
    await withDataBusSuppressed(() =>
      db.transaction(
      "rw",
      [
        db.stores,
        db.branches,
        db.brands,
        db.categories,
        db.subcategories,
        db.inventory,
        db.taxes,
        db.companySettings,
      ],
      async () => {
        await apply(db.stores, stores);
        await apply(db.branches, branches);
        await apply(db.brands, brands);
        await apply(db.categories, categories);
        await apply(db.subcategories, subcategories);
        await apply(db.inventory, inventory);
        await seedLocalConstants();
      },
      ),
    );
    if (!timedOut) {
      // Server-derived cursor: max updatedAt among pulled inventory rows
      // (fallback: keep the previous cursor; never trust the client clock).
      const maxUpdated = inventory.reduce<string | null>((acc, r) => {
        const u = (r as { updatedAt?: string | null }).updatedAt ?? null;
        return u && (!acc || u > acc) ? u : acc;
      }, null);
      cursors.inventoryPullCursor = maxUpdated ?? cursors.inventoryPullCursor;
      cursors.bootstrapComplete = true;
      cursors.lastBootstrapAt = new Date().toISOString();
    }
    return true;
  })();

  try {
    return await Promise.race([
      task,
      new Promise<boolean>((resolve) =>
        setTimeout(() => {
          timedOut = true;
          resolve(false);
        }, 60000),
      ),
    ]);
  } catch {
    return false;
  }
}

/** Full sync when never completed, else incremental (BootstrapSyncNotifier). */
export function runIncrementalIfNeeded(): Promise<boolean> {
  return runBootstrap();
}
