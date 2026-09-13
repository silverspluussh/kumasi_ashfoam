"use client";

import { useEffect, useState, type ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { LoadingSpinner } from "@/components/loading-spinner";
import { cursors } from "@/lib/db/cursors";
import { useOnline } from "@/lib/sync/connectivity";
import { runBootstrap } from "@/lib/sync/bootstrap";

/**
 * First-run gate mirroring BootstrapGate: blocks UI with "Preparing
 * offline data" until hasCompletedOnce; on error shows Retry /
 * Continue-local-only; re-triggers on offline→online.
 */
export function BootstrapGate({ children }: { children: ReactNode }) {
  const online = useOnline();
  const [ready, setReady] = useState(() => cursors.bootstrapComplete);
  const [failed, setFailed] = useState(false);
  const [running, setRunning] = useState(false);

  useEffect(() => {
    if (ready || !online || running) return;
    setRunning(true);
    runBootstrap()
      .then((ok) => {
        if (ok) setReady(true);
        else setFailed(true);
      })
      .finally(() => setRunning(false));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [online]);

  const retry = async () => {
    setFailed(false);
    setRunning(true);
    const ok = await runBootstrap({ force: true });
    setRunning(false);
    if (ok) setReady(true);
    else setFailed(true);
  };

  if (ready) return <>{children}</>;

  return (
    <div className="flex h-64 flex-col items-center justify-center gap-3">
      {failed ? (
        <>
          <p className="text-sm font-medium">
            Couldn&apos;t download offline data.
          </p>
          <p className="text-[13px] text-black/60">
            Check your connection, or continue with locally stored data.
          </p>
          <div className="flex gap-2 pt-1">
            <Button onClick={retry} disabled={running}>
              {running ? "Retrying…" : "Retry"}
            </Button>
            <Button variant="outline" onClick={() => setReady(true)}>
              Continue offline
            </Button>
          </div>
        </>
      ) : (
        <>
          <LoadingSpinner size="lg" label="Preparing offline data…" />
          <p className="text-[13px] text-black/60">
            Downloading products and catalog for offline use.
          </p>
        </>
      )}
    </div>
  );
}
