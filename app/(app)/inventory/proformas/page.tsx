"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { Eye, Pencil, Printer } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import {
  EMPTY_PROFORMA_FORM,
  ProformaDialog,
  type ProformaFormValues,
} from "@/features/docs/proforma-dialog";
import {
  addProforma,
  updateProforma,
} from "@/features/docs/mutations";
import { docTaxesFromJson } from "@/features/docs/totals";
import type { A4DocItem } from "@/lib/print/a4-table";
import { ProformaDoc, type ProformaDocData } from "@/lib/print/proforma";
import { PrintPreviewDialog } from "@/components/print-preview-dialog";
import type { ProductOption } from "@/features/docs/item-picker";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type {
  ProformaItemRow,
  Synced,
  ProformaRow,
} from "@/lib/db/types";
import { formatDateTime, formatShortDate } from "@/lib/dates";
import { isManager } from "@/lib/roles";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

const PAGE_SIZE = 10;

type DialogState =
  | { kind: "create" }
  | { kind: "edit"; id: string; initial: ProformaFormValues }
  | { kind: "details"; row: Synced<ProformaRow> }
  | null;

/**
 * Profoma Invoices — ported from proforma_page.dart. Create hidden for
 * manager; edit/view allowed. Print lands in P4.
 */
export default function ProformasPage() {
  const online = useOnline();
  const { role } = useAuth();
  const manager = isManager(role);
  const [rows, setRows] = useState<Synced<ProformaRow>[]>([]);
  const [products, setProducts] = useState<ProductOption[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [page, setPage] = useState(0);
  const [dialog, setDialog] = useState<DialogState>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [detailItems, setDetailItems] = useState<ProformaItemRow[]>([]);
  const [preview, setPreview] = useState<{
    doc: ProformaDocData;
    items: A4DocItem[];
  } | null>(null);

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmProformas(createClient());
          await remoteFirst.warmInventory(createClient());
        } catch {
          /* local stands */
        }
      }
      const [docs, inv] = await Promise.all([
        db.proformas.orderBy("created_at").reverse().toArray(),
        db.inventory.filter((p) => (p.isDeleted ?? 0) === 0).toArray(),
      ]);
      setRows(docs.filter((d) => (d.is_deleted ?? 0) === 0));
      setProducts(
        inv.map((p) => ({
          id: p.id,
          name: p.name,
          retailPrice: p.retailPrice ?? 0,
        })),
      );
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    const list = q
      ? rows.filter((r) => (r.party_name ?? "").toLowerCase().includes(q))
      : rows;
    return list;
  }, [rows, query]);

  const pageCount = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const safePage = Math.min(page, pageCount - 1);
  const pageRows = filtered.slice(
    safePage * PAGE_SIZE,
    safePage * PAGE_SIZE + PAGE_SIZE,
  );

  const openEdit = async (row: Synced<ProformaRow>) => {
    setBusy(true);
    try {
      const items = await db.proformaItems
        .where("proforma_id")
        .equals(row.id)
        .toArray();
      setDialog({
        kind: "edit",
        id: row.id,
        initial: {
          partyName: row.party_name ?? "",
          partyAddress: row.party_address ?? "",
          declaration: row.declaration ?? "",
          taxes: docTaxesFromJson(row.tax),
          items: items.map((it) => ({
            key: it.id,
            productId: it.product_id ?? "",
            productName: it.product_name,
            quantity: it.quantity,
            unitPrice: it.unit_price,
            discountPct: it.discount_percentage ?? 0,
            total: it.total_amount,
          })),
        },
      });
    } catch (e) {
      setError(
        `Error opening edit: ${e instanceof Error ? e.message : String(e)}`,
      );
    } finally {
      setBusy(false);
    }
  };

  const openDetails = async (row: Synced<ProformaRow>) => {
    setDialog({ kind: "details", row });
    setDetailItems(
      await db.proformaItems.where("proforma_id").equals(row.id).toArray(),
    );
  };

  const openPreview = async (row: Synced<ProformaRow>) => {
    setBusy(true);
    try {
      const items = await db.proformaItems
        .where("proforma_id")
        .equals(row.id)
        .toArray();
      setPreview({
        doc: {
          id: row.id,
          partyName: row.party_name,
          partyAddress: row.party_address,
          createdAt: row.created_at ?? new Date().toISOString(),
          taxes: docTaxesFromJson(row.tax),
          totalQuantity: row.total_quantity ?? 0,
          totalAmount: row.total_amount ?? 0,
        },
        items: items.map((it) => ({
          productName: it.product_name,
          quantity: it.quantity,
          unitPrice: it.unit_price,
          discountPct: it.discount_percentage ?? 0,
          total: it.total_amount,
        })),
      });
    } catch (e) {
      setError(
        `Error generating print preview: ${e instanceof Error ? e.message : String(e)}`,
      );
    } finally {
      setBusy(false);
    }
  };

  const submit = async (values: ProformaFormValues) => {
    setBusy(true);
    setError(null);
    try {
      if (dialog?.kind === "create") {
        if (manager) throw new Error("Managers can only view proformas");
        await addProforma(online, values);
      } else if (dialog?.kind === "edit") {
        await updateProforma(online, dialog.id, values);
      }
      setDialog(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  const details = dialog?.kind === "details" ? dialog.row : null;

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Proforma Invoices</h1>
          <p className="text-sm text-black/60">
            Manage and issue proforma invoices.
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search by client name..."
            value={query}
            onChange={(e) => {
              setQuery(e.target.value);
              setPage(0);
            }}
            className="w-52"
          />
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
          {!manager && (
            <Button
              onClick={() => setDialog({ kind: "create" })}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              Create New
            </Button>
          )}
        </div>
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}

      <DataTable
        loading={loading}
        columns={[
          {
            header: "Client",
            accessorKey: "party_name",
            cell: ({ row }) => row.original.party_name ?? "Walk-in Client",
          },
          {
            header: "Total Qty",
            accessorKey: "total_quantity",
            cell: ({ row }) => (
              <span>{row.original.total_quantity}</span>
            ),
          },
          {
            header: "Total Amount",
            accessorKey: "total_amount",
            cell: ({ row }) => (
              <span className="font-bold text-blue-700">
                {ghs.format(row.original.total_amount ?? 0)}
              </span>
            ),
          },
          {
            header: "Date",
            accessorKey: "created_at",
            cell: ({ row }) => formatShortDate(row.original.created_at),
          },
          {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => (
              <div className="flex items-center gap-1">
                <button
                  type="button"
                  title="View"
                  onClick={() => void openDetails(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-blue-600 hover:text-blue-800"
                >
                  <Eye className="h-4 w-4" />
                  View
                </button>
                <button
                  type="button"
                  title="Edit"
                  onClick={() => void openEdit(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-orange-600 hover:text-orange-800"
                >
                  <Pencil className="h-4 w-4" />
                  Edit
                </button>
                <button
                  type="button"
                  title="Print"
                  onClick={() => void openPreview(row.original)}
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-green-600 hover:text-green-800"
                >
                  <Printer className="h-4 w-4" />
                  Print
                </button>
              </div>
            ),
          },
        ]}
        rows={pageRows}
        emptyHint="No proformas yet — create a quote to see it here."
      />

      <div className="flex items-center justify-end gap-2 text-sm">
        <Button
          variant="outline"
          size="sm"
          disabled={safePage === 0}
          onClick={() => setPage(safePage - 1)}
        >
          Prev
        </Button>
        <span>
          Page {safePage + 1} of {pageCount}
        </span>
        <Button
          variant="outline"
          size="sm"
          disabled={safePage >= pageCount - 1}
          onClick={() => setPage(safePage + 1)}
        >
          Next
        </Button>
      </div>

      {(dialog?.kind === "create" || dialog?.kind === "edit") && (
        <ProformaDialog
          open
          title={dialog.kind === "create" ? "Create Proforma" : "Edit Proforma"}
          submitLabel={
            dialog.kind === "create" ? "Create Proforma" : "Save Changes"
          }
          initial={
            dialog.kind === "create" ? EMPTY_PROFORMA_FORM : dialog.initial
          }
          products={products}
          busy={busy}
          error={error}
          onClose={() => {
            setDialog(null);
            setError(null);
          }}
          onSubmit={(v) => void submit(v)}
        />
      )}

      <Dialog
        open={dialog?.kind === "details"}
        onOpenChange={() => setDialog(null)}
      >        <DialogContent className="max-h-[90vh] overflow-y-auto md:max-w-2xl">
          <DialogHeader>
            <DialogTitle>Proforma Details</DialogTitle>
          </DialogHeader>
          {details && (
            <div className="space-y-3">
              <dl className="space-y-1.5 text-sm">
                {(
                  [
                    ["Party Name", details.party_name ?? "N/A"],
                    ["Address", details.party_address ?? "N/A"],
                    ["Date", formatDateTime(details.created_at)],
                  ] as [string, string][]
                ).map(([k, v]) => (
                  <div key={k} className="flex justify-between gap-4">
                    <dt className="text-[12px] text-black">{k}</dt>
                    <dd className="text-right text-sm font-bold">{v}</dd>
                  </div>
                ))}
              </dl>
              <h3 className="font-bold">Items &amp; Services</h3>
              <DataTable
                columns={[
                  { header: "Description", accessorKey: "product_name" },
                  {
                    header: "Qty",
                    accessorKey: "quantity",
                    cell: ({ row }) => (
                      <span>{row.original.quantity}</span>
                    ),
                  },
                  {
                    header: "Rate",
                    accessorKey: "unit_price",
                    cell: ({ row }) => (
                      <span>{ghs.format(row.original.unit_price ?? 0)}</span>
                    ),
                  },
                  {
                    header: "Total",
                    accessorKey: "total_amount",
                    cell: ({ row }) => (
                      <span className="font-bold">{ghs.format(row.original.total_amount ?? 0)}</span>
                    ),
                  },
                ]}
                rows={detailItems}
                emptyHint="No items."
              />
              <p className="text-right text-[18px] font-bold text-blue-700">
                Grand Total: {ghs.format(details.total_amount ?? 0)}
              </p>
              {details.declaration && (
                <div>
                  <p className="text-[12px] font-bold">Declaration:</p>
                  <p className="text-[11px] text-black/60">
                    {details.declaration}
                  </p>
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>

      <PrintPreviewDialog
        open={!!preview}
        title={`Proforma Preview - ${preview?.doc.partyName ?? "Client"}`}
        fileName={`Proforma_${(preview?.doc.id ?? "").substring(0, 8)}.pdf`}
        document={
          preview ? (
            <ProformaDoc doc={preview.doc} items={preview.items} />
          ) : null
        }
        onClose={() => setPreview(null)}
      />
    </div>
  );
}
