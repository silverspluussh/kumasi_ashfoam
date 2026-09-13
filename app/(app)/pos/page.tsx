"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { CheckCircle2, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { SearchableSelect } from "@/components/searchable-select";
import {
  usePosCart,
  type CartProduct,
} from "@/features/pos/cart-store";
import { createPOSOrder } from "@/features/pos/create-order";
import { ReceiptDialog } from "@/components/receipt-dialog";
import type { ReceiptDocData } from "@/lib/print/receipt";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type { Synced, InventoryRow } from "@/lib/db/types";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

const PAYMENT_METHODS = ["cash", "momo", "cheque", "card"];
const capitalize = (s: string) => s.charAt(0).toUpperCase() + s.slice(1);
const todayIso = () => new Date().toISOString().slice(0, 10);

/**
 * Point Of Sale — ported from pos_page.dart + pos_providers.dart.
 * Reads Dexie (warmed from remote when online); checkout runs the
 * createPOSOrder transaction (remote-first, stock decrement mirrored).
 */
export default function PosPage() {
  const online = useOnline();
  const { displayName, branchId, branchName } = useAuth();
  const [products, setProducts] = useState<Synced<InventoryRow>[]>([]);
  const [loadingProducts, setLoadingProducts] = useState(true);

  const [orderDate, setOrderDate] = useState(todayIso);
  const [customerName, setCustomerName] = useState("");
  const [customerPhone, setCustomerPhone] = useState("");
  const [amountReceived, setAmountReceived] = useState("0");
  const [paymentMethod, setPaymentMethod] = useState("");
  const [createdByManual, setCreatedByManual] = useState("");
  const [placing, setPlacing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<{
    orderId: string;
    orderNumber: string;
    totalAmount: number;
    cashTendered: number;
    customerName: string;
    createdBy: string;
  } | null>(null);
  const [receipt, setReceipt] = useState<ReceiptDocData | null>(null);

  const {
    lines,
    current,
    selectProduct,
    updateQuantity,
    updateDiscount,
    currentSubtotal,
    addCurrent,
    removeLine,
    clear,
    summary,
  } = usePosCart();
  const s = summary();
  const received = parseFloat(amountReceived) || 0;
  const change = received - s.grandTotal;

  const loadProducts = useCallback(async () => {
    setLoadingProducts(true);
    try {
      if (online) {
        try {
          await remoteFirst.warmInventory(createClient());
        } catch {
          /* local stands */
        }
      }
      const rows = await db.inventory
        .filter((p) => (p.isDeleted ?? 0) === 0)
        .toArray();
      setProducts(rows);
    } finally {
      setLoadingProducts(false);
    }
  }, [online]);

  useEffect(() => {
    void loadProducts();
  }, [loadProducts]);

  const cartProducts: CartProduct[] = useMemo(
    () =>
      products.map((p) => ({
        id: p.id,
        name: p.name,
        retailPrice: p.retailPrice ?? 0,
        quantity: p.quantity ?? 0,
      })),
    [products],
  );

  const resetAll = () => {
    clear();
    setCustomerName("");
    setCustomerPhone("");
    setAmountReceived("0");
    setPaymentMethod("");
    setCreatedByManual("");
    setError(null);
  };

  const placeOrder = async () => {
    if (lines.length === 0 || placing) return;
    setPlacing(true);
    setError(null);
    const tendered = received;
    const buyer = customerName.trim() || "Walk-in";
    const cashier = createdByManual.trim() || displayName || "User";
    try {
      const created = await createPOSOrder({
        online,
        customerName,
        customerPhone,
        createdByManual,
        displayName,
        branchId,
        branchName,
        createInvoice: false,
        lines,
        summary: s,
      });
      clear();
      setCustomerName("");
      setCustomerPhone("");
      setPaymentMethod("");
      setAmountReceived("0");
      setSuccess({
        orderId: created.orderId,
        orderNumber: created.orderNumber,
        totalAmount: created.totalAmount,
        cashTendered: tendered,
        customerName: buyer,
        createdBy: cashier,
      });
      void loadProducts();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setPlacing(false);
    }
  };

  const openReceipt = async () => {
    if (!success) return;
    const [order, orderItems] = await Promise.all([
      db.saleOrders.get(success.orderId),
      db.saleOrderItems.where("saleOrderId").equals(success.orderId).toArray(),
    ]);
    if (!order) return;
    setReceipt({
      orderNumber: order.orderNumber,
      createdAt: order.createdAt ?? null,
      createdBy: order.createdBy,
      customerName: order.customerName,
      items: orderItems.map((it) => ({
        productName: it.productName,
        quantity: it.quantity ?? 0,
        unitPrice: it.unitPrice ?? 0,
        totalPrice: it.totalPrice ?? 0,
        discountAmount: it.discountAmount ?? 0,
      })),
      totalQuantity: order.totalQuantity ?? 0,
      totalAmount: order.totalAmount ?? 0,
      cashTendered: success.cashTendered,
    });
  };

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-xl font-bold">Point Of Sale</h1>
        <p className="text-sm text-black/60">
          Create sale orders and invoices.
        </p>
      </div>

      {/* Add Order card */}
      <section className="border border-black/15 bg-white p-4">
        <h2 className="font-bold">Add Order</h2>
        <p className="pb-3 text-[13px] text-black/60">
          Select and add sale orders below:
        </p>
        <div className="grid gap-3 md:grid-cols-[1fr_2fr_1fr]">
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Order Date
            </Label>
            <Input
              type="date"
              value={orderDate}
              onChange={(e) => setOrderDate(e.target.value)}
            />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Customer Name *
            </Label>
            <Input
              value={customerName}
              onChange={(e) => setCustomerName(e.target.value)}
              placeholder="Walk-in"
            />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Customer Phone
            </Label>
            <Input
              value={customerPhone}
              onChange={(e) => setCustomerPhone(e.target.value)}
            />
          </div>
        </div>

        <hr className="my-4 border-black/10" />

        <div className="grid items-end gap-3 md:grid-cols-[2fr_1fr_1fr_1fr_1fr_1fr_auto]">
          <SearchableSelect<CartProduct>
            label="Product"
            required
            hint="Select a product"
            items={cartProducts}
            format={(p) => p.name}
            filter={(p, q) => p.name.toLowerCase().includes(q)}
            value={
              current
                ? (cartProducts.find((p) => p.id === current.product.id) ??
                  null)
                : null
            }
            onSelect={selectProduct}
          />
          <div>
            <Label className="pb-1 block text-[13px] font-medium">Rate(GHS)</Label>
            <Input value={(current?.rate ?? 0).toFixed(2)} readOnly />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Current Stock
            </Label>
            <Input value={String(current?.stock ?? 0)} readOnly />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Order Quantity
            </Label>
            <Input
              type="number"
              min={0}
              value={current?.quantity ?? 1}
              onChange={(e) =>
                updateQuantity(parseInt(e.target.value, 10) || 0)
              }
            />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Discount(%)
            </Label>
            <Input
              type="number"
              min={0}
              value={current?.discountPct ?? 0}
              onChange={(e) =>
                updateDiscount(parseFloat(e.target.value) || 0)
              }
            />
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Sub Total(GHS)
            </Label>
            <Input value={currentSubtotal().toFixed(2)} readOnly />
          </div>
          <Button
            onClick={addCurrent}
            disabled={!current || loadingProducts}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            Add to Cart
          </Button>
        </div>
      </section>

      {/* Summary + Details */}
      <div className="grid gap-4 xl:grid-cols-2">
        <section className="border border-black/15 bg-white p-4">
          <h2 className="pb-3 font-bold">Order Summary</h2>
          <div className="space-y-3">
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-medium">
                Sub total (discounted)
              </Label>
              <Input
                className="w-40 text-right"
                value={s.subtotal.toFixed(2)}
                readOnly
              />
            </div>
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-medium">
                Amount Received
              </Label>
              <Input
                className="w-40 text-right"
                type="number"
                min={0}
                value={amountReceived}
                onChange={(e) => setAmountReceived(e.target.value)}
              />
            </div>
            {s.taxes.map((t) => (
              <div
                key={t.name}
                className="flex items-center justify-between gap-3"
              >
                <Label className="text-[13px] font-medium">
                  {t.name} ({t.percentage}%)
                </Label>
                <Input
                  className="w-40 text-right"
                  value={t.amount.toFixed(2)}
                  readOnly
                />
              </div>
            ))}
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-bold">Grand Total</Label>
              <span className="text-lg font-bold">
                {ghs.format(s.grandTotal)}
              </span>
            </div>
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-medium">Change</Label>
              <span className="font-bold">{ghs.format(change)}</span>
            </div>
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-medium">
                Payment method
              </Label>
              <select
                value={paymentMethod}
                onChange={(e) => setPaymentMethod(e.target.value)}
                className="w-40 border border-black/20 bg-white px-2 py-2 text-sm"
              >
                <option value="">Select payment method</option>
                {PAYMENT_METHODS.map((m) => (
                  <option key={m} value={m}>
                    {capitalize(m)}
                  </option>
                ))}
              </select>
            </div>
            <div className="flex items-center justify-between gap-3">
              <Label className="text-[13px] font-medium">Created By</Label>
              <Input
                className="w-40"
                placeholder="Name of user"
                value={createdByManual}
                onChange={(e) => setCreatedByManual(e.target.value)}
              />
            </div>
            {error && (
              <p className="text-[13px] font-medium text-red-600">{error}</p>
            )}
            <div className="flex gap-2 pt-1">
              <Button
                onClick={placeOrder}
                disabled={lines.length === 0 || placing}
                className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
              >
                {placing ? "Creating Order…" : "Create Sale Order"}
              </Button>
              <Button
                variant="outline"
                onClick={resetAll}
                disabled={placing}
                className="border-red-600 text-red-600 hover:bg-red-50"
              >
                Reset Sale Order
              </Button>
            </div>
          </div>
        </section>

        <section className="border border-black/15 bg-white p-4">
          <h2 className="pb-3 font-bold">Order Details</h2>
          <DataTable
            columns={[
              { header: "Product", accessorKey: "productName" },
              {
                header: "Quantity",
                accessorKey: "quantity",
              },
              {
                header: "Unit Price",
                accessorKey: "unitPrice",
                cell: ({ row }) => ghs.format(row.original.unitPrice),
              },
              {
                header: "Discount",
                accessorKey: "discountAmount",
                cell: ({ row }) => ghs.format(row.original.discountAmount),
              },
              {
                header: "Total Price",
                accessorKey: "totalPrice",
                cell: ({ row }) => ghs.format(row.original.totalPrice),
              },
              {
                header: "Actions",
                id: "actions",
                cell: ({ row }) => (
                  <button
                    type="button"
                    title="Remove from cart"
                    onClick={() => removeLine(row.original.productId)}
                    className="text-red-600 hover:text-red-800"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>
                ),
              },
            ]}
            rows={lines}
            emptyHint="No items in cart — select a product to begin."
          />
        </section>
      </div>

      {/* Order success dialog (OrderSuccessDialog; receipt print lands in P4) */}
      <Dialog open={!!success} onOpenChange={() => setSuccess(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Order Completed Successfully</DialogTitle>
          </DialogHeader>
          {success && (
            <div className="flex flex-col items-center gap-2 py-4 text-center">
              <CheckCircle2 className="h-16 w-16 text-green-600" />
              <p>Order #{success.orderNumber} has been recorded.</p>
              <p className="font-bold">
                Total Amount: {ghs.format(success.totalAmount)}
              </p>
              <div className="mt-2 flex gap-2">
                <Button onClick={() => void openReceipt()}>
                  Print Receipt
                </Button>
                <Button variant="outline" onClick={() => setSuccess(null)}>
                  Close
                </Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
      <ReceiptDialog
        open={!!receipt}
        doc={receipt}
        onClose={() => setReceipt(null)}
      />
    </div>
  );
}
