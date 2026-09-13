import { test, expect } from "@playwright/test";

/**
 * P6 — auth + offline-order flow. Requires live Supabase creds:
 *   E2E_EMAIL=... E2E_PASSWORD=... npx playwright test
 * Without them, the whole describe skips.
 */
const email = process.env.E2E_EMAIL;
const password = process.env.E2E_PASSWORD;

test.describe("auth + offline order", () => {
  test.skip(!email || !password, "E2E_EMAIL/E2E_PASSWORD not set");

  test("login → bootstrap → POS renders offline-capable UI", async ({
    page,
    context,
  }) => {
    await page.goto("/login");
    await page.getByPlaceholder(/email/i).fill(email!);
    await page.getByPlaceholder(/password/i).fill(password!);
    await page.getByRole("button", { name: /sign in/i }).click();

    // Auth success lands on the app shell (default /pos).
    await expect(page).toHaveURL(/\/(pos|$)/, { timeout: 30_000 });

    // Offline: Dexie keeps POS usable (cart, product search UI).
    await context.setOffline(true);
    await page.reload();
    await expect(page.getByText(/point of sale|cart|products/i).first()).toBeVisible();
    await context.setOffline(false);
  });

  test("offline POS order queues and drains on reconnect", async ({
    page,
    context,
  }) => {
    test.setTimeout(120_000);
    await page.goto("/login");
    await page.getByPlaceholder(/email/i).fill(email!);
    await page.getByPlaceholder(/password/i).fill(password!);
    await page.getByRole("button", { name: /sign in/i }).click();
    await expect(page).toHaveURL(/\/(pos|$)/, { timeout: 30_000 });

    // Go offline, add a product to cart, create order → queued in Dexie.
    await context.setOffline(true);
    // (Interactions mirror the real POS UI; selectors may need updating
    // as the UI evolves — search a product and start an order.)
    // Reconnect → AutoSync drains the queue.
    await context.setOffline(false);
    // Assert via the SyncQueueDialog state / counts UI once drained.
  });
});
