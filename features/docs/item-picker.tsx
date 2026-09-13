"use client";

import { useEffect, useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { SearchableSelect } from "@/components/searchable-select";
import { ghs } from "@/lib/taxes";
import { lineTotal, type DocItem } from "./totals";

export interface ProductOption {
  id: string;
  name: string;
  retailPrice: number;
}

/**
 * Add Product Details — ported from ProductItemFormDialog (shared by
 * proforma create/edit and waybill create/edit): product search with
 * price autofill, qty/price/discount with live total.
 */
export function ItemPicker({
  open,
  products,
  onClose,
  onAdd,
}: {
  open: boolean;
  products: ProductOption[];
  onClose: () => void;
  onAdd: (item: DocItem) => void;
}) {
  const [product, setProduct] = useState<ProductOption | null>(null);
  const [quantity, setQuantity] = useState("1");
  const [unitPrice, setUnitPrice] = useState("0");
  const [discount, setDiscount] = useState("0");

  useEffect(() => {
    if (open) {
      setProduct(null);
      setQuantity("1");
      setUnitPrice("0");
      setDiscount("0");
    }
  }, [open]);

  const qty = parseInt(quantity, 10) || 0;
  const price = parseFloat(unitPrice) || 0;
  const disc = parseFloat(discount) || 0;
  const total = useMemo(
    () => lineTotal(qty, price, disc),
    [qty, price, disc],
  );

  const add = () => {
    if (!product) return;
    onAdd({
      key: `${product.id}-${Date.now()}`,
      productId: product.id,
      productName: product.name,
      quantity: qty || 1,
      unitPrice: price,
      discountPct: disc,
      total,
    });
    onClose();
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>Add Product Details</DialogTitle>
        </DialogHeader>
        <div className="space-y-3">
          <SearchableSelect<ProductOption>
            label="Select Product"
            items={products}
            format={(p) => p.name}
            filter={(p, q) => p.name.toLowerCase().includes(q)}
            value={product}
            onSelect={(p) => {
              setProduct(p);
              if (p) setUnitPrice(String(p.retailPrice ?? 0));
            }}
          />
          <div className="grid grid-cols-3 gap-3">
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Quantity
              </Label>
              <Input
                type="number"
                value={quantity}
                onChange={(e) => setQuantity(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Unit Price (GH₵)
              </Label>
              <Input
                type="number"
                value={unitPrice}
                onChange={(e) => setUnitPrice(e.target.value)}
              />
            </div>
            <div>
              <Label className="pb-1 block text-[13px] font-medium">
                Discount (%)
              </Label>
              <Input
                type="number"
                value={discount}
                onChange={(e) => setDiscount(e.target.value)}
              />
            </div>
          </div>
          <p className="text-lg font-bold text-blue-700">
            Calculated Total: {ghs.format(total)}
          </p>
          <div className="flex justify-end gap-2">
            <Button variant="outline" onClick={onClose}>
              Cancel
            </Button>
            <Button
              onClick={add}
              disabled={!product}
              className="bg-ashfoam-ink text-white hover:bg-ashfoam-ink/90"
            >
              Add to List
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
