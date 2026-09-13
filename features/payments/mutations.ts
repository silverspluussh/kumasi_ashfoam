import { db } from "@/lib/db/dexie";
import { isUuid, newId } from "@/lib/db/mappers";
import { createClient } from "@/lib/supabase/browser";
import { bulkUploadBranchPayments } from "@/lib/supabase/queries/money";

export interface BranchPaymentInput {
  title: string;
  branchName: string;
  amount: number;
  note: string | null;
  date: string; // ISO
  createdBy: string;
}

/**
 * Branch payment write. Ported from addPaymentProvider:
 * online (+session) → remote upsert with branch_id nulled when the
 * free-text branch isn't a UUID (avoids PostgREST 22P02); RLS 42501
 * falls back to a local dirty write; other remote errors save nothing.
 * Offline → local dirty write for the upload queue.
 */
export async function addBranchPayment(
  online: boolean,
  input: BranchPaymentInput,
): Promise<{ synced: boolean }> {
  const now = new Date().toISOString();
  const row = {
    id: newId(),
    branch_id: input.branchName,
    branch_name: input.branchName,
    amount: input.amount,
    note: input.note,
    title: input.title,
    created_by: input.createdBy || "Admin",
    created_at: input.date,
  };

  let synced = false;
  if (online) {
    try {
      await bulkUploadBranchPayments(createClient(), [
        {
          ...row,
          branch_id: isUuid(row.branch_id) ? row.branch_id : null,
        },
      ]);
      synced = true;
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      if (!msg.includes("42501")) {
        throw new Error(
          `Not saved — remote sync failed. ${msg.split("\n")[0]}`,
        );
      }
      // RLS fallback: queue locally like Flutter.
    }
  }

  await db.branchPayments.put({
    ...row,
    _isSynced: synced ? 1 : 0,
    _lastSyncedAt: synced ? now : null,
  });
  return { synced };
}
