/**
 * Offline session cache & session management.
 * Expiration duration: 604800 seconds (7 days).
 */
import type { AppRole } from "@/lib/roles";
import { appRoleFromString } from "@/lib/roles";

/** Session / token expiration duration: 604800 seconds (7 days) */
export const SESSION_EXPIRY_SECONDS = 604800;

export interface OfflineSession {
  userId: string;
  email: string;
  displayName: string;
  role: AppRole;
  branchId: string | null;
  branchName: string | null;
  createdAt?: number;
  expiresAt?: number;
}

const KEYS = {
  userData: "user_data",
  userRole: "user_role",
  branchId: "branch_id",
  loggedIn: "is_logged_in",
  sessionCreatedAt: "session_created_at",
  sessionExpiresAt: "session_expires_at",
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

/**
 * Checks whether the stored session has expired based on SESSION_EXPIRY_SECONDS (604800s).
 */
export function isSessionExpired(): boolean {
  const expiresAtRaw = read(KEYS.sessionExpiresAt);
  if (expiresAtRaw) {
    const expiresAt = Number(expiresAtRaw);
    if (!isNaN(expiresAt) && Date.now() > expiresAt) {
      return true;
    }
  }

  const createdAtRaw = read(KEYS.sessionCreatedAt);
  if (createdAtRaw) {
    const createdAt = Number(createdAtRaw);
    if (!isNaN(createdAt) && Date.now() > createdAt + SESSION_EXPIRY_SECONDS * 1000) {
      return true;
    }
  }

  return false;
}

export function getSessionExpiresAt(): number | null {
  const expiresAtRaw = read(KEYS.sessionExpiresAt);
  if (!expiresAtRaw) return null;
  const exp = Number(expiresAtRaw);
  return isNaN(exp) ? null : exp;
}

export function getRemainingSessionSeconds(): number {
  const expiresAt = getSessionExpiresAt();
  if (!expiresAt) return SESSION_EXPIRY_SECONDS;
  const remaining = Math.floor((expiresAt - Date.now()) / 1000);
  return Math.max(0, remaining);
}

export function getOfflineSession(): OfflineSession | null {
  // If session has expired past 604800 seconds, clear and return null
  if (isSessionExpired()) {
    clearOfflineSession();
    return null;
  }

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
      createdAt?: number;
      expiresAt?: number;
    };
    if (!d.userId || !d.email) return null;
    return {
      userId: d.userId,
      email: d.email,
      displayName: d.displayName ?? d.email,
      role: appRoleFromString(d.role ?? read(KEYS.userRole)),
      branchId: d.branchId ?? read(KEYS.branchId),
      branchName: d.branchName ?? null,
      createdAt: d.createdAt,
      expiresAt: d.expiresAt ?? getSessionExpiresAt() ?? undefined,
    };
  } catch {
    return null;
  }
}

export function setOfflineSession(s: OfflineSession) {
  const now = Date.now();
  const createdAt = s.createdAt ?? now;
  const expiresAt = s.expiresAt ?? (now + SESSION_EXPIRY_SECONDS * 1000);

  write(
    KEYS.userData,
    JSON.stringify({
      userId: s.userId,
      email: s.email,
      displayName: s.displayName,
      role: s.role,
      branchId: s.branchId,
      branchName: s.branchName,
      createdAt,
      expiresAt,
    }),
  );
  write(KEYS.userRole, s.role);
  write(KEYS.branchId, s.branchId);
  write(KEYS.loggedIn, "true");
  write(KEYS.sessionCreatedAt, String(createdAt));
  write(KEYS.sessionExpiresAt, String(expiresAt));
}

export function refreshSessionExpiry() {
  const now = Date.now();
  const expiresAt = now + SESSION_EXPIRY_SECONDS * 1000;
  write(KEYS.sessionExpiresAt, String(expiresAt));
}

export function clearOfflineSession() {
  for (const k of Object.values(KEYS)) write(k, null);
}
