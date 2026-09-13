import { LoaderCircle } from "lucide-react";
import { cn } from "@/lib/utils";

/**
 * Circular progress indicator — the single loading visual app-wide
 * (mirrors Flutter's CircularProgressIndicator).
 */
export function LoadingSpinner({
  label,
  className,
  size = "md",
}: {
  label?: string;
  className?: string;
  size?: "sm" | "md" | "lg";
}) {
  const dims =
    size === "sm" ? "h-4 w-4" : size === "lg" ? "h-10 w-10" : "h-7 w-7";
  return (
    <div
      className={cn("flex flex-col items-center justify-center gap-2 py-10", className)}
      role="status"
      aria-label={label ?? "Loading"}
    >
      <LoaderCircle className={cn(dims, "animate-spin text-black")} />
      {label && <p className="text-sm font-medium text-black">{label}</p>}
    </div>
  );
}
