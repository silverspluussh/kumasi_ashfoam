import { findNavItem } from "@/lib/nav";

interface RoutePlaceholderProps {
  title: string;
  pathname: string;
  phase?: string;
}

/**
 * Temporary shell for every route until P2/P3 implement the real screens.
 * Shows Flutter traceability (selectedIndex) + online-only badge.
 */
export function RoutePlaceholder({
  title,
  pathname,
  phase = "P2/P3",
}: RoutePlaceholderProps) {
  const nav = findNavItem(pathname);

  return (
    <div className="space-y-2">
      <div className="flex flex-wrap items-center gap-2">
        <h1 className="text-xl font-bold">{title}</h1>
        {nav?.onlineOnly && (
          <span className="bg-black px-2 py-0.5 text-[11px] font-semibold text-white">
            ONLINE ONLY
          </span>
        )}
        {nav?.flutterIndex !== undefined && nav.flutterIndex >= 0 && (
          <span className="border border-black/20 px-2 py-0.5 text-[11px] text-black/60">
            Flutter idx {nav.flutterIndex}
          </span>
        )}
        {nav?.flutterIndex === -1 && (
          <span className="border border-black/20 px-2 py-0.5 text-[11px] text-black/60">
            New in Next.js
          </span>
        )}
      </div>
      <p className="text-sm text-black/60">
        Full screen lands in {phase}. Shell (sidebar, offline banner, guards)
        is P0.
      </p>
    </div>
  );
}
