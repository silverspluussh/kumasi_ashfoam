import { Button } from "@/components/ui/button";

/**
 * Prev / Page X of Y / Next footer for a paginated table. Renders nothing
 * when everything fits on one page, so short tables stay uncluttered.
 */
export function TablePagination({
  page,
  pageCount,
  onPage,
}: {
  page: number;
  pageCount: number;
  onPage: (next: number) => void;
}) {
  if (pageCount <= 1) return null;
  return (
    <div className="flex items-center justify-end gap-2 text-sm">
      <Button
        variant="outline"
        size="sm"
        disabled={page === 0}
        onClick={() => onPage(page - 1)}
      >
        Prev
      </Button>
      <span>
        Page {page + 1} of {pageCount}
      </span>
      <Button
        variant="outline"
        size="sm"
        disabled={page >= pageCount - 1}
        onClick={() => onPage(page + 1)}
      >
        Next
      </Button>
    </div>
  );
}