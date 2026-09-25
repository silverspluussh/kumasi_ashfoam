"use client";

import { useMemo, useState } from "react";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { toIsoDate } from "@/lib/dates";
import type { ExpenseRow } from "@/lib/db/types";
import {
  DEFAULT_EXPENSE_CATEGORIES,
  type ExpenseInput,
} from "./mutations";

interface ExpenseDialogProps {
  open: boolean;
  busy: boolean;
  error: string | null;
  initial?: ExpenseRow | null;
  existingCategories?: string[];
  onClose: () => void;
  onSubmit: (input: ExpenseInput) => void;
}

function ExpenseDialogInner({
  busy,
  error,
  initial,
  existingCategories = [],
  onClose,
  onSubmit,
}: Omit<ExpenseDialogProps, "open">) {
  const isEditing = Boolean(initial);

  // Merge default categories with any existing custom ones
  const allCategories = useMemo(
    () =>
      Array.from(
        new Set([...DEFAULT_EXPENSE_CATEGORIES, ...existingCategories.filter(Boolean)]),
      ),
    [existingCategories],
  );

  const initialIsPredefined = initial ? allCategories.includes(initial.category) : true;

  const [title, setTitle] = useState(initial?.title || "");
  const [category, setCategory] = useState<string>(
    initial && initialIsPredefined ? initial.category : DEFAULT_EXPENSE_CATEGORIES[0],
  );
  const [isCustomCategory, setIsCustomCategory] = useState(!initialIsPredefined);
  const [customCategory, setCustomCategory] = useState(
    initial && !initialIsPredefined ? initial.category : "",
  );
  const [amount, setAmount] = useState(initial?.amount ? String(initial.amount) : "");
  const [date, setDate] = useState(
    initial?.date ? toIsoDate(new Date(initial.date)) : toIsoDate(),
  );
  const [description, setDescription] = useState(initial?.description || "");
  const [touched, setTouched] = useState(false);

  const activeCategory = isCustomCategory ? customCategory.trim() : category.trim();
  const titleOk = title.trim().length > 0;
  const categoryOk = activeCategory.length > 0;
  const amountNum = parseFloat(amount);
  const amountOk = !Number.isNaN(amountNum) && amountNum > 0;
  const dateOk = date.trim().length > 0;

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setTouched(true);
    if (!titleOk || !categoryOk || !amountOk || !dateOk || busy) return;

    // Convert local YYYY-MM-DD to ISO timestamp
    const dateObj = new Date(`${date}T12:00:00`);
    const dateIso = !Number.isNaN(dateObj.getTime())
      ? dateObj.toISOString()
      : new Date().toISOString();

    onSubmit({
      title: title.trim(),
      category: activeCategory,
      amount: amountNum,
      date: dateIso,
      description: description.trim() || null,
    });
  };

  return (
    <>
      <DialogHeader>
        <DialogTitle className="text-lg font-bold text-ashfoam-ink">
          {isEditing ? "Edit Expense" : "Record New Expense"}
        </DialogTitle>
      </DialogHeader>

      {error && (
        <div className="rounded border border-red-200 bg-red-50 p-2.5 text-xs text-red-700">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4 pt-1">
        <div>
          <Label className="block text-[13px] font-medium text-black/80 pb-1">
            Title <span className="text-red-500">*</span>
          </Label>
          <Input
            placeholder="e.g. Shop Generator Fuel, Electricity Bill"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="border-black/20 focus-visible:ring-ashfoam-ink"
            disabled={busy}
            autoFocus
          />
          {touched && !titleOk && (
            <p className="pt-1 text-xs text-red-600">Please enter a title</p>
          )}
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div>
            <Label className="block text-[13px] font-medium text-black/80 pb-1">
              Amount (GHS) <span className="text-red-500">*</span>
            </Label>
            <div className="relative">
              <span className="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3 text-xs font-semibold text-black/50">
                GH₵
              </span>
              <Input
                type="number"
                step="0.01"
                min="0"
                placeholder="0.00"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
                className="pl-11 border-black/20 font-medium focus-visible:ring-ashfoam-ink"
                disabled={busy}
              />
            </div>
            {touched && !amountOk && (
              <p className="pt-1 text-xs text-red-600">Enter a valid amount</p>
            )}
          </div>

          <div>
            <Label className="block text-[13px] font-medium text-black/80 pb-1">
              Date <span className="text-red-500">*</span>
            </Label>
            <Input
              type="date"
              value={date}
              onChange={(e) => setDate(e.target.value)}
              className="border-black/20 focus-visible:ring-ashfoam-ink"
              disabled={busy}
            />
            {touched && !dateOk && (
              <p className="pt-1 text-xs text-red-600">Select a date</p>
            )}
          </div>
        </div>

        <div>
          <Label className="block text-[13px] font-medium text-black/80 pb-1">
            Category <span className="text-red-500">*</span>
          </Label>
          <select
            value={isCustomCategory ? "__custom__" : category}
            onChange={(e) => {
              if (e.target.value === "__custom__") {
                setIsCustomCategory(true);
              } else {
                setIsCustomCategory(false);
                setCategory(e.target.value);
              }
            }}
            disabled={busy}
            className="w-full rounded-md border border-black/20 bg-white px-3 py-2 text-sm focus:border-black focus:outline-none focus:ring-1 focus:ring-black disabled:opacity-60"
          >
            {allCategories.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
            <option value="__custom__">+ Custom Category...</option>
          </select>

          {isCustomCategory && (
            <div className="mt-2">
              <Input
                placeholder="Enter custom category name..."
                value={customCategory}
                onChange={(e) => setCustomCategory(e.target.value)}
                className="border-black/20 focus-visible:ring-ashfoam-ink"
                disabled={busy}
              />
              {touched && !categoryOk && (
                <p className="pt-1 text-xs text-red-600">
                  Please provide category name
                </p>
              )}
            </div>
          )}
        </div>

        <div>
          <Label className="block text-[13px] font-medium text-black/80 pb-1">
            Description / Notes (Optional)
          </Label>
          <Textarea
            placeholder="Additional details, receipt numbers, vendor info..."
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            className="min-h-[70px] border-black/20 focus-visible:ring-ashfoam-ink"
            disabled={busy}
          />
        </div>

        <DialogFooter className="pt-2 gap-2">
          <Button
            type="button"
            variant="outline"
            onClick={onClose}
            disabled={busy}
            className="border-black/20 text-black hover:bg-black/5"
          >
            Cancel
          </Button>
          <Button
            type="submit"
            disabled={busy}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90 font-medium"
          >
            {busy ? (
              <>
                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                Saving...
              </>
            ) : isEditing ? (
              "Update Expense"
            ) : (
              "Save Expense"
            )}
          </Button>
        </DialogFooter>
      </form>
    </>
  );
}

export function ExpenseDialog(props: ExpenseDialogProps) {
  if (!props.open) return null;

  return (
    <Dialog open={props.open} onOpenChange={(o) => !o && props.onClose()}>
      <DialogContent className="max-w-md border-black/15 bg-white p-6 shadow-xl sm:rounded-lg">
        <ExpenseDialogInner key={props.initial?.id ?? "new"} {...props} />
      </DialogContent>
    </Dialog>
  );
}
