"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { History, Minus, Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { adjustStock } from "@/features/inventory/adjust";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type {
  StockAdjustmentRow,
  Synced,
  InventoryRow,
  WaybillItemRow,
  WaybillRow,
} from "@/lib/db/types";
import { formatAuditDate, formatShortDate } from "@/lib/dates";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";
import { cn } from "@/lib/utils";

type Tab = "Manual" | "Waybill";

/**
 * Inventory Control — ported from stock_adjustment_page.dart:
 * Manual Adjustment | Receive from Waybill tabs + audit-log dialog.
 */
export default function AdjustmentsPage() {
  const online = useOnline();
  const { displayName } = useAuth();
  const [tab, setTab] = useState<Tab>("Manual");
  const [products, setProducts] = useState<Synced<InventoryRow>[]>([]);
  const [waybills, setWaybills] = useState<Synced<WaybillRow>[]>([]);
  const [search, setSearch] = useState("");
  const [productId, setProductId] = useState("");
  const [delta, setDelta] = useState("");
  const [reason, setReason] = useState("");
  const [waybillId, setWaybillId] = useState("");
  const [manifest, setManifest] = useState<WaybillItemRow[]>([]);
  const [committing, setCommitting] = useState(false);
  const [receiving, setReceiving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [ok, setOk] = useState<string | null>(null);
  const [logsOpen, setLogsOpen] = useState(false);
  const [logs, setLogs] = useState<StockAdjustmentRow[]>([]);

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    if (online) {
      try {
        const c = createClient();
        await Promise.all([
          remoteFirst.warmInventory(c),
          remoteFirst.warmWaybills(c),
        ]);
      } catch {
        /* local stands */
      }
    }
    const [inv, way] = await Promise.all([
      db.inventory.filter((p) => (p.isDeleted ?? 0) === 0).toArray(),
      db.waybills.toArray(),
    ]);
    setProducts(inv);
    setWaybills(way.filter((w) => (w.isDeleted ?? 0) === 0));
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const filteredProducts = useMemo(() => {
    const q = search.trim().toLowerCase();
    if (!q) return products;
    return products.filter(
      (p) =>
        p.name.toLowerCase().includes(q) ||
        p.sku.toLowerCase().includes(q),
    );
  }, [products, search]);

  const selected = products.find((p) => p.id === productId) ?? null;
  const deltaInt = parseInt(delta, 10);
  const deltaValid = delta.trim() !== "" && !Number.isNaN(deltaInt);
  const canCommit = selected && deltaValid && !committing;

  const commitManual = async () => {
    if (!canCommit || !selected) return;
    setCommitting(true);
    setError(null);
    setOk(null);
    try {
      await adjustStock(online, {
        productId: selected.id,
        quantityChange: deltaInt,
        type: "Manual",
        reason: reason.trim() || null,
        createdBy: displayName || "Admin",
      });
      setOk("Stock adjusted successfully");
      setDelta("");
      setReason("");
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setCommitting(false);
    }
  };

  const selectWaybill = async (id: string) => {
    setWaybillId(id);
    setManifest(
      id ? await db.waybillItems.where("waybill_id").equals(id).toArray() : [],
    );
  };

  const manifestTotal = manifest.reduce((a, i) => a + (i.quantity ?? 0), 0);

  const receiveWaybill = async () => {
    if (!waybillId || receiving) return;
    setReceiving(true);
    setError(null);
    setOk(null);
    try {
      for (const item of manifest) {
        if (!item.product_id) continue;
        await adjustStock(online, {
          productId: item.product_id,
          quantityChange: item.quantity ?? 0,
          type: "Waybill",
          reason: `Received from Waybill: ${waybillId}`,
          referenceId: waybillId,
          createdBy: displayName || "Admin",
        });
      }
      setOk("Waybill stock received successfully");
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setReceiving(false);
    }
  };

  const openLogs = async () => {
    setLogsOpen(true);
    setLogs(await db.stockAdjustments.orderBy("createdAt").reverse().toArray());
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Inventory Control</h1>
          <p className="text-sm text-black/60">
            Precision stock adjustments and inbound receiving
          </p>
        </div>
        <Button variant="outline" onClick={() => void openLogs()}>
          <History className="mr-1 h-4 w-4" />
          View Audit Logs
        </Button>
      </div>

      <div className="flex w-fit overflow-hidden border border-black/20">
        {(["Manual", "Waybill"] as Tab[]).map((t) => (
          <button
            key={t}
            type="button"
            onClick={() => setTab(t)}
            className={cn(
              "px-4 py-2 text-sm font-semibold",
              tab === t
                ? "bg-black text-white"
                : "bg-white text-black hover:bg-black/5",
            )}
          >
            {t === "Manual" ? "Manual Adjustment" : "Receive from Waybill"}
          </button>
        ))}
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}
      {ok && <p className="text-[13px] font-medium text-green-700">{ok}</p>}

      {tab === "Manual" ? (
        <div className="grid gap-4 lg:grid-cols-2">
          <section className="space-y-3 border border-black/15 bg-white p-4">
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Search products
              </Label>
              <Input
                placeholder="Search by name or SKU..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Pick a product
              </Label>
              <select
                value={productId}
                onChange={(e) => setProductId(e.target.value)}
                className="w-full border border-black/20 bg-white px-2 py-2 text-sm"
              >
                <option value="">Select a product</option>
                {filteredProducts.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Quantity Delta
              </Label>
              <Input
                placeholder="+ Increase / - Decrease"
                value={delta}
                onChange={(e) => setDelta(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Reason for Adjustment
              </Label>
              <Input
                placeholder="e.g. Broken packaging, Inbound receipt..."
                value={reason}
                onChange={(e) => setReason(e.target.value)}
              />
            </div>
            <Button
              onClick={() => void commitManual()}
              disabled={!canCommit}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {committing ? "Committing…" : "Commit Adjustment"}
            </Button>
          </section>

          <section className="h-fit border border-black/15 bg-white p-4">
            <h3 className="pb-2 font-bold">Summary of Change</h3>
            {selected && deltaValid ? (
              <div className="space-y-1 text-sm">
                <p>
                  <span className="text-black/60">Status Quo </span>
                  <span className="font-bold">{selected.quantity ?? 0}</span>
                </p>
                <p>
                  <span className="text-black/60">Adjustment </span>
                  <span
                    className={cn(
                      "font-bold",
                      deltaInt >= 0 ? "text-green-700" : "text-red-600",
                    )}
                  >
                    {deltaInt >= 0 ? `+${deltaInt}` : deltaInt}
                  </span>
                </p>
                <p>
                  <span className="text-black/60">Post-Action </span>
                  <span className="font-bold text-blue-700">
                    {(selected.quantity ?? 0) + deltaInt}
                  </span>
                </p>
                <p className="pt-1 text-xs text-black/60">
                  You are modifying {selected.name} ({selected.sku})
                </p>
              </div>
            ) : (
              <p className="text-sm text-black/50">
                Select a product and enter a quantity delta to preview.
              </p>
            )}
          </section>
        </div>
      ) : (
        <div className="grid gap-4 lg:grid-cols-2">
          <section className="space-y-3 border border-black/15 bg-white p-4">
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Active Waybills
              </Label>
              <select
                value={waybillId}
                onChange={(e) => void selectWaybill(e.target.value)}
                className="w-full border border-black/20 bg-white px-2 py-2 text-sm"
              >
                <option value="">Select a waybill</option>
                {waybills.map((w) => (
                  <option key={w.id} value={w.id}>
                    {w.partyName} • {formatShortDate(w.createdAt)}
                  </option>
                ))}
              </select>
            </div>
            <Button
              onClick={() => void receiveWaybill()}
              disabled={!waybillId || manifest.length === 0 || receiving}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {receiving ? "Receiving…" : "Confirm & Transfer to Local Stock"}
            </Button>
          </section>

          <section className="h-fit border border-black/15 bg-white p-4">
            <h3 className="pb-2 font-bold">
              Inbound Goods Manifest{" "}
              <span className="ml-1 bg-black/5 px-2 py-0.5 text-xs">
                {manifest.length} Items
              </span>
            </h3>
            {manifest.length === 0 ? (
              <p className="text-sm text-black/50">
                Select a waybill to preview its goods.
              </p>
            ) : (
              <ul className="divide-y divide-black/10">
                {manifest.map((it) => (
                  <li
                    key={it.id}
                    className="flex justify-between py-1.5 text-sm"
                  >
                    <span className="font-medium">{it.product_name}</span>
                    <span>Qty: {it.quantity}</span>
                  </li>
                ))}
                <li className="flex justify-between py-1.5 text-sm font-bold">
                  <span>Manifest Total</span>
                  <span>{manifestTotal}</span>
                </li>
              </ul>
            )}
          </section>
        </div>
      )}

      <Dialog open={logsOpen} onOpenChange={setLogsOpen}>
        <DialogContent className="max-h-[80vh] overflow-y-auto md:max-w-2xl">
          <DialogHeader>
            <DialogTitle>Adjustment Audit Logs</DialogTitle>
          </DialogHeader>
          <p className="-mt-2 text-[13px] text-black/60">
            Historical record of stock adjustments.
          </p>
          {logs.length === 0 ? (
            <p className="py-8 text-center text-sm text-black/50">
              No adjustment logs yet.
            </p>
          ) : (
            <ul className="divide-y divide-black/10">
              {logs.map((l) => (
                <li key={l.id} className="flex items-center gap-3 py-2">
                  <span
                    className={cn(
                      "flex h-7 w-7 items-center justify-center",
                      l.quantityChange >= 0
                        ? "bg-green-100 text-green-700"
                        : "bg-red-100 text-red-600",
                    )}
                  >
                    {l.quantityChange >= 0 ? (
                      <Plus className="h-4 w-4" />
                    ) : (
                      <Minus className="h-4 w-4" />
                    )}
                  </span>
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-bold">
                      {l.productName}
                    </p>
                    <p className="truncate text-xs text-black/60">
                      {l.type} • {l.reason ?? "No reason provided"}
                    </p>
                  </div>
                  <div>
                    <p
                      className={cn(
                        "text-sm font-bold",
                        l.quantityChange >= 0
                          ? "text-green-700"
                          : "text-red-600",
                      )}
                    >
                      {l.quantityChange >= 0
                        ? `+${l.quantityChange}`
                        : l.quantityChange}
                    </p>
                    <p className="text-[11px] text-black/50">
                      {formatAuditDate(l.createdAt)}
                    </p>
                  </div>
                </li>
              ))}
            </ul>
          )}
          <div className="flex justify-end">
            <Button variant="outline" onClick={() => setLogsOpen(false)}>
              Close
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
