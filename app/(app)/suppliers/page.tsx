"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useState } from "react";
import { Mail, MapPin, Pencil, Phone, Trash2, User } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { LoadingSpinner } from "@/components/loading-spinner";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  createSupplier,
  listSuppliers,
  removeSupplier,
  updateSupplier,
  type SupplierInput,
} from "@/features/suppliers/mutations";
import type { SupplierRow } from "@/lib/db/types";
import { useOnline } from "@/lib/sync/connectivity";
import { cn } from "@/lib/utils";

const EMPTY_INPUT: SupplierInput = {
  name: "",
  supplierCode: null,
  contactName: null,
  phone: null,
  email: null,
  address: null,
};

/**
 * Suppliers — ported from suppliers_page.dart. Online-only card grid
 * (no Dexie fallback, mirrors providers). Required name enforced
 * explicitly (Flutter's `*` had no validator).
 */
export default function SuppliersPage() {
  const online = useOnline();
  const [rows, setRows] = useState<SupplierRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [form, setForm] = useState<{
    mode: "add" | "edit";
    row: SupplierRow | null;
    input: SupplierInput;
  } | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [deleting, setDeleting] = useState<SupplierRow | null>(null);

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      setRows(await listSuppliers(online));
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setRows([]);
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter((r) =>
      [
        r.name,
        r.supplier_code,
        r.contact_name,
        r.email,
        r.phone,
      ].some((v) => (v ?? "").toLowerCase().includes(q)),
    );
  }, [rows, query]);

  const openAdd = () =>
    setForm({ mode: "add", row: null, input: { ...EMPTY_INPUT } });
  const openEdit = (row: SupplierRow) =>
    setForm({
      mode: "edit",
      row,
      input: {
        name: row.name,
        supplierCode: row.supplier_code,
        contactName: row.contact_name,
        phone: row.phone,
        email: row.email,
        address: row.address,
      },
    });

  const submit = async () => {
    if (!form) return;
    setBusy(true);
    setError(null);
    try {
      if (form.mode === "add") await createSupplier(online, form.input);
      else if (form.row)
        await updateSupplier(online, form.row.id, form.row, form.input);
      setForm(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  const confirmDelete = async () => {
    if (!deleting) return;
    setBusy(true);
    try {
      await removeSupplier(online, deleting.id);
      setDeleting(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setDeleting(null);
    } finally {
      setBusy(false);
    }
  };

  const set = (k: keyof SupplierInput, v: string) =>
    setForm((f) =>
      f ? { ...f, input: { ...f.input, [k]: v.trim() === "" ? null : v } } : f,
    );

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Suppliers</h1>
          <p className="text-sm text-black/60">
            Manage your suppliers and payments
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search suppliers..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-52"
          />
          <Button
            onClick={openAdd}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            Add New Supplier
          </Button>
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
        </div>
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}

      {loading ? (
        <LoadingSpinner />
      ) : filtered.length === 0 ? (
        <div className="mx-auto max-w-md py-10 text-center">
          <p className="font-bold">No suppliers yet</p>
          <p className="pb-3 text-sm text-black/60">
            Add your first supplier to start purchasing
          </p>
          <Button
            onClick={openAdd}
            className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            Add supplier
          </Button>
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
          {filtered.map((r) => {
            const active = (r.is_active ?? 1) === 1;
            return (
              <div
                key={r.id}
                className="flex min-h-56 flex-col border border-black/15 bg-white p-4"
              >
                <div className="flex items-center gap-2">
                  <span
                    className={cn(
                      "flex h-9 w-9 items-center justify-center",
                      active
                        ? "bg-blue-100 text-blue-700"
                        : "bg-black/5 text-black/40",
                    )}
                  >
                    <User className="h-5 w-5" />
                  </span>
                  <p className="min-w-0 flex-1 truncate text-sm font-bold">
                    {r.name}
                  </p>
                  <span
                    className={cn(
                      "px-2 py-0.5 text-[11px] font-bold",
                      active
                        ? "bg-green-100 text-green-700"
                        : "bg-red-100 text-red-700",
                    )}
                  >
                    {active ? "Active" : "Inactive"}
                  </span>
                </div>
                {r.supplier_code && (
                  <p className="pt-1 text-xs text-black/60">
                    Code: {r.supplier_code}
                  </p>
                )}
                <div className="flex-1 space-y-1 pt-2 text-[13px]">
                  {r.contact_name && (
                    <p className="flex items-center gap-1.5">
                      <User className="h-3.5 w-3.5 text-black/40" />
                      {r.contact_name}
                    </p>
                  )}
                  {r.phone && (
                    <p className="flex items-center gap-1.5">
                      <Phone className="h-3.5 w-3.5 text-black/40" />
                      {r.phone}
                    </p>
                  )}
                  {r.email && (
                    <p className="flex items-center gap-1.5 break-all">
                      <Mail className="h-3.5 w-3.5 shrink-0 text-black/40" />
                      {r.email}
                    </p>
                  )}
                  {r.address && (
                    <p className="flex items-center gap-1.5">
                      <MapPin className="h-3.5 w-3.5 shrink-0 text-black/40" />
                      {r.address}
                    </p>
                  )}
                </div>
                <div className="flex gap-2 border-t border-black/10 pt-2">
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => openEdit(r)}
                  >
                    <Pencil className="mr-1 h-3.5 w-3.5" />
                    Edit
                  </Button>
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => setDeleting(r)}
                    className="border-red-300 text-red-600 hover:bg-red-50"
                  >
                    <Trash2 className="mr-1 h-3.5 w-3.5" />
                    Delete
                  </Button>
                </div>
              </div>
            );
          })}
        </div>
      )}

      <Dialog open={!!form} onOpenChange={() => setForm(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              {form?.mode === "add" ? "Add New Supplier" : "Edit Supplier"}
            </DialogTitle>
          </DialogHeader>
          {form && (
            <div className="space-y-3">
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Supplier Name *
                </Label>
                <Input
                  placeholder="Enter supplier name"
                  value={form.input.name}
                  onChange={(e) =>
                    setForm({ ...form, input: { ...form.input, name: e.target.value } })
                  }
                />
              </div>
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Supplier Code
                </Label>
                <Input
                  placeholder="e.g. SUP-001"
                  value={form.input.supplierCode ?? ""}
                  onChange={(e) => set("supplierCode", e.target.value)}
                />
              </div>
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Contact Person
                </Label>
                <Input
                  placeholder="Enter contact name"
                  value={form.input.contactName ?? ""}
                  onChange={(e) => set("contactName", e.target.value)}
                />
              </div>
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Phone Number
                </Label>
                <Input
                  placeholder="e.g. +233 55 123 4567"
                  value={form.input.phone ?? ""}
                  onChange={(e) => set("phone", e.target.value)}
                />
              </div>
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Email Address
                </Label>
                <Input
                  type="email"
                  placeholder="supplier@example.com"
                  value={form.input.email ?? ""}
                  onChange={(e) => set("email", e.target.value)}
                />
              </div>
              <div>
                <Label className="pb-1 block text-[13px] font-medium">
                  Address
                </Label>
                <Textarea
                  rows={2}
                  placeholder="Enter supplier address"
                  value={form.input.address ?? ""}
                  onChange={(e) => set("address", e.target.value)}
                />
              </div>
              <div className="flex justify-end gap-2">
                <Button variant="outline" onClick={() => setForm(null)}>
                  Cancel
                </Button>
                <Button
                  onClick={() => void submit()}
                  disabled={busy}
                  className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
                >
                  {busy
                    ? "Saving…"
                    : form.mode === "add"
                      ? "Add Supplier"
                      : "Save Changes"}
                </Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      <Dialog open={!!deleting} onOpenChange={() => setDeleting(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Supplier</DialogTitle>
          </DialogHeader>
          <p className="text-sm">
            Are you sure you want to delete &quot;{deleting?.name}&quot;?
          </p>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setDeleting(null)}>
              Cancel
            </Button>
            <Button
              onClick={() => void confirmDelete()}
              disabled={busy}
              className="bg-red-600 text-white hover:bg-red-700"
            >
              {busy ? "Deleting…" : "Delete"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
