"use client";

import { useEffect, useRef, useState } from "react";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface SearchableSelectProps<T> {
  label: string;
  required?: boolean;
  hint?: string;
  items: T[];
  format: (item: T) => string;
  filter: (item: T, query: string) => boolean;
  value: T | null;
  onSelect: (item: T | null) => void;
  disabled?: boolean;
}

/**
 * Searchable dropdown (replaces FSelect.searchBuilder): text input with
 * a filtered listbox. Empty query shows all items.
 */
export function SearchableSelect<T>({
  label,
  required,
  hint,
  items,
  format,
  filter,
  value,
  onSelect,
  disabled,
}: SearchableSelectProps<T>) {
  const [query, setQuery] = useState("");
  const [open, setOpen] = useState(false);
  const boxRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setQuery(value ? format(value) : "");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [value]);

  useEffect(() => {
    const onDocClick = (e: MouseEvent) => {
      if (boxRef.current && !boxRef.current.contains(e.target as Node)) {
        setOpen(false);
        setQuery(value ? format(value) : "");
      }
    };
    document.addEventListener("mousedown", onDocClick);
    return () => document.removeEventListener("mousedown", onDocClick);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [value]);

  const q = query.trim().toLowerCase();
  const matches = q === "" ? items : items.filter((i) => filter(i, q));

  return (
    <div ref={boxRef} className="relative">
      <Label className="pb-1 block text-[13px] font-medium">
        {label}
        {required && " *"}
      </Label>
      <Input
        placeholder={hint ?? `Select ${label.toLowerCase()}`}
        value={query}
        disabled={disabled}
        onChange={(e) => {
          setQuery(e.target.value);
          setOpen(true);
        }}
        onFocus={() => setOpen(true)}
      />
      {open && !disabled && (
        <ul className="absolute z-20 max-h-56 w-full overflow-y-auto border border-black/20 bg-white shadow-lg">
          {matches.slice(0, 100).map((item, idx) => (
            <li key={idx}>
              <button
                type="button"
                className={cn(
                  "block w-full truncate px-3 py-2 text-left text-sm hover:bg-black/5",
                  value === item && "bg-black/5 font-semibold",
                )}
                onClick={() => {
                  onSelect(item);
                  setOpen(false);
                }}
              >
                {format(item)}
              </button>
            </li>
          ))}
          {matches.length === 0 && (
            <li className="px-3 py-2 text-sm text-black/50">No matches.</li>
          )}
        </ul>
      )}
    </div>
  );
}
