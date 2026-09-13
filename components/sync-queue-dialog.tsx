"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useSync } from "@/lib/sync/sync-context";

/**
 * Sync queue dialog mirroring sync_queue_dialog.dart: online dot,
 * last sync, per-entity pending counts, persisted errors, Sync Now.
 */
const ENTITY_LABELS: Record<string, string> = {
  inventory: "Products",
  saleOrders: "Sales",
  proformas: "Proformas",
  waybills: "Waybills",
  invoices: "Invoices",
  receipts: "Receipts",
  payments: "Payments",
  branchPayments: "Branch payments",
  expenses: "Expenses",
  supplierPayments: "Supplier payments",
  returnOrders: "Returns",
  creditNotes: "Credit notes",
  stockTransfers: "Transfers",
  stockReports: "Stock reports",
};

export function SyncQueueDialog() {
  const {
    online,
    uploading,
    progress,
    pending,
    pendingTotal,
    errors,
    lastUploadAt,
    uploadAll,
  } = useSync();
  const [open, setOpen] = useState(false);
  const errorEntries = Object.entries(errors);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger className="flex items-center gap-1.5 text-[12px] font-medium text-ashfoam-ink/70 hover:text-ashfoam-ink">
        <span
          className={`inline-block h-2 w-2 rounded-full ${online ? "bg-green-600" : "bg-amber-500"}`}
        />
        {pendingTotal > 0 ? `${pendingTotal} waiting` : "Synced"}
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Sync queue</DialogTitle>
        </DialogHeader>
        <div className="space-y-3 text-sm">
          <p className="text-black/60">
            {online ? "Online" : "Offline"}
            {lastUploadAt &&
              ` · Last sync ${new Date(lastUploadAt).toLocaleString()}`}
          </p>
          {uploading && progress && (
            <div className="h-1.5 w-full bg-black/10">
              <div
                className="h-1.5 bg-blue-600 transition-all"
                style={{
                  width: `${Math.round((progress.done / progress.total) * 100)}%`,
                }}
              />
            </div>
          )}
          <ul className="divide-y divide-black/10">
            {Object.entries(pending)
              .filter(([, n]) => n > 0)
              .map(([entity, n]) => (
                <li key={entity} className="flex justify-between py-1.5">
                  <span>{ENTITY_LABELS[entity] ?? entity}</span>
                  <span className="font-semibold">{n}</span>
                </li>
              ))}
            {pendingTotal === 0 && (
              <li className="py-1.5 text-black/60">Queue is empty.</li>
            )}
          </ul>
          {errorEntries.length > 0 && (
            <div className="space-y-1">
              <p className="font-semibold text-red-700">Sync errors</p>
              {errorEntries.map(([entity, msgs]) => (
                <p key={entity} className="text-xs text-red-600">
                  {ENTITY_LABELS[entity] ?? entity}: {msgs[0]}
                </p>
              ))}
            </div>
          )}
          <Button
            onClick={() => void uploadAll()}
            disabled={!online || uploading}
            className="w-full bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            {uploading
              ? `Syncing… ${progress?.currentStep ?? ""}`
              : "Sync now"}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
