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
import { Textarea } from "@/components/ui/textarea";
import { ItemPicker, type ProductOption } from "./item-picker";
import { TaxPicker } from "./tax-picker";
import {
  DEFAULT_DECLARATION,
  computeTotals,
  type DocItem,
  type DocTax,
} from "./totals";
import { ghs } from "@/lib/taxes";

export interface ProformaFormValues {
  partyName: string;
  partyAddress: string;
  declaration: string;
  taxes: DocTax[];
  items: DocItem[];
}

interface ProformaDialogProps {
  open: boolean;
  title: string;
  submitLabel: string;
  initial: ProformaFormValues;
  products: ProductOption[];
  busy: boolean;
  error: string | null;
  onClose: () => void;
  onSubmit: (values: ProformaFormValues) => void;
}

/** Create/Edit proforma form — 2-col layout per Flutter dialogs. */
export function ProformaDialog({
  open,
  title,
  submitLabel,
  initial,
  products,
  busy,
  error,
  onClose,
  onSubmit,
}: ProformaDialogProps) {
  const [partyName, setPartyName] = useState("");
  const [partyAddress, setPartyAddress] = useState("");
  const [declaration, setDeclaration] = useState(DEFAULT_DECLARATION);
  const [taxes, setTaxes] = useState<DocTax[]>([]);
  const [items, setItems] = useState<DocItem[]>([]);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [touched, setTouched] = useState(false);

  useEffect(() => {
    if (open) {
      setPartyName(initial.partyName);
      setPartyAddress(initial.partyAddress);
      setDeclaration(initial.declaration || DEFAULT_DECLARATION);
      setTaxes(initial.taxes);
      setItems(initial.items);
      setTouched(false);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open ]);

  const totals = useMemo(() => computeTotals(items, taxes), [items, taxes]);
  const nameOk = partyName.trim().length > 0;

  const submit = () => {
    setTouched(true);
    if (!nameOk || items.length === 0 || busy) return;
    onSubmit({
      partyName: partyName.trim(),
      partyAddress: partyAddress.trim(),
      declaration: declaration.trim(),
      taxes,
      items,
    });
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="max-h-[90vh] min-h-[70vh] overflow-y-auto md:max-w-[85vw] lg:max-w-[1100px]">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
        </DialogHeader>
        <div className="grid gap-5 md:grid-cols-2">
          <div className="space-y-3">
            <h3 className="font-bold">Client Information</h3>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Party Name *
              </Label>
              <Input
                value={partyName}
                onChange={(e) => setPartyName(e.target.value)}
              />
              {touched && !nameOk && (
                <p className="pt-1 text-xs text-red-600">Required</p>
              )}
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Party Address
              </Label>
              <Textarea
                rows={2}
                value={partyAddress}
                onChange={(e) => setPartyAddress(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Declaration Text
              </Label>
              <Textarea
                rows={3}
                value={declaration}
                onChange={(e) => setDeclaration(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Taxes
              </Label>
              <TaxPicker taxes={taxes} onChange={setTaxes} />
            </div>
          </div>

          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <h3 className="font-bold">Products &amp; Services</h3>
              <Button
                variant="outline"
                size="sm"
                onClick={() => setPickerOpen(true)}
              >
                <Plus className="mr-1 h-4 w-4" />
                Add Product
              </Button>
            </div>
            {items.length === 0 ? (
              <p className="py-6 text-center text-sm text-black/50">
                No items yet — add a product to begin.
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
                      {ghs.format(it.total)}
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
            {busy ? "Saving…" : submitLabel}
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

export const EMPTY_PROFORMA_FORM: ProformaFormValues = {
  partyName: "",
  partyAddress: "",
  declaration: DEFAULT_DECLARATION,
  taxes: [],
  items: [],
};
