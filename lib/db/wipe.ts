import { db } from "./dexie";
import { seedLocalConstants } from "./seed";

/**
 * Resilience: sign-out on a SHARED device can leave the previous user's
 * cached data in IndexedDB. Wipe all 32 stores, reopen the (same) database
 * and reseed the local constants. Dexie re-creates the schema on open.
 */
export async function wipeLocalData(): Promise<void> {
  await db.delete();
  await db.open();
  await seedLocalConstants();
}
