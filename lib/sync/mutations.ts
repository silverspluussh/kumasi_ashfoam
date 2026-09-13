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
      const first =
        e instanceof Error ? e.message.split("\n")[0] : String(e);
      throw new Error(`Remote ${opts.remoteLabel} failed — not saved locally. ${first}`);
    }
    await opts.applyLocal(true);
  } else {
    await opts.applyLocal(false);
  }
}
