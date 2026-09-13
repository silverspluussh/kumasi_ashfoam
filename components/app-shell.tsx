"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { usePathname } from "next/navigation";
import { X } from "lucide-react";
import { MobileTopbar } from "@/components/mobile-topbar";
import { OfflineBanner } from "@/components/offline-banner";
import { Sidebar, SidebarContent } from "@/components/sidebar";

/**
 * Responsive app shell: fixed sidebar on md+, overlay drawer with
 * top-bar trigger below md. Drawer closes on navigate, backdrop tap,
 * or Escape; body scroll locks while open.
 */
export function AppShell({ children }: { children: React.ReactNode }) {
  const [open, setOpen] = useState(false);
  const pathname = usePathname();
  const closeRef = useRef<HTMLButtonElement>(null);

  const close = useCallback(() => setOpen(false), []);

  // Auto-close on route change (backup for link taps).
  useEffect(() => {
    setOpen(false);
  }, [pathname]);

  // Escape closes; body scroll locks while open; focus the close button.
  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") close();
    };
    document.addEventListener("keydown", onKey);
    const prev = document.body.style.overflow;
    document.body.style.overflow = "hidden";
    closeRef.current?.focus();
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prev;
    };
  }, [open, close]);

  return (
    <div className="flex h-screen overflow-hidden bg-[#FAFAFA]">
      <Sidebar />
      <div className="flex min-w-0 flex-1 flex-col">
        <MobileTopbar onOpen={() => setOpen(true)} />
        <OfflineBanner />
        <main className="flex-1 overflow-y-auto p-3 md:p-6">{children}</main>
      </div>

      {open && (
        <div
          className="fixed inset-0 z-50 md:hidden"
          role="dialog"
          aria-modal="true"
          aria-label="Navigation"
        >
          <button
            type="button"
            aria-label="Close navigation"
            onClick={close}
            className="absolute inset-0 cursor-default bg-black/50"
          />
          <div className="absolute inset-y-0 left-0 w-72 max-w-[85vw] animate-drawer-in shadow-xl">
            <button
              ref={closeRef}
              type="button"
              onClick={close}
              aria-label="Close navigation"
              className="absolute top-2 right-2 z-10 p-2 text-ashfoam-ink hover:bg-black/10"
            >
              <X className="h-5 w-5" />
            </button>
            <SidebarContent onNavigate={close} />
          </div>
        </div>
      )}
    </div>
  );
}
