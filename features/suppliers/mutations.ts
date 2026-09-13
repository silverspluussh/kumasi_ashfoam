import { createClient } from "@/lib/supabase/browser";
import {
  bulkUploadSupplierPayments,
  bulkUploadSuppliers,
  deleteSupplier,
  deleteSupplierPayment,
  fetchSupplierPayments,
  fetchSuppliers,
} from "@/lib/supabase/queries/partners";
import { newId } from "@/lib/db/mappers";
import type { SupplierPaymentRow, SupplierRow } from "@/lib/db/types";

function requireOnline(online: boolean, action: string) {
  if (!online)
    throw new Error(
      `Connect to internet to ${action}. Supplier data is online-only.`,
    );
}

/* ashfoam_suppliers — online-only, no Dexie fallback (mirrors providers). */
export async function listSuppliers(
  online: boolean,
): Promise<SupplierRow[]> {
  requireOnline(online, "load suppliers");
  return fetchSuppliers(createClient(), { orderBy: "name" });
}

export interface SupplierInput {
  name: string;
  supplierCode: string | null;
  contactName: string | null;
  phone: string | null;
  email: string | null;
  address: string | null;
}

export async function createSupplier(
  online: boolean,
  input: SupplierInput,
): Promise<void> {
  requireOnline(online, "add supplier");
  if (!input.name.trim()) throw new Error("Supplier name is required");
  const now = new Date().toISOString();
  await bulkUploadSuppliers(createClient(), [
    {
      id: newId(),
      name: input.name.trim(),
      supplier_code: input.supplierCode,
      contact_name: input.contactName,
      phone: input.phone,
      email: input.email,
      address: input.address,
      is_active: 1,
      created_at: now,
      updated_at: now,
    },
  ]);
}

export async function updateSupplier(
  online: boolean,
  id: string,
  prev: SupplierRow,
  input: SupplierInput,
): Promise<void> {
  requireOnline(online, "update supplier");
  if (!input.name.trim()) throw new Error("Supplier name is required");
  const { id: _drop, ...rest } = {
    ...prev,
    name: input.name.trim(),
    supplier_code: input.supplierCode,
    contact_name: input.contactName,
    phone: input.phone,
    email: input.email,
    address: input.address,
    updated_at: new Date().toISOString(),
  };
  void _drop;
  await bulkUploadSuppliers(createClient(), [{ ...rest, id }]);
}

export async function removeSupplier(
  online: boolean,
  id: string,
): Promise<void> {
  requireOnline(online, "delete supplier");
  await deleteSupplier(createClient(), id);
}

/* ashfoam_supplier_payments — online-only. */
export async function listSupplierPayments(
  online: boolean,
  supplierId?: string | null,
): Promise<SupplierPaymentRow[]> {
  requireOnline(online, "load supplier payments");
  return fetchSupplierPayments(createClient(), supplierId ?? undefined);
}

export interface SupplierPaymentInput {
  supplierId: string;
  amount: number;
  note: string | null;
  date: string; // YYYY-MM-DD
}

export async function createSupplierPayment(
  online: boolean,
  input: SupplierPaymentInput,
): Promise<void> {
  if (!online)
    throw new Error(
      "Connect to internet to record supplier payment. Supplier payments are online-only.",
    );
  if (!input.supplierId) throw new Error("Please select a supplier first");
  if (!(input.amount > 0)) throw new Error("Please enter a valid amount");
  await bulkUploadSupplierPayments(createClient(), [
    {
      id: newId(),
      supplier_id: input.supplierId,
      amount: input.amount,
      note: input.note,
      date: input.date,
      created_at: new Date().toISOString(),
    },
  ]);
}

export async function removeSupplierPayment(
  online: boolean,
  id: string,
): Promise<void> {
  if (!online)
    throw new Error(
      "Connect to internet to delete supplier payment. Supplier payments are online-only.",
    );
  await deleteSupplierPayment(createClient(), id);
}
