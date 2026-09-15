/**
 * Remote-first mutation helper. Mirrors the provider pattern in
 * inventory/proforma/waybill/stockReport/payments/pos providers:
 * online → remote upsert first (throw "Remote X failed — not saved
 * locally" on error, NO local write); offline → Dexie write dirty.
 */
export async function saveRemoteFirst(opts: {
  online: boolean;
  remoteLabel: string;
  remote: () => Promise<void>;
  applyLocal: (clean: boolean) => Promise<unknown>;
}): Promise<void> {
  if (opts.online) {
    try {
      await opts.remote();
    } catch (e) {
      const raw =
        e instanceof Error ? e.message.split("\n")[0] : String(e);
      // Log full technical details for debugging
      console.error(`[saveRemoteFirst] ${opts.remoteLabel}:`, raw);
      throw new Error(
        `Could not save ${opts.remoteLabel} — please check your internet connection and try again.`,
      );
    }
    await opts.applyLocal(true);
  } else {
    await opts.applyLocal(false);
  }
}
