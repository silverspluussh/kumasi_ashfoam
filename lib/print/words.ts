/**
 * Number-to-words. Exact port of Flutter _numberToWords/_convertPart
 * (proforma + waybill print services): "Ghanaian Cedi X [and Y Pesewas]
 * Only"; hundreds use "and", thousands/millions plain concatenation.
 *
 * The amount is truncated to 2dp first so the words always agree with the
 * printed total, and so the pesewas split is exact.
 */
import { truncate2 } from "@/lib/money";
const UNITS = [
  "",
  "One",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Eleven",
  "Twelve",
  "Thirteen",
  "Fourteen",
  "Fifteen",
  "Sixteen",
  "Seventeen",
  "Eighteen",
  "Nineteen",
];
const TENS = [
  "",
  "",
  "Twenty",
  "Thirty",
  "Forty",
  "Fifty",
  "Sixty",
  "Seventy",
  "Eighty",
  "Ninety",
];

function convertPart(n: number): string {
  if (n === 0) return "";
  if (n < 20) return UNITS[n];
  if (n < 100) {
    return `${TENS[Math.floor(n / 10)]}${n % 10 !== 0 ? ` ${UNITS[n % 10]}` : ""}`;
  }
  if (n < 1000) {
    return `${UNITS[Math.floor(n / 100)]} Hundred${n % 100 !== 0 ? ` and ${convertPart(n % 100)}` : ""}`;
  }
  if (n < 1000000) {
    return `${convertPart(Math.floor(n / 1000))} Thousand${n % 1000 !== 0 ? ` ${convertPart(n % 1000)}` : ""}`;
  }
  if (n < 1000000000) {
    return `${convertPart(Math.floor(n / 1000000))} Million${n % 1000000 !== 0 ? ` ${convertPart(n % 1000000)}` : ""}`;
  }
  return String(n);
}

export function numberToWords(amount: number): string {
  const value = truncate2(amount ?? 0);
  if (value === 0) return "Zero Ghanaian Cedi";
  const cedis = Math.trunc(value);
  const pesewas = Math.round((value - cedis) * 100);
  let result = cedis > 0 ? `Ghanaian Cedi ${convertPart(cedis)}` : "Ghanaian Cedi";
  if (pesewas > 0) {
    result += ` and ${convertPart(pesewas)} Pesewas`;
  }
  return `${result} Only`;
}
