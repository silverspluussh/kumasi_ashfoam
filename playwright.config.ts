import { defineConfig, devices } from "@playwright/test";
import { readFileSync } from "node:fs";

/**
 * P6 — e2e. Live Supabase flows need test creds in E2E_EMAIL / E2E_PASSWORD;
 * without them the auth/offline specs skip. Smoke specs always run.
 * .env.local is loaded so Supabase reads (stock-equality assertions) work.
 */
const PORT = Number(process.env.PORT ?? 3000);

try {
  for (const line of readFileSync(".env.local", "utf8").split("\n")) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2];
  }
} catch {
  /* no .env.local — live specs skip */
}

export default defineConfig({
  testDir: "./e2e",
  timeout: 60_000,
  expect: { timeout: 10_000 },
  fullyParallel: false,
  retries: 0,
  reporter: [["list"]],
  use: {
    baseURL: `http://localhost:${PORT}`,
    trace: "retain-on-failure",
    screenshot: "only-on-failure",
  },
  projects: [
    { name: "chromium", use: { ...devices["Desktop Chrome"] } },
  ],
  webServer: {
    command: "npm run dev -- --port " + PORT,
    url: `http://localhost:${PORT}`,
    reuseExistingServer: true,
    timeout: 120_000,
  },
});
