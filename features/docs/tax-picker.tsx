"use client";

import { useState } from "react";
import { PlusCircle, X } from "lucide-react";
import { DOC_TAXES, type DocTax } from "./totals";

/**
 * Tax picker — ported from the proforma/waybill PopupMenuButton:
 * "Select Tax" trigger listing unselected taxes, selected shown as
 * removable chips.
 */
export function TaxPicker({
  taxes,
  onChange,
  disabled,
}: {
  taxes: DocTax[];
  onChange: (t: DocTax[]) => void;
  disabled?: boolean;
}) {
  const [open, setOpen] = useState(false);
  const available = DOC_TAXES.filter((t) => !taxes.some((s) => s.id === t.id));

  return (
    <div className="space-y-2">
      <div className="flex flex-wrap gap-1.5">
        {taxes.map((t, idx) => (
          <span
            key={`${t.id}-${idx}`}
            className="flex items-center gap-1 bg-blue-50 px-2 py-1 text-xs font-medium text-blue-900"
          >
            {t.name} ({t.valuePercentage}%)
            {!disabled && (
              <button
                type="button"
                onClick={() => onChange(taxes.filter((x) => x.id !== t.id))}
                className="text-red-600 hover:text-red-800"
                aria-label={`Remove ${t.name}`}
              >
                <X className="h-3.5 w-3.5" />
              </button>
            )}
          </span>
        ))}
      </div>
      {!disabled && available.length > 0 && (
        <div className="relative">
          <button
            type="button"
            onClick={() => setOpen((o) => !o)}
            className="flex items-center gap-1 text-xs font-bold text-blue-600"
          >
            <PlusCircle className="h-4 w-4" />
            Select Tax
          </button>
          {open && (
            <ul className="absolute z-20 w-56 border border-black/20 bg-white shadow-lg">
              {available.map((t) => (
                <li key={t.id}>
                  <button
                    type="button"
                    className="block w-full px-3 py-2 text-left text-sm hover:bg-black/5"
                    onClick={() => {
                      onChange([...taxes, t]);
                      setOpen(false);
                    }}
                  >
                    {t.name} ({t.valuePercentage}%)
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      )}
    </div>
  );
}
