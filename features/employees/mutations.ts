/**
 * PARKED — Employees screen removed from sidebar (per owner request).
 * Code kept for later re-use: uncomment this block to restore.
 */
/*
import { createClient } from "@/lib/supabase/browser";
import {
  bulkUploadEmployees,
  deleteEmployee,
  fetchEmployees,
} from "@/lib/supabase/queries/org";
import { newId } from "@/lib/db/mappers";
import type { EmployeeRow } from "@/lib/db/types";

export type EmploymentStatus =
  | "active"
  | "inactive"
  | "suspended"
  | "terminated"
  | "probation";

export const EMPLOYMENT_STATUSES: EmploymentStatus[] = [
  "active",
  "inactive",
  "suspended",
  "terminated",
  "probation",
];

function requireOnline(online: boolean, action: string) {
  if (!online)
    throw new Error(`Supabase not available — cannot ${action} offline.`);
}

export async function listEmployees(
  online: boolean,
): Promise<EmployeeRow[]> {
  requireOnline(online, "load employees");
  return fetchEmployees(createClient(), { orderBy: "last_name" });
}

export interface EmployeeInput {
  firstName: string;
  lastName: string;
  middleName: string | null;
  email: string;
  phone: string;
  role: string;
  department: string;
  designation: string | null;
  status: EmploymentStatus;
  address: string | null;
  notes: string | null;
}

export function validateEmployee(input: EmployeeInput): string | null {
  if (!input.firstName.trim()) return "First name is required";
  if (!input.lastName.trim()) return "Last name is required";
  if (!input.email.trim()) return "Email is required";
  if (!input.phone.trim()) return "Phone is required";
  if (!input.role.trim()) return "Role is required";
  if (!input.department.trim()) return "Department is required";
  return null;
}

const clean = (v: string) => (v.trim() === "" ? null : v.trim());

export async function createEmployee(
  online: boolean,
  input: EmployeeInput,
): Promise<void> {
  requireOnline(online, "add employee");
  const err = validateEmployee(input);
  if (err) throw new Error(err);
  const now = new Date().toISOString();
  await bulkUploadEmployees(createClient(), [
    {
      id: newId(),
      first_name: input.firstName.trim(),
      last_name: input.lastName.trim(),
      middle_name: clean(input.middleName ?? ""),
      email: input.email.trim(),
      phone: input.phone.trim(),
      role: input.role.trim(),
      department: input.department.trim(),
      branch_id: null,
      branch_name: null,
      manager_id: null,
      manager_name: null,
      designation: clean(input.designation ?? ""),
      status: input.status,
      is_active: input.status === "active",
      hire_date: now,
      end_date: null,
      address: clean(input.address ?? ""),
      notes: clean(input.notes ?? ""),
      created_at: now,
      updated_at: now,
    },
  ]);
}

export async function updateEmployee(
  online: boolean,
  id: string,
  prev: EmployeeRow,
  input: EmployeeInput,
): Promise<void> {
  requireOnline(online, "update employee");
  const err = validateEmployee(input);
  if (err) throw new Error(err);
  await bulkUploadEmployees(createClient(), [
    {
      ...prev,
      id,
      first_name: input.firstName.trim(),
      last_name: input.lastName.trim(),
      middle_name: clean(input.middleName ?? ""),
      email: input.email.trim(),
      phone: input.phone.trim(),
      role: input.role.trim(),
      department: input.department.trim(),
      designation: clean(input.designation ?? ""),
      status: input.status,
      is_active: input.status === "active",
      address: clean(input.address ?? ""),
      notes: clean(input.notes ?? ""),
      updated_at: new Date().toISOString(),
    },
  ]);
}

export async function removeEmployee(
  online: boolean,
  id: string,
): Promise<void> {
  requireOnline(online, "delete employee");
  await deleteEmployee(createClient(), id);
}

export function fullName(e: {
  first_name?: string | null;
  last_name?: string | null;
  email: string;
}): string {
  return (
    [e.first_name, e.last_name].filter(Boolean).join(" ") || e.email
  );
}
*/
