"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { ReceiptText } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";
import { db } from "@/lib/db/dexie";
import type {
  Synced,
  BranchPaymentRow,
  InventoryRow,
  ProformaRow,
  SaleOrderRow,
  WaybillRow,
} from "@/lib/db/types";
import {
  formatCompact,
  formatLongDate,
} from "@/lib/dates";
import { ghs } from "@/lib/taxes";
import { cn } from "@/lib/utils";

type TrendTimeframe = "daily" | "weekly" | "monthly" | "yearly";

const DAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MONTHS = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];

/**
 * Business overview — ported from summary_page.dart + summary_providers.dart.
 * Aggregates Dexie (warmed when online); CSS bar trend (replaces
 * SfCartesianChart ColumnSeries); timeframe bucketing mirrors
 * salesTrendProvider.
 */
export default function SummaryPage() {
  const online = useOnline();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [inventory, setInventory] = useState<Synced<InventoryRow>[]>([]);
  const [sales, setSales] = useState<Synced<SaleOrderRow>[]>([]);
  const [payments, setPayments] = useState<Synced<BranchPaymentRow>[]>([]);
  const [proformas, setProformas] = useState<Synced<ProformaRow>[]>([]);
  const [waybills, setWaybills] = useState<Synced<WaybillRow>[]>([]);
  const [timeframe, setTimeframe] = useState<TrendTimeframe>("daily");

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          const c = createClient();
          await Promise.all([
            remoteFirst.warmInventory(c),
            remoteFirst.warmSaleOrders(c),
            remoteFirst.warmBranchPayments(c),
            remoteFirst.warmProformas(c),
            remoteFirst.warmWaybills(c),
          ]);
        } catch {
          /* local stands */
        }
      }
      const [inv, ord, pay, prof, way] = await Promise.all([
        db.inventory.toArray(),
        db.saleOrders.toArray(),
        db.branchPayments.toArray(),
        db.proformas.toArray(),
        db.waybills.toArray(),
      ]);
      setInventory(inv);
      setSales(ord);
      setPayments(pay);
      setProformas(prof);
      setWaybills(way);
      setError(null);
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const stats = useMemo(() => {
    const totalSales = sales.reduce((a, o) => a + (o.totalAmount ?? 0), 0);
    const totalPayments = payments.reduce((a, p) => a + (p.amount ?? 0), 0);
    const lowStock = inventory.filter((p) => (p.quantity ?? 0) < 10);
    return {
      totalInventory: inventory.length,
      totalSales,
      totalPayments,
      totalProformas: proformas.length,
      totalWaybills: waybills.length,
      lowStockCount: lowStock.length,
    };
  }, [inventory, sales, payments, proformas, waybills]);

  const trend = useMemo(() => {
    const now = new Date();
    const labels: string[] = [];
    const keyOf = (t: Date): string => {
      if (timeframe === "daily") return DAYS[t.getDay()];
      if (timeframe === "weekly")
        return `Wk ${Math.floor((t.getDate() - 1) / 7) + 1} ${MONTHS[t.getMonth()]}`;
      if (timeframe === "monthly") return MONTHS[t.getMonth()];
      return String(t.getFullYear());
    };
    if (timeframe === "daily") {
      for (let i = 6; i >= 0; i--) {
        const t = new Date(now);
        t.setDate(now.getDate() - i);
        labels.push(DAYS[t.getDay()]);
      }
    } else if (timeframe === "weekly") {
      for (let i = 3; i >= 0; i--) {
        const t = new Date(now);
        t.setDate(now.getDate() - i * 7);
        labels.push(
          `Wk ${Math.floor((t.getDate() - 1) / 7) + 1} ${MONTHS[t.getMonth()]}`,
        );
      }
    } else if (timeframe === "monthly") {
      for (let i = 5; i >= 0; i--) {
        const t = new Date(now.getFullYear(), now.getMonth() - i, 1);
        labels.push(MONTHS[t.getMonth()]);
      }
    } else {
      for (let i = 4; i >= 0; i--) labels.push(String(now.getFullYear() - i));
    }
    const buckets = new Map(labels.map((l) => [l, 0]));
    for (const o of sales) {
      if (!o.createdAt) continue;
      const t = new Date(o.createdAt);
      if (Number.isNaN(t.getTime())) continue;
      const k = keyOf(t);
      if (buckets.has(k))
        buckets.set(k, (buckets.get(k) ?? 0) + (o.totalAmount ?? 0));
    }
    return labels.map((l) => ({ label: l, value: buckets.get(l) ?? 0 }));
  }, [sales, timeframe]);

  const trendTotal = trend.reduce((a, b) => a + b.value, 0);
  const trendMax = Math.max(0, ...trend.map((t) => t.value));
  const recent = useMemo(
    () =>
      [...sales]
        .sort((a, b) =>
          String(b.createdAt ?? "").localeCompare(String(a.createdAt ?? "")),
        )
        .slice(0, 5),
    [sales],
  );

  const cards = [
    {
      label: "All inventory",
      value: String(stats.totalInventory),
      caption: `${stats.lowStockCount} low stock`,
      accent: stats.lowStockCount > 0,
    },
    {
      label: "Recent sales",
      value: ghs.format(stats.totalSales),
      caption: "Gross revenue",
      accent: false,
    },
    {
      label: "Total payments",
      value: ghs.format(stats.totalPayments),
      caption: "Collected to date",
      accent: false,
    },
    {
      label: "Proformas",
      value: String(stats.totalProformas),
      caption: "Pending quotes",
      accent: false,
    },
    {
      label: "Waybills",
      value: String(stats.totalWaybills),
      caption: "Dispatched orders",
      accent: false,
    },
    {
      label: "Low stock",
      value: String(stats.lowStockCount),
      caption:
        stats.lowStockCount > 0 ? "Action required — needs attention" : "Needs attention",
      accent: stats.lowStockCount > 0,
    },
  ];

  return (
    <div className="mx-auto max-w-7xl space-y-7">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-2xl font-extrabold text-black">Business overview</h1>
          <p className="text-base font-medium text-black">
            Real-time performance from inventory, sales and dispatch.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <span className="flex items-center gap-1.5 border border-black/15 px-2 py-1 text-sm font-semibold text-black">
            <span className="inline-block h-2 w-2 rounded-full bg-black" />
            Live · {formatLongDate()}
          </span>
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
        </div>
      </div>

      {error && (
        <p className="text-sm font-medium text-red-600">
          Couldn&apos;t load overview — {error}
        </p>
      )}

      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        {cards.map((c) => (
          <div
            key={c.label}
            className={cn(
              "border bg-white p-4",
              c.accent ? "border-red-500" : "border-black",
            )}
          >
            <p className="text-[13px] font-semibold tracking-wider text-black uppercase">
              {c.label}
            </p>
            <div className="pt-1 text-[22px] font-extrabold text-black">
              {loading ? <LoadingSpinner size="sm" className="items-start justify-start py-1" /> : c.value}
            </div>
            <p className="pt-0.5 text-[13px] font-medium text-black">{c.caption}</p>
          </div>
        ))}
      </div>

      <section className="border border-black/15 bg-white p-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <p className="text-[13px] font-semibold tracking-wider text-black uppercase">
              Sales trend
            </p>
            <p className="text-2xl font-extrabold text-black">
              {new Intl.NumberFormat("en-GH", {
                style: "currency",
                currency: "GHS",
                maximumFractionDigits: 0,
              }).format(trendTotal)}{" "}
              <span className="text-sm font-semibold text-black">
                •{" "}
                {trendTotal > 0
                  ? timeframe.charAt(0).toUpperCase() + timeframe.slice(1)
                  : "No sales in period"}
              </span>
            </p>
          </div>
          <div className="flex overflow-hidden border border-black/20">
            {(["daily", "weekly", "monthly", "yearly"] as TrendTimeframe[]).map(
              (t) => (
                <button
                  key={t}
                  type="button"
                  onClick={() => setTimeframe(t)}
                  className={cn(
                    "px-3 py-1.5 text-sm font-semibold capitalize",
                    timeframe === t
                      ? "bg-black text-white"
                      : "bg-white text-black hover:bg-black/5",
                  )}
                >
                  {t}
                </button>
              ),
            )}
          </div>
        </div>
        {trendTotal === 0 ? (
          <p className="py-10 text-center text-base font-medium text-black">
            No sales in this period — switch timeframe or create a sale in
            POS.
          </p>
        ) : (
          <div className="flex h-80 items-end gap-2 pt-4">
            {trend.map((b) => (
              <div
                key={b.label}
                className="flex min-w-0 flex-1 flex-col items-center gap-1"
                title={`${b.label}: ${ghs.format(b.value)}`}
              >
                <span className="text-[13px] font-semibold text-black">
                  {trend.length <= 7 && b.value > 0
                    ? new Intl.NumberFormat("en-GH", {
                        notation: "compact",
                      }).format(b.value)
                    : ""}
                </span>
                <div
                  className="w-full max-w-14 bg-black"
                  style={{
                    height: `${trendMax > 0 ? Math.max(4, (b.value / trendMax) * 220) : 4}px`,
                  }}
                />
                <span className="truncate text-[13px] font-medium text-black">
                  {b.label}
                </span>
              </div>
            ))}
          </div>
        )}
        <p className="pt-3 text-sm font-medium text-black">
          Tap a bar for exact value. Figures from local sales ledger.
        </p>
      </section>

      <section className="space-y-2">
        <h2 className="text-lg font-bold text-black">Recent transactions</h2>
        <p className="text-sm font-medium text-black">
          Latest 5 sales. Full history in the sales module.
        </p>
        <div className="border border-black/15 bg-white p-4">
          <p className="flex items-center gap-2 pb-2 text-[13px] font-semibold tracking-wider text-black uppercase">
            <ReceiptText className="h-4 w-4" />
            Recent sales
          </p>
          <DataTable
            loading={loading}
            columns={[
              {
                header: "Order",
                accessorKey: "orderNumber",
                cell: ({ row }) =>
                  (row.original.orderNumber ?? "")
                    .slice(0, 8)
                    .toUpperCase(),
              },
              {
                header: "Date",
                accessorKey: "createdAt",
                cell: ({ row }) => formatCompact(row.original.createdAt),
              },
              {
                header: "Customer",
                accessorKey: "customerName",
                cell: ({ row }) => row.original.customerName ?? "Walk-in",
              },
              {
                header: "Amount",
                accessorKey: "totalAmount",
                cell: ({ row }) => (
                  <span className="font-bold">
                    {ghs.format(row.original.totalAmount ?? 0)}
                  </span>
                ),
              },
            ]}
            rows={recent}
            emptyHint="No sales yet — create one in Point of Sale."
          />
        </div>
      </section>
    </div>
  );
}
