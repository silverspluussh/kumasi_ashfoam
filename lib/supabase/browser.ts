import { createBrowserClient } from "@supabase/ssr";
import { SupabaseConfig } from "./config";

/** Client-side Supabase (browser). Nullable config guard like Flutter. */
export function createClient() {
  return createBrowserClient(SupabaseConfig.url, SupabaseConfig.anonKey);
}
