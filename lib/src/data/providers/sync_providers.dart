import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/data/local/drift_extensions.dart';
import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';
import 'package:ashfoam_sadiq/src/data/repositories/branch_payments_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/branches_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/credit_notes_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/customers_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/employees_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/expenses_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/invoices_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/product_brands_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/product_categories_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/product_subcategories_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/products_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/proformas_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/receipts_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/return_orders_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/sales_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/stock_reports_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/stores_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/suppliers_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/taxes_repository.dart';
import 'package:ashfoam_sadiq/src/data/repositories/waybills_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_providers.g.dart';

/// Sync result model to track sync operations
class SyncResult {
  final String entityType;
  final bool success;
  final int itemsSynced;
  final String? error;
  final DateTime syncedAt;

  SyncResult({
    required this.entityType,
    required this.success,
    required this.itemsSynced,
    this.error,
    required this.syncedAt,
  });

  @override
  String toString() =>
      'SyncResult(entityType: $entityType, success: $success, itemsSynced: $itemsSynced, error: $error, syncedAt: $syncedAt)';
}

/// Overall sync status model
class OverallSyncStatus {
  final bool allSuccess;
  final int totalItemsSynced;
  final List<SyncResult> results;
  final DateTime completedAt;
  final Duration duration;

  OverallSyncStatus({
    required this.allSuccess,
    required this.totalItemsSynced,
    required this.results,
    required this.completedAt,
    required this.duration,
  });

  @override
  String toString() =>
      'OverallSyncStatus(allSuccess: $allSuccess, totalItemsSynced: $totalItemsSynced, results: ${results.length} items, duration: $duration)';
}

// ============================================================================
// API CLIENT PROVIDER
// ============================================================================

@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

@riverpod
DatabaseService databaseService(Ref ref) {
  return DatabaseService.instance;
}

// ============================================================================
// REPOSITORY PROVIDERS
// ============================================================================

@riverpod
SalesRepository salesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SalesRepository(apiClient: apiClient);
}

@riverpod
ReturnOrdersRepository returnOrdersRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReturnOrdersRepository(apiClient: apiClient);
}

@riverpod
CreditNotesRepository creditNotesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CreditNotesRepository(apiClient: apiClient);
}

@riverpod
InvoicesRepository invoicesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return InvoicesRepository(apiClient: apiClient);
}

@riverpod
ProductsRepository productsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductsRepository(apiClient: apiClient);
}

@riverpod
ProformasRepository proformasRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProformasRepository(apiClient: apiClient);
}

@riverpod
WayBillsRepository wayBillsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return WayBillsRepository(apiClient: apiClient);
}

@riverpod
CustomersRepository customersRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CustomersRepository(apiClient: apiClient);
}

@riverpod
SuppliersRepository suppliersRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return SuppliersRepository(apiClient: apiClient);
}

@riverpod
EmployeesRepository employeesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EmployeesRepository(apiClient: apiClient);
}

@riverpod
ExpensesRepository expensesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ExpensesRepository(apiClient: apiClient);
}

@riverpod
StockReportsRepository stockReportsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return StockReportsRepository(apiClient: apiClient);
}

@riverpod
BranchPaymentsRepository branchPaymentsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BranchPaymentsRepository(apiClient: apiClient);
}

@riverpod
ReceiptsRepository receiptsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReceiptsRepository(apiClient: apiClient);
}

@riverpod
BranchesRepository branchesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BranchesRepository(apiClient: apiClient);
}

@riverpod
StoresRepository storesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return StoresRepository(apiClient: apiClient);
}

@riverpod
ProductBrandsRepository productBrandsRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductBrandsRepository(apiClient: apiClient);
}

@riverpod
ProductCategoriesRepository productCategoriesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductCategoriesRepository(apiClient: apiClient);
}

@riverpod
ProductSubCategoriesRepository productSubCategoriesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProductSubCategoriesRepository(apiClient: apiClient);
}

@riverpod
TaxesRepository taxesRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaxesRepository(apiClient: apiClient);
}

// ============================================================================
// INDIVIDUAL SYNC PROVIDERS - TRANSACTION DOCUMENTS
// ============================================================================

/// Sync sales orders from remote to local
@riverpod
Future<SyncResult> syncSalesOrders(Ref ref) async {
  try {
    final repository = ref.watch(salesRepositoryProvider);
    final data = await repository.syncSalesOrders();
    
    return SyncResult(
      entityType: 'Sales Orders',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Sales Orders',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync return orders from remote to local
@riverpod
Future<SyncResult> syncReturnOrders(Ref ref) async {
  try {
    final repository = ref.watch(returnOrdersRepositoryProvider);
    final data = await repository.syncReturnOrders();
    
    return SyncResult(
      entityType: 'Return Orders',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Return Orders',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync credit notes from remote to local
@riverpod
Future<SyncResult> syncCreditNotes(Ref ref) async {
  try {
    final repository = ref.watch(creditNotesRepositoryProvider);
    final data = await repository.syncCreditNotes();
    
    return SyncResult(
      entityType: 'Credit Notes',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Credit Notes',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync invoices from remote to local
@riverpod
Future<SyncResult> syncInvoices(Ref ref) async {
  try {
    final repository = ref.watch(invoicesRepositoryProvider);
    final data = await repository.syncInvoices();
    
    return SyncResult(
      entityType: 'Invoices',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Invoices',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync proformas from remote to local
@riverpod
Future<SyncResult> syncProformas(Ref ref) async {
  try {
    final repository = ref.watch(proformasRepositoryProvider);
    final data = await repository.syncProformas();
    
    return SyncResult(
      entityType: 'Proformas',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Proformas',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync way bills from remote to local
@riverpod
Future<SyncResult> syncWayBills(Ref ref) async {
  try {
    final repository = ref.watch(wayBillsRepositoryProvider);
    final data = await repository.syncWayBills();
    
    return SyncResult(
      entityType: 'Way Bills',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Way Bills',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync receipts from remote to local
@riverpod
Future<SyncResult> syncReceipts(Ref ref) async {
  try {
    final repository = ref.watch(receiptsRepositoryProvider);
    final data = await repository.syncReceipts();
    
    return SyncResult(
      entityType: 'Receipts',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Receipts',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

// ============================================================================
// INDIVIDUAL SYNC PROVIDERS - REFERENCE DATA
// ============================================================================

/// Sync inventory/products from remote to local
@riverpod
Future<SyncResult> syncInventory(Ref ref) async {
  try {
    final repository = ref.watch(productsRepositoryProvider);
    final data = await repository.syncInventory();
    
    return SyncResult(
      entityType: 'Inventory',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Inventory',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync customers from remote to local
@riverpod
Future<SyncResult> syncCustomers(Ref ref) async {
  try {
    final repository = ref.watch(customersRepositoryProvider);
    final data = await repository.syncCustomers();
    
    return SyncResult(
      entityType: 'Customers',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Customers',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync suppliers from remote to local
@riverpod
Future<SyncResult> syncSuppliers(Ref ref) async {
  try {
    final repository = ref.watch(suppliersRepositoryProvider);
    final data = await repository.syncSuppliers();
    
    return SyncResult(
      entityType: 'Suppliers',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Suppliers',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync employees from remote to local
@riverpod
Future<SyncResult> syncEmployees(Ref ref) async {
  try {
    final repository = ref.watch(employeesRepositoryProvider);
    final data = await repository.syncEmployees();
    
    return SyncResult(
      entityType: 'Employees',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Employees',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync branches from remote to local
@riverpod
Future<SyncResult> syncBranches(Ref ref) async {
  try {
    final repository = ref.watch(branchesRepositoryProvider);
    final data = await repository.syncBranches();
    
    return SyncResult(
      entityType: 'Branches',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Branches',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync stores from remote to local
@riverpod
Future<SyncResult> syncStores(Ref ref) async {
  try {
    final repository = ref.watch(storesRepositoryProvider);
    final data = await repository.syncStores();
    
    return SyncResult(
      entityType: 'Stores',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Stores',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync product brands from remote to local
@riverpod
Future<SyncResult> syncProductBrands(Ref ref) async {
  try {
    final repository = ref.watch(productBrandsRepositoryProvider);
    final data = await repository.syncBrands();
    
    return SyncResult(
      entityType: 'Product Brands',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Product Brands',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync product categories from remote to local
@riverpod
Future<SyncResult> syncProductCategories(Ref ref) async {
  try {
    final repository = ref.watch(productCategoriesRepositoryProvider);
    final data = await repository.syncCategories();
    
    return SyncResult(
      entityType: 'Product Categories',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Product Categories',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync product sub-categories from remote to local
@riverpod
Future<SyncResult> syncProductSubCategories(SyncProductSubCategoriesRef ref) async {
  try {
    final repository = ref.watch(productSubCategoriesRepositoryProvider);
    final data = await repository.syncSubCategories();
    
    return SyncResult(
      entityType: 'Product Sub-Categories',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Product Sub-Categories',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync taxes from remote to local
@riverpod
Future<SyncResult> syncTaxes(SyncTaxesRef ref) async {
  try {
    final repository = ref.watch(taxesRepositoryProvider);
    final data = await repository.syncTaxes();
    
    return SyncResult(
      entityType: 'Taxes',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Taxes',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync expenses from remote to local
@riverpod
Future<SyncResult> syncExpenses(SyncExpensesRef ref) async {
  try {
    final repository = ref.watch(expensesRepositoryProvider);
    final data = await repository.syncExpenses();
    
    return SyncResult(
      entityType: 'Expenses',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Expenses',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync stock reports from remote to local
@riverpod
Future<SyncResult> syncStockReports(SyncStockReportsRef ref) async {
  try {
    final repository = ref.watch(stockReportsRepositoryProvider);
    final data = await repository.syncStockReports();
    
    return SyncResult(
      entityType: 'Stock Reports',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Stock Reports',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Sync branch payments from remote to local
@riverpod
Future<SyncResult> syncBranchPayments(SyncBranchPaymentsRef ref) async {
  try {
    final repository = ref.watch(branchPaymentsRepositoryProvider);
    final data = await repository.syncBranchPayments();
    
    return SyncResult(
      entityType: 'Branch Payments',
      success: true,
      itemsSynced: data.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Branch Payments',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

// ============================================================================
// ALL-IN-ONE SYNC PROVIDER
// ============================================================================

/// Sync all data from remote to local database
/// This provider triggers all individual sync operations sequentially
/// and returns an overall status with all results
@riverpod
Future<OverallSyncStatus> syncAll(SyncAllRef ref) async {
  final startTime = DateTime.now();
  final results = <SyncResult>[];

  // Sync transactions
  results.add(await ref.watch(syncSalesOrdersProvider.future));
  results.add(await ref.watch(syncReturnOrdersProvider.future));
  results.add(await ref.watch(syncCreditNotesProvider.future));
  results.add(await ref.watch(syncInvoicesProvider.future));
  results.add(await ref.watch(syncProformasProvider.future));
  results.add(await ref.watch(syncWayBillsProvider.future));
  results.add(await ref.watch(syncReceiptsProvider.future));

  // Sync reference data
  results.add(await ref.watch(syncInventoryProvider.future));
  results.add(await ref.watch(syncCustomersProvider.future));
  results.add(await ref.watch(syncSuppliersProvider.future));
  results.add(await ref.watch(syncEmployeesProvider.future));
  results.add(await ref.watch(syncBranchesProvider.future));
  results.add(await ref.watch(syncStoresProvider.future));
  results.add(await ref.watch(syncProductBrandsProvider.future));
  results.add(await ref.watch(syncProductCategoriesProvider.future));
  results.add(await ref.watch(syncProductSubCategoriesProvider.future));
  results.add(await ref.watch(syncTaxesProvider.future));
  results.add(await ref.watch(syncExpensesProvider.future));
  results.add(await ref.watch(syncStockReportsProvider.future));
  results.add(await ref.watch(syncBranchPaymentsProvider.future));

  final endTime = DateTime.now();
  final allSuccess = results.every((result) => result.success);
  final totalItems = results.fold<int>(0, (sum, result) => sum + result.itemsSynced);

  return OverallSyncStatus(
    allSuccess: allSuccess,
    totalItemsSynced: totalItems,
    results: results,
    completedAt: endTime,
    duration: endTime.difference(startTime),
  );
}

// ============================================================================
// LOCAL-TO-REMOTE SYNC PROVIDERS (Push unsynced data to remote)
// ============================================================================

/// Push unsynced sales orders to remote
@riverpod
Future<SyncResult> pushUnsyncedSalesOrders(PushUnsyncedSalesOrdersRef ref) async {
  try {
    final databaseService = ref.watch(databaseServiceProvider);
    final repository = ref.watch(salesRepositoryProvider);

    // Fetch unsynced orders and items
    final unsyncedOrders = await databaseService.getUnsyncedSaleOrders();
    final unsyncedItems = await databaseService.getUnsyncedSaleOrderItems();

    if (unsyncedOrders.isEmpty && unsyncedItems.isEmpty) {
      return SyncResult(
        entityType: 'Sales Orders (Push)',
        success: true,
        itemsSynced: 0,
        error: null,
        syncedAt: DateTime.now(),
      );
    }

    // Convert to maps for API
    final orderMaps = unsyncedOrders.map((o) => o.toMap()).toList();
    final itemMaps = unsyncedItems.map((i) => i.toMap()).toList();

    int totalSynced = 0;

    // Push orders
    if (orderMaps.isNotEmpty) {
      await repository.pushUnsyncedSalesOrders(orderMaps);
      await databaseService.markSaleOrdersAsSynced(
        unsyncedOrders.map((o) => o.id).toList(),
      );
      totalSynced += orderMaps.length;
    }

    // Push items
    if (itemMaps.isNotEmpty) {
      await repository.pushUnsyncedSalesOrderItems(itemMaps);
      await databaseService.markSaleOrderItemsAsSynced(
        unsyncedItems.map((i) => i.id).toList(),
      );
      totalSynced += itemMaps.length;
    }

    return SyncResult(
      entityType: 'Sales Orders (Push)',
      success: true,
      itemsSynced: totalSynced,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Sales Orders (Push)',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Push unsynced return orders to remote
@riverpod
Future<SyncResult> pushUnsyncedReturnOrders(PushUnsyncedReturnOrdersRef ref) async {
  try {
    final databaseService = ref.watch(databaseServiceProvider);
    final repository = ref.watch(returnOrdersRepositoryProvider);

    // Fetch unsynced orders and items
    final unsyncedOrders = await databaseService.getUnsyncedReturnOrders();
    final unsyncedItems = await databaseService.getUnsyncedReturnOrderItems();

    if (unsyncedOrders.isEmpty && unsyncedItems.isEmpty) {
      return SyncResult(
        entityType: 'Return Orders (Push)',
        success: true,
        itemsSynced: 0,
        error: null,
        syncedAt: DateTime.now(),
      );
    }

    // Convert to maps for API
    final orderMaps = unsyncedOrders.map((o) => o.toMap()).toList();
    final itemMaps = unsyncedItems.map((i) => i.toMap()).toList();

    int totalSynced = 0;

    // Push orders
    if (orderMaps.isNotEmpty) {
      await repository.pushUnsyncedReturnOrders(orderMaps);
      await databaseService.markReturnOrdersAsSynced(
        unsyncedOrders.map((o) => o.id).toList(),
      );
      totalSynced += orderMaps.length;
    }

    // Push items
    if (itemMaps.isNotEmpty) {
      await repository.pushUnsyncedReturnOrderItems(itemMaps);
      await databaseService.markReturnOrderItemsAsSynced(
        unsyncedItems.map((i) => i.id).toList(),
      );
      totalSynced += itemMaps.length;
    }

    return SyncResult(
      entityType: 'Return Orders (Push)',
      success: true,
      itemsSynced: totalSynced,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Return Orders (Push)',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Push unsynced proformas to remote
@riverpod
Future<SyncResult> pushUnsyncedProformas(PushUnsyncedProformasRef ref) async {
  try {
    // Note: Proformas table doesn't have isSynced column, so we sync all proformas
    // This is a simplified implementation - you may want to add sync tracking to Proformas table
    final databaseService = ref.watch(databaseServiceProvider);
    final repository = ref.watch(proformasRepositoryProvider);

    // Fetch all proformas (since there's no sync tracking)
    final allProformas = await databaseService.getProformas();

    if (allProformas.isEmpty) {
      return SyncResult(
        entityType: 'Proformas (Push)',
        success: true,
        itemsSynced: 0,
        error: null,
        syncedAt: DateTime.now(),
      );
    }

    // Convert to maps for API
    final proformaMaps = allProformas.map((p) => p.toMap()).toList();

    // Push proformas
    await repository.pushUnsyncedProformas(proformaMaps);

    return SyncResult(
      entityType: 'Proformas (Push)',
      success: true,
      itemsSynced: proformaMaps.length,
      error: null,
      syncedAt: DateTime.now(),
    );
  } catch (e) {
    return SyncResult(
      entityType: 'Proformas (Push)',
      success: false,
      itemsSynced: 0,
      error: e.toString(),
      syncedAt: DateTime.now(),
    );
  }
}

/// Push all unsynced transaction documents to remote
@riverpod
Future<OverallSyncStatus> pushAllUnsynced(PushAllUnsyncedRef ref) async {
  final startTime = DateTime.now();
  final results = <SyncResult>[];

  // Push all unsynced transactions
  results.add(await ref.watch(pushUnsyncedSalesOrdersProvider.future));
  results.add(await ref.watch(pushUnsyncedReturnOrdersProvider.future));
  results.add(await ref.watch(pushUnsyncedProformasProvider.future));

  final endTime = DateTime.now();
  final allSuccess = results.every((result) => result.success);
  final totalItems = results.fold<int>(0, (sum, result) => sum + result.itemsSynced);

  return OverallSyncStatus(
    allSuccess: allSuccess,
    totalItemsSynced: totalItems,
    results: results,
    completedAt: endTime,
    duration: endTime.difference(startTime),
  );
}
