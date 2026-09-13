import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  ProformaItemRow,
  ProformaRow,
  WaybillItemRow,
  WaybillRow,
} from "@/lib/db/types";
import {
  fetchChildren,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_proformas */
export const fetchProformas = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<ProformaRow>(c, "ashfoam_proformas", {
    searchColumn: "party_name",
    orderBy: "created_at",
    ascending: false,
    ...o,
  });
export const bulkUploadProformas = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_proformas", rows);

/* ashfoam_proforma_items */
export const fetchProformaItems = (c: SupabaseClient, proformaId: string) =>
  fetchChildren<ProformaItemRow>(
    c,
    "ashfoam_proforma_items",
    "proforma_id",
    proformaId,
  );
export const bulkUploadProformaItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_proforma_items", rows);

/* ashfoam_waybills */
export const fetchWaybills = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<WaybillRow>(c, "ashfoam_waybills", {
    searchColumn: "orderNumber",
    orderBy: "createdAt",
    ascending: false,
    ...o,
  });
export const bulkUploadWaybills = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_waybills", rows);

/* ashfoam_waybill_items */
export const fetchWaybillItems = (c: SupabaseClient, waybillId: string) =>
  fetchChildren<WaybillItemRow>(
    c,
    "ashfoam_waybill_items",
    "waybill_id",
    waybillId,
  );
export const bulkUploadWaybillItems = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_waybill_items", rows);
