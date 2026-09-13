"use client";

import { useDataVersion } from "@/lib/db/data-bus";


import { useCallback, useEffect, useState } from "react";
import { Pencil, Trash2 } from "lucide-react";
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
import {
  addBrand,
  addCategory,
  removeBrand,
  removeCategory,
  updateBrand,
  updateCategory,
} from "@/features/catalog/mutations";
import { db } from "@/lib/db/dexie";
import type { BrandRow, CategoryRow } from "@/lib/db/types";
import { useOnline } from "@/lib/sync/connectivity";
import { remoteFirst } from "@/lib/sync/remote-first";
import { createClient } from "@/lib/supabase/browser";

interface Editing {
  kind: "brand" | "category";
  id: string;
  name: string;
}

interface Deleting {
  kind: "brand" | "category";
  id: string;
  name: string;
}

/**
 * Brands & Categories — ported from brand_category_page.dart:
 * two columns (add card + list card each), "Create Locally" semantics
 * preserved (offline writes queue via upload drain).
 */
export default function CatalogPage() {
  const online = useOnline();
  const [brands, setBrands] = useState<BrandRow[]>([]);
  const [categories, setCategories] = useState<CategoryRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [brandName, setBrandName] = useState("");
  const [categoryName, setCategoryName] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [editing, setEditing] = useState<Editing | null>(null);
  const [editName, setEditName] = useState("");
  const [deleting, setDeleting] = useState<Deleting | null>(null);

  const dataVersion = useDataVersion();
  const load = useCallback(async () => {
    try {
      if (online) {
        try {
          const c = createClient();
          await Promise.all([
            remoteFirst.warmBrands(c),
            remoteFirst.warmCategories(c),
          ]);
        } catch {
          /* local stands */
        }
      }
      const [b, c] = await Promise.all([
        db.brands.orderBy("name").toArray(),
        db.categories.orderBy("name").toArray(),
      ]);
      setBrands(b);
      setCategories(c);
    } finally {
      setLoading(false);
    }
  }, [online]);

  useEffect(() => {
    void load();
  }, [load, dataVersion]);

  const run = async (fn: () => Promise<void>, after?: () => void) => {
    setBusy(true);
    setError(null);
    try {
      await fn();
      after?.();
      void load();
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setBusy(false);
    }
  };

  const openEdit = (e: Editing) => {
    setEditing(e);
    setEditName(e.name);
  };

  const submitEdit = () =>
    editing &&
    void run(async () => {
      if (editing.kind === "brand")
        await updateBrand(online, editing.id, editName);
      else await updateCategory(online, editing.id, editName);
      setEditing(null);
    });

  const confirmDelete = () =>
    deleting &&
    void run(async () => {
      if (deleting.kind === "brand")
        await removeBrand(online, deleting.id);
      else await removeCategory(online, deleting.id);
      setDeleting(null);
    });

  const column = (
    title: string,
    listTitle: string,
    value: string,
    setValue: (v: string) => void,
    onAdd: () => void,
    rows: { id: string; name: string }[],
    kind: "brand" | "category",
    emptyHint: string,
  ) => (
    <div className="space-y-4">
      <section className="border border-black/15 bg-white p-4">
        <h2 className="pb-2 font-bold">New {title}</h2>
        <Label className="pb-1 block text-[13px] font-medium">
          Enter {title.toLowerCase()} name...
        </Label>
        <div className="flex gap-2">
          <Input
            value={value}
            onChange={(e) => setValue(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") onAdd();
            }}
          />
          <Button
            onClick={onAdd}
            disabled={busy}
            className="shrink-0 bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
          >
            {busy ? "Adding…" : "Create Locally"}
          </Button>
        </div>
      </section>
      <section className="border border-black/15 bg-white p-4">
        <h2 className="pb-2 font-bold">Existing {listTitle}</h2>
        {loading ? (
          <LoadingSpinner size="sm" />
        ) : rows.length === 0 ? (
          <p className="py-4 text-center text-sm text-black/50">{emptyHint}</p>
        ) : (
          <ul className="divide-y divide-black/10">
            {rows.map((r) => (
              <li key={r.id} className="flex items-center justify-between py-2">
                <span className="text-sm font-medium">{r.name}</span>
                <div className="flex gap-1">
                  <button
                    type="button"
                    title="Edit"
                    onClick={() =>
                      openEdit({ kind, id: r.id, name: r.name })
                    }
                    className="p-1 text-black/60 hover:text-black"
                  >
                    <Pencil className="h-4 w-4" />
                  </button>
                  <button
                    type="button"
                    title="Delete"
                    onClick={() =>
                      setDeleting({ kind, id: r.id, name: r.name })
                    }
                    className="p-1 text-red-600 hover:text-red-800"
                  >
                    <Trash2 className="h-4 w-4" />
                  </button>
                </div>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-xl font-bold">Brands &amp; Categories</h1>
        <p className="text-sm text-black/60">
          Manage labels used for grouping your inventory products.
        </p>
      </div>

      {error && (
        <p className="text-[13px] font-medium text-red-600">{error}</p>
      )}

      <div className="grid gap-6 lg:grid-cols-2">
        {column(
          "Brand",
          "Brands",
          brandName,
          setBrandName,
          () =>
            void run(async () => {
              await addBrand(online, brandName);
              setBrandName("");
            }),
          brands,
          "brand",
          "No brands yet",
        )}
        {column(
          "Category",
          "Categories",
          categoryName,
          setCategoryName,
          () =>
            void run(async () => {
              await addCategory(online, categoryName);
              setCategoryName("");
            }),
          categories,
          "category",
          "No categories yet",
        )}
      </div>

      <Dialog open={!!editing} onOpenChange={() => setEditing(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              Edit {editing?.kind === "brand" ? "Brand" : "Category"}
            </DialogTitle>
          </DialogHeader>
          <Input
            placeholder="Enter new name"
            value={editName}
            onChange={(e) => setEditName(e.target.value)}
          />
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setEditing(null)}>
              Cancel
            </Button>
            <Button
              onClick={submitEdit}
              disabled={busy}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {busy ? "Updating…" : "Update"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      <Dialog open={!!deleting} onOpenChange={() => setDeleting(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              Delete {deleting?.kind === "brand" ? "Brand" : "Category"}
            </DialogTitle>
          </DialogHeader>
          <p className="text-sm">
            Are you sure you want to delete the{" "}
            {deleting?.kind === "brand" ? "brand" : "category"} &quot;
            {deleting?.name}&quot;?
          </p>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={() => setDeleting(null)}>
              Cancel
            </Button>
            <Button
              onClick={confirmDelete}
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
