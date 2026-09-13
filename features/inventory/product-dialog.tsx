"use client";

import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import type { CategoryRow, Synced, InventoryRow } from "@/lib/db/types";
import { isManager, type AppRole } from "@/lib/roles";

export type ProductDialogMode = "add" | "edit" | "view";

interface ProductDialogProps {
  open: boolean;
  mode: ProductDialogMode;
  product: Synced<InventoryRow> | null;
  categories: CategoryRow[];
  role: AppRole;
  busy: boolean;
  error: string | null;
  onClose: () => void;
  onSubmit: (values: {
    name: string;
    category: string | null;
    categoryId: string | null;
    unit: string;
    retailPrice: number;
    quantity: number;
    material: string | null;
    size: string | null;
    thickness: string | null;
    density: string | null;
  }) => void;
}

/**
 * Add/Edit/View product dialog — ported from product_dialog.dart
 * (add_product_dialog.dart is legacy/unused in Flutter).
 */
export function ProductDialog({
  open,
  mode,
  product,
  categories,
  role,
  busy,
  error,
  onClose,
  onSubmit,
}: ProductDialogProps) {
  const readOnly = mode === "view" || isManager(role);
  const [name, setName] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [unit, setUnit] = useState("Pieces");
  const [retailPrice, setRetailPrice] = useState("");
  const [quantity, setQuantity] = useState("0");
  const [material, setMaterial] = useState("");
  const [size, setSize] = useState("");
  const [thickness, setThickness] = useState("");
  const [density, setDensity] = useState("");
  const [touched, setTouched] = useState(false);

  useEffect(() => {
    if (open) {
      setName(product?.name ?? "");
      setCategoryId(product?.catergory_id ?? "");
      setUnit(product?.unit ?? "Pieces");
      setRetailPrice(
        product?.retailPrice != null ? String(product.retailPrice) : "",
      );
      setQuantity(product ? String(product.quantity ?? 0) : "0");
      setMaterial(product?.material ?? "");
      setSize(product?.size ?? "");
      setThickness(product?.thickness ?? "");
      setDensity(product?.density ?? "");
      setTouched(false);
    }
  }, [open, product]);

  const nameOk = name.trim().length > 0;
  const priceOk = retailPrice.trim().length > 0;
  const qtyOk = quantity.trim().length > 0;
  const valid = nameOk && priceOk && qtyOk;

  const submit = () => {
    setTouched(true);
    if (!valid || readOnly) return;
    const cat = categories.find((c) => c.id === categoryId) ?? null;
    onSubmit({
      name: name.trim(),
      category: cat?.name ?? null,
      categoryId: cat?.id ?? null,
      unit: unit.trim() || "Pieces",
      retailPrice: parseFloat(retailPrice) || 0,
      quantity: parseInt(quantity, 10) || 0,
      material: material.trim() || null,
      size: size.trim() || null,
      thickness: thickness.trim() || null,
      density: density.trim() || null,
    });
  };

  const title =
    mode === "add" ? "Add New Product" : mode === "edit" ? "Edit Product" : "Product Details";
  const field = (
    label: string,
    required: boolean,
    control: React.ReactNode,
    ok: boolean,
  ) => (
    <div>
      <Label className="pb-1 block text-[13px] font-medium">
        {label}
        {required && " *"}
      </Label>
      {control}
      {touched && required && !ok && (
        <p className="pt-1 text-xs text-red-600">Required</p>
      )}
    </div>
  );

  const inputCls = "w-full";
  const ro = { readOnly, disabled: readOnly } as const;

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-2xl min-h-[70vh] max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
        </DialogHeader>
        <div className="grid gap-3 md:grid-cols-2">
          {field(
            "Product Name",
            true,
            <Input
              className={inputCls}
              value={name}
              onChange={(e) => setName(e.target.value)}
              {...ro}
            />,
            nameOk,
          )}
          <div>
            <Label className="pb-1 block text-[13px] font-medium">
              Category
            </Label>
            <select
              value={categoryId}
              onChange={(e) => setCategoryId(e.target.value)}
              disabled={readOnly}
              className="w-full border border-black/20 bg-white px-2 py-2 text-sm disabled:opacity-60"
            >
              <option value="">Uncategorized</option>
              {categories.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.name}
                </option>
              ))}
            </select>
          </div>
          {field(
            "Unit (e.g. Pieces, Sets)",
            false,
            <Input
              className={inputCls}
              placeholder="e.g. Pieces"
              value={unit}
              onChange={(e) => setUnit(e.target.value)}
              {...ro}
            />,
            true,
          )}
          {field(
            "Retail Price (GH₵)",
            true,
            <Input
              className={inputCls}
              type="number"
              min={0}
              value={retailPrice}
              onChange={(e) => setRetailPrice(e.target.value)}
              {...ro}
            />,
            priceOk,
          )}
          {field(
            mode === "add" ? "Initial Quantity" : "Quantity",
            true,
            <Input
              className={inputCls}
              type="number"
              value={quantity}
              onChange={(e) => setQuantity(e.target.value)}
              {...ro}
            />,
            qtyOk,
          )}
          {field(
            "Material",
            false,
            <Input
              className={inputCls}
              placeholder="e.g. Damask, Polyester"
              value={material}
              onChange={(e) => setMaterial(e.target.value)}
              {...ro}
            />,
            true,
          )}
          {field(
            "Size",
            false,
            <Input
              className={inputCls}
              placeholder="e.g. L/S, M/S, S/S, K/S, Q/S"
              value={size}
              onChange={(e) => setSize(e.target.value)}
              {...ro}
            />,
            true,
          )}
          {field(
            "Thickness",
            false,
            <Input
              className={inputCls}
              placeholder='e.g. 9", 6", 4", 3", 2"'
              value={thickness}
              onChange={(e) => setThickness(e.target.value)}
              {...ro}
            />,
            true,
          )}
          {field(
            "Density",
            false,
            <Input
              className={inputCls}
              placeholder="e.g. HD1, HD2, HD3"
              value={density}
              onChange={(e) => setDensity(e.target.value)}
              {...ro}
            />,
            true,
          )}
        </div>
        {error && (
          <p className="text-[13px] font-medium text-red-600">{error}</p>
        )}
        <div className="flex justify-end gap-2 pt-1">
          <Button variant="outline" onClick={onClose}>
            {readOnly ? "Close" : "Cancel"}
          </Button>
          {!readOnly && (
            <Button
              onClick={submit}
              disabled={busy}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              {busy ? "Saving…" : "Save Product"}
            </Button>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
