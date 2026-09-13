"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useEffect, useRef, useState } from "react";
import { Printer } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import { ReceiptDialog } from "@/components/receipt-dialog";
import { downloadSalesExport } from "@/lib/excel/excel";
import type { ReceiptDocData } from "@/lib/print/receipt";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { db } from "@/lib/db/dexie";
import type {
  Synced,
  SaleOrderItemRow,
  SaleOrderRow,
} from "@/lib/db/types";
import { formatDateTime, formatFullDate } from "@/lib/dates";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

/**
 * POS Sale Orders — ported from sale_orders_page.dart.
 * Read-only history + search (Flutter's unused search provider is wired
 * to a real input here) + details dialog. Excel export lands in P4.
 */
export default function SalesPage() {
  const online = useOnline();
  const [rows, setRows] = useState<Synced<SaleOrderRow>[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [selected, setSelected] = useState<Synced<SaleOrderRow> | null>(null);
  const [items, setItems] = useState<SaleOrderItemRow[]>([]);
  const [loadingItems, setLoadingItems] = useState(false);
  const [receipt, setReceipt] = useState<ReceiptDocData | null>(null);

  const dataVersion = useDataVersion();
  const loadedOnce = useRef(false);
  const load = async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmSaleOrders(createClient());
        } catch {
          /* local stands */
        }
      }
      const all = await db.saleOrders.orderBy("createdAt").reverse().toArray();
      setRows(all);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const first = !loadedOnce.current;
    loadedOnce.current = true;
    if (first) setLoading(true);
    void load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [online, dataVersion]);

  const openDetails = async (order: Synced<SaleOrderRow>) => {
    setSelected(order);
    setLoadingItems(true);
    try {
      const list = await db.saleOrderItems
        .where("saleOrderId")
        .equals(order.id)
        .toArray();
      setItems(list);
    } finally {
      setLoadingItems(false);
    }
  };

  const receiptFrom = (
    order: Synced<SaleOrderRow>,
    orderItems: SaleOrderItemRow[],
  ): ReceiptDocData => ({
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
    cashTendered: order.totalAmount ?? 0,
  });

  const openReceipt = () => {
    if (!selected) return;
    setReceipt(receiptFrom(selected, items));
  };

  /** Direct Print action on the table row (mirrors Flutter's Print button). */
  const printRow = async (order: Synced<SaleOrderRow>) => {
    const orderItems = await db.saleOrderItems
      .where("saleOrderId")
      .equals(order.id)
      .toArray();
    setReceipt(receiptFrom(order, orderItems));
  };

  const q = query.trim().toLowerCase();
  const filtered = q
    ? rows.filter(
        (r) =>
          r.orderNumber.toLowerCase().includes(q) ||
          (r.customerName ?? "").toLowerCase().includes(q) ||
          (r.branchName ?? "").toLowerCase().includes(q),
      )
    : rows;

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">POS Sale Orders</h1>
          <p className="text-sm text-black/60">
            View and manage all point of sale transactions
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search orders..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-52"
          />
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
          <Button
            variant="outline"
            onClick={() =>
              downloadSalesExport(
                filtered.map((r) => ({
                  orderNumber: r.orderNumber,
                  totalQuantity: r.totalQuantity ?? 0,
                  createdAt: r.createdAt,
                  customerName: r.customerName,
                  totalAmount: r.totalAmount ?? 0,
                })),
              )
            }
          >
            Export Excel
          </Button>
        </div>
      </div>

      <DataTable
        loading={loading}
        columns={[
          { header: "Order #", accessorKey: "orderNumber" },
          {
            header: "Total Items",
            accessorKey: "totalQuantity",
          },
          {
            header: "Date",
            accessorKey: "createdAt",
            cell: ({ row }) => formatFullDate(row.original.createdAt),
          },
          {
            header: "Customer",
            accessorKey: "customerName",
            cell: ({ row }) => row.original.customerName ?? "Walk-in",
          },
          {
            header: "Total Amount",
            accessorKey: "totalAmount",
            cell: ({ row }) => (
              <span className="font-semibold">
                {ghs.format(row.original.totalAmount ?? 0)}
              </span>
            ),
          },
          {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => (
              <div className="flex justify-center gap-1">
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => void openDetails(row.original)}
                >
                  View
                </Button>
                <button
                  type="button"
                  title="Print receipt"
                  onClick={() => void printRow(row.original)}
                  className="p-1.5 text-green-600 hover:text-green-800"
                >
                  <Printer className="h-4 w-4" />
                </button>
              </div>
            ),
          },
        ]}
        rows={filtered}
        emptyHint="No orders yet — orders from POS will appear here."
      />

      <Dialog open={!!selected} onOpenChange={() => setSelected(null)}>
        <DialogContent className="max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>
              Order Details - {selected?.orderNumber}
            </DialogTitle>
          </DialogHeader>
          {selected && (
            <div className="space-y-3">
              <dl className="space-y-1.5 text-sm">
                {(
                  [
                    ["Customer", selected.customerName ?? "Walk-in"],
                    ["Date Created", formatDateTime(selected.createdAt)],
                    ["Order Number", selected.orderNumber],
                    ["Total Quantity", String(selected.totalQuantity ?? 0)],
                  ] as [string, string][]
                ).map(([k, v]) => (
                  <div key={k} className="flex justify-between gap-4">
                    <dt className="text-[12px] text-black">{k}</dt>
                    <dd className="text-right text-sm font-bold">{v}</dd>
                  </div>
                ))}
              </dl>
              <hr className="border-black/10" />
              <h3 className="font-bold">Order Items</h3>
              <DataTable
                loading={loadingItems}
                columns={[
                  { header: "Product", accessorKey: "productName" },
                  {
                    header: "Qty",
                    accessorKey: "quantity",
                    cell: ({ row }) => (
                      <span className="font-bold">{row.original.quantity}</span>
                    ),
                  },
                  {
                    header: "Rate",
                    accessorKey: "unitPrice",
                    cell: ({ row }) => (
                      <span className="font-bold">{ghs.format(row.original.unitPrice ?? 0)}</span>
                    ),
                  },
                  {
                    header: "Total",
                    accessorKey: "totalPrice",
                    cell: ({ row }) => (
                      <span className="font-bold">{ghs.format(row.original.totalPrice ?? 0)}</span>
                    ),
                  },
                ]}
                rows={items}
                emptyHint="No items."
              />
              <hr className="border-black/10" />
              <p className="text-right text-[18px] font-medium">
                Total Amount: {ghs.format(selected.totalAmount ?? 0)}
              </p>
              <div className="flex justify-end gap-2">
                <Button onClick={openReceipt} disabled={loadingItems}>
                  Print Receipt
                </Button>
                <Button variant="outline" onClick={() => setSelected(null)}>
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
