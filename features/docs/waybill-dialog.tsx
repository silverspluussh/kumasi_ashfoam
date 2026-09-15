"use client";

import { useEffect, useMemo, useState } from "react";
import { Plus, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { SearchableSelect } from "@/components/searchable-select";
import { Textarea } from "@/components/ui/textarea";
import { ItemPicker, type ProductOption } from "./item-picker";
import { TaxPicker } from "./tax-picker";
import {
  computeTotals,
  type DocItem,
  type DocTax,
} from "./totals";
import { toIsoDate } from "@/lib/dates";
import { ghs } from "@/lib/taxes";

export interface ProformaOption {
  id: string;
  partyName: string | null;
  totalAmount: number;
}

export interface WaybillFormValues {
  orderNumber: string;
  dispatchDocNumber: string;
  driverName: string;
  destination: string;
  partyName: string;
  dispatchDate: string; // yyyy-MM-dd
  deliveryNote: string;
  taxes: DocTax[];
  items: DocItem[];
}

interface WaybillDialogProps {
  open: boolean;
  mode: "create" | "edit";
  initial: WaybillFormValues;
  products: ProductOption[];
  proformas: ProformaOption[];
  busy: boolean;
  error: string | null;
  onClose: () => void;
  onImportProforma: (id: string) => Promise<{
    partyName: string;
    destination: string;
    taxes: DocTax[];
    items: DocItem[];
  } | null>;
  onSubmit: (values: WaybillFormValues) => void;
}

/** Generate/Edit waybill — ported from create/edit_waybill_dialog.dart. */
export function WaybillDialog({
  open,
  mode,
  initial,
  products,
  proformas,
  busy,
  error,
  onClose,
  onImportProforma,
  onSubmit,
}: WaybillDialogProps) {
  const [orderNumber, setOrderNumber] = useState("");
  const [dispatchDocNumber, setDispatchDocNumber] = useState("");
  const [driverName, setDriverName] = useState("");
  const [destination, setDestination] = useState("");
  const [partyName, setPartyName] = useState("");
  const [dispatchDate, setDispatchDate] = useState(toIsoDate());
  const [deliveryNote, setDeliveryNote] = useState("");
  const [taxes, setTaxes] = useState<DocTax[]>([]);
  const [items, setItems] = useState<DocItem[]>([]);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [touched, setTouched] = useState(false);

  useEffect(() => {
    if (open) {
      setOrderNumber(initial.orderNumber);
      setDispatchDocNumber(initial.dispatchDocNumber);
      setDriverName(initial.driverName);
      setDestination(initial.destination);
      setPartyName(initial.partyName);
      setDispatchDate(initial.dispatchDate || toIsoDate());
      setDeliveryNote(initial.deliveryNote);
      setTaxes(initial.taxes);
      setItems(initial.items);
      setTouched(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open ]);

  const totals = useMemo(() => computeTotals(items, taxes), [items, taxes]);
  const driverOk = driverName.trim().length > 0;
  const destOk = destination.trim().length > 0;
  const partyOk = partyName.trim().length > 0;

  const submit = () => {
    setTouched(true);
    if (!driverOk || !destOk || !partyOk || items.length === 0 || busy) return;
    onSubmit({
      orderNumber: orderNumber.trim(),
      dispatchDocNumber: dispatchDocNumber.trim(),
      driverName: driverName.trim(),
      destination: destination.trim(),
      partyName: partyName.trim(),
      dispatchDate: new Date(dispatchDate || toIsoDate()).toISOString(),
      deliveryNote: deliveryNote.trim(),
      taxes,
      items,
    });
  };

  const req = (label: string, ok: boolean, control: React.ReactNode) => (
    <div>
      <Label className="pb-1 block text-[13px] font-medium">{label} *</Label>
      {control}
      {touched && !ok && (
        <p className="pt-1 text-xs text-red-600">Required</p>
      )}
    </div>
  );

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="max-h-[90vh] min-h-[70vh] overflow-y-auto md:max-w-[85vw] lg:max-w-[1200px]">
        <DialogHeader>
          <DialogTitle>
            {mode === "create" ? "Generate Waybill" : "Edit Waybill"}
          </DialogTitle>
        </DialogHeader>
        <div className="grid gap-5 md:grid-cols-2">
          <div className="space-y-3">
            {mode === "create" && (
              <div>
                <h3 className="pb-1 font-bold">Import Source (Optional)</h3>
                <SearchableSelect<ProformaOption>
                  label="Existing Proforma"
                  hint="Select an existing Proforma"
                  items={proformas}
                  format={(p) =>
                    `${p.partyName ?? "Unnamed Client"} (${p.id.slice(0, 8).toUpperCase()})`
                  }
                  filter={(p, q) =>
                    (p.partyName ?? "").toLowerCase().includes(q)
                  }
                  value={null}
                  onSelect={async (p) => {
                    if (!p) return;
                    const imported = await onImportProforma(p.id);
                    if (imported) {
                      setPartyName(imported.partyName);
                      setDestination(imported.destination);
                      setTaxes(imported.taxes);
                      setItems(imported.items);
                    }
                  }}
                />
              </div>
            )}

            <h3 className="font-bold">Dispatch Header</h3>
            {mode === "edit" && (
              <>
                {req(
                  "Order Number",
                  orderNumber.trim().length > 0,
                  <Input
                    value={orderNumber}
                    onChange={(e) => setOrderNumber(e.target.value)}
                  />,
                )}
                {req(
                  "Dispatch Doc Number",
                  dispatchDocNumber.trim().length > 0,
                  <Input
                    value={dispatchDocNumber}
                    onChange={(e) => setDispatchDocNumber(e.target.value)}
                  />,
                )}
              </>
            )}
            {req(
              "Driver Name",
              driverOk,
              <Input
                value={driverName}
                onChange={(e) => setDriverName(e.target.value)}
              />,
            )}
            {req(
              "Destination Address",
              destOk,
              <Input
                placeholder="Warehouse / Client Location"
                value={destination}
                onChange={(e) => setDestination(e.target.value)}
              />,
            )}
            {req(
              "Receiver / Party Name",
              partyOk,
              <Input
                placeholder="Individual or Company Name"
                value={partyName}
                onChange={(e) => setPartyName(e.target.value)}
              />,
            )}
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Dispatch Date
              </Label>
              <Input
                type="date"
                value={dispatchDate}
                onChange={(e) => setDispatchDate(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Delivery Note
              </Label>
              <Textarea
                rows={3}
                placeholder="Special instructions for delivery..."
                value={deliveryNote}
                onChange={(e) => setDeliveryNote(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Taxes (Optional)
              </Label>
              <TaxPicker taxes={taxes} onChange={setTaxes} />
            </div>
          </div>

          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="font-bold">Dispatched Products</h3>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setPickerOpen(true)}
              >
                <Plus className="mr-1 h-4 w-4" />
                Add Manual Item
              </Button>
            </div>
            {items.length === 0 ? (
              <p className="py-6 text-center text-sm text-black/50">
                No items yet.
              </p>
            ) : (
              <ul className="divide-y divide-black/10">
                {items.map((it) => (
                  <li key={it.key} className="flex items-center gap-2 py-2">
                    <div className="min-w-0 flex-1">
                      <p className="truncate text-sm font-bold">
                        {it.productName}
                      </p>
                      <p className="text-xs text-black/60">
                        Price: {ghs.format(it.unitPrice)} · Qty: {it.quantity}
                      </p>
                    </div>
                    <span className="text-sm font-bold">
                      Total: {ghs.format(it.total)}
                    </span>
                    <button
                      type="button"
                      onClick={() =>
                        setItems(items.filter((x) => x.key !== it.key))
                      }
                      className="p-1 text-red-600 hover:text-red-800"
                      aria-label={`Remove ${it.productName}`}
                    >
                      <Trash2 className="h-4 w-4" />
                    </button>
                  </li>
                ))}
              </ul>
            )}
            {mode === "edit" && (
              <div className="space-y-1 border-t border-black/10 pt-2 text-sm">
                <div className="flex justify-between">
                  <span>Subtotal</span>
                  <span className="font-semibold">
                    {ghs.format(totals.subtotal)}
                  </span>
                </div>
                {totals.taxRows.map((t) => (
                  <div key={t.name} className="flex justify-between">
                    <span>
                      {t.name} ({t.percentage}%)
                    </span>
                    <span>{ghs.format(t.amount)}</span>
                  </div>
                ))}
                <div className="flex justify-between border-t border-black/10 pt-1 text-[18px] font-bold text-blue-700">
                  <span>Grand Total</span>
                  <span>{ghs.format(totals.grandTotal)}</span>
                </div>
              </div>
            )}
          </div>
        </div>

        {error && (
          <div className="rounded-md bg-red-50 px-4 py-3 text-[13px] font-medium text-red-700 shadow-sm">
            {error}
          </div>
        )}
        <div className="flex justify-end gap-2">
          <Button variant="outline" onClick={onClose}>
            Cancel
          </Button>
          <Button
            onClick={submit}
            disabled={busy}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            {busy
              ? mode === "create"
                ? "Generating…"
                : "Saving…"
              : mode === "create"
                ? "Generate Waybill"
                : "Save Changes"}
          </Button>
        </div>

        <ItemPicker
          open={pickerOpen}
          products={products}
          onClose={() => setPickerOpen(false)}
          onAdd={(item) => setItems((prev) => [...prev, item])}
        />
      </DialogContent>
    </Dialog>
  );
}

export const EMPTY_WAYBILL_FORM = {
  orderNumber: "",
  dispatchDocNumber: "",
  driverName: "",
  destination: "",
  partyName: "",
  dispatchDate: toIsoDate(),
  deliveryNote: "",
  taxes: [],
  items: [],
};
