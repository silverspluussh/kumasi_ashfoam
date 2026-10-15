/**
 * Inventory list ordering. Products are shown stock-descending so
 * out-of-stock rows fall to the bottom.
 */

/** Stock on hand, tolerating null/NaN from remote rows. */
function qty(p: { quantity?: number | null }): number {
  const n = Number(p.quantity);
  return Number.isFinite(n) ? n : 0;
}

/**
 * New array ordered by stock descending. Ties keep their existing order
 * (Array#sort is stable), so the result is deterministic for a given input
 * and equal-quantity products don't shuffle between reloads.
 */
export function byQuantityDesc<T extends { quantity?: number | null }>(
  rows: readonly T[],
): T[] {
  return [...rows].sort((a, b) => qty(b) - qty(a));
}