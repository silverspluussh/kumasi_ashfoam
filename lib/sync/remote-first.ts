import type { SupabaseClient } from "@supabase/supabase-js";
import { db } from "@/lib/db/dexie";
import { markClean } from "@/lib/db/mappers";
import { withDataBusSuppressed } from "@/lib/db/data-bus";
import { createClient } from "@/lib/supabase/browser";
import { fetchBranches } from "@/lib/supabase/queries/org";
import {
  fetchBrands,
  fetchCategories,
  fetchSubcategories,
} from "@/lib/supabase/queries/catalog";
import { fetchInventory } from "@/lib/supabase/queries/inventory";
import {
  fetchInvoiceItems,
  fetchInvoices,
  fetchSaleOrderItems,
  fetchSaleOrders,
} from "@/lib/supabase/queries/sales";
import {
  fetchProformaItems,
  fetchProformas,
  fetchWaybillItems,
  fetchWaybills,
} from "@/lib/supabase/queries/docs";
import { fetchBranchPayments } from "@/lib/supabase/queries/money";
import { fetchStockReports } from "@/lib/supabase/queries/logistics";

/**
 * Remote-first reads. Ported from remote_first.dart: SELECT remote
 * (8s timeout via queries) → upsert clean rows, skipping dirty locals
 * (_isSynced==0) → callers then read Dexie. Never throws.
 */
async function warm<T extends { id: string }>(
  store: string,
  rows: T[],
): Promise<void> {
  if (rows.length === 0) return;
  try {
    const ids = rows.map((r) => r.id);
    const existing = (await db
      .table(store)
      .where("id")
      .anyOf(ids)
      .toArray()) as (T & { _isSynced?: number })[];
    const dirty = new Set(
      existing.filter((e) => e._isSynced === 0).map((e) => e.id),
    );
    await withDataBusSuppressed(() =>
      db
        .table(store)
        .bulkPut(rows.filter((r) => !dirty.has(r.id)).map((r) => markClean(r))),
    );
  } catch {
    /* Dexie unavailable — caller still reads local */
  }
}

async function tryWarm(fn: () => Promise<void>) {
  try {
    await fn();
  } catch {
    /* remote failed — local data stands */
  }
}

export const remoteFirst = {
  warmInventory: (c: SupabaseClient) =>
    tryWarm(async () => warm("inventory", await fetchInventory(c, { limit: 2000 }))),
  warmSaleOrders: (c: SupabaseClient) =>
    tryWarm(async () => {
      const orders = await fetchSaleOrders(c, { limit: 500 });
      await warm("saleOrders", orders);
      for (const o of orders.slice(0, 50)) {
        await tryWarm(async () =>
          warm(
            "saleOrderItems",
            await fetchSaleOrderItems(c, (o as { id: string }).id),
          ),
        );
      }
    }),
  warmProformas: (c: SupabaseClient) =>
    tryWarm(async () => {
      const docs = await fetchProformas(c, { limit: 500 });
      await warm("proformas", docs);
      for (const d of docs.slice(0, 50)) {
        await tryWarm(async () =>
          warm(
            "proformaItems",
            await fetchProformaItems(c, (d as { id: string }).id),
          ),
        );
      }
    }),
  warmWaybills: (c: SupabaseClient) =>
    tryWarm(async () => {
      const docs = await fetchWaybills(c, { limit: 500 });
      await warm("waybills", docs);
      for (const d of docs.slice(0, 50)) {
        await tryWarm(async () =>
          warm(
            "waybillItems",
            await fetchWaybillItems(c, (d as { id: string }).id),
          ),
        );
      }
    }),
  warmBranchPayments: (c: SupabaseClient) =>
    tryWarm(async () => warm("branchPayments", await fetchBranchPayments(c, { limit: 500 }))),
  warmInvoices: (c: SupabaseClient) =>
    tryWarm(async () => {
      const invs = await fetchInvoices(c, { limit: 500 });
      await warm("invoices", invs);
      for (const i of invs.slice(0, 50)) {
        await tryWarm(async () =>
          warm("invoiceItems", await fetchInvoiceItems(c, (i as { id: string }).id)),
        );
      }
    }),
  warmBrands: (c: SupabaseClient) =>
    tryWarm(async () => warm("brands", await fetchBrands(c, { limit: 1000 }))),
  warmCategories: (c: SupabaseClient) =>
    tryWarm(async () => warm("categories", await fetchCategories(c, { limit: 1000 }))),
  warmSubcategories: (c: SupabaseClient) =>
    tryWarm(async () => warm("subcategories", await fetchSubcategories(c, { limit: 2000 }))),
  warmBranches: (c: SupabaseClient) =>
    tryWarm(async () => warm("branches", await fetchBranches(c, { limit: 1000 }))),
  warmStockReports: (c: SupabaseClient) =>
    tryWarm(async () => {
      const rows = await fetchStockReports(c, { limit: 200 });
      // Remote shape is minimal {branch_id, report_date, data} — normalize
      // to the rich Dexie shape so dates/names render.
      await warm(
        "stockReports",
        rows.map((r) => ({
          ...r,
          createdAt:
            (r as { createdAt?: string }).createdAt ?? r.report_date ?? null,
          branchName:
            (r as { branchName?: string }).branchName ??
            r.data?.branchName ??
            null,
        })),
      );
    }),
};

/** Convenience: warm everything (used sparingly — per-screen warms land in P2). */
export async function warmAll() {
  const c = createClient();
  await Promise.all([
    remoteFirst.warmInventory(c),
    remoteFirst.warmBrands(c),
    remoteFirst.warmCategories(c),
    remoteFirst.warmSubcategories(c),
    remoteFirst.warmBranches(c),
  ]);
}
