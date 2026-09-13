"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useRef, useState } from "react";
import { CloudOff, Plus, Trash2 } from "lucide-react";
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
import { Textarea } from "@/components/ui/textarea";
import {
  createSupplierPayment,
  listSupplierPayments,
  listSuppliers,
  removeSupplierPayment,
} from "@/features/suppliers/mutations";
import type { SupplierPaymentRow, SupplierRow } from "@/lib/db/types";
import { formatFullDate, toIsoDate } from "@/lib/dates";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";

/**
 * Supplier Payments — ported from supplier_payments.dart. Online-only
 * with offline banner. Supplier names resolved locally (Flutter showed
 * the raw FK id).
 */
export default function SupplierPaymentsPage() {
  const online = useOnline();
  const [suppliers, setSuppliers] = useState<SupplierRow[]>([]);
  const [rows, setRows] = useState<SupplierPaymentRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedSupplier, setSelectedSupplier] = useState("");
  const [recordOpen, setRecordOpen] = useState(false);
  const [amount, setAmount] = useState("");
  const [date, setDate] = useState(toIsoDate());
  const [note, setNote] = useState("");
  const [dialogSupplier, setDialogSupplier] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [deleting, setDeleting] = useState<SupplierPaymentRow | null>(null);

  const dataVersion = useDataVersion();
  const loadedOnce = useRef(false);
  const load = useCallback(async () => {
    setError(null);
    try {
      const [sups, pays] = await Promise.all([
        listSuppliers(online).catch(() => [] as SupplierRow[]),
        listSupplierPayments(online),
      ]);
      setSuppliers(sups);
      setRows(pays);
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setRows([]);
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    const first = !loadedOnce.current;
    loadedOnce.current = true;
    if (first) setLoading(true);
    void load();
  }, [load, dataVersion]);

  const nameOf = (supplierId: string) =>
    suppliers.find((s) => s.id === supplierId)?.name ??
    supplierId.slice(0, 8).toUpperCase();

  const record = async () => {
    setBusy(true);
    setError(null);
    try {
      await createSupplierPayment(online, {
        supplierId: dialogSupplier,
        amount: parseFloat(amount) || 0,
        note: note.trim() || null,
        date,
      });
      setRecordOpen(false);
      setAmount("");
      setNote("");
      setDate(toIsoDate());
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  const confirmDelete = async () => {
    if (!deleting) return;
    setBusy(true);
    try {
      await removeSupplierPayment(online, deleting.id);
      setDeleting(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setDeleting(null);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Supplier Payments</h1>
          <p className="text-sm text-black/60">
            Track payments made to suppliers
          </p>
        </div>
        <div className="flex items-center gap-2">
          <select
            value={selectedSupplier}
            onChange={(e) => setSelectedSupplier(e.target.value)}
            className="w-52 border border-black/20 bg-white px-2 py-2 text-sm"
          >
            <option value="">All suppliers</option>
            {suppliers.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
          <Button
            onClick={() => {
              setError(null);
              setDialogSupplier(selectedSupplier);
              setRecordOpen(true);
            }}
            disabled={!online}
            title={online ? "Record payment" : "Connect to internet to record"}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90 disabled:opacity-50"
          >
            <Plus className="mr-1 h-4 w-4" />
            Record Payment
          </Button>
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
        </div>
      </div>

      {!online && (
        <p className="flex items-center gap-2 border border-orange-300 bg-orange-50 px-3 py-2 text-[13px] text-orange-800">
          <CloudOff className="h-4 w-4" />
          You are offline. Supplier payments are online-only and unavailable
          until you reconnect.
        </p>
      )}
      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}

      <DataTable
        loading={loading}
        columns={[
          {
            header: "Supplier",
            accessorKey: "supplier_id",
            cell: ({ row }) => nameOf(row.original.supplier_id),
          },
          {
            header: "Amount (GHS)",
            accessorKey: "amount",
            cell: ({ row }) => (
              <span className="font-semibold text-green-700">
                {ghs.format(Number(row.original.amount ?? 0))}
              </span>
            ),
          },
          {
            header: "Date",
            accessorKey: "created_at",
            cell: ({ row }) => formatFullDate(row.original.created_at),
          },
          {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => (
              <div className="flex justify-center">
                <button
                  type="button"
                  title={
                    online
                      ? "Delete payment"
                      : "Connect to internet to delete"
                  }
                  disabled={!online}
                  onClick={() => setDeleting(row.original)}
                  className="p-1 text-red-600 hover:text-red-800 disabled:opacity-40"
                >
                  <Trash2 className="h-4 w-4" />
                </button>
              </div>
            ),
          },
        ]}
        rows={rows}
        emptyHint="No supplier payments for this filter — record one"
      />

      <Dialog open={recordOpen} onOpenChange={setRecordOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Record Payment</DialogTitle>
          </DialogHeader>
          <div className="space-y-3">
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Supplier *
              </Label>
              <select
                value={dialogSupplier}
                onChange={(e) => setDialogSupplier(e.target.value)}
                className="w-full border border-black/20 bg-white px-2 py-2 text-sm"
              >
                <option value="">Select a supplier</option>
                {suppliers.map((s) => (
                  <option key={s.id} value={s.id}>
                    {s.name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Amount (GH₵) *
              </Label>
              <Input
                type="number"
                placeholder="Enter amount paid"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Date *
              </Label>
              <Input
                type="date"
                value={date}
                onChange={(e) => setDate(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">Note</Label>
              <Textarea
                rows={2}
                placeholder="Payment description or reference"
                value={note}
                onChange={(e) => setNote(e.target.value)}
              />
            </div>
          </div>
          <div className="flex justify-end gap-2 pt-1">
            <Button variant="outline" onClick={() => setRecordOpen(false)}>
              Cancel
            </Button>
            <Button
              onClick={() => void record()}
              disabled={busy}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {busy ? "Saving…" : "Save Payment"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={!!deleting} onOpenChange={() => setDeleting(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Payment</DialogTitle>
          </DialogHeader>
          <p className="text-sm">
            Are you sure you want to delete this payment record?
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
    </div>
  );
}
