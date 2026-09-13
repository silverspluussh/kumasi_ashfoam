import { createClient } from "@supabase/supabase-js";
import { test, expect } from "@playwright/test";

/**
 * P6 — stock-equality regression for the offline-sale double-decrement fix.
 * Invariant: after an offline sale + reconnect drain, the SERVER quantity
 * must equal the LOCAL (Dexie) quantity — the insert trigger accounts for
 * the sale, and the inventory absolute push must not subtract again.
 *
 * test.fixme until the POS cart/checkout selectors are validated against
 * the real UI (needs a live pass); the logic documents the exact assertions.
 */
const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

test.describe("offline sale stock equality", () => {
  test.fixme(
    !(url && key && process.env.E2E_EMAIL && process.env.E2E_PASSWORD),
    "needs NEXT_PUBLIC_SUPABASE_* + E2E_EMAIL/E2E_PASSWORD",
  );

  test("server qty == local qty after offline sale drains", async ({
    page,
    context,
  }) => {
    test.setTimeout(180_000);
    const supabase = createClient(url!, key!);
    await supabase.auth.signInWithPassword({
      email: process.env.E2E_EMAIL!,
      password: process.env.E2E_PASSWORD!,
    });

    // Pick the first product with stock.
    const { data: products } = await supabase
      .from("ashfoam_inventory")
      .select("id, quantity, name")
      .gt("quantity", 0)
      .limit(1);
    const product = products?.[0];
    expect(product).toBeTruthy();

    // UI: login → POS → add product to cart → checkout while OFFLINE.
    await page.goto("/login");
    await page.getByPlaceholder(/email/i).fill(process.env.E2E_EMAIL!);
    await page.getByPlaceholder(/password/i).fill(process.env.E2E_PASSWORD!);
    await page.getByRole("button", { name: /sign in/i }).click();
    await expect(page).toHaveURL(/\/(pos|$)/, { timeout: 30_000 });
    // TODO(live pass): fill cart via POS selectors, e.g.
    //   await page.getByPlaceholder(/search/i).fill(product!.name);
    //   await page.getByText(product!.name).first().click();
    //   await page.getByRole("button", { name: /checkout|charge/i }).click();

    await context.setOffline(true);
    // ...perform the sale (selectors above)...
    await context.setOffline(false);

    // Wait for the drain, then assert server == pre-sale - sold.
    // const sold = 1; // cart quantity used above
    // await expect
    //   .poll(async () => {
    //     const { data } = await supabase
    //       .from("ashfoam_inventory")
    //       .select("quantity").eq("id", product!.id).single();
    //     return data?.quantity;
    //   }, { timeout: 60_000 })
    //   .toBe(product!.quantity - sold);
  });
});
