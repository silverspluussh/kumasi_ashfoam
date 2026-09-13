"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { Eye, Printer, Trash2, X } from "lucide-react";
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
  generateMovementStockReport,
  removeStockReport,
} from "@/features/reports/generate";
import {
  StockReportDoc,
  reportMonthLabel,
  type StockReportDocData,
} from "@/lib/print/stock-report";
import { PrintPreviewDialog } from "@/components/print-preview-dialog";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type { Synced, StockReportRow } from "@/lib/db/types";
import {
  formatFullDate,
  formatReportDate,
  toIsoDate,
} from "@/lib/dates";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";
import { cn } from "@/lib/utils";

const MONTHS = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];

function periodLabel(r: Synced<StockReportRow>): string {
  if (r.startDate && r.endDate) {
    const s = new Date(r.startDate);
    const e = new Date(r.endDate);
    return `${s.getDate()} ${MONTHS[s.getMonth()]} – ${e.getDate()} ${MONTHS[e.getMonth()]} ${e.getFullYear()}`;
  }
  const c = r.createdAt ? new Date(r.createdAt) : new Date();
  return `${MONTHS[c.getMonth()]} ${c.getFullYear()}`;
}
function scopeLabel(r: Synced<StockReportRow>): string {
  return r.productName ?? r.data?.productName ?? "All products";
}

interface ProductOption {
  id: string;
  name: string;
  sku: string;
}

/**
 * Stock Reports — ported from stockreports.dart. Month filter applies to
 * generation month; movement math mirrors generateMovementStockReport.
 * Print lands in P4.
 */
export default function StockReportsPage() {
  const online = useOnline();
  const { displayName, branchId, branchName } = useAuth();
  const [rows, setRows] = useState<Synced<StockReportRow>[]>([]);
  const [products, setProducts] = useState<ProductOption[]>([]);
  const [loading, setLoading] = useState(true);
  const [startMonth, setStartMonth] = useState("");
  const [endMonth, setEndMonth] = useState("");
  const [genOpen, setGenOpen] = useState(false);
  const [details, setDetails] = useState<Synced<StockReportRow> | null>(null);
  const [deleting, setDeleting] = useState<Synced<StockReportRow> | null>(null);
  const [preview, setPreview] = useState<StockReportDocData | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // generate dialog state
  const [gStart, setGStart] = useState(() => {
    const n = new Date();
    return toIsoDate(new Date(n.getFullYear(), n.getMonth(), 1));
  });
  const [gEnd, setGEnd] = useState(() => toIsoDate());
  const [gProductId, setGProductId] = useState("");

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmStockReports(createClient());
          await remoteFirst.warmInventory(createClient());
        } catch {
          /* local stands */
        }
      }
      const [reports, inv] = await Promise.all([
        db.stockReports.orderBy("report_date").reverse().toArray(),
        db.inventory.filter((p) => (p.isDeleted ?? 0) === 0).toArray(),
      ]);
      setRows(reports);
      setProducts(inv.map((p) => ({ id: p.id, name: p.name, sku: p.sku })));
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const filtered = useMemo(() => {
    const sm = startMonth ? new Date(`${startMonth}-01`) : null;
    const em = endMonth ? new Date(`${endMonth}-01`) : null;
    if (!sm && !em) return rows;
    return rows.filter((r) => {
      if (!r.createdAt) return false;
      const t = new Date(r.createdAt);
      const m = new Date(t.getFullYear(), t.getMonth());
      if (sm && (m < sm)) return false;
      if (em && (m > em)) return false;
      return true;
    });
  }, [rows, startMonth, endMonth]);

  const gProduct = products.find((p) => p.id === gProductId) ?? null;

  const preset = (kind: "month" | "7d" | "30d") => {
    const now = new Date();
    if (kind === "month") {
      setGStart(toIsoDate(new Date(now.getFullYear(), now.getMonth(), 1)));
      setGEnd(toIsoDate(now));
    } else {
      const days = kind === "7d" ? 6 : 29;
      const s = new Date(now);
      s.setDate(now.getDate() - days);
      setGStart(toIsoDate(s));
      setGEnd(toIsoDate(now));
    }
  };

  const generate = async () => {
    const s = new Date(gStart);
    const e = new Date(gEnd);
    if (e < s) {
      setError("End date must be on or after the start date");
      return;
    }
    setBusy(true);
    setError(null);
    try {
      await generateMovementStockReport({
        online,
        start: s,
        end: e,
        productId: gProductId || null,
        productName: gProduct?.name ?? null,
        branchId,
        branchName,
        createdBy: displayName || "Admin",
      });
      setGenOpen(false);
      setGProductId("");
      void load();
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setBusy(false);
    }
  };

  const openPreview = (row: Synced<StockReportRow>) => {
    const stock = row.currentStock ?? row.data?.current_stock ?? [];
    setPreview({
      id: row.id,
      branchName: row.branchName ?? row.data?.branchName ?? "",
      periodLabel: periodLabel(row),
      scopeLabel: scopeLabel(row),
      createdBy: row.createdBy ?? row.data?.createdBy ?? "",
      rows: stock.map((r) => ({
        name: r.name,
        openingQuantity: r.openingQuantity ?? 0,
        quantitySold: r.quantitySold ?? 0,
        totalSales: r.totalSales ?? 0,
        quantityAdded: r.quantityAdded ?? 0,
        quantity: r.quantity ?? 0,
      })),
    });
  };

  const confirmDelete = async () => {
    if (!deleting) return;
    setBusy(true);
    try {
      await removeStockReport(online, deleting.id);
      setDeleting(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setDeleting(null);
    } finally {
      setBusy(false);
    }
  };

  const d = details;
  const dStock = d?.currentStock ?? d?.data?.current_stock ?? [];
  const dTotals = useMemo(() => {
    return dStock.reduce(
      (a, r) => ({
        opening: a.opening + (r.openingQuantity ?? 0),
        sold: a.sold + (r.quantitySold ?? 0),
        sales: a.sales + (r.totalSales ?? 0),
        added: a.added + (r.quantityAdded ?? 0),
        closing: a.closing + (r.quantity ?? 0),
      }),
      { opening: 0, sold: 0, sales: 0, added: 0, closing: 0 },
    );
  }, [details]);

  const summaryCards = [
    { label: "Opening", value: `${dTotals.opening} Items`, cls: "text-purple-700" },
    { label: "Total Sold", value: `${dTotals.sold} Items`, cls: "text-blue-700" },
    { label: "Sales Value", value: ghs.format(dTotals.sales), cls: "text-green-700" },
    { label: "Qty Added", value: `${dTotals.added} Items`, cls: "text-teal-700" },
    { label: "Closing", value: `${dTotals.closing} Items`, cls: "text-orange-700" },
  ];

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Stock Reports</h1>
          <p className="text-sm text-black/60">Inventory movement by period</p>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          <Input
            type="month"
            aria-label="Start Month"
            value={startMonth}
            onChange={(e) => setStartMonth(e.target.value)}
            className="w-40"
          />
          <span className="text-black/40">→</span>
          <Input
            type="month"
            aria-label="End Month"
            value={endMonth}
            onChange={(e) => setEndMonth(e.target.value)}
            className="w-40"
          />
          {(startMonth || endMonth) && (
            <button
              type="button"
              onClick={() => {
                setStartMonth("");
                setEndMonth("");
              }}
              className="p-1 text-red-600"
              title="Clear month filter"
            >
              <X className="h-4 w-4" />
            </button>
          )}
          <Button
            onClick={() => {
              setError(null);
              setGenOpen(true);
            }}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            Generate New
          </Button>
        </div>
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}

      <DataTable
        loading={loading}
        columns={[
          {
            header: "Generated On",
            accessorKey: "createdAt",
            cell: ({ row }) => formatReportDate(row.original.createdAt),
          },
          {
            header: "Period",
            id: "period",
            cell: ({ row }) =>
              `${periodLabel(row.original)} · ${scopeLabel(row.original)}`,
          },
          {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => (
              <div className="flex items-center gap-1">
                <button
                  type="button"
                  title="View"
                  onClick={() => setDetails(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-blue-600 hover:text-blue-800"
                >
                  <Eye className="h-4 w-4" />
                  View
                </button>
                <button
                  type="button"
                  title="Print"
                  onClick={() => openPreview(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-green-600 hover:text-green-800"
                >
                  <Printer className="h-4 w-4" />
                  Print
                </button>
                <button
                  type="button"
                  title="Delete"
                  onClick={() => setDeleting(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-red-600 hover:text-red-800"
                >
                  <Trash2 className="h-4 w-4" />
                  Delete
                </button>
              </div>
            ),
          },
        ]}
        rows={filtered}
        emptyHint="No reports yet — generate a stock movement report"
      />

      <Dialog open={genOpen} onOpenChange={setGenOpen}>
        <DialogContent className="md:max-w-xl">
          <DialogHeader>
            <DialogTitle>Generate Stock Report</DialogTitle>
          </DialogHeader>
          <p className="text-[13px] text-black/60">
            Pick a date range to see per-item opening quantity, quantity
            sold, sales value, quantity added, and closing quantity. Opening
            and added figures are derived from recorded movements.
          </p>
          <div className="flex gap-2">
            {(
              [
                ["month", "This month"],
                ["7d", "Last 7 days"],
                ["30d", "Last 30 days"],
              ] as const
            ).map(([k, label]) => (
              <Button
                key={k}
                variant="outline"
                size="sm"
                onClick={() => preset(k)}
              >
                {label}
              </Button>
            ))}
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Start
              </Label>
              <Input
                type="date"
                value={gStart}
                onChange={(e) => setGStart(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">End</Label>
              <Input
                type="date"
                value={gEnd}
                onChange={(e) => setGEnd(e.target.value)}
              />
            </div>
          </div>
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Product (optional)
            </Label>
            <SearchableSelect<ProductOption>
              label="Product"
              hint="All products"
              items={products}
              format={(p) => p.name}
              filter={(p, q) =>
                p.name.toLowerCase().includes(q) ||
                p.sku.toLowerCase().includes(q)
              }
              value={gProduct}
              onSelect={(p) => setGProductId(p?.id ?? "")}
            />
          </div>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setGenOpen(false)}>
              Cancel
            </Button>
            <Button
              onClick={() => void generate()}
              disabled={busy}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {busy ? "Generating…" : "Generate"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={!!details} onOpenChange={() => setDetails(null)}>
        <DialogContent className="max-h-[90vh] overflow-y-auto md:max-w-4xl">
          <DialogHeader>
            <DialogTitle>Stock Report Details</DialogTitle>
          </DialogHeader>
          {d && (
            <div className="space-y-3">
              <p className="text-sm text-black/60">
                {periodLabel(d)} · {scopeLabel(d)} -{" "}
                {d.branchName ?? d.data?.branchName ?? ""}
              </p>
              <div className="grid grid-cols-2 gap-2 sm:grid-cols-5">
                {summaryCards.map((c) => (
                  <div
                    key={c.label}
                    className="border border-black/15 bg-white p-2"
                  >
                    <p className="text-[11px] text-black/50">{c.label}</p>
                    <p className={cn("text-sm font-bold", c.cls)}>{c.value}</p>
                  </div>
                ))}
              </div>
              <h3 className="font-bold">Product Breakdown</h3>
              <DataTable
                columns={[
                  { header: "Product", accessorKey: "name" },
                  {
                    header: "Opening",
                    accessorKey: "openingQuantity",
                    cell: ({ row }) => row.original.openingQuantity ?? 0,
                  },
                  {
                    header: "Sold",
                    accessorKey: "quantitySold",
                    cell: ({ row }) => row.original.quantitySold ?? 0,
                  },
                  {
                    header: "Sales Value",
                    accessorKey: "totalSales",
                    cell: ({ row }) => (
                      <span className="font-bold text-green-700">
                        {ghs.format(row.original.totalSales ?? 0)}
                      </span>
                    ),
                  },
                  {
                    header: "Added",
                    accessorKey: "quantityAdded",
                    cell: ({ row }) => row.original.quantityAdded ?? 0,
                  },
                  {
                    header: "Closing",
                    accessorKey: "quantity",
                    cell: ({ row }) => (
                      <span className="font-bold">
                        {row.original.quantity ?? 0}
                      </span>
                    ),
                  },
                ]}
                rows={dStock}
                emptyHint="No items in this report."
              />
              <p className="text-[11px] text-black/50 italic">
                Opening quantities and quantities added are derived from
                recorded stock movements (≈). Generated{" "}
                {formatFullDate(d.createdAt)}.
              </p>
            </div>
          )}
        </DialogContent>
      </Dialog>

      <Dialog open={!!deleting} onOpenChange={() => setDeleting(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Report</DialogTitle>
          </DialogHeader>
          <p className="text-sm">
            Are you sure you want to delete the stock report for{" "}
            {deleting ? periodLabel(deleting) : ""} (
            {deleting ? scopeLabel(deleting) : ""})? This action cannot be
            undone.
          </p>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setDeleting(null)}>
              Cancel
            </Button>
            <Button
              onClick={() => void confirmDelete()}
              disabled={busy}
              className="bg-red-600 text-white hover:bg-red-700"
            >
              {busy ? "Deleting…" : "Delete"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      <PrintPreviewDialog
        open={!!preview}
        title={`Print Preview - ${preview ? reportMonthLabel(rows.find((r) => r.id === preview.id)?.createdAt ?? new Date().toISOString()) : ""}`}
        fileName={`Stock_Report_${preview ? reportMonthLabel(rows.find((r) => r.id === preview.id)?.createdAt ?? new Date().toISOString()) : ""}.pdf`}
        document={preview ? <StockReportDoc doc={preview} /> : null}
        onClose={() => setPreview(null)}
      />
    </div>
  );
}
