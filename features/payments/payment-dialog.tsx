"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { toIsoDate } from "@/lib/dates";

export interface PaymentFormValues {
  title: string;
  branchName: string;
  amount: number;
  note: string | null;
  date: string;
}

interface PaymentDialogProps {
  open: boolean;
  busy: boolean;
  error: string | null;
  onClose: () => void;
  onSubmit: (values: PaymentFormValues) => void;
}

/** Add New Payment — ported from add_payment_dialog.dart. */
export function PaymentDialog({
  open,
  busy,
  error,
  onClose,
  onSubmit,
}: PaymentDialogProps) {
  const [date, setDate] = useState(toIsoDate());
  const [branch, setBranch] = useState("");
  const [title, setTitle] = useState("");
  const [amount, setAmount] = useState("");
  const [notes, setNotes] = useState("");
  const [touched, setTouched] = useState(false);

  const branchOk = branch.trim().length > 0;
  const titleOk = title.trim().length > 0;
  const amountNum = parseFloat(amount);
  const amountOk = amount.trim().length > 0 && !Number.isNaN(amountNum);
  const amountPositive = amountOk && amountNum > 0;

  const submit = () => {
    setTouched(true);
    if (!branchOk || !titleOk || !amountPositive || busy) return;
    onSubmit({
      title: title.trim(),
      branchName: branch.trim(),
      amount: amountNum,
      note: notes.trim() || null,
      date: date
        ? new Date(`${date}T00:00:00`).toISOString()
        : new Date().toISOString(),
    });
  };

  const field = (
    label: string,
    control: React.ReactNode,
    valid: boolean,
    message: string,
  ) => (
    <div>
      <Label className="pb-1 block text-[13px] font-medium">{label}</Label>
      {control}
      {touched && !valid && (
        <p className="pt-1 text-xs text-red-600">{message}</p>
      )}
    </div>
  );

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Add New Payment</DialogTitle>
        </DialogHeader>
        <div className="space-y-3">
          {field(
            "Payment Date",
            <Input
              type="date"
              value={date}
              onChange={(e) => setDate(e.target.value)}
            />,
            true,
            "",
          )}
          {field(
            "Branch",
            <Input
              placeholder="e.g., Kumasi Main Branch"
              value={branch}
              onChange={(e) => setBranch(e.target.value)}
            />,
            branchOk,
            "Please enter a branch",
          )}
          {field(
            "Payment Title",
            <Input
              placeholder="e.g., Weekly Rent, Utility Bill"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            />,
            titleOk,
            "Please enter a title",
          )}
          {field(
            "Amount (GH₵)",
            <Input
              type="number"
              min={0}
              placeholder="0.00"
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
            />,
            amountOk,
            "Please enter an amount",
          )}
          {touched && amountOk && !amountPositive && (
            <p className="-mt-2 text-xs text-red-600">
              Please enter a valid amount
            </p>
          )}
          <div>
            <Label className="pb-1 block text-[13px] font-medium">Notes</Label>
            <Textarea
              rows={3}
              placeholder="Optional details..."
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
            />
          </div>
        </div>
        {error && (
          <p className="text-[13px] font-medium text-red-600">{error}</p>
        )}
        <div className="flex justify-end gap-2">
          <Button variant="outline" onClick={onClose}>
            Cancel
          </Button>
          <Button
            onClick={submit}
            disabled={busy}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            {busy ? "Saving…" : "Save Payment"}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
