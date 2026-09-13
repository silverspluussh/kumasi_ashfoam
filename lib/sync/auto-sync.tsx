"use client";

import { useCallback, useEffect, useRef } from "react";
import { useOnline } from "@/lib/sync/connectivity";
import { runIncrementalIfNeeded } from "@/lib/sync/bootstrap";
import { useSync } from "./sync-context";

/**
 * Auto-sync listener mirroring auto_sync_listener.dart: on false→true
 * runs incremental bootstrap + 3s-debounced upload when pending > 0.
 * Also a periodic sweep every 2 minutes while online (incremental pull
 * + debounced upload), guarded so overlapping runs are skipped.
 */
export function AutoSync() {
  const online = useOnline();
  const { uploadAll } = useSync();
  const prev = useRef(online);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const running = useRef(false);

  const sweep = useCallback(() => {
    if (running.current) return;
    running.current = true;
    const done = () => {
      running.current = false;
    };
    void runIncrementalIfNeeded()
      .catch(() => undefined)
      .then(() => {
        if (timer.current) clearTimeout(timer.current);
        timer.current = setTimeout(() => {
          void uploadAll({ auto: true }).catch(() => undefined);
        }, 3000);
      })
      .finally(done);
  }, [uploadAll]);

  useEffect(() => {
    const was = prev.current;
    prev.current = online;
    if (!was && online) {
      void runIncrementalIfNeeded().catch(() => undefined);
      if (timer.current) clearTimeout(timer.current);
      timer.current = setTimeout(() => {
        void uploadAll({ auto: true }).catch(() => undefined);
      }, 3000);
    }
  }, [online, uploadAll]);

  useEffect(() => {
    if (!online) return;
    const id = setInterval(sweep, 120_000);
    return () => clearInterval(id);
  }, [online, sweep]);

  return null;
}
