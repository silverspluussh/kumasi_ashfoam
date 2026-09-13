import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  BranchRow,
  EmployeeRow,
  StoreRow,
} from "@/lib/db/types";
import {
  deleteRemote,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_stores */
export const fetchStores = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<StoreRow>(c, "ashfoam_stores", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadStores = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_stores", rows);

/* ashfoam_branches */
export const fetchBranches = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<BranchRow>(c, "ashfoam_branches", {
    searchColumn: "branch_name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadBranches = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_branches", rows);

/* ashfoam_employees (id = auth.users.id) */
export const fetchEmployees = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<EmployeeRow>(c, "ashfoam_employees", {
    searchColumn: "email",
    orderBy: "created_at",
    ...o,
  });
export const fetchEmployeeByAuthId = async (
  c: SupabaseClient,
  authId: string,
): Promise<EmployeeRow | null> => {
  const { data, error } = await c
    .from("ashfoam_employees")
    .select("*")
    .eq("id", authId)
    .limit(1)
    .abortSignal(AbortSignal.timeout(8000));
  if (error) throw new Error(`Remote employee fetch failed: ${error.message}`);
  return ((data ?? []) as EmployeeRow[])[0] ?? null;
};
export const bulkUploadEmployees = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_employees", rows);
export const deleteEmployee = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_employees", id);
