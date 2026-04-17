import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

// Core/Admin Tables
class Branches extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get storeId => text()();
  TextColumn get storeName => text()();
  TextColumn get branchName => text()();
  TextColumn get branchAddress => text().nullable()();
  TextColumn get contact => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  IntColumn get isDeleted => integer().withDefault(const Constant(0))();
  TextColumn get companyDetails => text()();
  TextColumn get branchManagerName => text().nullable()();
  TextColumn get branchManagerId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Stores extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get address => text()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Employees
class Employees extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get middleName => text().nullable()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get role => text()();
  TextColumn get department => text()();
  TextColumn get branchId => text().nullable()();
  TextColumn get branchName => text().nullable()();
  TextColumn get managerId => text().nullable()();
  TextColumn get managerName => text().nullable()();
  TextColumn get designation => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  DateTimeColumn get hireDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Customers
class Customers extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get segment => text()();
  IntColumn get ordersCount => integer().withDefault(const Constant(0))();
  RealColumn get lifetimeValue => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastOrderDate => dateTime()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Tax & Suppliers
class Taxes extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  RealColumn get valuePercentage => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class Suppliers extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get supplierCode => text().nullable()();
  TextColumn get contactName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get isActive => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Inventory & Products
class ProductBrands extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductCategories extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductSubCategories extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get categoryId => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get sku => text()();
  TextColumn get category => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get subCategory => text().nullable()();
  TextColumn get size => text().nullable()();
  TextColumn get thickness => text().nullable()();
  TextColumn get material => text().nullable()();
  TextColumn get density => text().nullable()();
  TextColumn get brand => text().nullable()();
  TextColumn get brandId => text().nullable()();
  TextColumn get supplier => text().nullable()();
  TextColumn get supplierId => text().nullable()();
  RealColumn get retailPrice => real()();
  RealColumn get discountPrice => real().nullable()();
  RealColumn get discountPercentage => real().nullable()();
  IntColumn get quantity => integer()();
  TextColumn get unit => text().nullable()();
  TextColumn get branchId => text().nullable()();
  IntColumn get isAvailable => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Sales & Orders
class SaleOrders extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get orderNumber => text()();
  TextColumn get customerName => text().nullable()();
  TextColumn get channel => text().nullable()();
  TextColumn get branchId => text().nullable()();
  TextColumn get branchName => text().nullable()();
  IntColumn get totalQuantity => integer()();
  RealColumn get totalAmount => real()();
  RealColumn get discountAmount => real().withDefault(const Constant(0.0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  TextColumn get status => text()();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  TextColumn get createdBy => text()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Separate Sale Order Items table
class SaleOrderItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get saleOrderId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get productName => text()();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get totalPrice => real()();
  RealColumn get discountAmount => real().withDefault(const Constant(0.0))();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Receipts
class Receipts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text()();
  TextColumn get createdByName => text()();
  TextColumn get branchId => text()();
  TextColumn get branchName => text()();
  RealColumn get totalAmount => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// Proforma
class Proformas extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get partyName => text().nullable()();
  TextColumn get partyAddress => text().nullable()();
  TextColumn get tax => text()(); // JSON array of TaxComponent
  IntColumn get totalQuantity => integer()();
  TextColumn get declaration => text().nullable()();
  RealColumn get totalAmount => real()();
  IntColumn get isDeleted => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// WayBills
class WayBills extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get mainContent => text()(); // JSON serialized Profoma
  TextColumn get orderNumber => text()();
  TextColumn get dispatchDocNumber => text()();
  TextColumn get deliveryNote => text()();
  TextColumn get senderName => text()();
  TextColumn get destination => text()();
  TextColumn get partyName => text()();
  TextColumn get createdBy => text()();
  IntColumn get isDeleted => integer().withDefault(const Constant(0))();
  DateTimeColumn get dispatchDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Product Details - shared between Proforma and WayBill
class ProductDetailsList extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get productId => text()();
  TextColumn get proformaId => text().nullable()();
  TextColumn get waybillId => text().nullable()();
  TextColumn get productName => text()();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get discountPercentage => real()();
  RealColumn get totalAmount => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// Invoices
class Invoices extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get customerName => text().nullable()();
  RealColumn get totalAmount => real()();
  RealColumn get paidAmount => real()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get note => text().nullable()();
  TextColumn get saleOrderId => text()();
  TextColumn get branchName => text().nullable()();
  TextColumn get branchId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Return Orders & Credit Notes
class ReturnOrders extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get returnOrderNumber => text()();
  TextColumn get saleOrderId => text()();
  TextColumn get invoiceId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get branchId => text().nullable()();
  TextColumn get branchName => text().nullable()();
  IntColumn get totalItems => integer()();
  RealColumn get totalAmount => real()();
  RealColumn get refundAmount => real()();
  RealColumn get totalTax => real().withDefault(const Constant(0.0))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  TextColumn get createdBy => text()();
  DateTimeColumn get returnDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Separate Return Order Items table
class ReturnOrderItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get returnOrderId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get productName => text()();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get totalPrice => real()();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  TextColumn get reason => text().nullable()();
  RealColumn get refundAmount => real()();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CreditNotes extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get creditNoteNumber => text()();
  TextColumn get invoiceId => text().nullable()();
  TextColumn get returnOrderId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get branchId => text().nullable()();
  TextColumn get branchName => text().nullable()();
  IntColumn get totalItems => integer()();
  RealColumn get totalAmount => real()();
  RealColumn get appliedAmount => real().withDefault(const Constant(0.0))();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get note => text().nullable()();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  TextColumn get createdBy => text()();
  DateTimeColumn get issuedAt => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Separate Credit Note Items table
class CreditNoteItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get creditNoteId => text()();
  TextColumn get productId => text().nullable()();
  TextColumn get description => text()();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get totalPrice => real()();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  IntColumn get isSynced => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Stock Reports
class StockReports extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get branchId => text()();
  TextColumn get branchName => text()();
  TextColumn get currentStock => text()(); // JSON array of ProductStock
  TextColumn get categoryStock => text()(); // JSON array of CategoryStock
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// Expenses & Payments
class Expenses extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get expenseType => text()();
  TextColumn get description => text().nullable()();
  RealColumn get amount => real()();
  TextColumn get paymentMethod => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get branchId => text()();
  TextColumn get branchName => text()();
  DateTimeColumn get expenseDate => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BranchPayments extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get branchId => text()();
  TextColumn get branchName => text()();
  RealColumn get amount => real()();
  TextColumn get note => text().nullable()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Branches,
    Stores,
    Employees,
    Customers,
    Taxes,
    Suppliers,
    ProductBrands,
    ProductCategories,
    ProductSubCategories,
    InventoryItems,
    SaleOrders,
    SaleOrderItems,
    Receipts,
    Proformas,
    ProductDetailsList,
    WayBills,
    Invoices,
    ReturnOrders,
    ReturnOrderItems,
    CreditNotes,
    CreditNoteItems,
    StockReports,
    Expenses,
    BranchPayments,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          // Trigger for Sale Orders
          await customStatement('''
            CREATE TRIGGER IF NOT EXISTS update_stock_after_sale
            AFTER INSERT ON sale_order_items
            BEGIN
              UPDATE inventory_items
              SET quantity = quantity - NEW.quantity
              WHERE id = NEW.product_id;
            END;
          ''');

          // Trigger for Return Orders (Reverse the subtraction)
          await customStatement('''
            CREATE TRIGGER IF NOT EXISTS update_stock_after_return
            AFTER INSERT ON return_order_items
            BEGIN
              UPDATE inventory_items
              SET quantity = quantity + NEW.quantity
              WHERE id = NEW.product_id;
            END;
          ''');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ashfoam_sadiq.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}
