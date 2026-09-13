import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  InvoiceItemRow,
  InvoiceRow,
  SaleOrderItemRow,
  SaleOrderRow,
} from "@/lib/db/types";
import {
  fetchChildren,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_sale_orders */
export const fetchSaleOrders = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<SaleOrderRow>(c, "ashfoam_sale_orders", {
    searchColumn: "orderNumber",
    orderBy: "createdAt",
    ascending: false,
    updatedAtColumn: "lastSyncedAt",
    ...o,
  });
export const bulkUploadSaleOrders = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_sale_orders", rows);

/* ashfoam_sale_order_items */
export const fetchSaleOrderItems = (c: SupabaseClient, saleOrderId: string) =>
  fetchChildren<SaleOrderItemRow>(
    c,
    "ashfoam_sale_order_items",
    "saleOrderId",
    saleOrderId,
  );
export const bulkUploadSaleOrderItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_sale_order_items", rows);

/* ashfoam_invoices */
export const fetchInvoices = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<InvoiceRow>(c, "ashfoam_invoices", {
    searchColumn: "invoice_number",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadInvoices = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_invoices", rows);

/* ashfoam_invoice_items */
export const fetchInvoiceItems = (c: SupabaseClient, invoiceId: string) =>
  fetchChildren<InvoiceItemRow>(
    c,
    "ashfoam_invoice_items",
    "invoice_id",
    invoiceId,
  );
export const bulkUploadInvoiceItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_invoice_items", rows);
