/**
 * Print-only number/date formats. Amounts are truncated to 2 decimal
 * places — the pesewas remainder is dropped, never rounded up or down.
 * Dates use 'dd-MMM-yy' (e.g. 13-Sep-26); times use 24h 'HH:mm'.
 */
import { truncate2 } from "@/lib/money";
import { ghs } from "@/lib/taxes";

const MONTHS_SHORT = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
];
const pad = (n: number) => String(n).padStart(2, "0");

/** A4 amounts: 2dp truncated, no symbol. */
export function printAmount(amount: number): string {
  return truncate2(amount ?? 0).toFixed(2);
}

/** Receipt amounts: GH¢ with 2dp. */
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
