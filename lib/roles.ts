/**
 * Ported from ashfoam_sadiq lib/src/core/constants/roles.dart
 * (enum AppRole{manager,admin,owner} + isRoleBlockedForIndex).
 * Manager is blocked on employees + suppliers screens only; the guard
 * resets to /pos with an "Access restricted" placeholder (see layout).
 */
export type AppRole = "manager" | "admin" | "owner";

/** appRoleFromString — fail-open to admin, matching Flutter. */
export function appRoleFromString(role?: string | null): AppRole {
  switch (role?.toLowerCase()) {
    case "manager":
      return "manager";
    case "owner":
      return "owner";
    default:
      return "admin";
  }
}

export function roleLabel(role: AppRole): string {
  switch (role) {
    case "manager":
      return "Manager";
    case "owner":
      return "Owner";
    default:
      return "Admin";
  }
}

export const isManager = (r: AppRole) => r === "manager";
export const isPrivileged = (r: AppRole) => r === "admin" || r === "owner";

/** Mirrors Flutter canAccess* helpers in roles.dart. */
export const canAccessSuppliers = (r: AppRole) => r !== "manager";
export const canAccessSupplierPayments = (r: AppRole) => r !== "manager";
export const canAccessEmployees = (r: AppRole) => r !== "manager";
export const canCreateWaybill = (_r: AppRole) => true;
export const canCreateProforma = (_r: AppRole) => true;
export const canAddProduct = (r: AppRole) => r !== "manager";
export const canImportProducts = (r: AppRole) => r !== "manager";
export const canEditProduct = (r: AppRole) => r !== "manager";
export const canDeleteProduct = (r: AppRole) => r !== "manager";
