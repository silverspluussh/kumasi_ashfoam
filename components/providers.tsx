"use client";

import type { ReactNode } from "react";
import { BootstrapGate } from "@/components/bootstrap-gate";
import { AuthProvider } from "@/lib/auth/auth-context";
import { RequireAuth } from "@/lib/auth/role-gate";
import { AutoSync } from "@/lib/sync/auto-sync";
import { ConnectivityProvider } from "@/lib/sync/connectivity";
import { SyncProvider } from "@/lib/sync/sync-context";

/**
 * Client providers for the authenticated app shell.
 * Order mirrors Flutter: AppEntry.home → BootstrapGate → AutoSyncListener.
 */
export function AppProviders({ children }: { children: ReactNode }) {
  return (
    <AuthProvider>
      <ConnectivityProvider>
        <SyncProvider>
          <RequireAuth>
            <BootstrapGate>
              <AutoSync />
              {children}
            </BootstrapGate>
          </RequireAuth>
        </SyncProvider>
      </ConnectivityProvider>
    </AuthProvider>
  );
}
