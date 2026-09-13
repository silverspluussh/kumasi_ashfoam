import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  BranchPaymentRow,
  ExpenseRow,
  PaymentRow,
  ReceiptRow,
} from "@/lib/db/types";
import { fetchRows, upsertRows, type FetchOpts } from "./_table";

/* ashfoam_receipts */
export const fetchReceipts = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<ReceiptRow>(c, "ashfoam_receipts", {
    searchColumn: "receipt_number",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadReceipts = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_receipts", rows);

/* ashfoam_payments */
export const fetchPayments = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<PaymentRow>(c, "ashfoam_payments", {
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadPayments = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_payments", rows);

/* ashfoam_branch_payments */
export const fetchBranchPayments = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<BranchPaymentRow>(c, "ashfoam_branch_payments", {
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadBranchPayments = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_branch_payments", rows);

/* ashfoam_expenses */
export const fetchExpenses = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<ExpenseRow>(c, "ashfoam_expenses", {
    searchColumn: "title",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadExpenses = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_expenses", rows);
