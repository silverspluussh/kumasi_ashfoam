import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Generic PostgREST helpers shared by all query modules — mirrors the
 * fetch + bulkUpload pattern of Flutter's repositories. 8s timeout
 * matches Flutter's remote timeouts.
 */
export interface FetchOpts {
  search?: string;
  searchColumn?: string;
  limit?: number;
  offset?: number;
  orderBy?: string;
  ascending?: boolean;
  updatedSince?: string;
  updatedAtColumn?: string;
}

const withTimeout = () => ({ signal: AbortSignal.timeout(8000) });

export async function fetchRows<T>(
  client: SupabaseClient,
  table: string,
  opts: FetchOpts = {},
): Promise<T[]> {
  let q = client.from(table).select("*");
  if (opts.updatedSince) {
    q = q.gte(opts.updatedAtColumn ?? "updated_at", opts.updatedSince);
  }
  if (opts.search && opts.searchColumn) {
    q = q.ilike(opts.searchColumn, `%${opts.search}%`);
  }
  if (opts.orderBy) q = q.order(opts.orderBy, { ascending: opts.ascending ?? false });
  if (opts.limit) q = q.limit(opts.limit);
  if (opts.offset) q = q.range(opts.offset, opts.offset + (opts.limit ?? 100) - 1);
  const { data, error } = await q.abortSignal(AbortSignal.timeout(8000));
  if (error) throw new Error(`Remote ${table} fetch failed: ${error.message}`);
  return (data ?? []) as T[];
}

export async function upsertRows<T extends Record<string, unknown>>(
  client: SupabaseClient,
  table: string,
  rows: T[],
): Promise<T[]> {
  if (rows.length === 0) return [];
  const { data, error } = await client
    .from(table)
    .upsert(rows as unknown as Record<string, never>[], { onConflict: "id" })
    .select()
    .abortSignal(AbortSignal.timeout(8000));
  if (error) throw new Error(`Remote ${table} upsert failed: ${error.message}`);
  return (data ?? []) as T[];
}

export async function fetchChildren<T>(
  client: SupabaseClient,
  table: string,
  fk: string,
  parentId: string,
): Promise<T[]> {
  const { data, error } = await client
    .from(table)
    .select("*")
    .eq(fk, parentId)
    .abortSignal(AbortSignal.timeout(8000));
  if (error)
    throw new Error(`Remote ${table} items fetch failed: ${error.message}`);
  return (data ?? []) as T[];
}

export async function deleteRemote(
  client: SupabaseClient,
  table: string,
  id: string,
) {
  const { error } = await client
    .from(table)
    .delete()
    .eq("id", id)
    .abortSignal(AbortSignal.timeout(8000));
  if (error) throw new Error(`Remote ${table} delete failed: ${error.message}`);
}

export { withTimeout };
