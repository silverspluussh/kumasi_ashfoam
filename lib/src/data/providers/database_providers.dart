import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/data/repositories/employees_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/customer.model.dart';
import 'package:ashfoam_sadiq/src/data/models/supplier.model.dart';
import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/models/receipt.model.dart';
import 'package:ashfoam_sadiq/src/data/models/return_order.model.dart';
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/employee.model.dart';
import 'package:ashfoam_sadiq/src/data/models/expenses.model.dart';
import 'package:ashfoam_sadiq/src/data/models/stock_report.model.dart';
import 'package:ashfoam_sadiq/src/data/models/payments.model.dart';
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_providers.g.dart';

@riverpod
DatabaseService databaseService(Ref ref) {
  return DatabaseService.instance;
}

@riverpod
EmployeesRepository employeesRepository(Ref ref) {
  return EmployeesRepository(supabase: Supabase.instance.client);
}

@riverpod
Future<List<InventoryModel>> inventoryItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getInventoryItems();
}

@riverpod
Future<List<SupplierModel>> suppliers(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSuppliers();
}

@riverpod
Future<List<SaleOrderModel>> saleOrders(Ref ref) async {
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
Future<List<CustomerModel>> customers(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCustomers();
}

@riverpod
Future<List<ReturnOrderModel>> returnOrders(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReturnOrders();
}

@riverpod
Future<List<ReturnOrderItemModel>> returnOrderItems(
  Ref ref,
  String returnOrderId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReturnOrderItems(returnOrderId);
}

@riverpod
Future<List<ReturnOrderItemModel>> allReturnOrderItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getAllReturnOrderItems();
}

@riverpod
Future<List<CreditNoteModel>> creditNotes(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCreditNotes();
}

@riverpod
Future<List<CreditNoteItemModel>> creditNoteItems(
  Ref ref,
  String creditNoteId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCreditNoteItems(creditNoteId);
}

@riverpod
Future<List<CreditNoteItemModel>> allCreditNoteItems(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getAllCreditNoteItems();
}

@riverpod
Future<List<InvoiceModel>> invoices(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getInvoices();
}

@riverpod
Future<List<StockReportSummary>> stockReports(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getStockReports();
}

@riverpod
Future<List<EmployeeModel>> employees(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getEmployees();
}

@riverpod
Future<List<ExpenseModel>> expenses(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getExpenses();
}

@riverpod
Future<List<BranchPaymentModel>> branchPayments(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getBranchPayments();
}

@riverpod
Future<List<ReceiptModel>> receipts(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getReceipts();
}

@riverpod
Future<List<Profoma>> proformas(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProformas();
}

@riverpod
Future<List<WayBillModel>> wayBills(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getWayBills();
}

@riverpod
Future<List<ProductDetails>> allProductDetails(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProductDetails();
}

@riverpod
Future<List<ProductDetails>> proformaDetails(Ref ref, String proformaId) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getProformaDetails(proformaId);
}

@riverpod
Future<List<ProductDetails>> wayBillDetails(Ref ref, String wayBillId) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getWayBillDetails(wayBillId);
}

@riverpod
Future<List<Brand>> brands(Ref ref) async {
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

@riverpod
Future<CompanyModel?> companySettings(Ref ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getCompanySettings();
}
