import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import { stockReportToRemote } from "@/lib/db/mappers";
import { createClient } from "@/lib/supabase/browser";
import { bulkUploadStockReports } from "@/lib/supabase/queries/logistics";
import { deleteRemote } from "@/lib/supabase/queries/_table";
import type {
  CategoryStockJson,
  ProductStockJson,
} from "@/lib/db/types";

export interface GenerateReportInput {
  online: boolean;
  start: Date;
  end: Date;
  productId?: string | null;
  productName?: string | null;
  branchId: string | null;
  branchName: string | null;
  createdBy: string;
}

/**
 * Movement report. Ported from generateMovementStockReport +
 * generateStockReportProvider: per-item closing (current qty), sold +
 * sales from sale items in [startDay, endExclusive), added from positive
 * adjustments in range, opening = closing − sold − added. Category
 * snapshot unfiltered. Local-first (dirty), remote upsert attempt, mark
 * clean on success — remote failures swallowed, upload queue retries.
 */
export async function generateMovementStockReport(
  input: GenerateReportInput,
): Promise<string> {
  const startDay = new Date(
    input.start.getFullYear(),
    input.start.getMonth(),
    input.start.getDate(),
  );
  const endExclusive = new Date(
    input.end.getFullYear(),
    input.end.getMonth(),
    input.end.getDate() + 1,
  );
  const sIso = startDay.toISOString();
  const eIso = endExclusive.toISOString();
  const endInclusive = new Date(endExclusive.getTime() - 1000).toISOString();

  const [products, orders, adjustments, categories] = await Promise.all([
    db.inventory.toArray(),
    db.saleOrders.where("createdAt").between(sIso, eIso, true, false).toArray(),
    db.stockAdjustments
      .where("createdAt")
      .between(sIso, eIso, true, false)
      .toArray(),
    db.categories.toArray(),
  ]);

  const scoped = input.productId
    ? products.filter((p) => p.id === input.productId)
    : products.filter((p) => (p.isDeleted ?? 0) === 0);

  const orderIds = orders.map((o) => o.id);
  const items =
    orderIds.length > 0
      ? await db.saleOrderItems.where("saleOrderId").anyOf(orderIds).toArray()
      : [];
  const soldByProduct = new Map<string, { qty: number; amt: number }>();
  for (const it of items) {
    if (!it.productId) continue;
    const cur = soldByProduct.get(it.productId) ?? { qty: 0, amt: 0 };
    cur.qty += it.quantity ?? 0;
    cur.amt += it.totalPrice ?? 0;
    soldByProduct.set(it.productId, cur);
  }
  const addedByProduct = new Map<string, number>();
  for (const a of adjustments) {
    if ((a.quantityChange ?? 0) <= 0) continue;
    addedByProduct.set(
      a.productId,
      (addedByProduct.get(a.productId) ?? 0) + (a.quantityChange ?? 0),
    );
  }

  const currentStock: ProductStockJson[] = scoped.map((p) => {
    const closing = p.quantity ?? 0;
    const sold = soldByProduct.get(p.id) ?? { qty: 0, amt: 0 };
    const added = addedByProduct.get(p.id) ?? 0;
    return {
      id: p.id,
      name: p.name,
      sku: p.sku,
      quantity: closing,
      retailPrice: p.retailPrice ?? 0,
      quantitySold: sold.qty,
      totalSales: sold.amt,
      openingQuantity: closing - sold.qty - added,
      quantityAdded: added,
    };
  });

  const catById = new Map(categories.map((c) => [c.id, c.name]));
  const catAgg = new Map<string, { qty: number; val: number }>();
  for (const p of products.filter((x) => (x.isDeleted ?? 0) === 0)) {
    const cid = p.catergory_id;
    if (!cid || !catById.has(cid)) continue;
    const cur = catAgg.get(cid) ?? { qty: 0, val: 0 };
    cur.qty += p.quantity ?? 0;
    cur.val += (p.quantity ?? 0) * (p.retailPrice ?? 0);
    catAgg.set(cid, cur);
  }
  const categoryStock: CategoryStockJson[] = [...catAgg.entries()].map(
    ([categoryId, v]) => ({
      categoryId,
      categoryName: catById.get(categoryId) ?? "",
      totalQuantity: v.qty,
      totalValue: v.val,
    }),
  );

  const id = newId();
  const now = new Date().toISOString();
  const branchId = input.branchId ?? "main-store";
  const branchName = input.branchName ?? "Main Store";
  const record = {
    id,
    branch_id: branchId,
    branchName,
    report_date: now,
    data: null,
    currentStock,
    categoryStock,
    createdBy: input.createdBy,
    createdAt: now,
    startDate: startDay.toISOString(),
    endDate: endInclusive,
    productId: input.productId ?? null,
    productName: input.productName ?? null,
    _isSynced: 0 as 0 | 1,
    _lastSyncedAt: null as string | null,
  };
  await db.stockReports.put(record);

  if (input.online) {
    try {
      await bulkUploadStockReports(createClient(), [
        stockReportToRemote(record),
      ]);
      await db.stockReports.update(id, {
        _isSynced: 1,
        _lastSyncedAt: new Date().toISOString(),
      });
    } catch {
      /* stays dirty for the upload queue */
    }
  }
  return id;
}

export async function removeStockReport(
  online: boolean,
  id: string,
): Promise<void> {
  if (online) {
    try {
      await deleteRemote(createClient(), "ashfoam_stock_reports", id);
    } catch {
      /* fall through to local delete even if remote fails */
    }
  }
  await db.stockReports.delete(id);
}
