/**
 * Supabase connection config.
 * Values from ashfoam_sadiq/lib/src/core/config/supabase_config.dart,
 * provided via .env.local (anon key is public; never add a service key here).
 */
export const SupabaseConfig = {
  url: process.env.NEXT_PUBLIC_SUPABASE_URL ?? "",
  anonKey: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? "",
} as const;
