import type { SupabaseClient } from "@supabase/supabase-js";
import { db } from "@/lib/db/dexie";
import { cursors } from "@/lib/db/cursors";
import { stockReportToRemote, stripClientFields } from "@/lib/db/mappers";
import { createClient } from "@/lib/supabase/browser";
import { bulkUploadInventory } from "@/lib/supabase/queries/inventory";
import {
  bulkUploadSaleOrders,
  bulkUploadSaleOrderItems,
  bulkUploadInvoices,
  bulkUploadInvoiceItems,
} from "@/lib/supabase/queries/sales";
import {
  bulkUploadProformas,
  bulkUploadProformaItems,
  bulkUploadWaybills,
  bulkUploadWaybillItems,
} from "@/lib/supabase/queries/docs";
import {
  bulkUploadReceipts,
  bulkUploadPayments,
  bulkUploadBranchPayments,
  bulkUploadExpenses,
} from "@/lib/supabase/queries/money";
import {
  bulkUploadReturnOrders,
  bulkUploadReturnOrderItems,
  bulkUploadCreditNotes,
  bulkUploadCreditNoteItems,
} from "@/lib/supabase/queries/adjustments";
import {
  bulkUploadStockTransfers,
  bulkUploadStockTransferItems,
  bulkUploadStockReports,
} from "@/lib/supabase/queries/logistics";
import {
  bulkUploadBrands,
  bulkUploadCategories,
} from "@/lib/supabase/queries/catalog";
import { bulkUploadSupplierPayments } from "@/lib/supabase/queries/partners";

/**
 * Upload queue (up). Ported from UploadSyncService:
 * queue = _isSynced==0 rows; marked clean ONLY after a successful upsert;
 * FK-safe order; 3 tries with 1s/2s/4s backoff. Children ride with dirty
 * parents. Brands/categories push all rows idempotently (no sync flag).
 * Extends Flutter by also draining receipts/payments/expenses/
 * supplierPayments/returns/creditNotes/transfers (Flutter gap, §4.1).
 */

export const QUEUED_ENTITIES = [
  "saleOrders",
  "returnOrders",
  "inventory",
  "proformas",
  "waybills",
  "invoices",
  "receipts",
  "payments",
  "branchPayments",
  "expenses",
  "supplierPayments",
  "creditNotes",
  "stockTransfers",
  "stockReports",
] as const;

export type QueuedEntity = (typeof QUEUED_ENTITIES)[number];

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

/** IndexedDB quota/eviction — surfaced verbatim so the UI can react. */
function quotaHint(e: unknown): string {
  const msg = e instanceof Error ? e.message : String(e);
  if (
    e instanceof DOMException &&
    (e.name === "QuotaExceededError" || e.name === "NS_ERROR_DOM_QUOTA_REACHED")
  ) {
    return `Local storage is full — free space or clear offline data. ${msg}`;
  }
  return msg;
}

async function withRetry(
  label: string,
  errors: Record<string, string[]>,
  fn: () => Promise<void>,
) {
  const delays = [1000, 2000, 4000];
  for (let attempt = 0; attempt < 3; attempt++) {
    try {
      await fn();
      return;
    } catch (e) {
      if (attempt === 2) {
        (errors[label] ??= []).push(quotaHint(e));
      } else {
        await sleep(delays[attempt]);
      }
    }
  }
}

type Row = Record<string, unknown> & { id: string };

async function dirty(table: string): Promise<Row[]> {
  return (await db.table(table).where("_isSynced").equals(0).toArray()) as Row[];
}

async function markCleanIds(
  table: string,
  ids: string[],
  serverFlag?: Record<string, unknown>,
) {
  if (ids.length === 0) return;
  const now = new Date().toISOString();
  await db.table(table).where("id").anyOf(ids).modify({
    _isSynced: 1,
    _lastSyncedAt: now,
    ...serverFlag,
  });
}

async function childrenOf(
  childTable: string,
  fk: string,
  parentIds: string[],
): Promise<Row[]> {
  if (parentIds.length === 0) return [];
  return (await db
    .table(childTable)
    .where(fk)
    .anyOf(parentIds)
    .toArray()) as Row[];
}

const prep = (rows: Row[]) => rows.map(stripClientFields);

export async function getPendingUploadCounts(): Promise<
  Record<QueuedEntity, number>
> {
  const entries = await Promise.all(
    QUEUED_ENTITIES.map(async (e) => {
      const n = await db.table(e).where("_isSynced").equals(0).count();
      return [e, n] as const;
    }),
  );
  return Object.fromEntries(entries) as Record<QueuedEntity, number>;
}

export function totalPending(counts: Record<string, number>): number {
  return Object.values(counts).reduce((a, b) => a + b, 0);
}

export interface UploadProgress {
  currentStep: string | null;
  done: number;
  total: number;
}

/**
 * Drain the whole queue. Resolves with per-entity error lists (empty = ok).
 * Persists errors + lastUploadAt via cursors (SyncMetadataService).
 */
export async function uploadAllUnsynced(opts?: {
  supabase?: SupabaseClient;
  onProgress?: (p: UploadProgress) => void;
}): Promise<Record<string, string[]>> {
  // Single-flight lock: Sync Now + AutoSync must never double-drain.
  if (inFlight) return inFlight;
  inFlight = drainAllUnsynced(opts).finally(() => {
    inFlight = null;
  });
  return inFlight;
}

let inFlight: Promise<Record<string, string[]>> | null = null;

async function drainAllUnsynced(opts?: {
  supabase?: SupabaseClient;
  onProgress?: (p: UploadProgress) => void;
}): Promise<Record<string, string[]>> {
  const supabase = opts?.supabase ?? createClient();
  const errors: Record<string, string[]> = {};
  const steps: string[] = [...QUEUED_ENTITIES, "brands", "categories"];
  let done = 0;
  const tick = (currentStep: string | null) => {
    done += 1;
    opts?.onProgress?.({ currentStep, done, total: steps.length });
  };

  // 1. sale orders + items (server flag SMALLINT).
  // MUST drain BEFORE inventory: the items INSERT fires the server stock
  // trigger (decrement); the inventory push (step 3) then overwrites with
  // the absolute quantity, which already includes that decrement. The old
  // order (inventory first) double-decremented offline sales.
  await withRetry("saleOrders", errors, async () => {
    const rows = await dirty("saleOrders");
    if (rows.length === 0) return;
    const now = new Date().toISOString();
    await bulkUploadSaleOrders(
      supabase,
      prep(rows).map((r) => ({ ...r, isSynced: 1, lastSyncedAt: now })),
    );
    const items = await childrenOf(
      "saleOrderItems",
      "saleOrderId",
      rows.map((r) => r.id),
    );
    if (items.length > 0) {
      await bulkUploadSaleOrderItems(
        supabase,
        prep(items).map((r) => ({ ...r, isSynced: 1, lastSyncedAt: now })),
      );
      await markCleanIds(
        "saleOrderItems",
        items.map((r) => r.id),
        { isSynced: 1, lastSyncedAt: now },
      );
    }
    await markCleanIds(
      "saleOrders",
      rows.map((r) => r.id),
      { isSynced: 1, lastSyncedAt: now },
    );
  });
  tick("saleOrders");

  // 2. return orders + items — trigger INCREMENTS stock on items INSERT;
  // also must precede the absolute inventory push.
  await withRetry("returnOrders", errors, async () => {
    const rows = await dirty("returnOrders");
    if (rows.length === 0) return;
    await bulkUploadReturnOrders(supabase, prep(rows));
    const items = await childrenOf(
      "returnOrderItems",
      "return_order_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0)
      await bulkUploadReturnOrderItems(supabase, prep(items));
    await markCleanIds(
      "returnOrders",
      rows.map((r) => r.id),
    );
  });
  tick("returnOrders");

  // 3. inventory (absolute push — after all stock-carrying children).
  await withRetry("inventory", errors, async () => {
    const rows = await dirty("inventory");
    if (rows.length === 0) return;
    await bulkUploadInventory(
      supabase,
      prep(rows).map((r) => ({
        ...r,
        isSynced: true,
        lastSyncedAt: new Date().toISOString(),
      })),
    );
    await markCleanIds(
      "inventory",
      rows.map((r) => r.id),
      { isSynced: true, lastSyncedAt: new Date().toISOString() },
    );
  });
  tick("inventory");

  // 3. proformas + items
  await withRetry("proformas", errors, async () => {
    const rows = await dirty("proformas");
    if (rows.length === 0) return;
    await bulkUploadProformas(supabase, prep(rows));
    const items = await childrenOf(
      "proformaItems",
      "proforma_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0)
      await bulkUploadProformaItems(supabase, prep(items));
    await markCleanIds(
      "proformas",
      rows.map((r) => r.id),
    );
  });
  tick("proformas");

  // 4. waybills + items
  await withRetry("waybills", errors, async () => {
    const rows = await dirty("waybills");
    if (rows.length === 0) return;
    await bulkUploadWaybills(supabase, prep(rows));
    const items = await childrenOf(
      "waybillItems",
      "waybill_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0) await bulkUploadWaybillItems(supabase, prep(items));
    await markCleanIds(
      "waybills",
      rows.map((r) => r.id),
    );
  });
  tick("waybills");

  // 5. invoices + items (strip POS-only local fields before upload)
  const INVOICE_LOCAL_ONLY = new Set([
    "saleOrderId",
    "paidAmount",
    "dueDate",
    "branchId",
    "branchName",
  ]);
  await withRetry("invoices", errors, async () => {
    const rows = await dirty("invoices");
    if (rows.length === 0) return;
    const remote = prep(rows).map((r) => {
      const c = { ...r };
      for (const k of INVOICE_LOCAL_ONLY) delete c[k];
      return c;
    });
    await bulkUploadInvoices(supabase, remote);
    const items = await childrenOf(
      "invoiceItems",
      "invoice_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0) await bulkUploadInvoiceItems(supabase, prep(items));
    await markCleanIds(
      "invoices",
      rows.map((r) => r.id),
    );
  });
  tick("invoices");

  // 6-10. single-table money entities
  const singles: [QueuedEntity, (c: SupabaseClient, r: Row[]) => Promise<unknown>][] = [
    ["receipts", (c, r) => bulkUploadReceipts(c, prep(r))],
    ["payments", (c, r) => bulkUploadPayments(c, prep(r))],
    ["branchPayments", (c, r) => bulkUploadBranchPayments(c, prep(r))],
    ["expenses", (c, r) => bulkUploadExpenses(c, prep(r))],
    ["supplierPayments", (c, r) => bulkUploadSupplierPayments(c, prep(r))],
  ];
  for (const [entity, fn] of singles) {
    await withRetry(entity, errors, async () => {
      const rows = await dirty(entity);
      if (rows.length === 0) return;
      await fn(supabase, rows);
      await markCleanIds(entity, rows.map((r) => r.id));
    });
    tick(entity);
  }

  // 11. (moved to step 2 — return orders drain before the inventory push)

  // 12. credit notes + items
  await withRetry("creditNotes", errors, async () => {
    const rows = await dirty("creditNotes");
    if (rows.length === 0) return;
    await bulkUploadCreditNotes(supabase, prep(rows));
    const items = await childrenOf(
      "creditNoteItems",
      "credit_note_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0)
      await bulkUploadCreditNoteItems(supabase, prep(items));
    await markCleanIds(
      "creditNotes",
      rows.map((r) => r.id),
    );
  });
  tick("creditNotes");

  // 13. stock transfers + items
  await withRetry("stockTransfers", errors, async () => {
    const rows = await dirty("stockTransfers");
    if (rows.length === 0) return;
    await bulkUploadStockTransfers(supabase, prep(rows));
    const items = await childrenOf(
      "stockTransferItems",
      "stock_transfer_id",
      rows.map((r) => r.id),
    );
    if (items.length > 0)
      await bulkUploadStockTransferItems(supabase, prep(items));
    await markCleanIds(
      "stockTransfers",
      rows.map((r) => r.id),
    );
  });
  tick("stockTransfers");

  // 14. stock reports (minimal remote shape)
  await withRetry("stockReports", errors, async () => {
    const rows = (await dirty("stockReports")) as Row[];
    if (rows.length === 0) return;
    await bulkUploadStockReports(
      supabase,
      rows.map((r) =>
        stockReportToRemote(r as unknown as Parameters<typeof stockReportToRemote>[0]),
      ),
    );
    await markCleanIds(
      "stockReports",
      rows.map((r) => r.id),
    );
  });
  tick("stockReports");

  // 15-16. brands + categories push-all (no sync flag — idempotent)
  await withRetry("brands", errors, async () => {
    const rows = (await db.table("brands").toArray()) as Row[];
    if (rows.length === 0) return;
    await bulkUploadBrands(supabase, prep(rows));
  });
  tick("brands");
  await withRetry("categories", errors, async () => {
    const rows = (await db.table("categories").toArray()) as Row[];
    if (rows.length === 0) return;
    await bulkUploadCategories(supabase, prep(rows));
  });
  tick("categories");
  opts?.onProgress?.({ currentStep: null, done: steps.length, total: steps.length });

  if (Object.keys(errors).length === 0) cursors.clearUploadErrors();
  else cursors.setUploadErrors(errors);
  cursors.lastUploadAt = new Date().toISOString();
  return errors;
}
