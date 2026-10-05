"use client";

import { useAuth } from "./auth-context";

/**
 * Returns the parsed list of lowercase, trimmed emails configured in NEXT_PUBLIC_ALLOWED_EMAILS.
 */
export function getAllowedEmails(): string[] {
  const raw = process.env.NEXT_PUBLIC_ALLOWED_EMAILS || "";
  return raw
    .split(",")
    .map((e) => e.trim().toLowerCase())
    .filter(Boolean);
}

/**
 * Checks whether a given email address is in the allowed list (case-insensitive).
 */
export function isEmailAllowed(email?: string | null): boolean {
  if (!email) return false;
  const allowed = getAllowedEmails();
  return allowed.includes(email.trim().toLowerCase());
}

/**
 * React hook to check if the current signed-in user's email is allowed to perform guarded actions.
 */
export function useEmailGuard() {
  const { email } = useAuth();
  const isAllowed = isEmailAllowed(email);

  return {
    isAllowed,
    email,
    allowedEmails: getAllowedEmails(),
  };
}
