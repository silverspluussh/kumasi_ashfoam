/**
 * Ported from ashfoam_sadiq lib/src/core/constants/offline_capable.dart.
 * offlineCapable (Flutter idx {0,1,2,4,9,11}) work fully offline via Dexie;
 * onlineOnly routes render an offline placeholder redirecting to /pos.
 */
export const OFFLINE_CAPABLE_PATHS = new Set([
  "/",
  "/pos",
  "/sales",
  "/inventory",
  "/inventory/proformas",
  "/inventory/waybills",
]);

export function isOnlineOnlyPath(pathname: string): boolean {
  return !OFFLINE_CAPABLE_PATHS.has(pathname);
}
