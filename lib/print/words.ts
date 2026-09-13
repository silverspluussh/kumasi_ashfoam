/**
 * Number-to-words. Exact port of Flutter _numberToWords/_convertPart
 * (proforma + waybill print services): "Ghanaian Cedi X [and Y Pesewas]
 * Only"; hundreds use "and", thousands/millions plain concatenation.
 */
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
  if (amount === 0) return "Zero Ghanaian Cedi";
  const cedis = Math.trunc(amount);
  const pesewas = Math.round((amount - cedis) * 100);
  let result = `Ghanaian Cedi ${convertPart(cedis)}`;
  if (pesewas > 0) {
    result += ` and ${convertPart(pesewas)} Pesewas`;
  }
  return `${result} Only`;
}
