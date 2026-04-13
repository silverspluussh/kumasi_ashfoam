import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_providers.g.dart';


@riverpod
DatabaseService databaseService(DatabaseServiceRef ref) {
  return DatabaseService.instance;
}

@riverpod
Future<List<InventoryItem>> inventoryItems(InventoryItemsRef ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getInventoryItems();
}


@riverpod
Future<List<Supplier>> suppliers(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSuppliers();
}

@riverpod
Future<List<SaleOrder>> saleOrders(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSalesOrders();
}

@riverpod
Future<List<SaleOrderItem>> saleOrderItems(Ref ref, String saleOrderId) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSaleOrderItems(saleOrderId);
}

@riverpod
Future<List<SaleOrderItem>> allSaleOrderItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getAllSaleOrderItems();
}


@riverpod
Future<List<Customer>> customers(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCustomers();
}


@riverpod
Future<List<ReturnOrder>> returnOrders(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReturnOrders();
}

@riverpod
Future<List<ReturnOrderItem>> returnOrderItems(
  Ref ref,
  String returnOrderId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReturnOrderItems(returnOrderId);
}

@riverpod
Future<List<ReturnOrderItem>> allReturnOrderItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getAllReturnOrderItems();
}


@riverpod
Future<List<CreditNote>> creditNotes(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCreditNotes();
}

@riverpod
Future<List<CreditNoteItem>> creditNoteItems(
  Ref ref,
  String creditNoteId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCreditNoteItems(creditNoteId);
}

@riverpod
Future<List<CreditNoteItem>> allCreditNoteItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getAllCreditNoteItems();
}


@riverpod
Future<List<Invoice>> invoices(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getInvoices();
}


@riverpod
Future<List<StockReport>> stockReports(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getStockReports();
}


@riverpod
Future<List<Employee>> employees(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getEmployees();
}


@riverpod
Future<List<Expense>> expenses(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getExpenses();
}


@riverpod
Future<List<BranchPayment>> branchPayments(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getBranchPayments();
}


@riverpod
Future<List<Receipt>> receipts(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReceipts();
}


@riverpod
Future<List<Proforma>> proformas(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProformas();
}


@riverpod
Future<List<WayBill>> wayBills(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getWayBills();
}


@riverpod
Future<List<ProductDetailsListData>> allProductDetails(
  Ref ref,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProductDetails();
}

@riverpod
Future<List<ProductDetailsListData>> proformaDetails(
  Ref ref,
  String proformaId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProformaDetails(proformaId);
}

@riverpod
Future<List<ProductDetailsListData>> wayBillDetails(
  Ref ref,
  String wayBillId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getWayBillDetails(wayBillId);
}


@riverpod
Future<List<ProductBrand>> brands(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getBrands();
}


@riverpod
Future<List<ProductCategory>> categories(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCategories();
}


@riverpod
Future<List<ProductSubCategory>> subCategories(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSubCategories();
}
