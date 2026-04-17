import 'dart:convert';
import 'package:ashfoam_sadiq/src/data/local/app_database.dart';

import 'package:ashfoam_sadiq/src/data/models/stock_report.model.dart';
import 'package:drift/drift.dart' show Value, Variable;
import 'package:uuid/uuid.dart';

class DatabaseService {
  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService._internal();

  final AppDatabase _database = AppDatabase();

  AppDatabase get db => _database;

  Future<List<InventoryItem>> getInventoryItems() =>
      _database.select(_database.inventoryItems).get();

  Future<int> addInventoryItem(InventoryItemsCompanion item) =>
      _database.into(_database.inventoryItems).insert(item);

  Future<bool> updateInventoryItem(InventoryItem item) =>
      _database.update(_database.inventoryItems).replace(item);

  Future<int> deleteInventoryItem(String id) async {
    return (_database.delete(
      _database.inventoryItems,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<Supplier>> getSuppliers() =>
      _database.select(_database.suppliers).get();

  Future<int> addSupplier(SuppliersCompanion supplier) =>
      _database.into(_database.suppliers).insert(supplier);

  Future<int> addInvoice(InvoicesCompanion invoice) =>
      _database.into(_database.invoices).insert(invoice);

  Future<bool> updateInvoiceStatus(String id, String status) async {
    return await (_database.update(_database.invoices)
          ..where((tbl) => tbl.id.equals(id)))
        .write(InvoicesCompanion(status: Value(status))) >
        0;
  }

  Future<List<Invoice>> getInvoices() =>
      _database.select(_database.invoices).get();

  Future<List<SaleOrder>> getSalesOrders() =>
      _database.select(_database.saleOrders).get();

  Future<int> addSalesOrder(SaleOrdersCompanion order) =>
      _database.into(_database.saleOrders).insert(order);

  Future<List<SaleOrderItem>> getSaleOrderItems(String saleOrderId) async {
    return (_database.select(
      _database.saleOrderItems,
    )..where((tbl) => tbl.saleOrderId.equals(saleOrderId))).get();
  }

  Future<List<SaleOrderItem>> getAllSaleOrderItems() =>
      _database.select(_database.saleOrderItems).get();

  Future<int> addSaleOrderItem(SaleOrderItemsCompanion item) =>
      _database.into(_database.saleOrderItems).insert(item);

  Future<int> addSaleOrderItems(List<SaleOrderItemsCompanion> items) async {
    var totalCount = 0;
    for (final item in items) {
      final count = await addSaleOrderItem(item);
      totalCount += count;
    }
    return totalCount;
  }

  Future<bool> updateSaleOrderItem(SaleOrderItem item) =>
      _database.update(_database.saleOrderItems).replace(item);

  Future<int> deleteSaleOrderItem(String itemId) => (_database.delete(
    _database.saleOrderItems,
  )..where((tbl) => tbl.id.equals(itemId))).go();

  Future<int> deleteSaleOrderItemsByOrder(String saleOrderId) =>
      (_database.delete(
        _database.saleOrderItems,
      )..where((tbl) => tbl.saleOrderId.equals(saleOrderId))).go();

  Future<List<Customer>> getCustomers() =>
      _database.select(_database.customers).get();

  Future<int> addCustomer(CustomersCompanion customer) =>
      _database.into(_database.customers).insert(customer);

  Future<List<ReturnOrder>> getReturnOrders() =>
      _database.select(_database.returnOrders).get();

  Future<int> addReturnOrder(ReturnOrdersCompanion order) =>
      _database.into(_database.returnOrders).insert(order);

  Future<List<ReturnOrderItem>> getReturnOrderItems(
    String returnOrderId,
  ) async {
    return (_database.select(
      _database.returnOrderItems,
    )..where((tbl) => tbl.returnOrderId.equals(returnOrderId))).get();
  }

  Future<List<ReturnOrderItem>> getAllReturnOrderItems() =>
      _database.select(_database.returnOrderItems).get();

  Future<int> addReturnOrderItem(ReturnOrderItemsCompanion item) =>
      _database.into(_database.returnOrderItems).insert(item);

  Future<int> addReturnOrderItems(List<ReturnOrderItemsCompanion> items) async {
    var totalCount = 0;
    for (final item in items) {
      final count = await addReturnOrderItem(item);
      totalCount += count;
    }
    return totalCount;
  }

  Future<bool> updateReturnOrderItem(ReturnOrderItem item) =>
      _database.update(_database.returnOrderItems).replace(item);

  Future<int> deleteReturnOrderItem(String itemId) => (_database.delete(
    _database.returnOrderItems,
  )..where((tbl) => tbl.id.equals(itemId))).go();

  Future<int> deleteReturnOrderItems(String returnOrderId) => (_database.delete(
    _database.returnOrderItems,
  )..where((tbl) => tbl.returnOrderId.equals(returnOrderId))).go();

  Future<List<CreditNote>> getCreditNotes() =>
      _database.select(_database.creditNotes).get();

  Future<int> addCreditNote(CreditNotesCompanion note) =>
      _database.into(_database.creditNotes).insert(note);

  Future<List<CreditNoteItem>> getCreditNoteItems(String creditNoteId) async {
    return (_database.select(
      _database.creditNoteItems,
    )..where((tbl) => tbl.creditNoteId.equals(creditNoteId))).get();
  }

  Future<List<CreditNoteItem>> getAllCreditNoteItems() =>
      _database.select(_database.creditNoteItems).get();

  Future<int> addCreditNoteItem(CreditNoteItemsCompanion item) =>
      _database.into(_database.creditNoteItems).insert(item);

  Future<int> addCreditNoteItems(List<CreditNoteItemsCompanion> items) async {
    var totalCount = 0;
    for (final item in items) {
      final count = await addCreditNoteItem(item);
      totalCount += count;
    }
    return totalCount;
  }

  Future<bool> updateCreditNoteItem(CreditNoteItem item) =>
      _database.update(_database.creditNoteItems).replace(item);

  Future<int> deleteCreditNoteItem(String itemId) => (_database.delete(
    _database.creditNoteItems,
  )..where((tbl) => tbl.id.equals(itemId))).go();

  Future<int> deleteCreditNoteItems(String creditNoteId) => (_database.delete(
    _database.creditNoteItems,
  )..where((tbl) => tbl.creditNoteId.equals(creditNoteId))).go();

  Future<List<StockReport>> getStockReports() =>
      _database.select(_database.stockReports).get();

  Future<int> addStockReport(StockReportsCompanion report) =>
      _database.into(_database.stockReports).insert(report);

  Future<int> deleteStockReport(String id) async {
    return (_database.delete(
      _database.stockReports,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateBranch(String id, BranchesCompanion companion) async {
    return await (_database.update(_database.branches)
          ..where((tbl) => tbl.id.equals(id)))
        .write(companion) >
        0;
  }

  Future<List<Employee>> getEmployees() =>
      _database.select(_database.employees).get();

  Future<int> addEmployee(EmployeesCompanion employee) =>
      _database.into(_database.employees).insert(employee);

  Future<List<Expense>> getExpenses() =>
      _database.select(_database.expenses).get();

  Future<int> addExpense(ExpensesCompanion expense) =>
      _database.into(_database.expenses).insert(expense);

  Future<List<BranchPayment>> getBranchPayments() =>
      _database.select(_database.branchPayments).get();

  Future<int> addBranchPayment(BranchPaymentsCompanion payment) =>
      _database.into(_database.branchPayments).insert(payment);

  Future<List<Receipt>> getReceipts() =>
      _database.select(_database.receipts).get();

  Future<int> addReceipt(ReceiptsCompanion receipt) =>
      _database.into(_database.receipts).insert(receipt);

  Future<List<Proforma>> getProformas() =>
      _database.select(_database.proformas).get();

  Future<int> addProforma(ProformasCompanion proforma) =>
      _database.into(_database.proformas).insert(proforma);

  Future<List<WayBill>> getWayBills() =>
      _database.select(_database.wayBills).get();

  Future<int> addWayBill(WayBillsCompanion wayBill) =>
      _database.into(_database.wayBills).insert(wayBill);

  Future<List<ProductDetailsListData>> getProductDetails() =>
      _database.select(_database.productDetailsList).get();

  Future<List<ProductDetailsListData>> getProformaDetails(
    String proformaId,
  ) async {
    return (_database.select(
      _database.productDetailsList,
    )..where((tbl) => tbl.proformaId.equals(proformaId))).get();
  }

  Future<List<ProductDetailsListData>> getWayBillDetails(
    String wayBillId,
  ) async {
    return (_database.select(
      _database.productDetailsList,
    )..where((tbl) => tbl.waybillId.equals(wayBillId))).get();
  }

  Future<int> addProductDetails(ProductDetailsListCompanion details) =>
      _database.into(_database.productDetailsList).insert(details);

  Future<int> addProductDetailsList(
    List<ProductDetailsListCompanion> detailsList,
  ) async {
    var totalCount = 0;
    for (final details in detailsList) {
      final count = await addProductDetails(details);
      totalCount += count;
    }
    return totalCount;
  }

  Future<bool> updateProductDetails(ProductDetailsListData details) =>
      _database.update(_database.productDetailsList).replace(details);

  Future<int> deleteProductDetails(String detailsId) => (_database.delete(
    _database.productDetailsList,
  )..where((tbl) => tbl.id.equals(detailsId))).go();

  Future<int> deleteProformaDetails(String proformaId) => (_database.delete(
    _database.productDetailsList,
  )..where((tbl) => tbl.proformaId.equals(proformaId))).go();

  Future<int> deleteWayBillDetails(String wayBillId) => (_database.delete(
    _database.productDetailsList,
  )..where((tbl) => tbl.waybillId.equals(wayBillId))).go();

  // Product Brands
  Future<List<ProductBrand>> getBrands() =>
      _database.select(_database.productBrands).get();

  Future<int> addBrand(ProductBrandsCompanion brand) =>
      _database.into(_database.productBrands).insert(brand);

  // Product Categories
  Future<List<ProductCategory>> getCategories() =>
      _database.select(_database.productCategories).get();

  Future<int> addCategory(ProductCategoriesCompanion category) =>
      _database.into(_database.productCategories).insert(category);

  // Product Sub Categories
  Future<List<ProductSubCategory>> getSubCategories() =>
      _database.select(_database.productSubCategories).get();

  Future<int> addSubCategory(ProductSubCategoriesCompanion subCategory) =>
      _database.into(_database.productSubCategories).insert(subCategory);

  Future<List<SaleOrder>> getUnsyncedSaleOrders() async {
    return (_database.select(
      _database.saleOrders,
    )..where((tbl) => tbl.isSynced.equals(0))).get();
  }

  /// Get all unsynced sale order items (isSynced = 0)
  Future<List<SaleOrderItem>> getUnsyncedSaleOrderItems() async {
    return (_database.select(
      _database.saleOrderItems,
    )..where((tbl) => tbl.isSynced.equals(0))).get();
  }

  Future<List<ReturnOrder>> getUnsyncedReturnOrders() async {
    return (_database.select(
      _database.returnOrders,
    )..where((tbl) => tbl.isSynced.equals(0))).get();
  }

  Future<List<ReturnOrderItem>> getUnsyncedReturnOrderItems() async {
    return (_database.select(
      _database.returnOrderItems,
    )..where((tbl) => tbl.isSynced.equals(0))).get();
  }

  Future<void> markSaleOrderAsSynced(String orderId) async {
    final rows = await (_database.select(
      _database.saleOrders,
    )..where((tbl) => tbl.id.equals(orderId))).get();

    if (rows.isNotEmpty) {
      final order = rows.first;
      await _database
          .update(_database.saleOrders)
          .replace(
            order.copyWith(isSynced: 1, lastSyncedAt: Value(DateTime.now())),
          );
    }
  }

  /// Mark a sale order item as synced
  Future<void> markSaleOrderItemAsSynced(String itemId) async {
    final rows = await (_database.select(
      _database.saleOrderItems,
    )..where((tbl) => tbl.id.equals(itemId))).get();

    if (rows.isNotEmpty) {
      final item = rows.first;
      await _database
          .update(_database.saleOrderItems)
          .replace(
            item.copyWith(isSynced: 1, lastSyncedAt: Value(DateTime.now())),
          );
    }
  }

  /// Mark a return order as synced
  Future<void> markReturnOrderAsSynced(String orderId) async {
    final rows = await (_database.select(
      _database.returnOrders,
    )..where((tbl) => tbl.id.equals(orderId))).get();

    if (rows.isNotEmpty) {
      final order = rows.first;
      await _database
          .update(_database.returnOrders)
          .replace(
            order.copyWith(isSynced: 1, lastSyncedAt: Value(DateTime.now())),
          );
    }
  }

  /// Mark a return order item as synced
  Future<void> markReturnOrderItemAsSynced(String itemId) async {
    final rows = await (_database.select(
      _database.returnOrderItems,
    )..where((tbl) => tbl.id.equals(itemId))).get();

    if (rows.isNotEmpty) {
      final item = rows.first;
      await _database
          .update(_database.returnOrderItems)
          .replace(item.copyWith(isSynced: 1));
    }
  }

  /// Mark multiple sale orders as synced
  Future<void> markSaleOrdersAsSynced(List<String> orderIds) async {
    for (final id in orderIds) {
      await markSaleOrderAsSynced(id);
    }
  }

  /// Mark multiple sale order items as synced
  Future<void> markSaleOrderItemsAsSynced(List<String> itemIds) async {
    for (final id in itemIds) {
      await markSaleOrderItemAsSynced(id);
    }
  }

  /// Mark multiple return orders as synced
  Future<void> markReturnOrdersAsSynced(List<String> orderIds) async {
    for (final id in orderIds) {
      await markReturnOrderAsSynced(id);
    }
  }

  /// Mark multiple return order items as synced
  Future<void> markReturnOrderItemsAsSynced(List<String> itemIds) async {
    for (final id in itemIds) {
      await markReturnOrderItemAsSynced(id);
    }
  }

  Future<List<Branche>> getBranches() async =>
      _database.select(_database.branches).get();

  Future<List<Taxe>> getTaxes() async =>
      _database.select(_database.taxes).get();

  Future<int> addTax(TaxesCompanion tax) =>
      _database.into(_database.taxes).insert(tax);

  Future<bool> updateTax(String id, TaxesCompanion tax) =>
      (_database.update(_database.taxes)..where((t) => t.id.equals(id)))
          .write(tax)
          .then((v) => v > 0);

  Future<int> deleteTax(String id) =>
      (_database.delete(_database.taxes)..where((t) => t.id.equals(id))).go();

  /// Create a POS order with its items in a transaction
  Future<void> createPOSOrder(
    SaleOrdersCompanion order,
    List<SaleOrderItemsCompanion> items,
  ) async {
    await _database.transaction(() async {
      await _database.into(_database.saleOrders).insert(order);
      for (final item in items) {
        await _database.into(_database.saleOrderItems).insert(item);
      }
    });
  }

  /// Create a Waybill with its items in a transaction
  Future<void> createWaybill(
    WayBillsCompanion waybill,
    List<ProductDetailsListCompanion> items,
  ) async {
    await _database.transaction(() async {
      await _database.into(_database.wayBills).insert(waybill);
      for (final item in items) {
        await _database.into(_database.productDetailsList).insert(item);
      }
    });
  }

  /// Generate a monthly stock report for the local database
  Future<StockReportSummary> generateMonthlyStockReport({
    required int month,
    required int year,
    required String createdBy,
  }) async {
    // 1. Get the first branch's info for metadata
    final branchRow = await _database.select(_database.branches).getSingleOrNull();
    final branchId = branchRow?.id ?? 'main-branch';
    final branchName = branchRow?.branchName ?? 'Main Branch';

    // 2. Fetch Product Stock details
    // SQLite stores DateTime as unix timestamps by default in Drift.
    // We use datetime(col, 'unixepoch') to format them for strftime.
    final productStocks = await _database.customSelect(
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
    ).get().then((rows) => rows.map((row) => ProductStock(
          id: row.read<String>('id'),
          name: row.read<String>('name'),
          sku: row.read<String>('sku'),
          quantity: row.read<int>('quantity'),
          retailPrice: row.read<double>('retail_price'),
          quantitySold: row.read<int>('quantity_sold'),
          totalSales: row.read<double>('total_sales'),
        )).toList());

    // 3. Fetch Category Stock summaries
    final categoryStocks = await _database.customSelect(
      '''
      SELECT 
        c.id as category_id,
        c.name as category_name,
        SUM(i.quantity) as total_quantity,
        SUM(i.quantity * i.retail_price) as total_value
      FROM inventory_items i
      JOIN product_categories c ON i.category_id = c.id
      GROUP BY c.id, c.name
      ''',
      variables: [],
    ).get().then((rows) => rows.map((row) => CategoryStock(
          categoryId: row.read<String>('category_id'),
          categoryName: row.read<String>('category_name'),
          totalQuantity: row.read<int>('total_quantity'),
          totalValue: row.read<double>('total_value'),
        )).toList());

    // 4. Create the report entry
    final reportId = const Uuid().v4();
    final now = DateTime.now();

    final companion = StockReportsCompanion(
      id: Value(reportId),
      branchId: Value(branchId),
      branchName: Value(branchName),
      currentStock: Value(jsonEncode(productStocks.map((x) => x.toMap()).toList())),
      categoryStock: Value(jsonEncode(categoryStocks.map((x) => x.toMap()).toList())),
      createdAt: Value(now),
      createdBy: Value(createdBy),
      updatedAt: Value(now),
    );

    await _database.into(_database.stockReports).insert(companion);

    return StockReportSummary(
      id: reportId,
      branchId: branchId,
      branchName: branchName,
      createdAt: now,
      createdBy: createdBy,
      currentStock: productStocks,
      categoryStock: categoryStocks,
    );
  }
}
