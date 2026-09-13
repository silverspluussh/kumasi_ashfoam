import { useSyncExternalStore } from "react";
import { db } from "./dexie";

/**
 * Resilience (P3-plan): Dexie has no reactive UI binding here — screens read
 * imperatively on mount only, so a queue drain or bootstrap pull left open
 * screens stale. This bus bumps a version on ANY table write
 * (creating/updating/deleting hooks) and lets components re-run their loads.
 * Lightweight (no dexie-react-hooks): a version counter + useSyncExternalStore.
 */

type Listener = () => void;

const listeners = new Set<Listener>();
let version = 0;
let suppressed = 0;

/**
 * Suppress bumps while background sync writes (remote-first warm, bootstrap
 * pull) run — otherwise every sync write retriggers every mounted screen's
 * load() (loading→data flicker, and warm→bump→warm loops).
 */
export async function withDataBusSuppressed<T>(fn: () => Promise<T>): Promise<T> {
  suppressed += 1;
  try {
    return await fn();
  } finally {
    suppressed = Math.max(0, suppressed - 1);
  }
}

function bump() {
  if (suppressed > 0) return;
  version += 1;
  for (const l of listeners) l();
}

export function getDataVersion(): number {
  return version;
}

export function subscribeDataVersion(cb: Listener): () => void {
  listeners.add(cb);
  return () => listeners.delete(cb);
}

/** React hook — returns the current data version (bumps on any db write). */
export function useDataVersion(): number {
  return useSyncExternalStore(subscribeDataVersion, getDataVersion, () => 0);
}

let attached = false;

/** Attach write hooks to every table (idempotent, client-only). */
export function attachDbChangeHooks() {
  if (attached || typeof window === "undefined") return;
  attached = true;
  for (const table of db.tables) {
    table.hook("creating", bump);
    table.hook("updating", bump);
    table.hook("deleting", bump);
  }
}
