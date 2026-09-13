"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { Eye, Pencil, Trash2 } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DataTable } from "@/components/data-table";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import {
  ProductDialog,
  type ProductDialogMode,
} from "@/features/inventory/product-dialog";
import {
  addProduct,
  deleteProduct,
  updateProduct,
} from "@/features/inventory/mutations";
import {
  downloadInventoryExport,
  downloadTemplate,
  parseProducts,
} from "@/lib/excel/excel";
import { useAuth } from "@/lib/auth/auth-context";
import { db } from "@/lib/db/dexie";
import type {
  CategoryRow,
  Synced,
  InventoryRow,
} from "@/lib/db/types";
import { isManager } from "@/lib/roles";
import { ghs } from "@/lib/taxes";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

function stockBadge(quantity: number) {
  if (quantity === 0)
    return <Badge className="bg-red-100 text-red-700">Out of Stock</Badge>;
  if (quantity < 10)
    return <Badge className="bg-orange-100 text-orange-700">Low</Badge>;
  return <Badge className="bg-green-100 text-green-700">High</Badge>;
}

/**
 * Products — ported from inventory_page.dart + inventory_providers.dart.
 * Search matches name/sku/category. Manager sees View only.
 * (Excel Export/Sample/Import land in P4.)
 */
export default function InventoryPage() {
  const online = useOnline();
  const { role } = useAuth();
  const manager = isManager(role);
  const [rows, setRows] = useState<Synced<InventoryRow>[]>([]);
  const [categories, setCategories] = useState<CategoryRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [query, setQuery] = useState("");
  const [dialog, setDialog] = useState<{
    mode: ProductDialogMode;
    product: Synced<InventoryRow> | null;
  } | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [deleting, setDeleting] = useState<Synced<InventoryRow> | null>(null);
  const [brands, setBrands] = useState<{ id: string; name: string }[]>([]);
  const fileRef = useRef<HTMLInputElement>(null);

  const dataVersion = useDataVersion();
  const loadedOnce = useRef(false);
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          await remoteFirst.warmInventory(createClient());
        } catch {
          /* local stands */
        }
        try {
          await remoteFirst.warmCategories(createClient());
        } catch {
          /* local stands */
        }
      }
      const [items, cats, brs] = await Promise.all([
        db.inventory.filter((p) => (p.isDeleted ?? 0) === 0).toArray(),
        db.categories.toArray(),
        db.brands.toArray(),
      ]);
      setRows(items);
      setCategories(cats);
      setBrands(brs);
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    const first = !loadedOnce.current;
    loadedOnce.current = true;
    if (first) setLoading(true);
    void load();
  }, [load, dataVersion]);

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase();
    if (!q) return rows;
    return rows.filter(
      (r) =>
        r.name.toLowerCase().includes(q) ||
        r.sku.toLowerCase().includes(q) ||
        (r.category ?? "").toLowerCase().includes(q),
    );
  }, [rows, query]);

  const submit = async (values: Parameters<typeof addProduct>[1]) => {
    setBusy(true);
    setError(null);
    try {
      if (dialog?.mode === "add") {
        if (manager) throw new Error("Managers can only view products");
        await addProduct(online, values);
      } else if (dialog?.mode === "edit" && dialog.product) {
        if (manager) throw new Error("Managers can only view products");
        await updateProduct(online, dialog.product.id, dialog.product, values);
      }
      setDialog(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  const doExport = () =>
    downloadInventoryExport(
      filtered.map((r) => ({
        name: r.name,
        sku: r.sku,
        category: r.category,
        subCategory: r.subCategory,
        brand: r.brand,
        retailPrice: r.retailPrice ?? 0,
        quantity: r.quantity ?? 0,
        unit: r.unit,
        material: r.material,
        size: r.size,
        thickness: r.thickness,
        density: r.density,
      })),
    );

  const doImport = async (file: File | undefined) => {
    if (!file) return;
    if (manager) {
      setError("Managers can only view inventory");
      return;
    }
    setBusy(true);
    setError(null);
    setNotice(null);
    try {
      const { rows: parsed, errors } = await parseProducts(file);
      let added = 0;
      for (const p of parsed) {
        const cat = categories.find(
          (c) => c.name.toLowerCase() === (p.category ?? "").toLowerCase(),
        );
        const brand = brands.find(
          (b) => b.name.toLowerCase() === (p.brand ?? "").toLowerCase(),
        );
        await addProduct(online, {
          name: p.name,
          category: cat?.name ?? p.category,
          categoryId: cat?.id ?? null,
          unit: p.unit,
          retailPrice: p.retailPrice,
          quantity: p.quantity,
          material: p.material,
          size: p.size,
          thickness: p.thickness,
          density: p.density,
          brand: brand?.name ?? p.brand,
          brandId: brand?.id ?? null,
          subCategory: p.subCategory,
        });
        added += 1;
      }
      setNotice(
        `Imported ${added} product${added === 1 ? "" : "s"}` +
          (errors.length > 0 ? ` (${errors.length} rows skipped)` : ""),
      );
      if (errors.length > 0) setError(errors.slice(0, 5).join(" | "));
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
      if (fileRef.current) fileRef.current.value = "";
    }
  };

  const confirmDelete = async () => {    if (!deleting) return;
    if (manager) {
      setError("Managers cannot delete products");
      setDeleting(null);
      return;
    }
    setBusy(true);
    try {
      await deleteProduct(online, deleting.id);
      setDeleting(null);
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
      setDeleting(null);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="text-xl font-bold">Inventory</h1>
          <p className="text-sm text-black/60">View all Stocks</p>
        </div>
        <div className="flex items-center gap-2">
          <Input
            placeholder="Search..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="w-52"
          />
          <Button variant="outline" onClick={() => void load()}>
            Refresh
          </Button>
          {!manager && (
            <>
              <Button variant="outline" onClick={downloadTemplate}>
                Template
              </Button>
              <Button variant="outline" onClick={() => fileRef.current?.click()}>
                Import
              </Button>
              <input
                ref={fileRef}
                type="file"
                accept=".xlsx,.xls"
                className="hidden"
                onChange={(e) => void doImport(e.target.files?.[0])}
              />
            </>
          )}
          <Button variant="outline" onClick={doExport}>
            Export
          </Button>
          {!manager && (
            <Button
              onClick={() => setDialog({ mode: "add", product: null })}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              Add New Product
            </Button>
          )}
        </div>
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}
      {notice && (
        <p className="text-[13px] font-medium text-green-700">{notice}</p>
      )}

      <DataTable
        loading={loading}
        columns={[
          { header: "Product Name", accessorKey: "name" },
          {
            header: "Current Stock",
            accessorKey: "quantity",
            cell: ({ row }) => <span>{row.original.quantity}</span>,
          },
          {
            header: "Price (GHS)",
            accessorKey: "retailPrice",
            cell: ({ row }) => (
              <span>{ghs.format(row.original.retailPrice ?? 0)}</span>
            ),
          },
          {
            header: "Category",
            accessorKey: "category",
            cell: ({ row }) => row.original.category ?? "Uncategorized",
          },
          {
            header: "Status",
            id: "status",
            cell: ({ row }) => stockBadge(row.original.quantity ?? 0),
          },
          {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => (
              <div className="flex items-center gap-1">
                <button
                  type="button"
                  title="View"
                  onClick={() =>
                    setDialog({ mode: "view", product: row.original })
                  }
                  className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-blue-600 hover:text-blue-800"
                >
                  <Eye className="h-4 w-4" />
                  View
                </button>
                {!manager && (
                  <>
                    <button
                      type="button"
                      title="Edit"
                      onClick={() =>
                        setDialog({ mode: "edit", product: row.original })
                      }
                      className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-orange-600 hover:text-orange-800"
                    >
                      <Pencil className="h-4 w-4" />
                      Edit
                    </button>
                    <button
                      type="button"
                      title="Delete"
                      onClick={() => setDeleting(row.original)}
                      className="flex items-center gap-1 px-1.5 py-1 text-[12px] font-medium text-red-600 hover:text-red-800"
                    >
                      <Trash2 className="h-4 w-4" />
                      Delete
                    </button>
                  </>
                )}
              </div>
            ),
          },
        ]}
        rows={filtered}
        emptyHint="No products yet — add one to get started."
      />

      {dialog && (
        <ProductDialog
          open
          mode={dialog.mode}
          product={dialog.product}
          categories={categories}
          role={role}
          busy={busy}
          error={error}
          onClose={() => {
            setDialog(null);
            setError(null);
          }}
          onSubmit={(v) => void submit(v)}
        />
      )}

      <Dialog open={!!deleting} onOpenChange={() => setDeleting(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Product</DialogTitle>
          </DialogHeader>
          <p className="text-sm">
            Are you sure you want to delete &quot;{deleting?.name}&quot;?
          </p>
          <div className="flex justify-end gap-2 pt-2">
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
