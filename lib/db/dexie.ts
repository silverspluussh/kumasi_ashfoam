import Dexie, { type EntityTable } from "dexie";
import type {
  BranchPaymentRow,
  BranchRow,
  BrandRow,
  CategoryRow,
  CompanySettingsRow,
  CreditNoteItemRow,
  CreditNoteRow,
  CustomerRow,
  EmployeeRow,
  ExpenseRow,
  InventoryRow,
  InvoiceItemRow,
  InvoiceRow,
  PaymentRow,
  ProformaItemRow,
  ProformaRow,
  ReceiptRow,
  ReturnOrderItemRow,
  ReturnOrderRow,
  SaleOrderItemRow,
  SaleOrderRow,
  StockAdjustmentRow,
  StockReportRow,
  StockTransferItemRow,
  StockTransferRow,
  StoreRow,
  SubcategoryRow,
  SupplierPaymentRow,
  SupplierRow,
  Synced,
  TaxRow,
  WaybillItemRow,
  WaybillRow,
} from "./types";

/**
 * Dexie IndexedDB database — mirrors supabase_schema.sql 1:1 (30 stores)
 * + 2 local-only stores (companySettings, stockAdjustments) = 32 stores.
 * UI always reads Dexie; Supabase is reached via lib/sync/* and
 * lib/supabase/queries/*. Client sync bookkeeping: _isSynced/_lastSyncedAt.
 */
export class AshfoamDb extends Dexie {
  stores!: EntityTable<Synced<StoreRow>, "id">;
  branches!: EntityTable<Synced<BranchRow>, "id">;
  brands!: EntityTable<Synced<BrandRow>, "id">;
  categories!: EntityTable<Synced<CategoryRow>, "id">;
  subcategories!: EntityTable<Synced<SubcategoryRow>, "id">;
  taxes!: EntityTable<TaxRow, "id">;
  suppliers!: EntityTable<Synced<SupplierRow>, "id">;
  supplierPayments!: EntityTable<Synced<SupplierPaymentRow>, "id">;
  customers!: EntityTable<Synced<CustomerRow>, "id">;
  employees!: EntityTable<Synced<EmployeeRow>, "id">;
  inventory!: EntityTable<Synced<InventoryRow>, "id">;
  saleOrders!: EntityTable<Synced<SaleOrderRow>, "id">;
  saleOrderItems!: EntityTable<Synced<SaleOrderItemRow>, "id">;
  invoices!: EntityTable<Synced<InvoiceRow>, "id">;
  invoiceItems!: EntityTable<InvoiceItemRow, "id">;
  proformas!: EntityTable<Synced<ProformaRow>, "id">;
  proformaItems!: EntityTable<ProformaItemRow, "id">;
  waybills!: EntityTable<Synced<WaybillRow>, "id">;
  waybillItems!: EntityTable<WaybillItemRow, "id">;
  receipts!: EntityTable<Synced<ReceiptRow>, "id">;
  payments!: EntityTable<Synced<PaymentRow>, "id">;
  branchPayments!: EntityTable<Synced<BranchPaymentRow>, "id">;
  expenses!: EntityTable<Synced<ExpenseRow>, "id">;
  returnOrders!: EntityTable<Synced<ReturnOrderRow>, "id">;
  returnOrderItems!: EntityTable<ReturnOrderItemRow, "id">;
  creditNotes!: EntityTable<Synced<CreditNoteRow>, "id">;
  creditNoteItems!: EntityTable<CreditNoteItemRow, "id">;
  stockTransfers!: EntityTable<Synced<StockTransferRow>, "id">;
  stockTransferItems!: EntityTable<StockTransferItemRow, "id">;
  stockReports!: EntityTable<Synced<StockReportRow>, "id">;
  companySettings!: EntityTable<CompanySettingsRow, "id">;
  stockAdjustments!: EntityTable<StockAdjustmentRow, "id">;

  constructor() {
    super("ashfoam");
    // v4 adds stockTransfers.created_at ordering index.
    this.version(4).stores({
      stores: "id, name",
      branches: "id, store_id",
      brands: "id, name",
      categories: "id, name",
      subcategories: "id, category_id",
      taxes: "id, name",
      suppliers: "id, name, supplier_code",
      supplierPayments: "id, supplier_id, date",
      customers: "id, name",
      employees: "id, email, branch_id",
      inventory: "id, sku, brandId, branchId, _isSynced",
      saleOrders: "id, orderNumber, createdAt, _isSynced",
      saleOrderItems: "id, saleOrderId, productId, _isSynced",
      invoices: "id, invoice_number, customer_id, _isSynced",
      invoiceItems: "id, invoice_id, product_id",
      proformas: "id, created_at, _isSynced",
      proformaItems: "id, proforma_id, product_id",
      waybills: "id, orderNumber, createdAt, _isSynced",
      waybillItems: "id, waybill_id, product_id",
      receipts: "id, receipt_number, invoice_id, _isSynced",
      payments: "id, _isSynced",
      branchPayments: "id, branch_id, created_at, _isSynced",
      expenses: "id, category, date, _isSynced",
      returnOrders: "id, return_number, invoice_id, _isSynced",
      returnOrderItems: "id, return_order_id, product_id",
      creditNotes:
        "id, credit_note_number, invoice_id, return_order_id, _isSynced",
      creditNoteItems: "id, credit_note_id",
      stockTransfers: "id, transfer_number, created_at, _isSynced",
      stockTransferItems: "id, stock_transfer_id, product_id",
      stockReports: "id, branch_id, report_date, _isSynced",
      companySettings: "id",
      stockAdjustments: "id, productId, createdAt",
    });
  }
}

export const db = new AshfoamDb();

// Resilience: reload a stale tab when another tab upgrades the DB schema,
// and feed the change bus (lib/db/data-bus) so open screens stay live.
if (typeof window !== "undefined") {
  db.on("versionchange", () => {
    window.location.reload();
    return true;
  });
  void import("./data-bus").then(({ attachDbChangeHooks }) =>
    attachDbChangeHooks(),
  );
}
