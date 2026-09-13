/**
 * Offline session cache. Ported from SecureStorageService (Flutter):
 * user_data JSON + user_role + branch_id + is_logged_in. Lets the app
 * open offline-limited (appEntryProvider: error + offlineCache → home).
 */
import type { AppRole } from "@/lib/roles";
import { appRoleFromString } from "@/lib/roles";

export interface OfflineSession {
  userId: string;
  email: string;
  displayName: string;
  role: AppRole;
  branchId: string | null;
  branchName: string | null;
}

const KEYS = {
  userData: "user_data",
  userRole: "user_role",
  branchId: "branch_id",
  loggedIn: "is_logged_in",
} as const;

function read(key: string): string | null {
  if (typeof window === "undefined") return null;
  try {
    return window.localStorage.getItem(key);
  } catch {
    return null;
  }
}

function write(key: string, value: string | null) {
  if (typeof window === "undefined") return;
  try {
    if (value === null) window.localStorage.removeItem(key);
    else window.localStorage.setItem(key, value);
  } catch {
    /* ignore */
  }
}

export function getOfflineSession(): OfflineSession | null {
  const raw = read(KEYS.userData);
  if (!raw || read(KEYS.loggedIn) !== "true") return null;
  try {
    const d = JSON.parse(raw) as {
      userId?: string;
      email?: string;
      displayName?: string;
      role?: string;
      branchId?: string | null;
      branchName?: string | null;
    };
    if (!d.userId || !d.email) return null;
    return {
      userId: d.userId,
      email: d.email,
      displayName: d.displayName ?? d.email,
      role: appRoleFromString(d.role ?? read(KEYS.userRole)),
      branchId: d.branchId ?? read(KEYS.branchId),
      branchName: d.branchName ?? null,
    };
  } catch {
    return null;
  }
}

export function setOfflineSession(s: OfflineSession) {
  write(
    KEYS.userData,
    JSON.stringify({
      userId: s.userId,
      email: s.email,
      displayName: s.displayName,
      role: s.role,
      branchId: s.branchId,
      branchName: s.branchName,
    }),
  );
  write(KEYS.userRole, s.role);
  write(KEYS.branchId, s.branchId);
  write(KEYS.loggedIn, "true");
}

export function clearOfflineSession() {
  for (const k of Object.values(KEYS)) write(k, null);
}
