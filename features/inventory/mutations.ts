import { createClient } from "@/lib/supabase/browser";
import { bulkUploadInventory } from "@/lib/supabase/queries/inventory";
import { deleteRemote } from "@/lib/supabase/queries/_table";
import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import { saveRemoteFirst } from "@/lib/sync/mutations";
import type { InventoryRow } from "@/lib/db/types";

export interface ProductValues {
  name: string;
  category: string | null;
  categoryId: string | null;
  unit: string;
  retailPrice: number;
  quantity: number;
  material: string | null;
  size: string | null;
  thickness: string | null;
  density: string | null;
  brand?: string | null;
  brandId?: string | null;
  subCategory?: string | null;
}

/** PREFIX-YYYYMMDD-millis (initials of first 3 words, or first 3 chars). */
export function generateSku(name: string): string {
  const words = name.trim().split(/\s+/).filter(Boolean);
  const prefix =
    words.length >= 2
      ? words
          .slice(0, 3)
          .map((w) => w[0])
          .join("")
      : name.slice(0, 3);
  const date = new Date().toISOString().slice(0, 10).replaceAll("-", "");
  const millis = Date.now().toString().substring(7);
  return `${prefix.toUpperCase()}-${date}-${millis}`;
}

const strip = (r: Record<string, unknown>) => {
  const c = { ...r };
  delete c._isSynced;
  delete c._lastSyncedAt;
  return c;
};

export async function addProduct(
  online: boolean,
  values: ProductValues,
): Promise<void> {
  const now = new Date().toISOString();
  const base = {
    id: newId(),
    name: values.name,
    sku: generateSku(values.name),
    category: values.category,
    catergory_id: values.categoryId,
    subCategory: values.subCategory ?? null,
    size: values.size,
    thickness: values.thickness,
    material: values.material,
    density: values.density,
    brand: values.brand ?? null,
    brandId: values.brandId ?? null,
    retailPrice: values.retailPrice,
    discountPrice: null as number | null,
    discountPercentage: null as number | null,
    quantity: values.quantity,
    unit: values.unit,
    branchId: null as string | null,
    isAvailable: 1,
    isDeleted: 0,
    createdAt: now,
    updatedAt: now,
  };
  await saveRemoteFirst({
    online,
    remoteLabel: "sync",
    remote: async () => {
      await bulkUploadInventory(createClient(), [strip(base)]);
    },
    applyLocal: async (isClean) =>
      db.inventory.put({
        ...base,
        _isSynced: isClean ? 1 : 0,
        _lastSyncedAt: isClean ? now : null,
      }),
  });
}

export async function updateProduct(
  online: boolean,
  id: string,
  prev: InventoryRow,
  values: ProductValues,
): Promise<void> {
  const now = new Date().toISOString();
  const base = {
    ...prev,
    name: values.name,
    category: values.category,
    catergory_id: values.categoryId,
    unit: values.unit,
    retailPrice: values.retailPrice,
    quantity: values.quantity,
    material: values.material,
    size: values.size,
    thickness: values.thickness,
    density: values.density,
    updatedAt: now,
  };
  await saveRemoteFirst({
    online,
    remoteLabel: "update",
    remote: async () => {
      await bulkUploadInventory(createClient(), [strip(base)]);
    },
    applyLocal: async (isClean) =>
      db.inventory.put({
        ...base,
        _isSynced: isClean ? 1 : 0,
        _lastSyncedAt: isClean ? now : null,
      }),
  });
}

export async function deleteProduct(
  online: boolean,
  id: string,
): Promise<void> {
  if (online) {
    try {
      await deleteRemote(createClient(), "ashfoam_inventory", id);
    } catch (e) {
      const first = e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(`Remote delete failed — not deleted locally. ${first}`);
    }
  }
  await db.inventory.delete(id);
}
