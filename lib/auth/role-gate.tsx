"use client";

import { useRouter } from "next/navigation";
import { useEffect, type ReactNode } from "react";
import { LoadingSpinner } from "@/components/loading-spinner";
import { isManager } from "@/lib/roles";
import { useAuth } from "./auth-context";

/**
 * Mirrors Flutter's guards:
 * - unauthenticated (no live session AND no offline cache) → /login
 * - manager on employees/suppliers/* → "Access restricted" placeholder
 *   (isRoleBlockedForIndex {14,15,16}).
 */
export function RequireAuth({
  children,
  restrictedForManager = false,
}: {
  children: ReactNode;
  restrictedForManager?: boolean;
}) {
  const { loading, session, offline, role } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!loading && !session && !offline) router.replace("/login");
  }, [loading, session, offline, router]);

  if (loading) {
    return (
      <div className="flex min-h-[70vh] items-center justify-center">
        <LoadingSpinner size="lg" />
      </div>
    );
  }
  if (!session && !offline) return null;
  if (restrictedForManager && isManager(role)) {
    return (
      <div className="space-y-2">
        <h1 className="text-xl font-bold">Access restricted</h1>
        <p className="text-sm text-black/60">
          Your role cannot access this section.
        </p>
      </div>
    );
  }
  return <>{children}</>;
}
