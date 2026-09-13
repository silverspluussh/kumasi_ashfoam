import type { ClientSync, StockReportRow, SyncFlag } from "./types";

const nowIso = () => new Date().toISOString();

/** Stamp a record dirty (offline write) or clean (after remote upsert). */
export function withSync<T extends object>(
  record: T,
  flag: SyncFlag,
): T & ClientSync {
  return {
    ...record,
    _isSynced: flag,
    _lastSyncedAt: flag === 1 ? nowIso() : null,
  };
}

export const markDirty = <T extends object>(record: T) => withSync(record, 0);
export const markClean = <T extends object>(record: T) => withSync(record, 1);

/** Remove client-only underscore fields before a Supabase upsert. */
export function stripClientFields<T extends object>(record: T): T {
  const clone = { ...(record as Record<string, unknown>) };
  delete clone._isSynced;
  delete clone._lastSyncedAt;
  return clone as T;
}

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
export const isUuid = (v: unknown): v is string =>
  typeof v === "string" && UUID_RE.test(v);

/** First defined/non-null candidate — dual-key tolerant reads. */
export function pickFirst<T>(row: Record<string, unknown>, keys: string[]): T {
  for (const k of keys) {
    const v = row[k];
    if (v !== undefined && v !== null) return v as T;
  }
  return undefined as T;
}

/** Flutter convention: INV-<first 8 of uuid>. */
export function invoiceNumberFor(id: string): string {
  return `INV-${id.replace(/-/g, "").slice(0, 8).toUpperCase()}`;
}

/**
 * Serialize a rich Dexie stock report to the minimal remote shape
 * {branch_id: null if !isUuid, report_date, data:{…}} (mirrors Flutter).
 */
export function stockReportToRemote(report: StockReportRow) {
  return {
    id: report.id,
    branch_id: isUuid(report.branch_id) ? report.branch_id : null,
    report_date: report.report_date,
    data: {
      branchId: report.branch_id,
      branchName: report.branchName ?? null,
      current_stock: report.currentStock ?? report.data?.current_stock ?? [],
      category_stock:
        report.categoryStock ?? report.data?.category_stock ?? [],
      startDate: report.startDate ?? report.data?.startDate ?? null,
      endDate: report.endDate ?? report.data?.endDate ?? null,
      productId: report.productId ?? report.data?.productId ?? null,
      productName: report.productName ?? report.data?.productName ?? null,
      createdBy: report.createdBy ?? null,
    },
  };
}

export function newId(): string {
  return crypto.randomUUID();
}
