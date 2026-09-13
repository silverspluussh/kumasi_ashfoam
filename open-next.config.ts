import { defineCloudflareConfig } from "@opennextjs/cloudflare";

/**
 * P5 — OpenNext Cloudflare adapter config.
 * Default (no incremental cache binding): the app is client-side-heavy
 * (Dexie + Supabase + client PDF/Excel), so edge caching of ISR/SSG is not
 * needed. Revisit if server components start caching per-branch data.
 */
export default {
  ...defineCloudflareConfig({}),
  buildCommand: "npx next build",
};
