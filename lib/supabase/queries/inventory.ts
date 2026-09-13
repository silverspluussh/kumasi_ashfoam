import type { SupabaseClient } from "@supabase/supabase-js";
import type { InventoryRow } from "@/lib/db/types";
import { fetchRows, upsertRows, type FetchOpts } from "./_table";

/* ashfoam_inventory — quoted camelCase columns used verbatim. */
export const fetchInventory = (
  c: SupabaseClient,
  o?: FetchOpts & { skipUnsyncedNote?: never },
) =>
  fetchRows<InventoryRow>(c, "ashfoam_inventory", {
    searchColumn: "name",
    orderBy: "createdAt",
    ascending: false,
    updatedAtColumn: "updatedAt",
    ...o,
  });

export const bulkUploadInventory = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_inventory", rows);

/**
 * Mirrors ProductsRepository.syncInventory({updatedSince, skipLocalUnsynced}):
 * incremental pull; caller skips dirty locals when applying.
 */
export const syncInventoryPull = (
  c: SupabaseClient,
  updatedSince?: string,
  o?: FetchOpts,
) =>
  fetchInventory(c, {
    ...(updatedSince ? { updatedSince } : undefined),
    ...o,
  });
