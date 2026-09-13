"use client";

import { usePathname } from "next/navigation";
import { Menu } from "lucide-react";
import { SyncQueueDialog } from "@/components/sync-queue-dialog";
import { findNavItem } from "@/lib/nav";

/**
 * Mobile top bar (below md): hamburger + current section title +
 * sync status. Opens the nav drawer.
 */
export function MobileTopbar({ onOpen }: { onOpen: () => void }) {
  const pathname = usePathname();
  const title = findNavItem(pathname)?.label ?? "Ashfoam";

  return (
    <header className="flex items-center gap-2 bg-ashfoam px-2 py-2 md:hidden">
      <button
        type="button"
        onClick={onOpen}
        aria-label="Open navigation"
        className="p-2 text-ashfoam-ink hover:bg-black/10"
      >
        <Menu className="h-5 w-5" />
      </button>
      <p className="min-w-0 flex-1 truncate text-sm font-bold text-ashfoam-ink">
        {title}
      </p>
      <div className="px-1 text-ashfoam-ink">
        <SyncQueueDialog />
      </div>
    </header>
  );
}
