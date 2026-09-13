"use client";

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import { createClient } from "@/lib/supabase/browser";

interface ConnectivityState {
  /** Unknown treated as offline (matches Flutter isOnlineSyncProvider). */
  online: boolean;
}

/**
 * Ported from connectivity_service.dart: seeded status + platform events
 * + 15s poll + Supabase reachability probe. Unknown = offline.
 */
const ConnectivityContext = createContext<ConnectivityState>({ online: false });

export function ConnectivityProvider({ children }: { children: ReactNode }) {
  const [online, setOnline] = useState(
    () => typeof navigator !== "undefined" && navigator.onLine,
  );
  const probe = useCallback(async () => {
    if (typeof navigator !== "undefined" && !navigator.onLine) {
      setOnline(false);
      return;
    }
    try {
      const supabase = createClient();
      const { error } = await supabase
        .from("ashfoam_stores")
        .select("id", { count: "exact", head: true })
        .abortSignal(AbortSignal.timeout(8000));
      setOnline(!error);
    } catch {
      setOnline(
        typeof navigator === "undefined" ? false : navigator.onLine,
      );
    }
  }, []);

  useEffect(() => {
    void probe();
    const onOnline = () => void probe();
    const onOffline = () => setOnline(false);
    window.addEventListener("online", onOnline);
    window.addEventListener("offline", onOffline);
    const id = setInterval(() => void probe(), 15000);
    return () => {
      window.removeEventListener("online", onOnline);
      window.removeEventListener("offline", onOffline);
      clearInterval(id);
    };
  }, [probe]);

  const value = useMemo(() => ({ online }), [online]);
  return (
    <ConnectivityContext.Provider value={value}>
      {children}
    </ConnectivityContext.Provider>
  );
}

export function useOnline(): boolean {
  return useContext(ConnectivityContext).online;
}
