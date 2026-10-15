import type { SupabaseClient } from "@supabase/supabase-js";

/**
 * Generic PostgREST helpers shared by all query modules — mirrors the
 * fetch + bulkUpload pattern of Flutter's repositories. 8s timeout
 * matches Flutter's remote timeouts.
 */
export interface FetchOpts {
  search?: string;
  searchColumn?: string;
  /** Narrow the projection — defaults to "*". */
  columns?: string;
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
  let q = client.from(table).select(opts.columns ?? "*");
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

const ID_PAGE_SIZE = 500;

/**
 * Every `id` in a table, paged to exhaustion — the input to pull-side
 * reconciliation (lib/sync/reconcile). Only the requested columns come back,
 * so this stays cheap even on large tables.
 *
 * Two things make this safe to delete against:
 * - ordering by the unique primary key gives a total order, so pages can
 *   never overlap or skip a row that shifts between requests;
 * - the row count is cross-checked against an exact COUNT before returning.
 *   A server-side `max-rows` cap, a mid-flight insert or a silently
 *   truncated page therefore THROWS rather than looking like a deletion.
 *
 * Throwing is meaningful: callers treat it as "skip this table, delete
 * nothing" — the failure mode is a stale row, never lost data.
 */
export async function fetchAllIds(
  client: SupabaseClient,
  table: string,
  opts: { columns?: string } = {},
): Promise<Record<string, unknown>[]> {
  const { count, error: countError } = await client
    .from(table)
    .select("id", { count: "exact", head: true })
    .abortSignal(AbortSignal.timeout(8000));
  if (countError)
    throw new Error(`Remote ${table} count failed: ${countError.message}`);

  const out: Record<string, unknown>[] = [];
  for (let offset = 0; ; offset += ID_PAGE_SIZE) {
    const { data, error } = await client
      .from(table)
      .select(opts.columns ?? "id")
      .order("id", { ascending: true })
      .range(offset, offset + ID_PAGE_SIZE - 1)
      .abortSignal(AbortSignal.timeout(8000));
    if (error)
      throw new Error(`Remote ${table} id sweep failed: ${error.message}`);
    const rows = (data ?? []) as unknown as Record<string, unknown>[];
    out.push(...rows);
    if (rows.length < ID_PAGE_SIZE) break;
    if (offset > 200_000) break; // hard safety stop
  }

  if (count != null && out.length !== count) {
    throw new Error(
      `Remote ${table} id sweep incomplete: fetched ${out.length} of ${count}`,
    );
  }
  return out;
}

export { withTimeout };
