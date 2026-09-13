import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import { createClient } from "@/lib/supabase/browser";

export type AdjustmentType = "Manual" | "Waybill";

export interface AdjustStockInput {
  productId: string;
  quantityChange: number;
  type: AdjustmentType;
  reason?: string | null;
  referenceId?: string | null;
  createdBy: string;
}

/**
 * Stock adjustment. Ported from adjustStockProvider: online → remote
 * quantity update first (camelCase `updatedAt` — snake_case fails
 * PGRST204); remote-missing stays queued; remote error saves nothing.
 * Offline → local dirty write. Audit log is always local-only.
 */
export async function adjustStock(
  online: boolean,
  input: AdjustStockInput,
): Promise<void> {
  const local = await db.inventory.get(input.productId);
  if (!local) throw new Error("Product not found locally");
  const newQty = (local.quantity ?? 0) + input.quantityChange;
  const now = new Date().toISOString();
  let remoteOk = false;

  if (online) {
    try {
      const supabase = createClient();
      const { data, error } = await supabase
        .from("ashfoam_inventory")
        .update({ quantity: newQty, updatedAt: now })
        .eq("id", input.productId)
        .select()
        .abortSignal(AbortSignal.timeout(8000));
      if (error) throw new Error(error.message);
      remoteOk = Array.isArray(data) && data.length > 0;
    } catch (e) {
      const first = e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(
        `Remote stock sync failed — adjustment not saved locally. ${first}`,
      );
    }
  }

  const clean = online && remoteOk;
  await db.transaction(
    "rw",
    [db.inventory, db.stockAdjustments],
    async () => {
      await db.inventory.update(input.productId, {
        quantity: Math.max(0, newQty),
        _isSynced: clean ? 1 : 0,
        _lastSyncedAt: clean ? now : null,
      });
      await db.stockAdjustments.put({
        id: newId(),
        productId: input.productId,
        productName: local.name,
        quantityChange: input.quantityChange,
        type: input.type,
        reason: input.reason ?? null,
        referenceId: input.referenceId ?? null,
        createdAt: now,
        createdBy: input.createdBy || "Admin",
      });
    },
  );
}
