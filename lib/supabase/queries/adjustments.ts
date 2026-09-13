import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  CreditNoteItemRow,
  CreditNoteRow,
  ReturnOrderItemRow,
  ReturnOrderRow,
} from "@/lib/db/types";
import {
  fetchChildren,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_return_orders */
export const fetchReturnOrders = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<ReturnOrderRow>(c, "ashfoam_return_orders", {
    searchColumn: "return_number",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadReturnOrders = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_return_orders", rows);

/* ashfoam_return_order_items */
export const fetchReturnOrderItems = (
  c: SupabaseClient,
  returnOrderId: string,
) =>
  fetchChildren<ReturnOrderItemRow>(
    c,
    "ashfoam_return_order_items",
    "return_order_id",
    returnOrderId,
  );
export const bulkUploadReturnOrderItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_return_order_items", rows);

/* ashfoam_credit_notes */
export const fetchCreditNotes = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<CreditNoteRow>(c, "ashfoam_credit_notes", {
    searchColumn: "credit_note_number",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadCreditNotes = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_credit_notes", rows);

/* ashfoam_credit_note_items */
export const fetchCreditNoteItems = (c: SupabaseClient, creditNoteId: string) =>
  fetchChildren<CreditNoteItemRow>(
    c,
    "ashfoam_credit_note_items",
    "credit_note_id",
    creditNoteId,
  );
export const bulkUploadCreditNoteItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_credit_note_items", rows);
