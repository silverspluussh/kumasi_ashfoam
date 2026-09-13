/**
 * Local record types — Supabase column names verbatim (incl. quoted
 * camelCase: "retailPrice", "orderNumber", …) per MIGRATION_PLAN §1.4.
 * Every store carries two CLIENT-ONLY fields (`_isSynced`, `_lastSyncedAt`)
 * stripped before upload; on tables whose remote has "isSynced",
 * `_isSynced` is mapped onto it at upload time.
 */

export type SyncFlag = 0 | 1; // 0 = dirty (queued), 1 = clean

export interface ClientSync {
  _isSynced: SyncFlag;
  _lastSyncedAt: string | null;
}

export type Synced<T> = T & Partial<ClientSync>;

/* ---------- 1. stores / branches ---------- */
export interface StoreRow {
  id: string;
  created_at: string;
  name: string;
  address: string;
  is_active: number;
}
export interface BranchRow {
  id: string;
  store_id: string | null;
  store_name: string;
  branch_name: string;
  branch_address: string | null;
  contact: string | null;
  is_active: number;
  is_deleted: number;
  branch_manager_name: string | null;
  branch_manager_id: string | null;
  company_details: Record<string, unknown> | null;
  created_at: string;
  updated_at: string;
}

/* ---------- 2. catalog ---------- */
export interface BrandRow {
  id: string;
  name: string;
  created_at: string;
}
export interface CategoryRow {
  id: string;
  name: string;
  created_at: string;
}
export interface SubcategoryRow {
  id: string;
  category_id: string | null;
  name: string;
  created_at: string;
}
export interface TaxRow {
  id: string;
  name: string;
  value_percentage: number;
}

/* ---------- 3. partners ---------- */
export interface SupplierRow {
  id: string;
  name: string;
  supplier_code: string | null;
  contact_name: string | null;
  email: string | null;
  phone: string | null;
  address: string | null;
  is_active: number;
  created_at: string;
  updated_at: string;
}
export interface SupplierPaymentRow {
  id: string;
  supplier_id: string;
  amount: number;
  note: string | null;
  date: string;
  created_at: string;
}
export interface CustomerRow {
  id: string;
  name: string;
  email: string | null;
  phone: string | null;
  address: string | null;
  created_at: string;
  updated_at: string;
}
export interface EmployeeRow {
  id: string; // = auth.users.id
  first_name: string | null;
  last_name: string | null;
  middle_name: string | null;
  email: string;
  phone: string | null;
  role: string;
  department: string | null;
  branch_id: string | null;
  branch_name: string | null;
  manager_id: string | null;
  manager_name: string | null;
  designation: string | null;
  status: string;
  is_active: boolean;
  hire_date: string;
  end_date: string | null;
  address: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

/* ---------- 4. inventory ---------- */
export interface InventoryRow {
  id: string;
  name: string;
  sku: string;
  category: string | null;
  catergory_id: string | null; // typo kept — matches Supabase column
  subCategory: string | null;
  size: string | null;
  thickness: string | null;
  material: string | null;
  density: string | null;
  brand: string | null;
  brandId: string | null;
  retailPrice: number;
  discountPrice: number | null;
  discountPercentage: number | null;
  quantity: number;
  unit: string | null;
  branchId: string | null;
  isAvailable: number;
  isDeleted: number;
  createdAt: string;
  updatedAt: string;
  isSynced?: boolean | number | null; // server-side flag (BOOLEAN)
  lastSyncedAt?: string | null;
}

/* ---------- 5. sales ---------- */
export interface SaleOrderRow {
  id: string;
  orderNumber: string;
  customerName: string | null;
  channel: string | null;
  branchId: string | null;
  branchName: string | null;
  totalAmount: number;
  discountAmount: number;
  totalQuantity: number;
  taxAmount: number;
  status: string;
  isSynced?: number | null;
  createdBy: string;
  lastSyncedAt?: string | null;
  createdAt?: string | null;
}
export interface SaleOrderItemRow {
  id: string;
  saleOrderId: string;
  productId: string | null;
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  discountAmount: number;
  taxAmount: number;
  isSynced?: number | null;
  lastSyncedAt?: string | null;
}
export interface InvoiceRow {
  id: string;
  invoice_number: string;
  customer_id: string | null;
  customer_name: string | null;
  total_amount: number;
  status: string;
  created_at?: string | null;
  updated_at?: string | null;
  /** Local-only (POS side-effect bookkeeping, stripped before upload). */
  saleOrderId?: string | null;
  paidAmount?: number | null;
  dueDate?: string | null;
  branchId?: string | null;
  branchName?: string | null;
}
export interface InvoiceItemRow {
  id: string;
  invoice_id: string;
  product_id: string | null;
  description: string;
  quantity: number;
  unit_price: number;
  total_price: number;
}

/* ---------- 6. proformas / waybills ---------- */
export interface TaxComponentJson {
  name: string;
  valuePercentage?: number;
  value_percentage?: number;
  taxAmount?: number;
}
export interface ProformaRow {
  id: string;
  party_name: string | null;
  party_address: string | null;
  declaration: string | null;
  tax: TaxComponentJson[] | null;
  total_quantity: number;
  total_amount: number;
  is_deleted: number;
  created_at?: string | null;
  updated_at?: string | null;
}
export interface ProformaItemRow {
  id: string;
  proforma_id: string;
  product_id: string | null;
  product_name: string;
  quantity: number;
  unit_price: number;
  discount_percentage: number;
  total_amount: number;
}
export interface WaybillRow {
  id: string;
  mainContent: Record<string, unknown> | null;
  orderNumber: string;
  dispatchDocNumber: string;
  deliveryNote: string;
  senderName: string;
  destination: string;
  dispatchDate: string;
  partyName: string;
  createdBy: string;
  isDeleted: number;
  createdAt?: string | null;
  updatedAt?: string | null;
}
export interface WaybillItemRow {
  id: string;
  waybill_id: string;
  product_id: string | null;
  product_name: string;
  quantity: number;
  unit_price: number;
  discount_percentage: number;
  total_amount: number;
}

/* ---------- 7. money ---------- */
export interface ReceiptRow {
  id: string;
  receipt_number: string;
  invoice_id: string | null;
  amount_paid: number;
  payment_method: string;
  created_at?: string | null;
}
export interface PaymentRow {
  id: string;
  amount: number;
  payment_method: string;
  reference: string | null;
  created_at?: string | null;
}
export interface BranchPaymentRow {
  id: string;
  branch_id: string | null;
  branch_name: string | null;
  amount: number;
  note: string | null;
  title: string;
  created_by: string | null;
  created_at?: string | null;
}
export interface ExpenseRow {
  id: string;
  title: string;
  description: string | null;
  amount: number;
  category: string;
  date: string;
  created_at?: string | null;
}

/* ---------- 8. returns / credit notes ---------- */
export interface ReturnOrderRow {
  id: string;
  return_number: string;
  invoice_id: string | null;
  customer_name: string | null;
  total_amount: number;
  status: string;
  created_at?: string | null;
}
export interface ReturnOrderItemRow {
  id: string;
  return_order_id: string;
  product_id: string | null;
  quantity: number;
  reason: string | null;
}
export interface CreditNoteRow {
  id: string;
  credit_note_number: string;
  invoice_id: string | null;
  return_order_id: string | null;
  customer_name: string | null;
  total_amount: number;
  applied_amount: number;
  status: string;
  created_at?: string | null;
}
export interface CreditNoteItemRow {
  id: string;
  credit_note_id: string;
  description: string;
  quantity: number;
  total_price: number;
}

/* ---------- 9. logistics / reports ---------- */
export interface StockTransferRow {
  id: string;
  transfer_number: string;
  from_branch_id: string | null;
  to_branch_id: string | null;
  status: string;
  created_at?: string | null;
}
export interface StockTransferItemRow {
  id: string;
  stock_transfer_id: string;
  product_id: string | null;
  quantity: number;
}
export interface ProductStockJson {
  id?: string;
  name: string;
  sku?: string;
  quantity?: number;
  retailPrice?: number;
  quantitySold?: number;
  totalSales?: number;
  openingQuantity?: number;
  quantityAdded?: number;
}
export interface CategoryStockJson {
  categoryId?: string;
  categoryName?: string;
  totalQuantity?: number;
  totalValue?: number;
}
/** Rich Dexie working shape; serialized to {branch_id, report_date, data} on upload. */
export interface StockReportRow {
  id: string;
  branch_id: string | null;
  branchName?: string | null;
  report_date: string;
  data?: {
    branchId?: string | null;
    branchName?: string | null;
    createdBy?: string | null;
    current_stock?: ProductStockJson[];
    category_stock?: CategoryStockJson[];
    startDate?: string | null;
    endDate?: string | null;
    productId?: string | null;
    productName?: string | null;
  } | null;
  currentStock?: ProductStockJson[];
  categoryStock?: CategoryStockJson[];
  createdBy?: string | null;
  createdAt?: string | null;
  startDate?: string | null;
  endDate?: string | null;
  productId?: string | null;
  productName?: string | null;
}

/* ---------- local-only ---------- */
export interface CompanySettingsRow {
  id: string; // singleton "main"
  name: string;
  postalAddress?: string | null;
  commercialAddress?: string | null;
  phonePrimary?: string | null;
  phoneSecondary?: string | null;
  faxId?: string | null;
  email?: string | null;
  website?: string | null;
  updatedAt?: string | null;
}
export interface StockAdjustmentRow {
  id: string;
  productId: string;
  productName: string;
  quantityChange: number;
  type: string; // 'Manual' | 'Waybill'
  reason?: string | null;
  referenceId?: string | null;
  createdAt: string;
  createdBy: string;
}
