"use client";

import type { Session } from "@supabase/supabase-js";
import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import { cursors } from "@/lib/db/cursors";
import { wipeLocalData } from "@/lib/db/wipe";
import { appRoleFromString, type AppRole } from "@/lib/roles";
import { createClient } from "@/lib/supabase/browser";
import { fetchEmployeeByAuthId } from "@/lib/supabase/queries/org";
import {
  clearOfflineSession,
  getOfflineSession,
  setOfflineSession,
  type OfflineSession,
} from "./session";

interface AuthState {
  loading: boolean;
  /** Live Supabase session (null when offline / signed out). */
  session: Session | null;
  /** Offline-cached identity — present in offline-limited mode. */
  offline: OfflineSession | null;
  role: AppRole;
  displayName: string;
  branchId: string | null;
  branchName: string | null;
  email: string | null;
  /** True when running on cached credentials without a live session. */
  offlineLimited: boolean;
  signIn: (email: string, password: string) => Promise<{ error?: string }>;
  signOut: (wipeLocal?: boolean) => Promise<void>;
}

const AuthContext = createContext<AuthState | null>(null);

const displayNameOf = (e: {
  first_name?: string | null;
  last_name?: string | null;
  email: string;
}) =>
  [e.first_name, e.last_name].filter(Boolean).join(" ") || e.email;

/**
 * Mirrors auth_provider.dart + current_role_provider.dart:
 * live session first, cached offline role for fast return, restrictive
 * manager fallback. signOut clears offline session + sync cursors.
 */
export function AuthProvider({ children }: { children: ReactNode }) {
  const [supabase] = useState(createClient);
  const [loading, setLoading] = useState(true);
  const [session, setSession] = useState<Session | null>(null);
  const [offline, setOffline] = useState<OfflineSession | null>(null);
  const [liveRole, setLiveRole] = useState<AppRole | null>(null);
  const [liveName, setLiveName] = useState<string | null>(null);
  const [liveBranch, setLiveBranch] = useState<{
    id: string | null;
    name: string | null;
  } | null>(null);
  const [liveEmail, setLiveEmail] = useState<string | null>(null);

  const loadEmployee = useCallback(
    async (userId: string, email: string) => {
      try {
        const emp = await fetchEmployeeByAuthId(supabase, userId);
        if (!emp) {
          setLiveRole("manager");
          setLiveName(email);
          return;
        }
        const role = appRoleFromString(emp.role);
        const name = displayNameOf(emp);
        setLiveRole(role);
        setLiveName(name);
        setLiveBranch({
          id: emp.branch_id,
          name: emp.branch_name,
        });
        setLiveEmail(emp.email);
        setOfflineSession({
          userId,
          email: emp.email,
          displayName: name,
          role,
          branchId: emp.branch_id,
          branchName: emp.branch_name,
        });
        setOffline(getOfflineSession());
      } catch {
        // Offline: keep cached identity (offline-limited), restrictive role.
        setLiveRole((r) => r ?? "manager");
      }
    },
    [supabase],
  );

  useEffect(() => {
    let mounted = true;
    (async () => {
      setOffline(getOfflineSession());
      try {
        const { data } = await supabase.auth.getSession();
        if (!mounted) return;
        setSession(data.session);
        if (data.session?.user) {
          await loadEmployee(
            data.session.user.id,
            data.session.user.email ?? "",
          );
        }
      } catch {
        // No connectivity — offline cache (if any) governs.
      } finally {
        if (mounted) setLoading(false);
      }
    })();
    const { data: sub } = supabase.auth.onAuthStateChange(
      async (_event, next) => {
        setSession(next);
        if (next?.user) {
          await loadEmployee(next.user.id, next.user.email ?? "");
        } else {
          setLiveRole(null);
          setLiveName(null);
          setLiveBranch(null);
          setLiveEmail(null);
        }
      },
    );
    return () => {
      mounted = false;
      sub.subscription.unsubscribe();
    };
  }, [supabase, loadEmployee]);

  const signIn = useCallback(
    async (email: string, password: string) => {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: email.trim(),
        password,
      });
      if (error) return { error: error.message };
      if (data.session?.user) {
        await loadEmployee(
          data.session.user.id,
          data.session.user.email ?? email,
        );
      }
      return {};
    },
    [supabase, loadEmployee],
  );

  const signOut = useCallback(async (wipeLocal = false) => {
    clearOfflineSession();
    cursors.clearAll();
    setOffline(null);
    try {
      await supabase.auth.signOut();
    } catch {
      /* offline — local state already cleared */
    }
    if (wipeLocal) {
      try {
        await wipeLocalData();
      } catch {
        /* wipe failed — data stays; next sign-in still re-bootstraps */
      }
    }
  }, [supabase]);

  const value = useMemo<AuthState>(() => {
    const role = liveRole ?? offline?.role ?? "manager";
    return {
      loading,
      session,
      offline,
      role,
      displayName: liveName ?? offline?.displayName ?? "",
      branchId: liveBranch?.id ?? offline?.branchId ?? null,
      branchName: liveBranch?.name ?? offline?.branchName ?? null,
      email: liveEmail ?? offline?.email ?? session?.user?.email ?? null,
      offlineLimited: !session && !!offline,
      signIn,
      signOut,
    };
  }, [
    loading,
    session,
    offline,
    liveRole,
    liveName,
    liveBranch,
    liveEmail,
    signIn,
    signOut,
  ]);

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthState {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error("useAuth must be used inside AuthProvider");
  return ctx;
}
