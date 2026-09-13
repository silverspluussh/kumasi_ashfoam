import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import { saveRemoteFirst } from "@/lib/sync/mutations";
import { createClient } from "@/lib/supabase/browser";
import {
  bulkUploadBrands,
  bulkUploadCategories,
  deleteBrand,
  deleteCategory,
} from "@/lib/supabase/queries/catalog";

/**
 * Brand/category mutations. Ported from management_providers.dart:
 * id ensured uuid upfront; online → upsert (abort local on error);
 * offline → local-only (UploadSyncService re-upserts all idempotently).
 * No isSynced column on these tables.
 */
export async function addBrand(online: boolean, name: string): Promise<void> {
  const trimmed = name.trim();
  if (!trimmed) return;
  const now = new Date().toISOString();
  const row = { id: newId(), name: trimmed, created_at: now };
  await saveRemoteFirst({
    online,
    remoteLabel: "brand sync",
    remote: async () => {
      await bulkUploadBrands(createClient(), [row]);
    },
    applyLocal: async () => db.brands.put(row),
  });
}

export async function updateBrand(
  online: boolean,
  id: string,
  name: string,
): Promise<void> {
  const trimmed = name.trim();
  if (!trimmed) return;
  await saveRemoteFirst({
    online,
    remoteLabel: "brand update",
    remote: async () => {
      await bulkUploadBrands(createClient(), [{ id, name: trimmed }]);
    },
    applyLocal: async () => db.brands.update(id, { name: trimmed }),
  });
}

export async function removeBrand(online: boolean, id: string): Promise<void> {
  if (online) {
    try {
      await deleteBrand(createClient(), id);
    } catch (e) {
      const first = e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(
        `Remote brand delete failed — not deleted locally. ${first}`,
      );
    }
  }
  await db.brands.delete(id);
}

export async function addCategory(
  online: boolean,
  name: string,
): Promise<void> {
  const trimmed = name.trim();
  if (!trimmed) return;
  const now = new Date().toISOString();
  const row = { id: newId(), name: trimmed, created_at: now };
  await saveRemoteFirst({
    online,
    remoteLabel: "category sync",
    remote: async () => {
      await bulkUploadCategories(createClient(), [row]);
    },
    applyLocal: async () => db.categories.put(row),
  });
}

export async function updateCategory(
  online: boolean,
  id: string,
  name: string,
): Promise<void> {
  const trimmed = name.trim();
  if (!trimmed) return;
  await saveRemoteFirst({
    online,
    remoteLabel: "category update",
    remote: async () => {
      await bulkUploadCategories(createClient(), [{ id, name: trimmed }]);
    },
    applyLocal: async () => db.categories.update(id, { name: trimmed }),
  });
}

export async function removeCategory(
  online: boolean,
  id: string,
): Promise<void> {
  if (online) {
    try {
      await deleteCategory(createClient(), id);
    } catch (e) {
      const first = e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(
        `Remote category delete failed — not deleted locally. ${first}`,
      );
    }
  }
  await db.categories.delete(id);
}
