"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { Eye, Pencil, Printer, Truck } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import type { ProductOption } from "@/features/docs/item-picker";
import {
  addWaybill,
  updateWaybill,
} from "@/features/docs/mutations";
import { docTaxesFromJson } from "@/features/docs/totals";
import type { A4DocItem } from "@/lib/print/a4-table";
import { WaybillDoc, type WaybillDocData } from "@/lib/print/waybill";
import { PrintPreviewDialog } from "@/components/print-preview-dialog";
import {
  EMPTY_WAYBILL_FORM,
  WaybillDialog,
  type ProformaOption,
  type WaybillFormValues,
} from "@/features/docs/waybill-dialog";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type {
  Synced,
  WaybillItemRow,
  WaybillRow,
} from "@/lib/db/types";
import { formatFullDate, toIsoDate } from "@/lib/dates";
import { isManager } from "@/lib/roles";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

const PAGE_SIZE = 10;

type DialogState =
  | { kind: "create" }
  | { kind: "edit"; id: string; initial: WaybillFormValues }
  | { kind: "details"; row: Synced<WaybillRow> }
  | null;

/**
 * Dispatch Waybills — ported from waybill_page.dart. Generate hidden for
 * manager (edit allowed). Proforma import supported. Print lands in P4.
 */
export default function WaybillsPage() {
  const online = useOnline();
  const { role, displayName } = useAuth();
  const manager = isManager(role);
  const [rows, setRows] = useState<Synced<WaybillRow>[]>([]);
  const [products, setProducts] = useState<ProductOption[]>([]);
  const [proformas, setProformas] = useState<ProformaOption[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [page, setPage] = useState(0);
  const [dialog, setDialog] = useState<DialogState>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Auto-dismiss errors after 5 seconds
  useEffect(() => {
    if (!error) return;
    const t = setTimeout(() => setError(null), 5000);
    return () => clearTimeout(t);
  }, [error]);
  const [detailItems, setDetailItems] = useState<WaybillItemRow[]>([]);
  const [preview, setPreview] = useState<{
    doc: WaybillDocData;
    items: A4DocItem[];
  } | null>(null);

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmWaybills(createClient());
          await remoteFirst.warmInventory(createClient());
          await remoteFirst.warmProformas(createClient());
        } catch {
          /* local stands */
        }
      }
      const [docs, inv, profs] = await Promise.all([
        db.waybills.orderBy("createdAt").reverse().toArray(),
        db.inventory.filter((p) => (p.isDeleted ?? 0) === 0).toArray(),
        db.proformas.toArray(),
      ]);
      setRows(docs.filter((d) => (d.isDeleted ?? 0) === 0));
      setProducts(
        inv.map((p) => ({
          id: p.id,
          name: p.name,
          retailPrice: p.retailPrice ?? 0,
        })),
      );
      setProformas(
        profs
          .filter((p) => (p.is_deleted ?? 0) === 0)
          .map((p) => ({
            id: p.id,
            partyName: p.party_name,
            totalAmount: p.total_amount ?? 0,
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
    if (!q) return rows;
    return rows.filter(
      (r) =>
        r.orderNumber.toLowerCase().includes(q) ||
        r.partyName.toLowerCase().includes(q) ||
        r.dispatchDocNumber.toLowerCase().includes(q),
    );
  }, [rows, query]);

  const pageCount = Math.max(1, Math.ceil(filtered.length / PAGE_SIZE));
  const safePage = Math.min(page, pageCount - 1);
  const pageRows = filtered.slice(
    safePage * PAGE_SIZE,
    safePage * PAGE_SIZE + PAGE_SIZE,
  );

  const importProforma = async (id: string) => {
    const prof = await db.proformas.get(id);
    if (!prof) return null;
    const items = await db.proformaItems
      .where("proforma_id")
      .equals(id)
      .toArray();
    return {
      partyName: prof.party_name ?? "",
      destination: prof.party_address ?? "",
      taxes: docTaxesFromJson(prof.tax),
      items: items.map((it) => ({
        key: it.id,
        productId: it.product_id ?? "",
        productName: it.product_name,
        quantity: it.quantity,
        unitPrice: it.unit_price,
        discountPct: it.discount_percentage ?? 0,
        total: it.total_amount,
      })),
    };
  };

  const openEdit = async (row: Synced<WaybillRow>) => {
    setBusy(true);
    try {
      const items = await db.waybillItems
        .where("waybill_id")
        .equals(row.id)
        .toArray();
      setDialog({
        kind: "edit",
        id: row.id,
        initial: {
          orderNumber: row.orderNumber,
          dispatchDocNumber: row.dispatchDocNumber,
          driverName: row.senderName,
          destination: row.destination,
          partyName: row.partyName,
          dispatchDate: row.dispatchDate
            ? toIsoDate(new Date(row.dispatchDate))
            : toIsoDate(),
          deliveryNote: row.deliveryNote ?? "",
          taxes: docTaxesFromJson(
            (row.mainContent as { tax?: unknown } | null)?.tax,
          ),
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

  const openDetails = async (row: Synced<WaybillRow>) => {
    setDialog({ kind: "details", row });
    setDetailItems(
      await db.waybillItems.where("waybill_id").equals(row.id).toArray(),
    );
  };

  const openPreview = async (row: Synced<WaybillRow>) => {
    setBusy(true);
    try {
      const items = await db.waybillItems
        .where("waybill_id")
        .equals(row.id)
        .toArray();
      const main = (row.mainContent ?? {}) as {
        tax?: unknown;
        totalQuantity?: number;
        totalAmount?: number;
      };
      setPreview({
        doc: {
          id: row.id,
          orderNumber: row.orderNumber,
          dispatchDocNumber: row.dispatchDocNumber,
          deliveryNote: row.deliveryNote ?? "",
          senderName: row.senderName,
          destination: row.destination,
          dispatchDate: row.dispatchDate,
          partyName: row.partyName,
          taxes: docTaxesFromJson(main.tax),
          totalQuantity: main.totalQuantity ?? 0,
          totalAmount: main.totalAmount ?? 0,
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
        `Error generating preview: ${e instanceof Error ? e.message : String(e)}`,
      );
    } finally {
      setBusy(false);
    }
  };

  const submit = async (values: WaybillFormValues) => {
    setBusy(true);
    setError(null);
    try {
      if (dialog?.kind === "create") {
        if (manager) throw new Error("Managers can only view waybills");
        await addWaybill(online, displayName || "Administrator", values);
      } else if (dialog?.kind === "edit") {
        await updateWaybill(online, dialog.id, {
          ...values,
          dispatchDocNumber:
            values.dispatchDocNumber || `WB-${Date.now().toString().slice(-6)}`,
        });
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
  const detailsMain = (details?.mainContent ?? {}) as {
    totalAmount?: number;
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Dispatch Waybills</h1>
          <p className="text-sm text-black/60">
            Manage and dispatch products to clients
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search by Order # or Client..."
            value={query}
            onChange={(e) => {
              setQuery(e.target.value);
              setPage(0);
            }}
            className="w-60"
          />
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
          {!manager && (
            <Button
              onClick={() => setDialog({ kind: "create" })}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              <Truck className="mr-1 h-4 w-4" />
              Generate Waybill
            </Button>
          )}
        </div>
      </div>

      {error && (
        <div className="rounded-md bg-red-50 px-4 py-3 text-[13px] font-medium text-red-700 shadow-sm">
          {error}
        </div>
      )}

      <DataTable
        loading={loading}
        columns={[
          { header: "Order #", accessorKey: "orderNumber" },
          { header: "Client Name", accessorKey: "partyName" },
          { header: "Driver", accessorKey: "senderName" },
          { header: "Destination", accessorKey: "destination" },
          {
            header: "Dispatch Date",
            accessorKey: "dispatchDate",
            cell: ({ row }) => formatFullDate(row.original.dispatchDate),
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
        emptyHint="No waybills yet — generate a dispatch to track it."
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
        <WaybillDialog
          open
          mode={dialog.kind}
          initial={
            dialog.kind === "create" ? EMPTY_WAYBILL_FORM : dialog.initial
          }
          products={products}
          proformas={proformas}
          busy={busy}
          error={error}
          onClose={() => {
            setDialog(null);
            setError(null);
          }}
          onImportProforma={importProforma}
          onSubmit={(v) => void submit(v)}
        />
      )}

      <Dialog
        open={dialog?.kind === "details"}
        onOpenChange={() => setDialog(null)}
      >
        <DialogContent className="max-h-[90vh] overflow-y-auto md:max-w-2xl">
          <DialogHeader>
            <DialogTitle>
              Waybill Details · Doc #: {details?.dispatchDocNumber}
            </DialogTitle>
          </DialogHeader>
          {details && (
            <div className="space-y-3">
              <span className="inline-block bg-blue-100 px-2 py-0.5 text-[11px] font-bold text-blue-700">
                DISPATCHED
              </span>
              <dl className="grid grid-cols-2 gap-x-6 gap-y-1.5 text-sm md:grid-cols-3">
                {(
                  [
                    ["Order Number", details.orderNumber],
                    ["Dispatch Date", formatFullDate(details.dispatchDate)],
                    ["Driver", details.senderName],
                    ["Client / Party", details.partyName],
                    ["Destination", details.destination],
                    ["Created By", details.createdBy],
                  ] as [string, string][]
                ).map(([k, v]) => (
                  <div key={k}>
                    <dt className="text-[11px] text-black/60">{k}</dt>
                    <dd className="font-bold">{v}</dd>
                  </div>
                ))}
              </dl>
              <h3 className="font-bold">Dispatched Items</h3>
              <DataTable
                columns={[
                  { header: "Product Name", accessorKey: "product_name" },
                  {
                    header: "Quantity",
                    accessorKey: "quantity",
                    cell: ({ row }) => (
                      <span>{row.original.quantity}</span>
                    ),
                  },
                ]}
                rows={detailItems}
                emptyHint="No items."
              />
              <p className="text-right text-[18px] font-bold text-blue-700">
                GRAND TOTAL: {ghs.format(detailsMain.totalAmount ?? 0)}
              </p>
              {details.deliveryNote && (
                <div>
                  <p className="text-[12px] font-bold">Delivery Notes</p>
                  <p className="text-sm text-black/70">
                    {details.deliveryNote}
                  </p>
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>

      <PrintPreviewDialog
        open={!!preview}
        title={`Waybill Preview - ${preview?.doc.orderNumber ?? ""}`}
        fileName={`Waybill_${preview?.doc.dispatchDocNumber ?? ""}.pdf`}
        document={
          preview ? (
            <WaybillDoc doc={preview.doc} items={preview.items} />
          ) : null
        }
        onClose={() => setPreview(null)}
      />
    </div>
  );
}
