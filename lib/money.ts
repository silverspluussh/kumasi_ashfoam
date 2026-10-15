/**
 * Money helpers. Document amounts are always truncated to 2 decimal places
 * (pesewas) — the remainder is dropped, never rounded up or down.
 */

/**
 * Truncate to 2 decimal places without rounding.
 *
 * The `toFixed(6)` guard strips binary floating-point noise *before*
 * truncating. Without it a value whose 2dp representation sits just below
 * the decimal loses a pesewa: `0.29 * 100 === 28.999999999999996`, so a
 * naive `Math.trunc(v * 100) / 100` returns `0.28`; likewise `157.7`
 * (price 166 @ 5%) collapses to `157.69`.
 */
export function truncate2(value: number): number {
  if (!Number.isFinite(value)) return 0;
  return Math.trunc(Number((value * 100).toFixed(6))) / 100;
}