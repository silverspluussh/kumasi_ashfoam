"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import { Input } from "@/components/ui/input";
import {
  PaymentDialog,
  type PaymentFormValues,
} from "@/features/payments/payment-dialog";
import { addBranchPayment } from "@/features/payments/mutations";
import { downloadPaymentsExport } from "@/lib/excel/excel";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type { Synced, BranchPaymentRow } from "@/lib/db/types";
import { formatPaymentDate } from "@/lib/dates";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

/**
 * Payments — ported from payments_page.dart. Branch payments only
 * (ashfoam_payments has no Flutter UI). Export lands in P4.
 */
export default function PaymentsPage() {
  const online = useOnline();
  const { displayName } = useAuth();
  const [rows, setRows] = useState<Synced<BranchPaymentRow>[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [dialogOpen, setDialogOpen] = useState(false);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const dataVersion = useDataVersion();
  const loadedOnce = useRef(false);
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmBranchPayments(createClient());
        } catch {
          /* local stands */
        }
      }
      setRows(await db.branchPayments.orderBy("created_at").reverse().toArray());
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

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter(
      (r) =>
        (r.title ?? "").toLowerCase().includes(q) ||
        (r.branch_name ?? "").toLowerCase().includes(q),
    );
  }, [rows, query]);

  const submit = async (values: PaymentFormValues) => {
    setBusy(true);
    setError(null);
    setNotice(null);
    try {
      const { synced } = await addBranchPayment(online, {
        ...values,
        createdBy: displayName || "Admin",
      });
      setNotice(
        synced
          ? "Payment recorded — synced"
          : "Saved locally — will sync when online",
      );
      setDialogOpen(false);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Payments</h1>
          <p className="text-sm text-black/60">Manage payments</p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search payments or branches..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-60"
          />
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
          <Button
            variant="outline"
            onClick={() =>
              downloadPaymentsExport(
                filtered.map((r) => ({
                  title: r.title,
                  branch_name: r.branch_name,
                  amount: r.amount ?? 0,
                  note: r.note,
                  created_at: r.created_at,
                })),
              )
            }
          >
            Export
          </Button>
          <Button
            onClick={() => {
              setError(null);
              setDialogOpen(true);
            }}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            <Plus className="mr-1 h-4 w-4" />
            Add New
          </Button>
        </div>
      </div>

      {notice && (
        <p className="text-[13px] font-medium text-green-700">{notice}</p>
      )}

      <DataTable
        loading={loading}
        columns={[
          { header: "Title", accessorKey: "title" },
          { header: "Branch", accessorKey: "branch_name" },
          {
            header: "Amount",
            accessorKey: "amount",
            cell: ({ row }) => (
              <span className="text-[12px] font-semibold text-green-700">
                {ghs.format(row.original.amount ?? 0)}
              </span>
            ),
          },
          {
            header: "Date",
            accessorKey: "created_at",
            cell: ({ row }) => formatPaymentDate(row.original.created_at),
          },
        ]}
        rows={filtered}
        emptyHint="No branch payments yet — record a payment"
      />

      {dialogOpen && (
        <PaymentDialog
          open
          busy={busy}
          error={error}
          onClose={() => setDialogOpen(false)}
          onSubmit={(v) => void submit(v)}
        />
      )}
    </div>
  );
}
