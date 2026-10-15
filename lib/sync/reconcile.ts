import type { SupabaseClient } from "@supabase/supabase-js";
import { db } from "@/lib/db/dexie";
import { withDataBusSuppressed } from "@/lib/db/data-bus";
import { fetchAllIds } from "@/lib/supabase/queries/_table";

/**
 * Pull-side reconciliation: after a FULL remote pull, delete local rows that
 * no longer exist remotely (or that were soft-deleted remotely), so a record
 * deleted on another device disappears here instead of lingering forever.
 *
 * This is deliberately NOT wired into lib/sync/remote-first.ts. Those warms
 * are capped (`warmInventory` takes 2000, orders 500, children of the first
 * 50 parents only) and are driven for screen freshness — "delete what isn't
 * in the result" against them would destroy live rows. Reconciliation only
 * runs from a full, exhaustively-paged pull (see lib/sync/bootstrap.ts).
 *
 * Every failure mode here is a stale row, never lost data:
 * - a table whose id sweep errors or comes back short is SKIPPED entirely;
 * - `_isSynced === 0` rows (queued for upload, not yet on the server) are
 *   never candidates for deletion;
 * - a fetch returning far fewer rows than we hold locally trips a ratio
 *   guard and is skipped.
 */

export interface ReconcileSpec {
  /** Dexie store name. */
  store: string;
  /** PostgREST table. */
  remote: string;
  /** Soft-delete column, when the table has one. */
  softDelete?: "is_deleted" | "isDeleted";
  /** Child stores keyed to this parent, deleted with it. */
  children?: readonly { store: string; fk: string }[];
}

/**
 * Only tables that a sync path actually pulls in full. Deliberately absent:
 * receipts, payments, supplierPayments, returnOrders, creditNotes and
 * stockTransfers are pushed on upload but NEVER pulled — reconciling them
 * would delete 100% of local rows. Nor taxes / companySettings /
 * stockAdjustments / suppliers / customers / employees, which have no remote
 * counterpart in the sync layer.
 */
export const RECONCILE_SPECS: readonly ReconcileSpec[] = [
  { store: "stores", remote: "ashfoam_stores" },
  { store: "branches", remote: "ashfoam_branches", softDelete: "is_deleted" },
  { store: "brands", remote: "ashfoam_product_brands" },
  { store: "categories", remote: "ashfoam_product_categories" },
  { store: "subcategories", remote: "ashfoam_product_subcategories" },
  { store: "inventory", remote: "ashfoam_inventory", softDelete: "isDeleted" },
  {
    store: "saleOrders",
    remote: "ashfoam_sale_orders",
    children: [{ store: "saleOrderItems", fk: "saleOrderId" }],
  },
  {
    store: "invoices",
    remote: "ashfoam_invoices",
    children: [{ store: "invoiceItems", fk: "invoice_id" }],
  },
  {
    store: "proformas",
    remote: "ashfoam_proformas",
    softDelete: "is_deleted",
    children: [{ store: "proformaItems", fk: "proforma_id" }],
  },
  {
    store: "waybills",
    remote: "ashfoam_waybills",
    softDelete: "isDeleted",
    children: [{ store: "waybillItems", fk: "waybill_id" }],
  },
  { store: "expenses", remote: "ashfoam_expenses" },
  { store: "branchPayments", remote: "ashfoam_branch_payments" },
  { store: "stockReports", remote: "ashfoam_stock_reports" },
];

/** Below this many local clean rows the ratio guard stays out of the way. */
const RATIO_GUARD_MIN_LOCAL = 20;
/** Remote must hold at least this share of our local clean rows. */
const RATIO_GUARD_MIN_REMOTE = 0.5;

export interface ReconcileResult {
  deleted: Record<string, number>;
  skipped: { store: string; reason: string }[];
}

interface DeleteBatch {
  table: string;
  ids: string[];
}

type SpecPlan =
  | { ok: true; batches: DeleteBatch[] }
  | { ok: false; reason: string };

const message = (e: unknown) => (e instanceof Error ? e.message : String(e));

async function planSpec(
  client: SupabaseClient,
  spec: ReconcileSpec,
): Promise<SpecPlan> {
  const columns = spec.softDelete ? `id, ${spec.softDelete}` : "id";
  const remote = await fetchAllIds(client, spec.remote, { columns });

  const remoteIds = new Set<string>();
  const softDeleted = new Set<string>();
  for (const row of remote) {
    const id = String(row.id);
    remoteIds.add(id);
    if (spec.softDelete && row[spec.softDelete]) softDeleted.add(id);
  }

  const local = (await db.table(spec.store).toArray()) as Record<
    string,
    unknown
  >[];
  // Pending uploads exist only here — never candidates for deletion.
  const clean = local.filter((r) => r._isSynced !== 0);

  if (
    clean.length >= RATIO_GUARD_MIN_LOCAL &&
    remoteIds.size < clean.length * RATIO_GUARD_MIN_REMOTE
  ) {
    return {
      ok: false,
      reason: `remote holds ${remoteIds.size} of ${clean.length} local clean rows (< ${RATIO_GUARD_MIN_REMOTE * 100}%)`,
    };
  }

  const doomed = clean
    .map((r) => String(r.id))
    .filter((id) => !remoteIds.has(id) || softDeleted.has(id));

  // Children first, so nothing is ever orphaned by ordering.
  const batches: DeleteBatch[] = [];
  for (const child of spec.children ?? []) {
    if (doomed.length === 0) continue;
    const rows = (await db
      .table(child.store)
      .where(child.fk)
      .anyOf(doomed)
      .toArray()) as Record<string, unknown>[];
    const ids = rows.map((r) => String(r.id));
    if (ids.length > 0) batches.push({ table: child.store, ids });
  }
  if (doomed.length > 0) batches.push({ table: spec.store, ids: doomed });

  return { ok: true, batches };
}

/**
 * Reconcile every spec in one transaction. Best-effort per table: a failure
 * removes that table from the run and leaves the rest to complete.
 */
export async function reconcileAll(
  client: SupabaseClient,
  specs: readonly ReconcileSpec[] = RECONCILE_SPECS,
): Promise<ReconcileResult> {
  const skipped: ReconcileResult["skipped"] = [];
  const batches: DeleteBatch[] = [];

  for (const spec of specs) {
    try {
      const plan = await planSpec(client, spec);
      if (plan.ok) batches.push(...plan.batches);
      else skipped.push({ store: spec.store, reason: plan.reason });
    } catch (e) {
      skipped.push({ store: spec.store, reason: message(e) });
    }
  }

  const deleted: Record<string, number> = {};
  if (batches.length === 0) return { deleted, skipped };

  const tables = [...new Set(batches.map((b) => b.table))]
    .map((name) => db.tables.find((t) => t.name === name))
    .filter((t): t is NonNullable<typeof t> => Boolean(t));

  // One transaction: a run can never leave half the deletions applied.
  await withDataBusSuppressed(() =>
    db.transaction("rw", tables, async () => {
      for (const batch of batches) {
        await db.table(batch.table).bulkDelete(batch.ids);
      }
    }),
  );

  for (const batch of batches) {
    deleted[batch.table] = (deleted[batch.table] ?? 0) + batch.ids.length;
  }
  return { deleted, skipped };
}