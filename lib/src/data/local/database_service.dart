import 'dart:convert';
import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/local/drift_extensions.dart';
import 'package:ashfoam_sadiq/src/data/local/model_mappings.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/customer.model.dart';
import 'package:ashfoam_sadiq/src/data/models/supplier.model.dart';
import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/models/receipt.model.dart';
import 'package:ashfoam_sadiq/src/data/models/return_order.model.dart';
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart';
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart'
    as proforma_model;
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:ashfoam_sadiq/src/data/models/employee.model.dart';
import 'package:ashfoam_sadiq/src/data/models/expenses.model.dart';
import 'package:ashfoam_sadiq/src/data/models/stock_report.model.dart';
import 'package:ashfoam_sadiq/src/data/models/stock_adjustment.model.dart';
import 'package:ashfoam_sadiq/src/data/models/payments.model.dart'
    as payment_model;
import 'package:drift/drift.dart'
    show Value, Variable, OrderingMode, OrderingTerm;
import 'package:uuid/uuid.dart';

class DatabaseService {
  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService._internal();

  final db.AppDatabase _database = db.AppDatabase();

  db.AppDatabase get appDatabase => _database;
  db.AppDatabase get database => _database;

  // Inventory
  Future<List<InventoryModel>> getInventoryItems() =>
      (_database.select(_database.inventoryItems)..orderBy([
            (t) =>
                OrderingTerm(expression: t.quantity, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addInventoryItem(db.InventoryItemsCompanion item) =>
      _database.into(_database.inventoryItems).insert(item);

  Future<bool> updateInventoryItem(db.InventoryItem item) =>
      _database.update(_database.inventoryItems).replace(item);

  Future<int> deleteInventoryItem(String id) async {
    return (_database.delete(
      _database.inventoryItems,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> adjustInventoryStock({
    required String productId,
    required int quantityChange,
    required String type,
    String? reason,
    String? referenceId,
    required String createdBy,
  }) async {
    await _database.transaction(() async {
      final existing = await (_database.select(
        _database.inventoryItems,
      )..where((tbl) => tbl.id.equals(productId))).getSingleOrNull();

      if (existing != null) {
        // 1. Update quantity
        await (_database.update(
          _database.inventoryItems,
        )..where((tbl) => tbl.id.equals(productId))).write(
          db.InventoryItemsCompanion(
            quantity: Value(existing.quantity + quantityChange),
            updatedAt: Value(DateTime.now()),
          ),
        );

        // 2. Create log entry (using customStatement to avoid missing generated companion)
        await _database.customStatement(
          'INSERT INTO stock_adjustments (id, product_id, product_name, quantity_change, type, reason, reference_id, created_at, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            const Uuid().v4(),
            productId,
            existing.name,
            quantityChange,
            type,
            reason,
            referenceId,
            DateTime.now().millisecondsSinceEpoch ~/ 1000,
            createdBy,
          ],
        );
      }
    });
  }

  Future<List<AdjustmentLog>> getStockAdjustmentLogs() => _database
      .customSelect('SELECT * FROM stock_adjustments ORDER BY created_at DESC')
      .get()
      .then(
        (rows) => rows.map((row) {
          final createdAtVal = row.data['created_at'];
          int milliseconds = 0;
          if (createdAtVal is num) {
            milliseconds = createdAtVal.toInt() * 1000;
          } else if (createdAtVal is String) {
            milliseconds = (int.tryParse(createdAtVal) ?? 0) * 1000;
          }

          return AdjustmentLog(
            id: row.data['id'] as String,
            productId: row.data['product_id'] as String,
            productName: row.data['product_name'] as String,
            quantityChange: (row.data['quantity_change'] as num).toInt(),
            type: row.data['type'] as String,
            reason: row.data['reason'] as String?,
            referenceId: row.data['reference_id'] as String?,
            createdAt: DateTime.fromMillisecondsSinceEpoch(milliseconds),
            createdBy: row.data['created_by'] as String,
          );
        }).toList(),
      );

  // Suppliers
  Future<List<SupplierModel>> getSuppliers() =>
      (_database.select(_database.suppliers)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addSupplier(db.SuppliersCompanion supplier) =>
      _database.into(_database.suppliers).insert(supplier);

  // Invoices
  Future<List<InvoiceModel>> getInvoices() =>
      (_database.select(_database.invoices)..orderBy([
            (t) => OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addInvoice(db.InvoicesCompanion invoice) =>
      _database.into(_database.invoices).insert(invoice);

  Future<bool> updateInvoiceStatus(String id, String status) async {
    return await (_database.update(_database.invoices)
              ..where((tbl) => tbl.id.equals(id)))
            .write(db.InvoicesCompanion(status: Value(status))) >
        0;
  }

  // Sales Orders
  Future<List<SaleOrderModel>> getSalesOrders() =>
      (_database.select(_database.saleOrders)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addSalesOrder(db.SaleOrdersCompanion order) =>
      _database.into(_database.saleOrders).insert(order);

  Future<void> createPOSOrder(
    db.SaleOrdersCompanion order,
    List<db.SaleOrderItemsCompanion> items,
  ) async {
    await _database.transaction(() async {
      await _database.into(_database.saleOrders).insert(order);
      for (final item in items) {
        await _database.into(_database.saleOrderItems).insert(item);
      }
    });
  }

  Future<List<SaleOrderItem>> getSaleOrderItems(String saleOrderId) async {
    return (_database.select(_database.saleOrderItems)
          ..where((tbl) => tbl.saleOrderId.equals(saleOrderId)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<SaleOrderItem>> getAllSaleOrderItems() => _database
      .select(_database.saleOrderItems)
      .get()
      .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addSaleOrderItem(db.SaleOrderItemsCompanion item) =>
      _database.into(_database.saleOrderItems).insert(item);

  // Customers
  Future<List<CustomerModel>> getCustomers() =>
      (_database.select(_database.customers)..orderBy([
            (t) => OrderingTerm(
              expression: t.lastOrderDate,
              mode: OrderingMode.desc,
            ),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addCustomer(db.CustomersCompanion customer) =>
      _database.into(_database.customers).insert(customer);

  // Return Orders
  Future<List<ReturnOrderModel>> getReturnOrders() =>
      (_database.select(_database.returnOrders)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addReturnOrder(db.ReturnOrdersCompanion order) =>
      _database.into(_database.returnOrders).insert(order);

  Future<List<ReturnOrderItemModel>> getReturnOrderItems(
    String returnOrderId,
  ) async {
    return (_database.select(_database.returnOrderItems)
          ..where((tbl) => tbl.returnOrderId.equals(returnOrderId)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<ReturnOrderItemModel>> getAllReturnOrderItems() => _database
      .select(_database.returnOrderItems)
      .get()
      .then((rows) => rows.map((e) => e.toModel()).toList());

  // Credit Notes
  Future<List<CreditNoteModel>> getCreditNotes() =>
      (_database.select(_database.creditNotes)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addCreditNote(db.CreditNotesCompanion note) =>
      _database.into(_database.creditNotes).insert(note);

  Future<List<CreditNoteItemModel>> getCreditNoteItems(
    String creditNoteId,
  ) async {
    return (_database.select(_database.creditNoteItems)
          ..where((tbl) => tbl.creditNoteId.equals(creditNoteId)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<CreditNoteItemModel>> getAllCreditNoteItems() => _database
      .select(_database.creditNoteItems)
      .get()
      .then((rows) => rows.map((e) => e.toModel()).toList());

  // Stock Reports
  Future<List<StockReportSummary>> getStockReports() =>
      (_database.select(_database.stockReports)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then(
            (rows) => rows
                .map((e) => StockReportSummary.fromMap(e.toJson()))
                .toList(),
          );

  Future<int> deleteStockReport(String id) async {
    return (_database.delete(
      _database.stockReports,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  // Employees
  Future<List<EmployeeModel>> getEmployees() =>
      (_database.select(_database.employees)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addEmployee(db.EmployeesCompanion employee) =>
      _database.into(_database.employees).insert(employee);

  // Expenses
  Future<List<ExpenseModel>> getExpenses() =>
      (_database.select(_database.expenses)..orderBy([
            (t) => OrderingTerm(
              expression: t.expenseDate,
              mode: OrderingMode.desc,
            ),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addExpense(db.ExpensesCompanion expense) =>
      _database.into(_database.expenses).insert(expense);

  // Receipts, Proformas, Waybills
  Future<List<ReceiptModel>> getReceipts() =>
      (_database.select(_database.receipts)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<List<proforma_model.Profoma>> getProformas() =>
      (_database.select(_database.proformas)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addProforma(db.ProformasCompanion proforma) =>
      _database.into(_database.proformas).insert(proforma);

  Future<List<WayBillModel>> getWayBills() =>
      (_database.select(_database.wayBills)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<void> createWaybill(
    db.WayBillsCompanion waybill,
    List<db.ProductDetailsListCompanion> items,
  ) async {
    await _database.transaction(() async {
      await _database.into(_database.wayBills).insert(waybill);
      for (final item in items) {
        await _database.into(_database.productDetailsList).insert(item);
      }
    });
  }

  Future<List<proforma_model.ProductDetails>> getWayBillDetails(
    String waybillId,
  ) async {
    return (_database.select(_database.productDetailsList)
          ..where((tbl) => tbl.waybillId.equals(waybillId)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  // Product Details (for Waybills/Proformas)
  Future<List<proforma_model.ProductDetails>> getProductDetails() => _database
      .select(_database.productDetailsList)
      .get()
      .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<void> addProductDetailsList(
    List<db.ProductDetailsListCompanion> items,
  ) async {
    await _database.batch((batch) {
      batch.insertAll(_database.productDetailsList, items);
    });
  }

  Future<List<proforma_model.ProductDetails>> getProformaDetails(
    String proformaId,
  ) async {
    return (_database.select(_database.productDetailsList)
          ..where((tbl) => tbl.proformaId.equals(proformaId)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  // Brands, Categories, Subcategories
  Future<List<Brand>> getBrands() =>
      (_database.select(_database.productBrands)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<List<ProductCategory>> getCategories() =>
      (_database.select(_database.productCategories)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<List<ProductSubCategory>> getSubCategories() =>
      (_database.select(_database.productSubCategories)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addBrand(db.ProductBrandsCompanion brand) =>
      _database.into(_database.productBrands).insert(brand);

  Future<int> addCategory(db.ProductCategoriesCompanion category) =>
      _database.into(_database.productCategories).insert(category);

  Future<bool> updateBrand(String id, db.ProductBrandsCompanion brand) async {
    return await (_database.update(
          _database.productBrands,
        )..where((tbl) => tbl.id.equals(id))).write(brand) >
        0;
  }

  Future<int> deleteBrand(String id) async {
    return (_database.delete(
      _database.productBrands,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateCategory(
    String id,
    db.ProductCategoriesCompanion category,
  ) async {
    return await (_database.update(
          _database.productCategories,
        )..where((tbl) => tbl.id.equals(id))).write(category) >
        0;
  }

  Future<int> deleteCategory(String id) async {
    return (_database.delete(
      _database.productCategories,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  // Company Settings
  Future<CompanyModel?> getCompanySettings() => _database
      .select(_database.companySettings)
      .getSingleOrNull()
      .then((row) => row?.toModel());

  Future<void> updateCompanySettings(
    db.CompanySettingsCompanion settings,
  ) async {
    final existing = await _database
        .select(_database.companySettings)
        .getSingleOrNull();
    if (existing != null) {
      await (_database.update(_database.companySettings)
            ..where((tbl) => tbl.id.equals(existing.id)))
          .write(settings.copyWith(updatedAt: Value(DateTime.now())));
    } else {
      await _database.into(_database.companySettings).insert(settings);
    }
  }

  // Branch Payments
  Future<List<payment_model.BranchPaymentModel>> getBranchPayments() =>
      (_database.select(_database.branchPayments)..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
          .get()
          .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addBranchPayment(db.BranchPaymentsCompanion payment) =>
      _database.into(_database.branchPayments).insert(payment);

  // Sync Checks
  Future<List<SaleOrderModel>> getUnsyncedSaleOrders() async {
    return (_database.select(_database.saleOrders)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<SaleOrderItem>> getUnsyncedSaleOrderItems() async {
    return (_database.select(_database.saleOrderItems)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<InvoiceModel>> getUnsyncedInvoices() async {
    return (_database.select(_database.invoices)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<payment_model.BranchPaymentModel>> getUnsyncedPayments() async {
    return (_database.select(_database.branchPayments)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<ReturnOrderModel>> getUnsyncedReturnOrders() async {
    return (_database.select(_database.returnOrders)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  Future<List<ReturnOrderItemModel>> getUnsyncedReturnOrderItems() async {
    return (_database.select(_database.returnOrderItems)
          ..where((tbl) => tbl.isSynced.equals(0)))
        .get()
        .then((rows) => rows.map((e) => e.toModel()).toList());
  }

  // --- Mark As Synced Helpers ---
  Future<int> markSaleOrderAsSynced(String id) {
    return (_database.update(
      _database.saleOrders,
    )..where((tbl) => tbl.id.equals(id))).write(
      db.SaleOrdersCompanion(
        isSynced: const Value(1),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> markSaleOrderItemAsSynced(String id) {
    return (_database.update(
      _database.saleOrderItems,
    )..where((tbl) => tbl.id.equals(id))).write(
      db.SaleOrderItemsCompanion(
        isSynced: const Value(1),
        lastSyncedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> markInvoiceAsSynced(String id) {
    return (_database.update(_database.invoices)
          ..where((tbl) => tbl.id.equals(id)))
        .write(db.InvoicesCompanion(isSynced: const Value(1)));
  }

  Future<int> markPaymentAsSynced(String id) {
    return (_database.update(_database.branchPayments)
          ..where((tbl) => tbl.id.equals(id)))
        .write(db.BranchPaymentsCompanion(isSynced: const Value(1)));
  }

  Future<int> markReturnOrderAsSynced(String id) {
    return (_database.update(_database.returnOrders)
          ..where((tbl) => tbl.id.equals(id)))
        .write(db.ReturnOrdersCompanion(isSynced: const Value(1)));
  }

  Future<int> markReturnOrderItemAsSynced(String id) {
    return (_database.update(_database.returnOrderItems)
          ..where((tbl) => tbl.id.equals(id)))
        .write(db.ReturnOrderItemsCompanion(isSynced: const Value(1)));
  }

  //gettaxes
  Future<List<TaxModel>> getTaxes() => _database
      .select(_database.taxes)
      .get()
      .then((rows) => rows.map((e) => e.toModel()).toList());

  Future<int> addTax(db.TaxesCompanion tax) =>
      _database.into(_database.taxes).insert(tax);

  Future<bool> updateTax(String id, db.TaxesCompanion tax) async {
    return await (_database.update(
          _database.taxes,
        )..where((tbl) => tbl.id.equals(id))).write(tax) >
        0;
  }

  Future<int> deleteTax(String id) async {
    return (_database.delete(
      _database.taxes,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  // Complex Queries (Preserved)
  Future<StockReportSummary> generateMonthlyStockReport({
    required int month,
    required int year,
    required String createdBy,
  }) async {
    final storeId = 'main-store';
    final storeName = 'Main Store';

    final productStocks = await _database
        .customSelect(
          '''
      SELECT 
        i.id, i.name, i.sku, i.quantity, i.retail_price,
        COALESCE(sales.qty_sold, 0) as quantity_sold,
        COALESCE(sales.total_amt, 0.0) as total_sales
      FROM inventory_items i
      LEFT JOIN (
        SELECT 
          soi.product_id, 
          SUM(soi.quantity) as qty_sold, 
          SUM(soi.total_price) as total_amt
        FROM sale_order_items soi
        JOIN sale_orders so ON soi.sale_order_id = so.id
        WHERE strftime('%m', datetime(so.created_at, 'unixepoch')) = ? 
          AND strftime('%Y', datetime(so.created_at, 'unixepoch')) = ?
        GROUP BY soi.product_id
      ) sales ON i.id = sales.product_id
      ''',
          variables: [
            Variable<String>(month.toString().padLeft(2, '0')),
            Variable<String>(year.toString()),
          ],
        )
        .get()
        .then(
          (rows) => rows
              .map(
                (row) => ProductStock(
                  id: row.read<String>('id'),
                  name: row.read<String>('name'),
                  sku: row.read<String>('sku'),
                  quantity: row.read<int>('quantity'),
                  retailPrice: row.read<double>('retail_price'),
                  quantitySold: row.read<int>('quantity_sold'),
                  totalSales: row.read<double>('total_sales'),
                ),
              )
              .toList(),
        );

    final categoryStocks = await _database
        .customSelect('''
      SELECT 
        c.id as category_id,
        c.name as category_name,
        SUM(i.quantity) as total_quantity,
        SUM(i.quantity * i.retail_price) as total_value
      FROM inventory_items i
      JOIN product_categories c ON i.category_id = c.id
      GROUP BY c.id, c.name
      ''')
        .get()
        .then(
          (rows) => rows
              .map(
                (row) => CategoryStock(
                  categoryId: row.read<String>('category_id'),
                  categoryName: row.read<String>('category_name'),
                  totalQuantity: row.read<int>('total_quantity'),
                  totalValue: row.read<double>('total_value'),
                ),
              )
              .toList(),
        );

    final reportId = const Uuid().v4();
    final now = DateTime.now();

    final companion = db.StockReportsCompanion(
      id: Value(reportId),
      branchId: Value(storeId),
      branchName: Value(storeName),
      currentStock: Value(
        jsonEncode(productStocks.map((x) => x.toMap()).toList()),
      ),
      categoryStock: Value(
        jsonEncode(categoryStocks.map((x) => x.toMap()).toList()),
      ),
      createdAt: Value(now),
      createdBy: Value(createdBy),
      updatedAt: Value(now),
    );

    await _database.into(_database.stockReports).insert(companion);

    return StockReportSummary(
      id: reportId,
      branchId: storeId,
      branchName: storeName,
      createdAt: now,
      createdBy: createdBy,
      currentStock: productStocks,
      categoryStock: categoryStocks,
    );
  }
}
