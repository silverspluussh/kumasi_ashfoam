import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  CustomerRow,
  SupplierPaymentRow,
  SupplierRow,
} from "@/lib/db/types";
import {
  deleteRemote,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_suppliers */
export const fetchSuppliers = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<SupplierRow>(c, "ashfoam_suppliers", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadSuppliers = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_suppliers", rows);
export const deleteSupplier = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_suppliers", id);

/* ashfoam_supplier_payments */
export const fetchSupplierPayments = (
  c: SupabaseClient,
  supplierId?: string,
  o?: FetchOpts,
) =>
  fetchRows<SupplierPaymentRow>(c, "ashfoam_supplier_payments", {
    orderBy: "date",
    ...o,
  }).then((rows) =>
    supplierId ? rows.filter((r) => r.supplier_id === supplierId) : rows,
  );
export const bulkUploadSupplierPayments = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_supplier_payments", rows);
export const deleteSupplierPayment = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_supplier_payments", id);

/* ashfoam_customers */
export const fetchCustomers = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<CustomerRow>(c, "ashfoam_customers", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadCustomers = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_customers", rows);
