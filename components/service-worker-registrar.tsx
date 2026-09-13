"use client";

import { useEffect } from "react";

/**
 * P5 — registers the app-shell service worker (public/sw.js).
 * Production-only registration; SW never touches Dexie data (see sw.js).
 */
export function ServiceWorkerRegistrar() {
  useEffect(() => {
    if (process.env.NODE_ENV !== "production") return;
    if (!("serviceWorker" in navigator)) return;
    navigator.serviceWorker.register("/sw.js").catch(() => {
      /* PWA is progressive enhancement — ignore */
    });
  }, []);
  return null;
}
