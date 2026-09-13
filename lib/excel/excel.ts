import * as XLSX from "xlsx";

/**
 * Excel layer (SheetJS) — ported from excel_service.dart + excel_providers:
 * template (exact headers + sample row), product import parser,
 * inventory/payments/sales exports. Browser downloads (no path_provider).
 */

export const TEMPLATE_HEADERS = [
  "Product Name*",
  "Category",
  "Sub-Category",
  "Brand",
  "Retail Price*",
  "Initial Quantity*",
  "Unit",
  "Material",
  "Size",
  "Thickness",
  "Density",
];

const TEMPLATE_SAMPLE = [
  "Sample Foam Mattress",
  "Mattresses",
  "Double",
  "Ashfoam",
  1200,
  10,
  "Pieces",
  "Damask",
  "L/S",
  '6"',
  "HD2",
];

function download(workbook: XLSX.WorkBook, fileName: string) {
  const bytes = XLSX.write(workbook, { bookType: "xlsx", type: "array" });
  const blob = new Blob([bytes], {
    type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = fileName;
  a.click();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}

/** generateTemplate(): headers + one sample row. */
export function downloadTemplate() {
  const ws = XLSX.utils.aoa_to_sheet([TEMPLATE_HEADERS, TEMPLATE_SAMPLE]);
  ws["!cols"] = TEMPLATE_HEADERS.map(() => ({ wch: 20 }));
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Products");
  download(wb, "Product_Import_Template.xlsx");
}

export interface ParsedProduct {
  name: string;
  category: string | null;
  subCategory: string | null;
  brand: string | null;
  retailPrice: number;
  quantity: number;
  unit: string;
  material: string | null;
  size: string | null;
  thickness: string | null;
  density: string | null;
}

export interface ParseResult {
  rows: ParsedProduct[];
  errors: string[];
}

/**
 * parseProducts(): skip header, map by header name (case-insensitive,
 * '*' stripped). Required: Product Name, Retail Price, Initial Quantity.
 */
export async function parseProducts(file: File): Promise<ParseResult> {
  const buf = await file.arrayBuffer();
  const wb = XLSX.read(buf, { type: "array" });
  const ws = wb.Sheets[wb.SheetNames[0]];
  const grid = XLSX.utils.sheet_to_json<unknown[]>(ws, {
    header: 1,
    defval: "",
  });
  const rows: ParsedProduct[] = [];
  const errors: string[] = [];
  if (grid.length === 0) return { rows, errors: ["File is empty"] };

  const norm = (h: unknown) =>
    String(h ?? "")
      .replace("*", "")
      .trim()
      .toLowerCase();
  const header = (grid[0] as unknown[]).map(norm);
  const col = (name: string) => header.indexOf(name);
  const cName = col("product name");
  const cCat = col("category");
  const cSub = col("sub-category");
  const cBrand = col("brand");
  const cPrice = col("retail price");
  const cQty = col("initial quantity");
  const cUnit = col("unit");
  const cMat = col("material");
  const cSize = col("size");
  const cThick = col("thickness");
  const cDen = col("density");

  if (cName < 0 || cPrice < 0 || cQty < 0) {
    return {
      rows,
      errors: [
        "Missing required columns: Product Name*, Retail Price*, Initial Quantity*",
      ],
    };
  }

  const text = (v: unknown) => String(v ?? "").trim();
  const num = (v: unknown) => {
    const n = typeof v === "number" ? v : parseFloat(String(v ?? ""));
    return Number.isNaN(n) ? 0 : n;
  };

  for (let i = 1; i < grid.length; i++) {
    const r = grid[i] as unknown[];
    const name = text(r[cName]);
    if (!name) continue; // skip blank rows
    const price = num(r[cPrice]);
    const qty = Math.trunc(num(r[cQty]));
    if (!(price > 0)) {
      errors.push(`Row ${i + 1}: invalid retail price — skipped`);
      continue;
    }
    rows.push({
      name,
      category: cCat >= 0 && text(r[cCat]) ? text(r[cCat]) : null,
      subCategory: cSub >= 0 && text(r[cSub]) ? text(r[cSub]) : null,
      brand: cBrand >= 0 && text(r[cBrand]) ? text(r[cBrand]) : null,
      retailPrice: price,
      quantity: qty,
      unit: cUnit >= 0 && text(r[cUnit]) ? text(r[cUnit]) : "Pieces",
      material: cMat >= 0 && text(r[cMat]) ? text(r[cMat]) : null,
      size: cSize >= 0 && text(r[cSize]) ? text(r[cSize]) : null,
      thickness: cThick >= 0 && text(r[cThick]) ? text(r[cThick]) : null,
      density: cDen >= 0 && text(r[cDen]) ? text(r[cDen]) : null,
    });
  }
  return { rows, errors };
}

export interface InventoryExportRow {
  name: string;
  sku: string;
  category: string | null;
  subCategory: string | null;
  brand: string | null;
  retailPrice: number;
  quantity: number;
  unit: string | null;
  material: string | null;
  size: string | null;
  thickness: string | null;
  density: string | null;
}

/** generateInventoryExport(). */
export function downloadInventoryExport(rows: InventoryExportRow[]) {
  const data = rows.map((r) => ({
    "Product Name": r.name,
    SKU: r.sku,
    Category: r.category ?? "",
    "Sub-Category": r.subCategory ?? "",
    Brand: r.brand ?? "",
    "Retail Price": r.retailPrice ?? 0,
    Quantity: r.quantity ?? 0,
    Unit: r.unit ?? "",
    Material: r.material ?? "",
    Size: r.size ?? "",
    Thickness: r.thickness ?? "",
    Density: r.density ?? "",
  }));
  const ws = XLSX.utils.json_to_sheet(data);
  ws["!cols"] = Object.keys(data[0] ?? {}).map(() => ({ wch: 18 }));
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Inventory");
  download(wb, "Inventory_Export.xlsx");
}

export interface PaymentExportRow {
  title: string | null;
  branch_name: string | null;
  amount: number;
  note: string | null;
  created_at?: string | null;
}

/** generatePaymentsExport() → PaymentsReport.xlsx. */
export function downloadPaymentsExport(rows: PaymentExportRow[]) {
  const data = rows.map((r) => ({
    Title: r.title ?? "",
    Branch: r.branch_name ?? "",
    Amount: r.amount ?? 0,
    Date: r.created_at ?? "",
    Notes: r.note ?? "",
  }));
  const ws = XLSX.utils.json_to_sheet(data);
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "Payments");
  download(wb, "PaymentsReport.xlsx");
}

export interface SaleExportRow {
  orderNumber: string;
  totalQuantity: number;
  createdAt?: string | null;
  customerName: string | null;
  totalAmount: number;
}

/** SaleOrders.xlsx (Flutter sales export). */
export function downloadSalesExport(rows: SaleExportRow[]) {
  const data = rows.map((r) => ({
    "Order #": r.orderNumber,
    "Total Items": r.totalQuantity ?? 0,
    Date: r.createdAt ?? "",
    Customer: r.customerName ?? "Walk-in",
    "Total Amount": r.totalAmount ?? 0,
  }));
  const ws = XLSX.utils.json_to_sheet(data);
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, "SaleOrders");
  download(wb, "SaleOrders.xlsx");
}
