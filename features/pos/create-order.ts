import { db } from "@/lib/db/dexie";
import { invoiceNumberFor, newId } from "@/lib/db/mappers";
import { saveRemoteFirst } from "@/lib/sync/mutations";
import { createClient } from "@/lib/supabase/browser";
import {
  bulkUploadInvoiceItems,
  bulkUploadInvoices,
  bulkUploadSaleOrderItems,
  bulkUploadSaleOrders,
} from "@/lib/supabase/queries/sales";
import { bulkUploadCustomers } from "@/lib/supabase/queries/partners";
import type {
  CartLine,
  CartSummary,
} from "./cart-store";

/**
 * Checkout transaction. Ported from CreatePOSOrderNotifier.createOrder:
 * orderNumber ORD-{millis[7:]}, channel 'Retail', status 'Paid',
 * createdBy = manual || displayName || 'User'. Remote-first: no local
 * write when the remote upsert fails. Dexie stock decrement mirrors the
 * server trigger so offline UI stays correct.
 */
export interface CreateOrderInput {
  online: boolean;
  customerName: string;
  customerPhone: string;
  createdByManual: string;
  displayName: string;
  branchId: string | null;
  branchName: string | null;
  createInvoice: boolean;
  lines: CartLine[];
  summary: CartSummary;
}

export interface CreatedOrder {
  orderId: string;
  orderNumber: string;
  totalAmount: number;
  totalQuantity: number;
}

export async function createPOSOrder(
  input: CreateOrderInput,
): Promise<CreatedOrder> {
  const customerName = input.customerName.trim();
  if (!customerName) throw new Error("Please enter customer name");
  if (input.lines.length === 0) throw new Error("Cart is empty");

  const orderId = newId();
  const orderNumber = `ORD-${Date.now().toString().substring(7)}`;
  const now = new Date().toISOString();
  const createdBy =
    input.createdByManual.trim() || input.displayName || "User";

  const order = {
    id: orderId,
    orderNumber,
    customerName,
    channel: "Retail",
    branchId: input.branchId,
    branchName: input.branchName,
    totalAmount: input.summary.grandTotal,
    discountAmount: input.summary.totalDiscount,
    totalQuantity: input.summary.totalQuantity,
    taxAmount: input.summary.vatAmount,
    status: "Paid",
    createdBy,
    createdAt: now,
    lastSyncedAt: now,
  };
  const items = input.lines.map((l) => ({
    id: newId(),
    saleOrderId: orderId,
    productId: l.productId,
    productName: l.productName,
    quantity: l.quantity,
    unitPrice: l.unitPrice,
    totalPrice: l.totalPrice,
    discountAmount: l.discountAmount,
    taxAmount: l.taxAmount,
    isSynced: 0,
    lastSyncedAt: now,
  }));
  const customerId = newId();
  const customer = {
    id: customerId,
    name: customerName,
    email: null as string | null,
    phone: input.customerPhone.trim() || null,
    address: null as string | null,
    created_at: now,
    updated_at: now,
  };

  const invoiceId = newId();
  const invoiceNumber = invoiceNumberFor(invoiceId);
  const invoice = {
    id: invoiceId,
    invoice_number: invoiceNumber,
    customer_id: null as string | null,
    customer_name: customerName,
    total_amount: input.summary.grandTotal,
    status: "paid",
    created_at: now,
    updated_at: now,
    saleOrderId: orderId,
    paidAmount: input.summary.grandTotal,
    dueDate: now,
    branchId: input.branchId ?? "Main",
    branchName: input.branchName ?? "Kumasi Ashfoam",
  };
  const invoiceItems = input.lines.map((l) => ({
    id: newId(),
    invoice_id: invoiceId,
    product_id: l.productId,
    description: l.productName,
    quantity: l.quantity,
    unit_price: l.unitPrice,
    total_price: l.totalPrice,
  }));

  const strip = <T extends object>(r: T) => {
    const { _isSynced: _a, _lastSyncedAt: _b, ...rest } = r as T & {
      _isSynced: number;
      _lastSyncedAt: string | null;
    };
    void _a;
    void _b;
    return rest;
  };
  const stamp = <T extends object>(r: T, isClean: boolean) => ({
    ...r,
    _isSynced: (isClean ? 1 : 0) as 0 | 1,
    _lastSyncedAt: isClean ? now : null,
  });

  await saveRemoteFirst({
    online: input.online,
    remoteLabel: "sale",
    remote: async () => {
      const supabase = createClient();
      await bulkUploadSaleOrders(supabase, [
        { ...strip(order), isSynced: 1, lastSyncedAt: now },
      ]);
      await bulkUploadSaleOrderItems(
        supabase,
        items.map((i) => ({ ...strip(i), isSynced: 1, lastSyncedAt: now })),
      );
      // Best-effort customer + invoice (Flutter: never blocks the sale).
      try {
        await bulkUploadCustomers(supabase, [strip(customer)]);
      } catch {
        /* ignore */
      }
      if (input.createInvoice) {
        try {
          const { saleOrderId: _s, paidAmount: _p, dueDate: _d, branchId: _b, branchName: _n, ...remoteInvoice } = strip(invoice);
          void _s; void _p; void _d; void _b; void _n;
          await bulkUploadInvoices(supabase, [remoteInvoice]);
          await bulkUploadInvoiceItems(supabase, invoiceItems);
        } catch {
          /* queued locally instead */
        }
      }
    },
    applyLocal: async (isClean) =>
      db.transaction(
        "rw",
        [
          db.saleOrders,
          db.saleOrderItems,
          db.customers,
          db.invoices,
          db.invoiceItems,
          db.inventory,
        ],
        async () => {
          await db.saleOrders.put(
            stamp(
              { ...order, isSynced: isClean ? 1 : 0, lastSyncedAt: now },
              isClean,
            ),
          );
          await db.saleOrderItems.bulkPut(
            items.map((i) =>
              stamp(
                { ...i, isSynced: isClean ? 1 : 0, lastSyncedAt: now },
                isClean,
              ),
            ),
          );
          await db.customers.put(stamp(customer, isClean));
          if (input.createInvoice) {
            await db.invoices.put(stamp(invoice, isClean));
            await db.invoiceItems.bulkPut(invoiceItems);
          }
          // Mirror the server stock trigger locally.
          // NOTE: a sale-driven decrement is a MIRROR of the server trigger
          // (which fires on saleOrderItems INSERT). It must NOT dirty a
          // clean inventory row — otherwise the drain uploads the absolute
          // decremented quantity in step 1 AND the trigger decrements again
          // in step 2 → server stock short by the sale quantity.
          // Only rows already dirty (offline edit) stay queued.
          for (const l of input.lines) {
            const inv = await db.inventory.get(l.productId);
            if (inv) {
              const wasDirty = inv._isSynced === 0;
              await db.inventory.update(l.productId, {
                quantity: Math.max(0, (inv.quantity ?? 0) - l.quantity),
                _isSynced: wasDirty ? 0 : 1,
                _lastSyncedAt: wasDirty ? null : now,
              });
            }
          }
        },
      ),
  });

  return {
    orderId,
    orderNumber,
    totalAmount: input.summary.grandTotal,
    totalQuantity: input.summary.totalQuantity,
  };
}
