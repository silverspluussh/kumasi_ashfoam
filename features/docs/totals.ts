/**
 * Shared math + constants for proforma/waybill documents.
 * Proforma: inclusive-tax assumption (base = subtotal/(1+pct), display only,
 * grand = subtotal). Waybill: additive display (tax = subtotal*pct/100,
 * grand = subtotal). Line total (both) = qty*price*(1-disc/100).
 */
export interface DocTax {
  id: string;
  name: string;
  valuePercentage: number;
  taxAmount?: number;
}

/** allTaxesProvider constant (ids gfl|nhil|vat). */
export const DOC_TAXES: DocTax[] = [
  { id: "gfl", name: "GetFund(GFL)", valuePercentage: 2.5 },
  { id: "nhil", name: "NHIL", valuePercentage: 2.5 },
  { id: "vat", name: "VAT", valuePercentage: 15.0 },
];

export interface DocItem {
  key: string;
  productId: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  discountPct: number;
  total: number;
}

export function lineTotal(
  qty: number,
  price: number,
  discPct: number,
): number {
  return qty * price * (1 - discPct / 100);
}

export interface DocTotals {
  subtotal: number;
  totalQty: number;
  totalPct: number;
  base: number;
  taxRows: { name: string; percentage: number; amount: number }[];
  grandTotal: number;
}

export function computeTotals(
  items: Pick<DocItem, "quantity" | "total">[],
  taxes: DocTax[],
): DocTotals {
  const subtotal = items.reduce((a, i) => a + i.total, 0);
  const totalQty = items.reduce((a, i) => a + i.quantity, 0);
  const totalPct = taxes.reduce((a, t) => a + t.valuePercentage, 0);
  const base = totalPct > 0 ? subtotal / (1 + totalPct / 100) : subtotal;
  const taxRows = taxes.map((t) => ({
    name: t.name,
    percentage: t.valuePercentage,
    amount: (base * t.valuePercentage) / 100,
  }));
  return { subtotal, totalQty, totalPct, base, taxRows, grandTotal: subtotal };
}

/** Stored tax JSON with computed taxAmount (inclusive). */
export function taxesWithAmounts(
  taxes: DocTax[],
  subtotal: number,
): DocTax[] {
  const totalPct = taxes.reduce((a, t) => a + t.valuePercentage, 0);
  const base = totalPct > 0 ? subtotal / (1 + totalPct / 100) : subtotal;
  return taxes.map((t) => ({
    ...t,
    taxAmount: (base * t.valuePercentage) / 100,
  }));
}

/** Normalize stored tax JSON (no stable ids) back to DocTax. */
export function docTaxesFromJson(tax: unknown): DocTax[] {
  if (!Array.isArray(tax)) return [];
  const seen = new Set<string>();
  const out: DocTax[] = [];
  for (const raw of tax as Record<string, unknown>[]) {
    const name = String(raw.name ?? "Tax");
    const id = typeof raw.id === "string" ? raw.id : name.toLowerCase();
    if (seen.has(id)) continue; // stored rows can repeat a tax
    seen.add(id);
    const valuePercentage =
      typeof raw.valuePercentage === "number"
        ? raw.valuePercentage
        : typeof raw.value_percentage === "number"
          ? raw.value_percentage
          : 0;
    out.push({
      id,
      name,
      valuePercentage,
      taxAmount: typeof raw.taxAmount === "number" ? raw.taxAmount : undefined,
    });
  }
  return out;
}

export const DEFAULT_DECLARATION =
  "We declare that this proforma invoice shows the actual price of the goods described and that all particulars are true and correct.";
