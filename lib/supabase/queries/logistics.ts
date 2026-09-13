import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  StockReportRow,
  StockTransferItemRow,
  StockTransferRow,
} from "@/lib/db/types";
import { stockReportToRemote } from "@/lib/db/mappers";
import {
  fetchChildren,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_stock_transfers */
export const fetchStockTransfers = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<StockTransferRow>(c, "ashfoam_stock_transfers", {
    searchColumn: "transfer_number",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadStockTransfers = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_stock_transfers", rows);

/* ashfoam_stock_transfer_items */
export const fetchStockTransferItems = (
  c: SupabaseClient,
  transferId: string,
) =>
  fetchChildren<StockTransferItemRow>(
    c,
    "ashfoam_stock_transfer_items",
    "stock_transfer_id",
    transferId,
  );
export const bulkUploadStockTransferItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_stock_transfer_items", rows);

/* ashfoam_stock_reports — remote is minimal {branch_id, report_date, data} */
export const fetchStockReports = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<StockReportRow>(c, "ashfoam_stock_reports", {
    orderBy: "report_date",
    ascending: false,
    ...o,
  });
export const bulkUploadStockReports = (
  c: SupabaseClient,
  rows: StockReportRow[],
) => upsertRows(c, "ashfoam_stock_reports", rows.map(stockReportToRemote));
