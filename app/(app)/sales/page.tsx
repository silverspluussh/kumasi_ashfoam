"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useState } from "react";
import { Printer } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import { TablePagination } from "@/components/table-pagination";
import { useTablePagination } from "@/hooks/use-table-pagination";
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
import { fetchSaleOrderItems } from "@/lib/supabase/queries/sales";

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
  /** Dexie only — local data is the source of truth, so it paints instantly. */
  const read = useCallback(async () => {
    try {
      setRows(await db.saleOrders.orderBy("createdAt").reverse().toArray());
    } finally {
      setLoading(false);
    }
  }, []);

  const load = useCallback(async () => {
    await read();
    if (!online) return;
    try {
      // Items are read one order at a time (details, print) and fetched on
      // demand there, so the 50-document item sweep is not needed here.
      await remoteFirst.warmSaleOrders(createClient(), { items: false });
      await read();
    } catch {
      /* local stands */
    }
  }, [online, read]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  /**
   * Item rows are only pre-fetched for recent orders, so fall back to a
   * direct fetch. printRow builds a receipt from these — an empty list would
   * print a receipt with no line items.
   */
  const itemsFor = async (order: Synced<SaleOrderRow>) => {
    const local = await db.saleOrderItems
      .where("saleOrderId")
      .equals(order.id)
      .toArray();
    if (local.length > 0 || !online) return local;
    try {
      return await fetchSaleOrderItems(createClient(), order.id);
    } catch {
      return local;
    }
  };

  const openDetails = async (order: Synced<SaleOrderRow>) => {
    setSelected(order);
    setLoadingItems(true);
    try {
      setItems(await itemsFor(order));
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
    setReceipt(receiptFrom(order, await itemsFor(order)));
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

  // Export spans every search match; only the visible table is paginated.
  const { pageRows, page, pageCount, setPage } = useTablePagination(
    filtered,
    query,
  );

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
        rows={pageRows}
        emptyHint="No orders yet — orders from POS will appear here."
      />

      <TablePagination page={page} pageCount={pageCount} onPage={setPage} />

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
