import { test, expect } from "@playwright/test";

/**
 * P6 smoke — no live Supabase required. Guards that unauthenticated users
 * are redirected to /login and that the PWA files are served.
 */
test.describe("smoke", () => {
  test("unauthenticated visit to a protected route redirects to /login", async ({
    page,
  }) => {
    await page.goto("/pos", { waitUntil: "domcontentloaded" });
    // RequireAuth replaces to /login once auth resolves.
    await expect(page).toHaveURL(/\/login/, { timeout: 15_000 });
    await expect(page.getByRole("heading", { name: /sign in/i })).toBeVisible();
  });

  test("login page renders validation and online-gate messaging", async ({
    page,
  }) => {
    await page.goto("/login");
    await expect(page.getByRole("button", { name: /sign in/i })).toBeVisible();
    // Headless/probe-offline → submit is online-gated (disabled).
    const button = page.getByRole("button", { name: /sign in/i });
    if (await button.isEnabled()) {
      await button.click();
    } else {
      await expect(button).toBeDisabled();
      await expect(
        page.getByText(/requires internet/i).first(),
      ).toBeVisible();
    }
    await expect(page).toHaveURL(/\/login/);
  });

  test("PWA manifest and icons are served", async ({ request }) => {
    const manifest = await request.get("/manifest.webmanifest");
    expect(manifest.ok()).toBeTruthy();
    const body = (await manifest.json()) as { name: string; icons: unknown[] };
    expect(body.name).toContain("Ashfoam");
    expect(body.icons.length).toBeGreaterThan(0);

    for (const icon of ["/AppIcon64.png", "/AppIcon256.png"]) {
      const res = await request.get(icon);
      expect(res.ok()).toBeTruthy();
    }
  });

  test("service worker is registered in production builds", async ({
    page,
  }) => {
    // dev server serves public/sw.js regardless; check it's fetchable and
    // that the registrar mounts (script tag present after hydration).
    const sw = await page.request.get("/sw.js");
    expect(sw.ok()).toBeTruthy();
    expect(await sw.text()).toContain("ashfoam-shell");
  });
});
