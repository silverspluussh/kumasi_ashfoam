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
import { cursors } from "@/lib/db/cursors";
import { useDataVersion } from "@/lib/db/data-bus";
import { useOnline } from "./connectivity";
import {
  getPendingUploadCounts,
  totalPending,
  uploadAllUnsynced,
  type QueuedEntity,
  type UploadProgress,
} from "./upload";

interface SyncState {
  online: boolean;
  uploading: boolean;
  progress: UploadProgress | null;
  pending: Record<QueuedEntity, number>;
  pendingTotal: number;
  errors: Record<string, string[]>;
  lastUploadAt: string | null;
  refreshCounts: () => Promise<void>;
  uploadAll: (opts?: { auto?: boolean }) => Promise<Record<string, string[]>>;
}

/**
 * Mirrors sync_providers.dart (pendingUploadCounts, persisted errors,
 * lastUploadAt) + UploadSyncNotifier.uploadAllUnsynced.
 */
const SyncContext = createContext<SyncState | null>(null);

const EMPTY_COUNTS = {} as Record<QueuedEntity, number>;

export function SyncProvider({ children }: { children: ReactNode }) {
  const online = useOnline();
  const dataVersion = useDataVersion(); // refresh pending counts on any write
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState<UploadProgress | null>(null);
  const [pending, setPending] =
    useState<Record<QueuedEntity, number>>(EMPTY_COUNTS);
  const [errors, setErrors] = useState<Record<string, string[]>>({});
  const [lastUploadAt, setLastUploadAt] = useState<string | null>(null);

  const refreshCounts = useCallback(async () => {
    try {
      setPending(await getPendingUploadCounts());
    } catch {
      /* Dexie unavailable */
    }
    setErrors(cursors.getUploadErrors());
    setLastUploadAt(cursors.lastUploadAt);
  }, []);

  useEffect(() => {
    void refreshCounts();
  }, [refreshCounts, dataVersion]);

  const uploadAll = useCallback(
    async (opts?: { auto?: boolean }) => {
      if (!online) return {};
      if (opts?.auto) {
        try {
          const counts = await getPendingUploadCounts();
          if (totalPending(counts) === 0) return {};
        } catch {
          return {};
        }
      }
      setUploading(true);
      setProgress({ currentStep: "starting", done: 0, total: 16 });
      try {
        const errs = await uploadAllUnsynced({ onProgress: setProgress });
        return errs;
      } finally {
        setUploading(false);
        setProgress(null);
        await refreshCounts();
      }
    },
    [online, refreshCounts],
  );

  const value = useMemo<SyncState>(
    () => ({
      online,
      uploading,
      progress,
      pending,
      pendingTotal: totalPending(pending),
      errors,
      lastUploadAt,
      refreshCounts,
      uploadAll,
    }),
    [
      online,
      uploading,
      progress,
      pending,
      errors,
      lastUploadAt,
      refreshCounts,
      uploadAll,
    ],
  );

  return <SyncContext.Provider value={value}>{children}</SyncContext.Provider>;
}

export function useSync(): SyncState {
  const ctx = useContext(SyncContext);
  if (!ctx) throw new Error("useSync must be used inside SyncProvider");
  return ctx;
}
