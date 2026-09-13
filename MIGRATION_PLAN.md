# Ashfoam Sadiq → Next.js Duplication / Migration Plan

> Source: `../ashfoam_sadiq` (Flutter, 122 Dart files, Drift/SQLite local-first + Supabase remote, ForUI)
> Target: `./` (`ashfoam_nextjs`, empty) — Next.js App Router + TypeScript + Tailwind + shadcn/ui + Dexie.js (IndexedDB) + Supabase + PWA on Cloudflare
> Reason: Flutter web does not work well. Same theme + assets, IndexedDB for offline, Supabase stays remote.

Stack locked:
- Next.js App Router + TypeScript strict + Tailwind + shadcn/ui (radius 0, sharp-edge ForUI look)
- Dexie.js over IndexedDB (offline store + sync queue)
- Supabase JS + @supabase/ssr (remote, schema unchanged)
- Printing: @react-pdf/renderer (A4 docs) + pdf-lib/thermal path for 80mm receipt
- Excel: SheetJS (`xlsx`) — replaces `excel` + `syncfusion_xlsio`
- Tables: TanStack Table + shadcn (replaces Syncfusion DataGrid, no license)
- Deploy: Cloudflare (Workers/Pages via @opennextjs/cloudflare), PWA via Serwist/next-pwa

---

## 1. Source inventory (do not delete, mirror behavior)

### 1.1 Entry / navigation (no router in Flutter)

- `lib/main.dart`: `AppEntry.loading → login → home (BootstrapGate > AutoSyncListener > StarterApp)`
- `lib/main_app.dart:499-546`: manual `selectedIndex` sidebar. `lib/splash_page.dart` empty. `src/shared/routes/` only `.gitkeep`.
- `src/core/constants/offline_capable.dart`: offline-capable `{0,1,2,4,9,11}`, online-only `{3,5,7,10,12,13,14,15,16}` + `_OfflineBanner` in `main.dart`.

| Flutter idx | Sidebar label | Next.js route | Offline? |
|---|---|---|---|
| 0 | Summary | `/(app)/page.tsx` (also `/summary` alias) | offline |
| 1 | Point of Sale (default) | `/(app)/pos/page.tsx` | offline |
| 2 | Sale Orders / POS SALES | `/(app)/sales/page.tsx` | offline |
| 4 | PRODUCTS | `/(app)/inventory/page.tsx` | offline |
| 5 | STOCK / STOCK REPORTS | `/(app)/inventory/reports/page.tsx` | online-only |
| 6 / 9 | Proformas ("Profomas" typo) | `/(app)/inventory/proformas/page.tsx` | offline |
| 7 | Payments / ALL/BRANCH PAYMENTS | `/(app)/payments/page.tsx` | online-only |
| 11 | Waybills | `/(app)/inventory/waybills/page.tsx` | offline |
| 12 | BRANDS & CATEGORIES | `/(app)/settings/catalog/page.tsx` | online-only |
| 13 | ADJUSTMENT | `/(app)/inventory/adjustments/page.tsx` | online-only |
| 15 | SUPPLIER PAYMENTS | `/(app)/suppliers/payments/page.tsx` | online-only |
| 16 | SUPPLIERS | `/(app)/suppliers/page.tsx` | online-only |
| — | Login | `/(auth)/login/page.tsx` | requires online |

> Removed by owner (intentional): Employees (idx 14) and invoices/returns/credit-notes UI — `employees` store still syncs, no UI shipped.

### 1.2 Theme / assets

- `src/core/theme/app_colors.dart` (478 lines, generated from `assets/colors.css`, 476 vars). No semantic tokens.
- Key tokens: sidebar `yellow13 #FFE01A (0xFFFFE01A)`, login `yellow17 #E6C13D`, brand yellows `#FFE500/#FFDD00/#FFFF00`, active item `#0F0F0F` black bg + white text, scaffold `grey.shade50`.
- `FThemes.yellow.light.desktop` + `toApproximateMaterialTheme()` with **all radii 0** (card/dialog/buttons/inputs/chip/bottomSheet/snackBar/popup/appBar).
- Fonts: none — system Material + ForUI default. Next.js: system stack, no webfont needed.
- Assets (`pubspec.yaml` declares `assets/` wholesale): `ashfoam_logo.png` (sidebar `FHeader` + login `width:220`), `AppIcon256/64/512.png` (launcher icons), `proforma_invoice_sample.jpeg` (unused, keep as visual reference), `colors.css` (source of palette).

### 1.3 Auth / roles / constants

- `src/features/auth/`: `login_page.dart` (email regex + pw len>=6), `providers/auth_provider.dart` (Supabase `signInWithPassword`, `authStateProvider`, `sessionProvider`, `userProvider`, `offlineSessionProvider` 3s timeout, `appEntryProvider`), `providers/current_role_provider.dart` (cached offline role → fast return + bg refresh, fallback `manager` = restrictive).
- `utils/secure_storage_service.dart` (`flutter_secure_storage`): `user_data` JSON `{accessToken,refreshToken,userId,email,displayName,role?,branchId?,branchName?}` + `user_role`, `branch_id`, `is_logged_in`, bootstrap flags, sync cursors. Next.js equivalent: `localStorage` (+ httpOnly cookies for Supabase session via `@supabase/ssr`).
- `signOut()`: clear offline session + bootstrap status + `SyncMetadata` cursors/errors + Supabase signOut + reset bootstrap notifiers.
- Login requires online (`canSubmit=isOnline && !isLoading`). Forgot-password dialog is static contacts (`info@ashfoamghana.com`, `0556579214/0544352785`).
- `src/core/constants/roles.dart`: `enum AppRole{manager,admin,owner}`, fail-open `appRoleFromString→admin`, `isRoleBlockedForIndex`: **manager blocked on {14,15,16} only**, guard resets to POS(1) + `_RoleBlockedPlaceholder`.
- `company_info.dart`: `ASHANTI FOAM FACTORY LTD, P.O.BOX SE512, Ahodwo Off Atinga Junction, 0202643905/0559683429, (03220)24193, ahodwoshowroom@gmail.com, VAT C0002718510` + `kCompanyHeaderMap/kCompanyModel`.
- `taxes.dart`: Ghana `GFL 2.5% + NHIL 2.5% + VAT 15% = kTotalTaxPercentage 20.0` (tax-inclusive extraction).
- `config/supabase_config.dart`: `url=https://pzplgeysaefdaegeplpr.supabase.co` + anonKey (copy into `.env.local`, never commit service key).

### 1.4 Data — Supabase is source of truth → Dexie mirrors it (32 stores)

> CONFIRMED: `../ashfoam_sadiq/supabase_schema.sql` (30 tables) is authoritative. No schema changes.
> Dexie mirrors Supabase 1:1 (30 stores) + 2 local-only stores (`companySettings`, `stockAdjustments`) = **32 stores**.
> Drift (`src/data/local/app_database.dart` v5, 25 tables) is reference only — its gaps and shape differences are documented below, Supabase wins every conflict.

Supabase table → Dexie store (`lib/db/dexie.ts`). All PKs are UUID strings (`Uuid().v4()` client-generated); RLS: authenticated all-actions (per schema §`DO $$` block); triggers live server-side (`update_stock_after_sale` on `ashfoam_sale_order_items`, `update_stock_after_return` on `ashfoam_return_order_items` — Next.js must ALSO decrement/increment Dexie qty optimistically so offline UI stays correct, server trigger is the backstop).

| # | Supabase table | Dexie store | Key columns / notes |
|---|---|---|---|
| 1 | `ashfoam_stores` | `stores` | `id, created_at, name, address, is_active` — bootstrap pull |
| 2 | `ashfoam_branches` | `branches` | `id, store_id FK, store_name, branch_name, branch_address, contact, is_active, is_deleted, branch_manager_name/id, company_details JSONB` — **missing in Drift entirely**; bootstrap pull; FK target for employees/stock_transfers/stock_reports |
| 3 | `ashfoam_product_brands` | `brands` | `id, name, created_at` — push-all drain (no `isSynced` col, idempotent upsert) |
| 4 | `ashfoam_product_categories` | `categories` | same as brands |
| 5 | `ashfoam_product_subcategories` | `subcategories` | `id, category_id FK CASCADE, name, created_at` — bootstrap pull |
| 6 | `ashfoam_taxes` | `taxes` | `id, name, value_percentage` — local-only constants, seed 3 (GFL 2.5 / NHIL 2.5 / VAT 15); never synced |
| 7 | `ashfoam_suppliers` | `suppliers` | full cols incl. `supplier_code, contact_name, email, phone, address, is_active` — online-first CRUD |
| 8 | `ashfoam_supplier_payments` (+2 indexes) | `supplierPayments` | `id, supplier_id FK CASCADE, amount, note, date, created_at` — **missing in Drift**; NOW DRAINED (Flutter gap fixed, see §4.1) |
| 9 | `ashfoam_customers` | `customers` | `id UUID PK, name, email, phone, address, created_at, updated_at` — **UUID wins over Drift's int id**; no int-mapping layer |
| 10 | `ashfoam_employees` | `employees` | `id FK auth.users CASCADE, first_name, last_name, middle_name, email UNIQUE, phone, role, department, branch_id FK, branch_name, manager_id self-FK, manager_name, designation, status, is_active, hire_date, end_date, address, notes` — online CRUD |
| 11 | `ashfoam_inventory` | `inventory` | quoted camelCase verbatim (`"retailPrice"`, `"discountPrice"`, `"discountPercentage"`, `"brandId"` FK brands, `"subCategory"`, `"branchId"`, `"isAvailable"`, `"isDeleted"`, `"createdAt"`, `"updatedAt"`, `"isSynced"` BOOLEAN, `"lastSyncedAt"`) + `sku UNIQUE`, `catergory_id` typo FK kept — bootstrap pull + upload queue head; idx `sku, branchId, isSynced` |
| 12 | `ashfoam_sale_orders` | `saleOrders` | `"orderNumber"` UNIQUE, `"customerName", channel, "branchId", "branchName", "totalAmount", "discountAmount", "totalQuantity", "taxAmount", status, "isSynced"` SMALLINT, `"createdBy", "lastSyncedAt", "createdAt"` — upload queue |
| 13 | `ashfoam_sale_order_items` | `saleOrderItems` | `"saleOrderId"` FK CASCADE, `"productId"` FK inventory, `"productName", quantity, "unitPrice", "totalPrice", "discountAmount", "taxAmount", "isSynced", "lastSyncedAt"` — idx `saleOrderId`; inserting also decrements Dexie `inventory.quantity` (mirror server trigger) |
| 14 | `ashfoam_invoices` | `invoices` | `invoice_number UNIQUE (format INV-<id[0:8]>), customer_id FK, customer_name, total_amount, status` — upload queue; **replaces Drift's simplified invoice shape** |
| 15 | `ashfoam_invoice_items` | `invoiceItems` | `invoice_id FK CASCADE, product_id FK, description, quantity, unit_price, total_price` — idx `invoice_id`; **missing in Drift** |
| 16 | `ashfoam_proformas` | `proformas` | `party_name, party_address, declaration, tax JSONB, total_quantity, total_amount, is_deleted` — upload queue |
| 17 | `ashfoam_proforma_items` | `proformaItems` | `proforma_id FK CASCADE, product_id FK, product_name, quantity, unit_price, discount_percentage, total_amount` — idx `proforma_id`; **replaces Drift's shared ProductDetailsList (split in two)** |
| 18 | `ashfoam_waybills` | `waybills` | `"mainContent"` JSONB, `"orderNumber", "dispatchDocNumber", "deliveryNote", "senderName", destination, "dispatchDate", "partyName", "createdBy", "isDeleted"` — upload queue |
| 19 | `ashfoam_waybill_items` | `waybillItems` | `waybill_id FK CASCADE, product_id FK, product_name, quantity, unit_price, discount_percentage, total_amount` — idx `waybill_id`; split from shared list |
| 20 | `ashfoam_receipts` | `receipts` | `receipt_number UNIQUE, invoice_id FK, amount_paid, payment_method` — **NOW DRAINED** (Flutter kept write-only local; Supabase table exists so drain it, see §4.1) |
| 21 | `ashfoam_payments` | `payments` | `amount, payment_method, reference, created_at` — **missing in Drift** (only branchPayments existed); C+R on `/payments` + branch-payments view |
| 22 | `ashfoam_branch_payments` | `branchPayments` | `branch_id, branch_name, amount, note, title, created_by` — upload queue (`toRemoteMap()`) |
| 23 | `ashfoam_expenses` | `expenses` | `title, description, amount, category, date, created_at` — **NOW DRAINED** (Flutter queued locally, never uploaded) |
| 24 | `ashfoam_return_orders` | `returnOrders` | `return_number UNIQUE, invoice_id FK, customer_name, total_amount, status` — **NOW DRAINED**; inserting items also increments Dexie `inventory.quantity` (mirror server trigger) |
| 25 | `ashfoam_return_order_items` | `returnOrderItems` | `return_order_id FK CASCADE, product_id FK, quantity, reason` — idx `return_order_id` |
| 26 | `ashfoam_credit_notes` | `creditNotes` | `credit_note_number UNIQUE, invoice_id FK, return_order_id FK, customer_name, total_amount, applied_amount, status` — **NOW DRAINED** |
| 27 | `ashfoam_credit_note_items` | `creditNoteItems` | `credit_note_id FK CASCADE, description, quantity, total_price` — idx `credit_note_id` |
| 28 | `ashfoam_stock_transfers` | `stockTransfers` | `transfer_number UNIQUE, from_branch_id FK, to_branch_id FK, status` — **missing in Drift** (dead model only); R + status updates |
| 29 | `ashfoam_stock_transfer_items` | `stockTransferItems` | `stock_transfer_id FK CASCADE, product_id FK, quantity` — idx `stock_transfer_id` |
| 30 | `ashfoam_stock_reports` | `stockReports` | remote minimal (`id, branch_id FK nullable, report_date, data JSONB`); Dexie keeps rich working shape (`branchName, currentStock[], categoryStock[], createdBy, startDate, endDate, productId?, productName?`, `isSynced`) and serializes to `{branch_id: null if !isUuid, report_date, data:{branchId,branchName,current_stock,category_stock,…}}` on upload — upload queue |
| — | (local-only, no Supabase table) | `companySettings` | singleton from `kCompanyHeaderMap` — never uploaded |
| — | (local-only, no Supabase table) | `stockAdjustments` | audit log (`productId, productName, quantityChange, type Manual/Waybill, reason?, referenceId?, createdAt, createdBy`) — never uploaded |

Models: `src/data/models/*` (18 files) + `model_mappings.dart` + `drift_extensions.dart` → `lib/db/types.ts` (Zod schemas matching Supabase column names incl. quoted camelCase) + `lib/db/mappers.ts` (dual-key tolerant reads: `category_id|catergory_id`, `retailPrice|retail_price`, `value_percentage|valuePercentage`, `first_name|firstName`). Dexie stores keep Supabase column names verbatim (camelCase where quoted) to avoid `PGRST204`.

Repositories `src/data/repositories/*` (fetch + bulkUpload pattern) → `lib/supabase/queries/*.ts` — one module per Supabase table (30), each `fetch({search,limit,offset})`, `bulkUpload(rows)` (upsert+select), child `fetchItems(parentId)` / `bulkUploadItems(rows)` where FK exists. Special: `ProductsRepository.syncInventory({updatedSince, skipLocalUnsynced})` → `lib/supabase/queries/inventory.ts:syncInventory`.

### 1.5 Sync architecture (port faithfully)

```
[Supabase (30 tables): stores|branches|brands|categories|subcategories|taxes|suppliers|supplier_payments|customers|employees|inventory|sale_orders(+items)|invoices(+items)|proformas(+items)|waybills(+items)|receipts|payments|branch_payments|expenses|return_orders(+items)|credit_notes(+items)|stock_transfers(+items)|stock_reports]
  ^ bootstrap pull (down)        ^ remote-first writes (per-action)      ^ bulk upload queue drain
[lib/sync/bootstrap.ts]          [features/*/mutations]                  [lib/sync/upload.ts]
  v                              v                                       v
[Dexie IndexedDB: 32 stores (30 mirrored + companySettings + stockAdjustments), isSynced 0=dirty/1=clean, lastSyncedAt] <-- UI always reads Dexie
  ^ localStorage cursors/errors  ^ connectivity gate
[lib/db/cursors.ts + lib/sync/connectivity.tsx]
```

- Bootstrap (down): masters + branches: stores, branches, products (`gte updated_at` incremental via `pull_cursor_inventory`, `skipLocalUnsynced:true`) + brands + categories + subcategories, `bulkPut` in txn. Taxes/company seeded locally (no remote pull). `run()` full vs `runIncremental({updatedSince})`. Flags: `bootstrapComplete`, `lastBootstrapAt`. `BootstrapGate` blocks first-run UI ("Preparing offline data") with Retry/Continue-local-only; re-triggers on offline→online. 60s timeout, never throw to UI, invalidate lists.
- Upload (up): queue = `isSynced==0` (+ all-rows push for brands/categories which lack the flag). Writers set `0` offline, `1+lastSyncedAt` on remote upsert success. Only mark `1` after success (`_upsertWithRetry`, 3 tries, 1s/2s/4s backoff). FK-safe order: Inventory → SaleOrders → SaleOrderItems → Proformas → ProformaItems → Waybills → WaybillItems → Invoices → InvoiceItems → Receipts → Payments → BranchPayments → Expenses → SupplierPayments → ReturnOrders → ReturnOrderItems → CreditNotes → CreditNoteItems → StockTransfers → StockTransferItems → StockReports → Brands → Categories (last two push-all idempotently) → Customers/Suppliers/Employees/Stores/Branches/Subcategories (upsert-on-write, no queue). Suppliers/customers/employees writes are online-first direct (no offline queue — matches Flutter repos). Persist `countsByEntity/errorsByEntity`, `lastUploadAt`. `SyncQueueDialog` shows online dot + counts + errors + Sync Now.
- Remote-first reads (`src/services/remote_first.dart` → `lib/sync/remote-first.ts`): `tryWarmRemote/warmInventory/warmSaleOrders(+Items)/warmProformas(+Details)/warmWayBills(+Details)/warmAllProductDetails/warmBranchPayments/warmInvoices/warmBrands/warmCategories/warmSubCategories/warmStockReports` — SELECT remote (8s timeout) → upsert clean rows (skip dirty) → return local read.
- Providers (inventory/proforma/waybill/stockReport/payments/pos): remote-before-local strict when online (`else throw "Remote X failed — not saved locally"`); offline save `isSynced:0`. `adjustInventoryStock` flips to `0` + audit log insert.
- Connectivity (`connectivity_service.dart` → `lib/sync/connectivity.tsx`): `navigator.onLine` + events + 15s poll + Supabase reachability; `AutoSyncListener` on false→true runs incremental + 3s-debounced upload if pending>0; amber banner "N change(s) waiting…" → dialog; blue progress while uploading.

### 1.6 Features CRUD matrix

| Feature | Flutter pages/dialogs | Next.js | CRUD |
|---|---|---|---|
| auth | `login_page.dart` | `/(auth)/login` | Auth only; supplies `createdBy` |
| pos | `pos_page.dart`, `order_success_dialog`, `pos_state.dart`, `pos_providers.dart` (cart+summary+createPOSOrder), `receipt_service.dart` | `/pos` | C SaleOrder+Items + Invoice+InvoiceItems side-effect in txn (Dexie stock decrement mirrors server trigger), R inventory/sales |
| sales | `sale_orders_page.dart`, `invoices_page.dart` (dup), `order_details_dialog` | `/sales` | R only (history + search) |
| invoices | `invoices_page.dart`, `invoice_details_dialog`, `invoice_print_service.dart` (294L) | `/invoices` | R + U(status); C via POS (with items); print |
| inventory | `inventory_page.dart`, `proforma_page.dart`, `waybill_page.dart`, `stock_adjustment_page.dart`, `stockreports.dart`, 8 dialogs, 6 providers | `/inventory/*` | Full CRUD products/proformas(+items)/waybills(+items); C+R adjustments/logs; C+R+D movement reports `generateMovementStockReport(start,end,productId?)`; NEW transfers screen (§P3) |
| payments | `payments_page.dart`, `add_payment_dialog` | `/payments` | C+R BranchPayments + Payments (`ashfoam_payments` table — new vs Flutter) |
| suppliers | `suppliers_page.dart`, `supplier_payments.dart` | `/suppliers/*` | Full CRUD suppliers + supplier-payments (`ashfoam_supplier_payments` — new vs Flutter, online-first) |
| employees | `employees_page.dart` | `/employees` | Full CRUD (branch picker now backed by `branches` store) |
| management | `brand_category_page.dart` | `/settings/catalog` | Full CRUD brands/categories/subcategories |
| summary | `summary_page.dart`, `summary_providers.dart` (inventory+sales+payments+invoices+proformas+waybills totals, outstanding, lowStock, trends) | `/` | R aggregate |
| sync | `bootstrap_gate`, `auto_sync_listener`, `sync_queue_dialog` | layout-level | orchestration |
| common | `empty_state`, `grid_action_button`, `pdf_helper.dart` (`buildCompanyHeader`, `buildReceiptHeader`) | shared components | header for all docs |

### 1.7 Printing / Excel (must duplicate outputs)

- Common: `pdf_helper.dart` → `lib/print/header.tsx` (strict company constants).
- Per doc `showPreview → Dialog>PdfPreview → _generatePdf → Uint8List` → Next.js: route-level Preview dialog + Download + `window.print`:
  - `proforma_print_service.dart` (587L, A4, meta grid party/proformaNo `id[0:8]`/date/declaration, items `#,Description,Qty,UnitPrice,Discount%,Amount`, tax rows, total, signatures)
  - `waybill_print_service.dart` (609L, A4, `orderNumber,dispatchDocNumber,dispatchDate,senderName,destination,partyName,deliveryNote`, items, qty total)
  - `invoice_print_service.dart` (294L, A4, blue header, `INV-<id>`, customer, dueDate, items from saleOrder, `total/paid/balanceDue`, status color)
  - `receipt_service.dart` (448L, **80mm thermal only** `226.77pt`, 12pt margins, orderNo/date/cashier/branch, `name xQty … amount`, subtotal/discount/tax/total `GH¢`, VAT footer, `Receipt_<orderNumber>.pdf`)
  - `stock_report_print_service.dart` (287L, A4 landscape-ish, `periodLabel/scopeLabel`, `currentStock` table `SKU,Name,Opening,Added,Sold,Closing,Price,Value`, category summary, `Stock_Report_<date>.pdf`)
- `excel_service.dart` (258L) → `lib/excel/`: `generateTemplate()` (headers `Product Name*,Category,Sub-Category,Brand,Retail Price*,Initial Quantity*,Unit,Material,Size,Thickness,Density` + sample), `parseProducts(bytes)` (skip header, `isSynced:0`), `generateInventoryExport`, `generatePaymentsExport`, `saveFile` (browser download, no `path_provider`).

---

## 2. Target file tree (create in this order)

```
MIGRATION_PLAN.md            # this file
.env.local                   # NEXT_PUBLIC_SUPABASE_URL, NEXT_PUBLIC_SUPABASE_ANON_KEY (copy from supabase_config.dart)
app/globals.css              # colors.css vars + --radius:0 + system font stack
app/layout.tsx               # root, PWA metadata
app/(auth)/login/page.tsx
app/(app)/layout.tsx         # AppShell: fixed sidebar md+, drawer + topbar below md
app/(app)/page.tsx            # summary
app/(app)/pos/page.tsx
app/(app)/sales/page.tsx
app/(app)/inventory/page.tsx
app/(app)/inventory/reports/page.tsx
app/(app)/inventory/proformas/page.tsx
app/(app)/inventory/waybills/page.tsx
app/(app)/inventory/adjustments/page.tsx
app/(app)/payments/page.tsx
app/(app)/suppliers/page.tsx
app/(app)/suppliers/payments/page.tsx
app/(app)/employees/page.tsx
app/(app)/settings/catalog/page.tsx
components/ui/*               # shadcn
components/{sidebar.tsx,offline-banner.tsx,sync-queue-dialog.tsx,bootstrap-gate.tsx,empty-state.tsx,data-table.tsx}
lib/theme.ts  lib/company.ts  lib/taxes.ts  lib/roles.ts  lib/offline-capable.ts
lib/supabase/{config,client,browser,server,queries/*.ts}  # 30 query modules, one per Supabase table
lib/db/{dexie.ts,types.ts (zod),mappers.ts,cursors.ts}
lib/auth/{session.ts,role.ts}
lib/sync/{bootstrap.ts,upload.ts,remote-first.ts,connectivity.tsx,auto-sync.tsx}
lib/print/{header,proforma,waybill,invoice,receipt-80mm,stock-report}.tsx
lib/excel/{template,parser,export}.ts
features/{pos,sales,invoices,inventory,payments,suppliers,employees,catalog,summary}/{queries,mutations,components}.ts(x)
public/{ashfoam_logo.png,AppIcon*.png,manifest.webmanifest,icons/*}
wrangler.toml  next.config.ts (opennext)  playwright/e2e
```

---

## 3. Phase plan (check off as built)

### P0 — Scaffold + theme + assets [DONE 2026-09-13]
- [x] Next 16.3.5 App Router + TS + Tailwind v4 scaffolded in `ashfoam_nextjs/` (`package.json` renamed to `ashfoam_nextjs`)
- [x] shadcn init (base-nova, neutral) + `--radius: 0rem` in `globals.css`; dark-mode off (unused `.dark` block left inert)
- [x] `public/ashfoam_logo.png`, `AppIcon64/256/512.png` copied; brand tokens (`--ashfoam-yellow #FFE01A`, `--ashfoam-yellow-login #E6C13D`, `--ashfoam-ink #0F0F0F`) + `bg-ashfoam/*` utilities; `lib/theme.ts` with `AppColors`
- [x] `app/(app)/layout.tsx` sidebar (yellow bg, black active item, logo header, 5 sections, default `/pos` via nav) + `OfflineBanner`; `app/(auth)/login/page.tsx` shell (email regex, pw≥6, online-required note, static admin contacts); all 18 routes as `RoutePlaceholder` shells with Flutter-idx badges; `lib/{company,taxes,roles,offline-capable,nav}.ts` ported
- [x] `.env.local` from `supabase_config.dart`; `lib/supabase/config.ts`; `wrangler.toml` draft
- Verify: `npm run build` passes (21/21 static, all 18 routes); sidebar `#FFE01A` pixel-check + logo 220px on login still to eyeball in `npm run dev`.

### P1 — Foundation: Supabase + auth + Dexie + sync core [DONE 2026-09-13]
- [x] `lib/supabase/*`: `@supabase/supabase-js` + `@supabase/ssr` browser/server clients + `middleware.ts` session refresh; queries grouped by domain (`_table` helper + `org/catalog/partners/inventory/sales/docs/money/adjustments/logistics` — same per-table fetch+bulkUpload coverage as 30 thin modules, grouped for maintainability)
- [x] `lib/db/`: `dexie.ts` 32 stores §1.4 (+`_isSynced` idx incl. `payments`), `types.ts` (Supabase column names verbatim), `mappers.ts` (`withSync/stripClientFields/isUuid/invoiceNumberFor/stockReportToRemote`), `cursors.ts` (SSR-safe localStorage), `seed.ts` (3 taxes + company singleton)
- [x] Auth: `lib/auth/session.ts` (offline cache: `user_data/user_role/branch_id/is_logged_in`), `auth-context.tsx` (live session + cached role fast-return + restrictive manager fallback; signOut clears session + cursors), `role-gate.tsx` (`RequireAuth`: unauthenticated→/login, manager→"Access restricted"); login wired (online-gated submit, error display, autoredirect); sidebar hides blocked items + displayName + sign-out
- [x] Sync: `bootstrap.ts` (stores/branches/masters, full vs incremental cursor, skip-dirty, 60s timeout, never throws), `upload.ts` (14 queued entities + brands/categories push-all, FK-safe order, 1s/2s/4s retry, clean-only-on-success, persisted errors/lastUploadAt), `remote-first.ts` (warm helpers for all entities + `warmAll`), `connectivity.tsx` (navigator + events + 15s poll + Supabase probe, unknown=offline), `sync-context.tsx` (counts/errors/uploadAll), `AutoSync` (reconnect → incremental + 3s-debounced upload), `BootstrapGate` (Retry/Continue-offline), `SyncQueueDialog` (counts/errors/Sync Now + progress bar in sidebar footer)
- [x] `lib/offline-capable.ts` + route guards (online-only badge on placeholders; full placeholder→/pos redirect lands with P2 screens)
- Verify: `npx tsc --noEmit` clean; `npm run build` green (22/22 static + middleware). Live login + cold-start bootstrap + airplane-mode queue drain need a browser pass (test creds pending).

### P2 — Offline-first parity [DONE 2026-09-13]
- [x] POS `/pos`: product search + category-less filter (name search), cart (Zustand `cart-store`, exact Flutter formulas), summary (discount/tax via `lib/taxes`, GH₵), `createPOSOrder` txn (order+items+customer, `ORD-` numbers, channel Retail, status Paid, Dexie stock decrement mirroring server trigger, remote-first + best-effort customer), `OrderSuccessDialog` equivalent (receipt print noted as P4). Invoice side-effect flag plumbed, default off (no checkbox in Flutter UI).
- [x] Products `/inventory`: full CRUD (remote-before-local via `saveRemoteFirst`, queued offline), name/sku/category search, add/edit/view `ProductDialog` (exact fields/defaults/validation), auto-SKU `PREFIX-YYYYMMDD-millis`, manager view-only + delete confirm. Excel buttons deferred to P4.
- [x] SaleOrders `/sales`: history (Order # | Items | Date | Customer | Amount) + working search input (Flutter's provider existed but no input was wired) + details dialog (meta rows, items, total). Excel/print in P4.
- [x] Proformas `/inventory/proformas`: CRUD + items + tax picker (gfl/nhil/vat, inclusive math) + details + pager (10/page); manager create-blocked. Print in P4 (disabled button with title).
- [x] Waybills `/inventory/waybills`: CRUD + items + proforma import + dispatch header + `WB-`/`ORD-` numbering + details (DISPATCHED pill); manager create-blocked, edit allowed. Print in P4.
- [x] Summary `/`: 6 stat cards, timeframe trend (daily/weekly/monthly/yearly bucketing per `salesTrendProvider`, CSS bars replacing SfCartesianChart), recent-5 table, Live pill + refresh.
- Shared: `lib/sync/mutations.ts` (`saveRemoteFirst`), `components/{searchable-select,data-table}`, `features/docs/{totals,tax-picker,item-picker,mutations}`, `lib/dates.ts`, TanStack Table v8 pinned, `proxy.ts` (Next 16.3 middleware rename), mount-fetch lint rule → warn.
- Divergences (documented in code): cart merge also merges taxAmount (Flutter kept stale value); sales search input added (was dead code).
- Verify: `tsc` clean, `eslint` 0 errors, `npm run build` green, dev smoke (`/login` renders, `/pos` auth-gates). Browser + Supabase live pass pending test creds.

### P3 — Online-only parity + NEW tables [DONE 2026-09-13]
- [x] StockReports `/inventory/reports`: `generateMovementStockReport` (opening = closing − sold − added from sale items + positive adjustments in range; category snapshot; branch `main-store` fallback), month filter on generation date, generate dialog (presets + range validation + product scope), details modal (5 summary cards + breakdown), delete. Dexie v4.
- [x] Payments `/payments`: branch-payments list/filter + `PaymentDialog` (date/branch/title/amount>0/notes); `branch_id` nulled when free text isn't UUID; RLS-42501 → local queue, other errors save nothing.
- [x] Catalog `/settings/catalog`: brands/categories two-column CRUD ("Create Locally" semantics, push-all drain).
- [x] Adjustments `/inventory/adjustments`: Manual (search + signed delta + reason + change preview) + Waybill receive (manifest + loop) tabs, audit-log dialog; remote camelCase `updatedAt` update, missing-remote stays queued, error saves nothing.
- [x] Suppliers `/suppliers` + `/suppliers/payments`: online-only card grid (explicit name-required validation) + payments table with resolved supplier names (Flutter showed raw FK), record/delete dialogs with online guards.
- [x] ~~Employees `/employees`~~ — REMOVED by owner (no UI; store + queries remain).
- Verify: `tsc` clean, `eslint` 0 errors, `npm run build` green (16 routes). Live Supabase pass pending test creds.
- Dropped per owner request: transfers page + `features/transfers` (table still syncs).

### P4 — Printing + Excel [DONE 2026-09-13]
- [x] Shared: `lib/print/{words.ts (exact converter), format.ts (ceil amounts, GH¢ 2dp, dd-MMM-yy), header.tsx, a4-table.tsx}` + `components/{pdf-viewer, print-preview-dialog}` (ssr:false viewer + download).
- [x] Proforma A4 + wire list Print button (preview title/file per Flutter; quirk fixes: tax % in Disc.% col + taxAmount in Amount, Ref. No. line removed, 8pt unified).
- [x] Waybill A4 + wire list Print button (info boxes, V.A.T INVOICE, 'Total' label, `propety`→`property`).
- [x] Receipt 80mm thermal: HTML twin + PDF (computed roll height) + `ReceiptDialog` (preview/Print via 80mm @page + Download) wired to POS success + sales details; real Amount Received → Cash Tendered/Balance (no more identical rows / empty Balance); `—` date fallback.
- [x] Stock report A4 (`STOCK MOVEMENT`, grey header, signature line, page footer) + wire reports Print button (month-label title/file).
- [x] Excel (SheetJS): template (exact headers + sample), import parser (header-mapped, required cols, row errors) wired to inventory (Template/Import/Export + brand/category name resolution), payments export, sales export.
- Verify: `tsc` clean, `eslint` 0 errors, `npm run build` green; all 4 PDFs render-tested via temp API route (valid %PDF- magic, since removed). Side-by-side vs Flutter + physical 80mm/A4 test prints pending.

### P5 — PWA + Cloudflare [DONE 2026-09-13]
- [x] `manifest.webmanifest` (name Ashfoam, icons from `AppIcon*.png`, standalone, theme `#0F0F0F`) + layout PWA metadata (`themeColor`, apple-web-app, icons)
- [x] Service worker: hand-written `public/sw.js` app-shell cache (static assets cache-first, navigations network-first → cache fallback; never touches API/Supabase — Dexie stays the data layer) + `components/service-worker-registrar.tsx` (prod-only). Divergence from plan: plain SW instead of Serwist (Next 16 + Turbopack compatibility; same behavior)
- [x] `@opennextjs/cloudflare` 1.20.6 + `open-next.config.ts` (default, no cache binding) + `wrangler.toml` (`.open-next/worker.js` + assets binding, `nodejs_compat`, `global_fetch_strictly_public`); scripts `build:cf`/`preview`/`deploy`; `proxy.ts` kept (Next 16 middleware rename)
- [x] `wrangler deploy --dry-run` green (15 MiB worker / 3.4 MiB gzip). Actual `wrangler deploy` + offline PWA install smoke test pending (needs `wrangler login`)
- Verify: `tsc` clean, `npm run build` green, lint 0 errors.

### P6 — QA + cutover [PARTIAL 2026-09-13]
- [x] Playwright: `@playwright/test` + `playwright.config.ts` + `e2e/` — smoke suite green (login redirect guard, login online-gate, manifest/icons served, SW served); live-creds specs (offline POS order → drain) ready, skip without `E2E_EMAIL`/`E2E_PASSWORD`
- [x] eslint fixed: mounted `eslint-plugin-react-hooks` (was crashing since 16.3.5), ignored `.open-next`/`.wrangler`/`test-results` build output; 0 errors, 27 intentional mount-fetch warnings
- [ ] Matrix: roles {manager,admin,owner} × {online,offline} × every entity; RLS check; empty states; sync error surfacing — needs live Supabase test creds + browser pass
- [ ] Data migration: point at same Supabase project (no schema changes)
- [ ] Full Playwright live flow: login → POS order offline → reconnect → invoice/receipt PDFs (blocked on test creds)
- Pages removed by owner (intentional): Employees `/employees` (idx 14) — store + queries still sync, no UI. Nav/acceptance criteria updated accordingly.

### P6.5 — Offline resilience hardening [DONE 2026-09-13]
- [x] **CRITICAL fix — offline-sale stock double-decrement**: POS sales no longer dirty clean inventory rows (the decrement is a mirror of the server INSERT trigger); drain reordered so stock-carrying children (`saleOrders`/`saleOrderItems` step 1, `returnOrders(+items)` step 2) upload BEFORE the absolute `inventory` push (step 3). Previously: inventory (absolute Q−qty) pushed first, then items INSERT trigger subtracted again → server = Q−2·qty. Regression spec: `e2e/stock-equality.spec.ts` (fixme until POS selectors live-validated).
- [x] **Server-derived pull cursor**: `inventoryPullCursor` is now max `updatedAt` from pulled inventory rows (client clock no longer used; skewed clocks no longer skip rows silently).
- [x] **Paginated bootstrap**: all master pulls (stores/branches/brands/categories/subcategories/inventory) page at 500 until short page — no silent caps (old hard limits 500–2000).
- [x] **Single-flight upload lock**: `uploadAllUnsynced` reuses one in-flight promise — Sync Now + AutoSync can't double-drain.
- [x] **Reactive data bus** (`lib/db/data-bus.ts`): table hooks (creating/updating/deleting) bump a version; `useDataVersion()` re-runs each list page's load on ANY db write (drain/warm now refresh open screens — closes the non-reactive-UI gap); SyncProvider auto-refreshes pending counts.
- [x] **Quota errors surfaced**: upload retry errors flag `QuotaExceededError` with a "local storage full" message in the SyncQueueDialog.
- [x] **Sign-out data wipe** (shared-device hygiene): sidebar offers "Clear data & sign out" (`wipeLocalData` deletes + reopens + reseeds Dexie); default keeps data for convenience.
- [x] **Multi-tab + bootstrap race**: `db.on("versionchange")` reloads stale tabs on schema upgrade; a timed-out bootstrap no longer persists cursors after the gate gives up.

---

## 4. Decisions / risks

1. **Silent-backlog gap — DECIDED (fix)**: Flutter never drains `expenses/returns/credit-notes/receipts` although Supabase tables exist. Next.js drains all of them in FK-safe order (§1.5) and adds a NEW transfers screen (§P3). Returns/credit-notes/invoices have no UI (removed per owner request) but their tables still sync. Divergence from Flutter is intentional and documented here.
2. **`customers.id` — DECIDED (UUID)**: Supabase `id UUID PK` wins; Drift's int id discarded. No mapping layer.
3. **Shared `ProductDetailsList` — DECIDED (split)**: Dexie `proformaItems` + `waybillItems` match Supabase child tables.
4. **Drift-only tables**: `companySettings`, `stockAdjustments` stay local-only Dexie stores (no remote).
5. **Syncfusion → TanStack Table**: accepted (no license, Cloudflare-safe). Keep column sets identical.
6. **`proforma_invoice_sample.jpeg`**: reference only, not shipped.
7. **"Profomas" typo**: ship "Proformas", keep `/proforma` alias route for muscle memory.
8. **Cloudflare edge**: no `sharp`, no node `pdf`/`printing`; all doc generation client-side. Supabase anon key public; service key never in repo.

## 5. Acceptance criteria

- All routes render with same labels/data as Flutter (minus removed invoices/returns/credit-notes/Employees per owner); manager role blocked on suppliers only.
- Dexie holds 32 stores mirroring `supabase_schema.sql` 1:1 (+2 local-only); no schema changes.
- Offline P2 flows (POS sale, product add, proforma, waybill) queue in Dexie and drain in FK-safe order on reconnect; queue dialog counts exact. Returns increment stock (Dexie mirror of server trigger).
- All 5 print outputs + Excel template/import/export visually match Flutter.
- PWA installs, works offline; deployed on Cloudflare; `npm run build` green.
