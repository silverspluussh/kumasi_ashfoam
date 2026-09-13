/**
 * Sync cursors + flags. Ported from SecureStorageService via
 * SyncMetadataService (Flutter). localStorage in Next.js; SSR-safe.
 */
const KEYS = {
  pullCursorInventory: "pull_cursor_inventory",
  bootstrapComplete: "bootstrap_complete",
  lastBootstrapAt: "last_bootstrap_at",
  uploadErrors: "upload_errors",
  lastUploadAt: "last_upload_at",
} as const;

function read(key: string): string | null {
  if (typeof window === "undefined") return null;
  try {
    return window.localStorage.getItem(key);
  } catch {
    return null;
  }
}

function write(key: string, value: string | null) {
  if (typeof window === "undefined") return;
  try {
    if (value === null) window.localStorage.removeItem(key);
    else window.localStorage.setItem(key, value);
  } catch {
    /* storage unavailable — sync still works, cursors just don't persist */
  }
}

export const cursors = {
  get inventoryPullCursor(): string | null {
    return read(KEYS.pullCursorInventory);
  },
  set inventoryPullCursor(v: string | null) {
    write(KEYS.pullCursorInventory, v);
  },
  get bootstrapComplete(): boolean {
    return read(KEYS.bootstrapComplete) === "1";
  },
  set bootstrapComplete(v: boolean) {
    write(KEYS.bootstrapComplete, v ? "1" : "0");
  },
  get lastBootstrapAt(): string | null {
    return read(KEYS.lastBootstrapAt);
  },
  set lastBootstrapAt(v: string | null) {
    write(KEYS.lastBootstrapAt, v);
  },
  get lastUploadAt(): string | null {
    return read(KEYS.lastUploadAt);
  },
  set lastUploadAt(v: string | null) {
    write(KEYS.lastUploadAt, v);
  },
  getUploadErrors(): Record<string, string[]> {
    try {
      return JSON.parse(read(KEYS.uploadErrors) ?? "{}");
    } catch {
      return {};
    }
  },
  setUploadErrors(errors: Record<string, string[]>) {
    write(KEYS.uploadErrors, JSON.stringify(errors));
  },
  clearUploadErrors() {
    write(KEYS.uploadErrors, null);
  },
  /** Wiped on sign-out, mirroring Flutter signOut(). */
  clearAll() {
    for (const k of Object.values(KEYS)) write(k, null);
  },
};
