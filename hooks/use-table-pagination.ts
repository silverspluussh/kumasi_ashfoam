import { useMemo, useState } from "react";

export const TABLE_PAGE_SIZE = 25;

/**
 * Client-side pagination over an already-loaded array.
 *
 * Callers pass the FULL filtered set and get back one page of it — filtering
 * always happens before slicing, so search keeps matching across every row
 * rather than only the current page. That ordering is the whole point: the
 * app is offline-first and data lives in Dexie, so server-side paging would
 * make search blind to everything off-page.
 *
 * `resetKey` is any value identifying the current filter state (a search
 * string, or a joined set of filters). When it changes the page resets to 0
 * automatically, so pages can't forget to do it in their search onChange.
 * The comparison happens during render rather than in an effect — same
 * outcome without a wasted render or a setState-in-effect lint warning.
 */
export function useTablePagination<T>(rows: T[], resetKey = "") {
  const [state, setState] = useState({ key: resetKey, page: 0 });
  const page = state.key === resetKey ? state.page : 0;

  const pageCount = Math.max(1, Math.ceil(rows.length / TABLE_PAGE_SIZE));
  // Clamp rather than reset: deleting the last row on the last page should
  // land the user on the previous page, not an empty one.
  const safePage = Math.min(page, pageCount - 1);

  const pageRows = useMemo(
    () =>
      rows.slice(safePage * TABLE_PAGE_SIZE, (safePage + 1) * TABLE_PAGE_SIZE),
    [rows, safePage],
  );

  return {
    pageRows,
    page: safePage,
    pageCount,
    setPage: (next: number) => setState({ key: resetKey, page: next }),
  };
}