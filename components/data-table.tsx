"use client";

import {
  flexRender,
  getCoreRowModel,
  useReactTable,
  type ColumnDef,
} from "@tanstack/react-table";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { LoadingSpinner } from "@/components/loading-spinner";

/* eslint-disable @typescript-eslint/no-explicit-any -- display-only table wrapper */
interface DataTableProps<T = any> {
  columns: ColumnDef<T, any>[];
  rows: T[];
  emptyHint?: string;
  loading?: boolean;
}

/** Lightweight TanStack table with the sharp shadcn look (replaces SfDataGrid). */
export function DataTable<T = any>({
  columns,
  rows,
  emptyHint = "No rows yet.",
  loading = false,
}: DataTableProps<T>) {
  const table = useReactTable({
    data: rows,
    columns,
    getCoreRowModel: getCoreRowModel(),
  });

  if (loading) {
    return <LoadingSpinner />;
  }

  return (
    <div className="overflow-x-auto border border-black/15">
      <Table>
        <TableHeader>
          {table.getHeaderGroups().map((hg) => (
            <TableRow key={hg.id} className="bg-black/[0.03]">
              {hg.headers.map((h) => (
                <TableHead key={h.id} className="font-bold text-black">
                  {h.isPlaceholder
                    ? null
                    : flexRender(h.column.columnDef.header, h.getContext())}
                </TableHead>
              ))}
            </TableRow>
          ))}
        </TableHeader>
        <TableBody>
          {table.getRowModel().rows.length === 0 ? (
            <TableRow>
              <TableCell
                colSpan={columns.length}
                className="py-10 text-center text-sm text-black/50"
              >
                {emptyHint}
              </TableCell>
            </TableRow>
          ) : (
            table.getRowModel().rows.map((row) => (
              <TableRow key={row.id} className="hover:bg-ashfoam/20">
                {row.getVisibleCells().map((cell) => (
                  <TableCell key={cell.id}>
                    {flexRender(cell.column.columnDef.cell, cell.getContext())}
                  </TableCell>
                ))}
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
    </div>
  );
}
