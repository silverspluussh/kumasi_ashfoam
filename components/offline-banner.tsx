"use client";

import { useEffect, useState } from "react";
import { WifiOff } from "lucide-react";

/**
 * Amber offline banner mirroring Flutter _OfflineBanner in main.dart.
 * P1 upgrades this to the shared connectivity provider + pending-count.
 */
export function OfflineBanner() {
  const [online, setOnline] = useState(true);

  useEffect(() => {
    setOnline(navigator.onLine);
    const goOnline = () => setOnline(true);
    const goOffline = () => setOnline(false);
    window.addEventListener("online", goOnline);
    window.addEventListener("offline", goOffline);
    return () => {
      window.removeEventListener("online", goOnline);
      window.removeEventListener("offline", goOffline);
    };
  }, []);

  if (online) return null;

  return (
    <div className="flex items-center justify-center gap-2 bg-amber-500 px-4 py-1.5 text-[13px] font-medium text-black">
      <WifiOff className="h-4 w-4" />
      You are offline — showing locally stored data.
    </div>
  );
}
