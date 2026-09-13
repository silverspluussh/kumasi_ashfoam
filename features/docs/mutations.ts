import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import { saveRemoteFirst } from "@/lib/sync/mutations";
import { createClient } from "@/lib/supabase/browser";
import {
  bulkUploadProformaItems,
  bulkUploadProformas,
  bulkUploadWaybillItems,
  bulkUploadWaybills,
} from "@/lib/supabase/queries/docs";
import {
  computeTotals,
  taxesWithAmounts,
  type DocItem,
  type DocTax,
} from "./totals";

/**
 * Proforma/waybill mutations. Ported from proforma_providers.dart +
 * waybill_providers.dart: stable pre-generated item ids shared by the
 * remote upsert and the local write (avoids doubling); update = delete
 * remote children then upsert parent + children.
 */

export interface ProformaInput {
  partyName: string;
  partyAddress: string;
  declaration: string;
  taxes: DocTax[];
  items: DocItem[];
}

export async function addProforma(
  online: boolean,
  input: ProformaInput,
): Promise<string> {
  const id = newId();
  const now = new Date().toISOString();
  const totals = computeTotals(input.items, input.taxes);
  const itemIds = input.items.map(() => newId());

  const parent = {
    id,
    party_name: input.partyName || null,
    party_address: input.partyAddress || null,
    declaration: input.declaration || null,
    tax: taxesWithAmounts(input.taxes, totals.subtotal),
    total_quantity: totals.totalQty,
    total_amount: totals.grandTotal,
    is_deleted: 0,
    created_at: now,
    updated_at: now,
  };
  const children = input.items.map((it, i) => ({
    id: itemIds[i],
    proforma_id: id,
    product_id: it.productId,
    product_name: it.productName,
    quantity: it.quantity,
    unit_price: it.unitPrice,
    discount_percentage: it.discountPct,
    total_amount: it.total,
  }));

  await saveRemoteFirst({
    online,
    remoteLabel: "proforma sync",
    remote: async () => {
      const c = createClient();
      await bulkUploadProformas(c, [parent]);
      await bulkUploadProformaItems(c, children);
    },
    applyLocal: async (isClean) =>
      db.transaction("rw", [db.proformas, db.proformaItems], async () => {
        await db.proformas.put({
          ...parent,
          _isSynced: isClean ? 1 : 0,
          _lastSyncedAt: isClean ? now : null,
        });
        await db.proformaItems.bulkPut(children);
      }),
  });
  return id;
}

export async function updateProforma(
  online: boolean,
  id: string,
  input: ProformaInput & { isDeleted?: number },
): Promise<void> {
  const now = new Date().toISOString();
  const totals = computeTotals(input.items, input.taxes);
  const itemIds = input.items.map(() => newId());
  const parent = {
    id,
    party_name: input.partyName || null,
    party_address: input.partyAddress || null,
    declaration: input.declaration || null,
    tax: taxesWithAmounts(input.taxes, totals.subtotal),
    total_quantity: totals.totalQty,
    total_amount: totals.grandTotal,
    is_deleted: input.isDeleted ?? 0,
    updated_at: now,
  };
  const children = input.items.map((it, i) => ({
    id: itemIds[i],
    proforma_id: id,
    product_id: it.productId,
    product_name: it.productName,
    quantity: it.quantity,
    unit_price: it.unitPrice,
    discount_percentage: it.discountPct,
    total_amount: it.total,
  }));

  await saveRemoteFirst({
    online,
    remoteLabel: "proforma update",
    remote: async () => {
      const c = createClient();
      const { error } = await c
        .from("ashfoam_proforma_items")
        .delete()
        .eq("proforma_id", id);
      if (error) throw new Error(error.message);
      await bulkUploadProformas(c, [parent]);
      await bulkUploadProformaItems(c, children);
    },
    applyLocal: async (isClean) =>
      db.transaction("rw", [db.proformas, db.proformaItems], async () => {
        const prev = await db.proformas.get(id);
        await db.proformas.put({
          ...prev,
          ...parent,
          created_at: prev?.created_at ?? now,
          _isSynced: isClean ? 1 : 0,
          _lastSyncedAt: isClean ? now : null,
        });
        await db.proformaItems.where("proforma_id").equals(id).delete();
        await db.proformaItems.bulkPut(children);
      }),
  });
}

export interface WaybillInput {
  orderNumber: string;
  driverName: string;
  destination: string;
  partyName: string;
  dispatchDate: string; // ISO
  deliveryNote: string;
  taxes: DocTax[];
  items: DocItem[];
  sourceProforma?: {
    id: string;
    partyName: string | null;
    partyAddress: string | null;
    tax: DocTax[];
  } | null;
}

const yyyymmdd = (d: Date) =>
  `${d.getFullYear()}${String(d.getMonth() + 1).padStart(2, "0")}${String(d.getDate()).padStart(2, "0")}`;

export async function addWaybill(
  online: boolean,
  createdBy: string,
  input: WaybillInput,
): Promise<string> {
  const id = newId();
  const now = new Date().toISOString();
  const totals = computeTotals(input.items, input.taxes);
  const short = id.replace(/-/g, "").slice(0, 4).toUpperCase();
  const itemIds = input.items.map(() => newId());

  const mainContent = input.sourceProforma
    ? {
        id: input.sourceProforma.id,
        partyName: input.partyName,
        partyAddress: input.destination,
        tax: [...input.sourceProforma.tax, ...taxesWithAmounts(input.taxes, totals.subtotal)],
        totalQuantity: totals.totalQty,
        totalAmount: totals.grandTotal,
        isDeleted: 0,
        createdAt: now,
        updatedAt: now,
      }
    : {
        id: `MANUAL-${id.replace(/-/g, "").slice(0, 8).toUpperCase()}`,
        partyName: input.partyName,
        partyAddress: input.destination,
        tax: taxesWithAmounts(input.taxes, totals.subtotal),
        totalQuantity: totals.totalQty,
        totalAmount: totals.grandTotal,
        isDeleted: 0,
        createdAt: now,
        updatedAt: now,
      };

  const parent = {
    id,
    mainContent,
    orderNumber:
      input.orderNumber.trim() || `ORD-${yyyymmdd(new Date())}-${short}`,
    dispatchDocNumber: `WB-${yyyymmdd(new Date())}-${short}`,
    deliveryNote: input.deliveryNote,
    senderName: input.driverName,
    destination: input.destination,
    partyName: input.partyName,
    dispatchDate: input.dispatchDate,
    createdBy,
    isDeleted: 0,
    createdAt: now,
    updatedAt: now,
  };
  const children = input.items.map((it, i) => ({
    id: itemIds[i],
    waybill_id: id,
    product_id: it.productId,
    product_name: it.productName,
    quantity: it.quantity,
    unit_price: it.unitPrice,
    discount_percentage: it.discountPct,
    total_amount: it.total,
  }));

  await saveRemoteFirst({
    online,
    remoteLabel: "waybill sync",
    remote: async () => {
      const c = createClient();
      await bulkUploadWaybills(c, [parent]);
      await bulkUploadWaybillItems(c, children);
    },
    applyLocal: async (isClean) =>
      db.transaction("rw", [db.waybills, db.waybillItems], async () => {
        await db.waybills.put({
          ...parent,
          _isSynced: isClean ? 1 : 0,
          _lastSyncedAt: isClean ? now : null,
        });
        await db.waybillItems.bulkPut(children);
      }),
  });
  return id;
}

export async function updateWaybill(
  online: boolean,
  id: string,
  input: WaybillInput & { dispatchDocNumber: string },
): Promise<void> {
  const now = new Date().toISOString();
  const totals = computeTotals(input.items, input.taxes);
  const itemIds = input.items.map(() => newId());
  const prev = await db.waybills.get(id);
  const prevMain = (prev?.mainContent ?? {}) as Record<string, unknown>;
  const mainContent = {
    ...prevMain,
    partyName: input.partyName,
    partyAddress: input.destination,
    tax: taxesWithAmounts(input.taxes, totals.subtotal),
    totalQuantity: totals.totalQty,
    totalAmount: totals.grandTotal,
    updatedAt: now,
  };
  const parent = {
    id,
    mainContent,
    orderNumber: input.orderNumber,
    dispatchDocNumber: input.dispatchDocNumber,
    deliveryNote: input.deliveryNote,
    senderName: input.driverName,
    destination: input.destination,
    partyName: input.partyName,
    dispatchDate: input.dispatchDate,
    updatedAt: now,
  };
  const children = input.items.map((it, i) => ({
    id: itemIds[i],
    waybill_id: id,
    product_id: it.productId,
    product_name: it.productName,
    quantity: it.quantity,
    unit_price: it.unitPrice,
    discount_percentage: it.discountPct,
    total_amount: it.total,
  }));

  await saveRemoteFirst({
    online,
    remoteLabel: "waybill update",
    remote: async () => {
      const c = createClient();
      const { error } = await c
        .from("ashfoam_waybill_items")
        .delete()
        .eq("waybill_id", id);
      if (error) throw new Error(error.message);
      await bulkUploadWaybills(c, [{ ...prev, ...parent }]);
      await bulkUploadWaybillItems(c, children);
    },
    applyLocal: async (isClean) =>
      db.transaction("rw", [db.waybills, db.waybillItems], async () => {
        await db.waybills.put({
          id,
          mainContent,
          orderNumber: parent.orderNumber,
          dispatchDocNumber: parent.dispatchDocNumber,
          deliveryNote: parent.deliveryNote,
          senderName: parent.senderName,
          destination: parent.destination,
          partyName: parent.partyName,
          dispatchDate: parent.dispatchDate,
          createdBy: prev?.createdBy ?? "",
          isDeleted: prev?.isDeleted ?? 0,
          createdAt: prev?.createdAt ?? now,
          updatedAt: now,
          _isSynced: isClean ? 1 : 0,
          _lastSyncedAt: isClean ? now : null,
        });
        await db.waybillItems.where("waybill_id").equals(id).delete();
        await db.waybillItems.bulkPut(children);
      }),
  });
}
