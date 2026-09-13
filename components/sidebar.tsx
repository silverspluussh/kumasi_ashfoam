"use client";

import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { LogOut } from "lucide-react";
import { ConfirmDialog } from "@/components/confirm-dialog";
import { useAuth } from "@/lib/auth/auth-context";
import { NAV_SECTIONS } from "@/lib/nav";
import { SyncQueueDialog } from "@/components/sync-queue-dialog";
import { cn } from "@/lib/utils";

/**
 * Shared sidebar content (logo + nav + footer). Rendered in the fixed
 * desktop aside and reused verbatim inside the mobile drawer.
 */
export function SidebarContent({ onNavigate }: { onNavigate?: () => void }) {
  const pathname = usePathname();
  const { role, displayName, signOut } = useAuth();
  const [confirmSignOut, setConfirmSignOut] = useState(false);
  const [wipeAsk, setWipeAsk] = useState(false);

  return (
    <div className="flex h-full flex-col bg-ashfoam">
      <div className="flex justify-center px-4 pt-5 pb-4">
        <Image
          src="/ashfoam_logo.png"
          alt="Ashfoam"
          width={120}
          height={44}
          style={{ width: 120, height: "auto" }}
          priority
        />
      </div>

      <nav className="flex-1 space-y-4 overflow-y-auto px-2 pb-4">
        {NAV_SECTIONS.map((section) => (
          <div key={section.title}>
            <p className="px-2 pb-1 text-[10px] font-bold tracking-widest text-ashfoam-ink/60 uppercase">
              {section.title}
            </p>
            <ul className="space-y-0.5">
              {section.items
                .filter((item) => !item.blockedFor?.includes(role))
                .map((item) => {
                // Exact match only: "/inventory" must not stay active when
                // a child route like "/inventory/proformas" is selected.
                const active = pathname === item.href;
                const Icon = item.icon;
                return (
                  <li key={item.href}>
                    <Link
                      href={item.href}
                      onClick={onNavigate}
                      className={cn(
                        "flex items-center gap-2.5 px-2.5 py-2 text-[13px] font-medium transition-colors",
                        active
                          ? "bg-ashfoam-ink text-white"
                          : "text-ashfoam-ink hover:bg-black/10",
                      )}
                    >
                      <Icon className="h-4 w-4 shrink-0" />
                      <span className="truncate">{item.label}</span>
                    </Link>
                  </li>
                );
              })}
            </ul>
          </div>
        ))}
      </nav>

      <div className="space-y-1 border-t border-black/15 px-4 py-3">
        {displayName && (
          <p className="truncate text-[12px] font-semibold text-ashfoam-ink">
            {displayName}
          </p>
        )}
        <button
          type="button"
          onClick={() => setConfirmSignOut(true)}
          className="flex items-center gap-1.5 text-[12px] font-medium text-ashfoam-ink/70 hover:text-ashfoam-ink"
        >
          <LogOut className="h-3.5 w-3.5" />
          Sign out
        </button>
        <SyncQueueDialog />
      </div>
      <ConfirmDialog
        open={confirmSignOut}
        title="Sign out?"
        message="Are you sure you want to sign out? Unsynced offline changes stay on this device and will sync next time you sign in."
        confirmLabel="Sign out"
        onCancel={() => setConfirmSignOut(false)}
        onConfirm={() => {
          setConfirmSignOut(false);
          // Shared-device hygiene: offer to wipe cached offline data.
          setWipeAsk(true);
        }}
      />
      <ConfirmDialog
        open={wipeAsk}
        title="Clear offline data too?"
        message={`Remove ${displayName || "this user"}'s cached offline data from this device? Recommended on shared devices — offline changes still on the queue will be lost.`}
        confirmLabel="Clear data & sign out"
        tone="danger"
        onCancel={() => {
          setWipeAsk(false);
          onNavigate?.();
          void signOut();
        }}
        onConfirm={() => {
          setWipeAsk(false);
          onNavigate?.();
          void signOut(true);
        }}
      />
    </div>
  );
}

/**
 * Desktop sidebar (md+). Yellow, fixed width — pixel-identical to before.
 */
export function Sidebar() {
  return (
    <aside className="hidden h-full w-60 shrink-0 md:block">
      <SidebarContent />
    </aside>
  );
}
