/**
 * Print-only number/date formats. These mirror the Flutter print services
 * exactly — do NOT use the app GH₵ formatters here:
 * - A4 cells: ceil() to integer, no decimals, no symbol (_formatAmount)
 * - Grand total: 'GHC {int}'
 * - Receipt: GH¢ with 2dp
 * - Dates: 'dd-MMM-yy' (e.g. 13-Sep-26)
 */
import { ghs } from "@/lib/taxes";

const MONTHS_SHORT = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];
const pad = (n: number) => String(n).padStart(2, "0");

/** Flutter _formatAmount: ceil, no decimals, no symbol. */
export function printAmount(amount: number): string {
  return String(Math.ceil(amount ?? 0));
}

/** Flutter NumberFormat.currency(symbol: 'GH¢') with 2dp. */
export function receiptAmount(amount: number): string {
  return ghs.format(amount ?? 0);
}

/** DateFormat('dd-MMM-yy'). */
export function printDate(iso?: string | null): string {
  const d = iso ? new Date(iso) : new Date();
  if (Number.isNaN(d.getTime())) return "";
  return `${pad(d.getDate())}-${MONTHS_SHORT[d.getMonth()]}-${String(d.getFullYear()).slice(2)}`;
}

/** 24h 'HH:mm' for receipt Time row. */
export function printTime24(iso?: string | null): string {
  const d = iso ? new Date(iso) : null;
  if (!d || Number.isNaN(d.getTime())) return "";
  return `${pad(d.getHours())}:${pad(d.getMinutes())}`;
}
