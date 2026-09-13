import { create } from "zustand";
import { TOTAL_TAX_PERCENTAGE, Taxes } from "@/lib/taxes";

export interface CartProduct {
  id: string;
  name: string;
  retailPrice: number;
  quantity: number; // stock on hand (display only)
}

export interface CartLine {
  productId: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  discountAmount: number;
  taxAmount: number;
  totalPrice: number;
}

export interface CurrentSaleItem {
  product: CartProduct;
  rate: number;
  stock: number;
  quantity: number;
  discountPct: number;
}

export interface CartSummary {
  subtotal: number;
  totalDiscount: number;
  totalQuantity: number;
  vatAmount: number;
  grandTotal: number;
  taxes: { name: string; percentage: number; amount: number }[];
}

/**
 * Ported from CartNotifier + CurrentSaleItem + cartSummaryProvider.
 * One fix vs Flutter: merging an existing line also merges taxAmount
 * (Flutter kept the stale value, understating VAT on merged lines).
 */
interface PosCartState {
  lines: CartLine[];
  current: CurrentSaleItem | null;
  selectProduct: (p: CartProduct | null) => void;
  updateQuantity: (qty: number) => void;
  updateDiscount: (pct: number) => void;
  currentSubtotal: () => number;
  addCurrent: () => void;
  removeLine: (productId: string) => void;
  clear: () => void;
  summary: () => CartSummary;
}

export function lineTotals(
  retailPrice: number,
  qty: number,
  discPct: number,
): { totalPrice: number; discountAmount: number; taxAmount: number } {
  const full = retailPrice * qty;
  const discountAmount = (full * discPct) / 100;
  const taxAmount =
    (full * (TOTAL_TAX_PERCENTAGE / 100)) / (1 + TOTAL_TAX_PERCENTAGE / 100);
  return { totalPrice: full - discountAmount, discountAmount, taxAmount };
}

export const usePosCart = create<PosCartState>()((set, get) => ({
  lines: [],
  current: null,

  selectProduct: (p) =>
    set({
      current: p
        ? {
            product: p,
            rate: p.retailPrice,
            stock: p.quantity,
            quantity: 1,
            discountPct: 0,
          }
        : null,
    }),

  updateQuantity: (qty) =>
    set((s) =>
      s.current
        ? { current: { ...s.current, quantity: Number.isNaN(qty) ? 0 : qty } }
        : s,
    ),

  updateDiscount: (pct) =>
    set((s) =>
      s.current
        ? {
            current: {
              ...s.current,
              discountPct: Number.isNaN(pct) ? 0 : pct,
            },
          }
        : s,
    ),

  currentSubtotal: () => {
    const c = get().current;
    if (!c) return 0;
    return lineTotals(c.rate, c.quantity, c.discountPct).totalPrice;
  },

  addCurrent: () => {
    const c = get().current;
    if (!c) return;
    const t = lineTotals(c.rate, c.quantity, c.discountPct);
    set((s) => {
      const existing = s.lines.find((l) => l.productId === c.product.id);
      if (existing) {
        return {
          lines: s.lines.map((l) =>
            l.productId === c.product.id
              ? {
                  ...l,
                  quantity: l.quantity + c.quantity,
                  totalPrice: l.totalPrice + t.totalPrice,
                  discountAmount: l.discountAmount + t.discountAmount,
                  taxAmount: l.taxAmount + t.taxAmount,
                }
              : l,
          ),
          current: null,
        };
      }
      return {
        lines: [
          ...s.lines,
          {
            productId: c.product.id,
            productName: c.product.name,
            quantity: c.quantity,
            unitPrice: c.rate,
            discountAmount: t.discountAmount,
            taxAmount: t.taxAmount,
            totalPrice: t.totalPrice,
          },
        ],
        current: null,
      };
    });
  },

  removeLine: (productId) =>
    set((s) => ({ lines: s.lines.filter((l) => l.productId !== productId) })),

  clear: () => set({ lines: [], current: null }),

  summary: () => {
    const { lines } = get();
    const subtotal = lines.reduce((a, l) => a + l.totalPrice, 0);
    const totalDiscount = lines.reduce((a, l) => a + l.discountAmount, 0);
    const totalQuantity = lines.reduce((a, l) => a + l.quantity, 0);
    const vatAmount = lines.reduce((a, l) => a + l.taxAmount, 0);
    const grandTotal = subtotal;
    const base = grandTotal / (1 + TOTAL_TAX_PERCENTAGE / 100);
    const taxes = Taxes.map((t) => ({
      name: t.name,
      percentage: t.valuePercentage,
      amount: (base * t.valuePercentage) / 100,
    }));
    return {
      subtotal,
      totalDiscount,
      totalQuantity,
      vatAmount,
      grandTotal,
      taxes,
    };
  },
}));
