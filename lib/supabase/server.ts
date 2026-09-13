import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { SupabaseConfig } from "./config";

/** Server-side Supabase (Server Components / Route Handlers). */
export async function createServerSupabase() {
  const cookieStore = await cookies();
  return createServerClient(SupabaseConfig.url, SupabaseConfig.anonKey, {
    cookies: {
      getAll: () => cookieStore.getAll(),
      setAll: (toSet) => {
        try {
          toSet.forEach(({ name, value, options }) =>
            cookieStore.set(name, value, options),
          );
        } catch {
          /* called from a Server Component — middleware refreshes instead */
        }
      },
    },
  });
}
