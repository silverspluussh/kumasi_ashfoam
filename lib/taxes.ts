/**
 * Ported from ashfoam_sadiq lib/src/core/constants/taxes.dart.
 * Ghana taxes: GFL 2.5% + NHIL 2.5% + VAT 15% (tax-inclusive extraction).
 */
export interface TaxComponent {
  name: string;
  valuePercentage: number;
}

export const Taxes: TaxComponent[] = [
  { name: "GFL", valuePercentage: 2.5 },
  { name: "NHIL", valuePercentage: 2.5 },
  { name: "VAT", valuePercentage: 15 },
];

/** kTotalTaxPercentage */
export const TOTAL_TAX_PERCENTAGE = 20.0;

/** Extract the tax-inclusive portion, e.g. tax on GH₵120 @ 20% = GH₵20. */
export function extractTaxAmount(inclusiveAmount: number): number {
  return (
    (inclusiveAmount * TOTAL_TAX_PERCENTAGE) / (100 + TOTAL_TAX_PERCENTAGE)
  );
}

export const ghs = new Intl.NumberFormat("en-GH", {
  style: "currency",
  currency: "GHS",
});
