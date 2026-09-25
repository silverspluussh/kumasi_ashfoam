import { db } from "@/lib/db/dexie";
import { newId } from "@/lib/db/mappers";
import type { ExpenseRow, Synced } from "@/lib/db/types";
import { createClient } from "@/lib/supabase/browser";
import { bulkUploadExpenses, deleteExpense } from "@/lib/supabase/queries/money";

export const DEFAULT_EXPENSE_CATEGORIES = [
  "Utilities",
  "Rent",
  "Salaries & Wages",
  "Transportation & Fuel",
  "Maintenance & Repairs",
  "Office Supplies",
  "Marketing & Advertising",
  "Shop Supplies",
  "Bank & POS Charges",
  "Food & Refreshments",
  "Miscellaneous",
] as const;

export function getCategoryBadgeClass(category: string): string {
  const norm = category.toLowerCase();
  if (
    norm.includes("util") ||
    norm.includes("power") ||
    norm.includes("electric") ||
    norm.includes("water")
  ) {
    return "bg-amber-100 text-amber-800 border-amber-300";
  }
  if (norm.includes("rent")) {
    return "bg-purple-100 text-purple-800 border-purple-300";
  }
  if (
    norm.includes("salar") ||
    norm.includes("wage") ||
    norm.includes("staff")
  ) {
    return "bg-blue-100 text-blue-800 border-blue-300";
  }
  if (
    norm.includes("transport") ||
    norm.includes("fuel") ||
    norm.includes("travel")
  ) {
    return "bg-sky-100 text-sky-800 border-sky-300";
  }
  if (norm.includes("repair") || norm.includes("mainten")) {
    return "bg-orange-100 text-orange-800 border-orange-300";
  }
  if (norm.includes("office") || norm.includes("station")) {
    return "bg-indigo-100 text-indigo-800 border-indigo-300";
  }
  if (norm.includes("market") || norm.includes("advert")) {
    return "bg-pink-100 text-pink-800 border-pink-300";
  }
  if (
    norm.includes("bank") ||
    norm.includes("pos") ||
    norm.includes("charge")
  ) {
    return "bg-rose-100 text-rose-800 border-rose-300";
  }
  if (norm.includes("food") || norm.includes("refresh")) {
    return "bg-emerald-100 text-emerald-800 border-emerald-300";
  }
  return "bg-gray-100 text-gray-800 border-gray-300";
}

export interface ExpenseInput {
  title: string;
  description: string | null;
  amount: number;
  category: string;
  date: string; // ISO string
}

/**
 * Add a new expense.
 * Online: upsert to Supabase + save to Dexie as clean (_isSynced=1).
 * Offline (or RLS 42501): save to Dexie as dirty (_isSynced=0) for upload queue.
 */
export async function addExpense(
  online: boolean,
  input: ExpenseInput,
): Promise<{ synced: boolean; row: Synced<ExpenseRow> }> {
  if (!input.title.trim()) throw new Error("Expense title is required");
  if (!input.category.trim()) throw new Error("Category is required");
  if (!(input.amount > 0)) throw new Error("Amount must be greater than 0");

  const now = new Date().toISOString();
  const row: ExpenseRow = {
    id: newId(),
    title: input.title.trim(),
    description: input.description?.trim() || null,
    amount: input.amount,
    category: input.category.trim(),
    date: input.date,
    created_at: now,
  };

  let synced = false;
  if (online) {
    try {
      await bulkUploadExpenses(createClient(), [row as unknown as Record<string, unknown>]);
      synced = true;
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      if (!msg.includes("42501")) {
        throw new Error(
          `Not saved — remote sync failed: ${msg.split("\n")[0]}`,
        );
      }
      // RLS fallback: queue locally
    }
  }

  const storedRow: Synced<ExpenseRow> = {
    ...row,
    _isSynced: synced ? 1 : 0,
    _lastSyncedAt: synced ? now : null,
  };

  await db.expenses.put(storedRow);
  return { synced, row: storedRow };
}

/**
 * Update an existing expense.
 */
export async function updateExpense(
  online: boolean,
  id: string,
  input: ExpenseInput,
  prev?: Partial<ExpenseRow>,
): Promise<{ synced: boolean; row: Synced<ExpenseRow> }> {
  if (!input.title.trim()) throw new Error("Expense title is required");
  if (!input.category.trim()) throw new Error("Category is required");
  if (!(input.amount > 0)) throw new Error("Amount must be greater than 0");

  const now = new Date().toISOString();
  const row: ExpenseRow = {
    id,
    title: input.title.trim(),
    description: input.description?.trim() || null,
    amount: input.amount,
    category: input.category.trim(),
    date: input.date,
    created_at: prev?.created_at || now,
  };

  let synced = false;
  if (online) {
    try {
      await bulkUploadExpenses(createClient(), [row as unknown as Record<string, unknown>]);
      synced = true;
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      if (!msg.includes("42501")) {
        throw new Error(
          `Not updated — remote sync failed: ${msg.split("\n")[0]}`,
        );
      }
    }
  }

  const storedRow: Synced<ExpenseRow> = {
    ...row,
    _isSynced: synced ? 1 : 0,
    _lastSyncedAt: synced ? now : null,
  };

  await db.expenses.put(storedRow);
  return { synced, row: storedRow };
}

/**
 * Delete an expense.
 */
export async function deleteExpenseItem(
  online: boolean,
  id: string,
): Promise<void> {
  if (online) {
    try {
      await deleteExpense(createClient(), id);
    } catch (e) {
      const first = e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(`Remote delete failed — not deleted locally. ${first}`);
    }
  }
  await db.expenses.delete(id);
}
