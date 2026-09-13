import type { SupabaseClient } from "@supabase/supabase-js";
import type {
  BrandRow,
  CategoryRow,
  SubcategoryRow,
  TaxRow,
} from "@/lib/db/types";
import {
  deleteRemote,
  fetchRows,
  upsertRows,
  type FetchOpts,
} from "./_table";

/* ashfoam_product_brands */
export const fetchBrands = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<BrandRow>(c, "ashfoam_product_brands", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadBrands = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_product_brands", rows);
export const deleteBrand = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_product_brands", id);

/* ashfoam_product_categories */
export const fetchCategories = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<CategoryRow>(c, "ashfoam_product_categories", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadCategories = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_product_categories", rows);
export const deleteCategory = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_product_categories", id);

/* ashfoam_product_subcategories */
export const fetchSubcategories = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<SubcategoryRow>(c, "ashfoam_product_subcategories", {
    searchColumn: "name",
    orderBy: "created_at",
    ...o,
  });
export const bulkUploadSubcategories = (
  c: SupabaseClient,
  rows: Record<string, unknown>[],
) => upsertRows(c, "ashfoam_product_subcategories", rows);
export const deleteSubcategory = (c: SupabaseClient, id: string) =>
  deleteRemote(c, "ashfoam_product_subcategories", id);

/* ashfoam_taxes (read-only in practice — seeded locally) */
export const fetchTaxes = (c: SupabaseClient, o?: FetchOpts) =>
  fetchRows<TaxRow>(c, "ashfoam_taxes", { orderBy: "name", ...o });
