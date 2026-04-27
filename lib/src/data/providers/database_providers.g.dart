// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(databaseService)
final databaseServiceProvider = DatabaseServiceProvider._();

final class DatabaseServiceProvider
    extends
        $FunctionalProvider<DatabaseService, DatabaseService, DatabaseService>
    with $Provider<DatabaseService> {
  DatabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'databaseServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$databaseServiceHash();

  @$internal
  @override
  $ProviderElement<DatabaseService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DatabaseService create(Ref ref) {
    return databaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DatabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DatabaseService>(value),
    );
  }
}

String _$databaseServiceHash() => r'59eee919c01b00fdf56c694367d3db2529a4e2fd';

@ProviderFor(inventoryItems)
final inventoryItemsProvider = InventoryItemsProvider._();

final class InventoryItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InventoryModel>>,
          List<InventoryModel>,
          FutureOr<List<InventoryModel>>
        >
    with
        $FutureModifier<List<InventoryModel>>,
        $FutureProvider<List<InventoryModel>> {
  InventoryItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<InventoryModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InventoryModel>> create(Ref ref) {
    return inventoryItems(ref);
  }
}

String _$inventoryItemsHash() => r'0e298c0ac755d037ae4d647bd8263480039021bf';

@ProviderFor(suppliers)
final suppliersProvider = SuppliersProvider._();

final class SuppliersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SupplierModel>>,
          List<SupplierModel>,
          FutureOr<List<SupplierModel>>
        >
    with
        $FutureModifier<List<SupplierModel>>,
        $FutureProvider<List<SupplierModel>> {
  SuppliersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'suppliersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$suppliersHash();

  @$internal
  @override
  $FutureProviderElement<List<SupplierModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SupplierModel>> create(Ref ref) {
    return suppliers(ref);
  }
}

String _$suppliersHash() => r'e407eb004c93af52b845eccc1c8b1d1864787d7f';

@ProviderFor(saleOrders)
final saleOrdersProvider = SaleOrdersProvider._();

final class SaleOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SaleOrderModel>>,
          List<SaleOrderModel>,
          FutureOr<List<SaleOrderModel>>
        >
    with
        $FutureModifier<List<SaleOrderModel>>,
        $FutureProvider<List<SaleOrderModel>> {
  SaleOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saleOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saleOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<SaleOrderModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SaleOrderModel>> create(Ref ref) {
    return saleOrders(ref);
  }
}

String _$saleOrdersHash() => r'9139ab2a7afb68cc72d1a8bab41f89da9dd971fd';

@ProviderFor(saleOrderItems)
final saleOrderItemsProvider = SaleOrderItemsFamily._();

final class SaleOrderItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SaleOrderItem>>,
          List<SaleOrderItem>,
          FutureOr<List<SaleOrderItem>>
        >
    with
        $FutureModifier<List<SaleOrderItem>>,
        $FutureProvider<List<SaleOrderItem>> {
  SaleOrderItemsProvider._({
    required SaleOrderItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'saleOrderItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$saleOrderItemsHash();

  @override
  String toString() {
    return r'saleOrderItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SaleOrderItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SaleOrderItem>> create(Ref ref) {
    final argument = this.argument as String;
    return saleOrderItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SaleOrderItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$saleOrderItemsHash() => r'40130deea2f3c5f72282e4cd46bcab508707091e';

final class SaleOrderItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SaleOrderItem>>, String> {
  SaleOrderItemsFamily._()
    : super(
        retry: null,
        name: r'saleOrderItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SaleOrderItemsProvider call(String saleOrderId) =>
      SaleOrderItemsProvider._(argument: saleOrderId, from: this);

  @override
  String toString() => r'saleOrderItemsProvider';
}

@ProviderFor(allSaleOrderItems)
final allSaleOrderItemsProvider = AllSaleOrderItemsProvider._();

final class AllSaleOrderItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SaleOrderItem>>,
          List<SaleOrderItem>,
          FutureOr<List<SaleOrderItem>>
        >
    with
        $FutureModifier<List<SaleOrderItem>>,
        $FutureProvider<List<SaleOrderItem>> {
  AllSaleOrderItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSaleOrderItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSaleOrderItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<SaleOrderItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SaleOrderItem>> create(Ref ref) {
    return allSaleOrderItems(ref);
  }
}

String _$allSaleOrderItemsHash() => r'3255d5c1b2b0ce137328d93194cb14e6e01e3037';

@ProviderFor(customers)
final customersProvider = CustomersProvider._();

final class CustomersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CustomerModel>>,
          List<CustomerModel>,
          FutureOr<List<CustomerModel>>
        >
    with
        $FutureModifier<List<CustomerModel>>,
        $FutureProvider<List<CustomerModel>> {
  CustomersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersHash();

  @$internal
  @override
  $FutureProviderElement<List<CustomerModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CustomerModel>> create(Ref ref) {
    return customers(ref);
  }
}

String _$customersHash() => r'f88d82308be02a459549c7930d1eacb44c043dcb';

@ProviderFor(returnOrders)
final returnOrdersProvider = ReturnOrdersProvider._();

final class ReturnOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReturnOrderModel>>,
          List<ReturnOrderModel>,
          FutureOr<List<ReturnOrderModel>>
        >
    with
        $FutureModifier<List<ReturnOrderModel>>,
        $FutureProvider<List<ReturnOrderModel>> {
  ReturnOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'returnOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$returnOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<ReturnOrderModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReturnOrderModel>> create(Ref ref) {
    return returnOrders(ref);
  }
}

String _$returnOrdersHash() => r'7f5ba2db30f12c4ace154df9ae42eb56bc517e8e';

@ProviderFor(returnOrderItems)
final returnOrderItemsProvider = ReturnOrderItemsFamily._();

final class ReturnOrderItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReturnOrderItemModel>>,
          List<ReturnOrderItemModel>,
          FutureOr<List<ReturnOrderItemModel>>
        >
    with
        $FutureModifier<List<ReturnOrderItemModel>>,
        $FutureProvider<List<ReturnOrderItemModel>> {
  ReturnOrderItemsProvider._({
    required ReturnOrderItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'returnOrderItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$returnOrderItemsHash();

  @override
  String toString() {
    return r'returnOrderItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ReturnOrderItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReturnOrderItemModel>> create(Ref ref) {
    final argument = this.argument as String;
    return returnOrderItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReturnOrderItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$returnOrderItemsHash() => r'e9f71e1ec167f8d0472b67c238e1ae9388a79063';

final class ReturnOrderItemsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ReturnOrderItemModel>>,
          String
        > {
  ReturnOrderItemsFamily._()
    : super(
        retry: null,
        name: r'returnOrderItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReturnOrderItemsProvider call(String returnOrderId) =>
      ReturnOrderItemsProvider._(argument: returnOrderId, from: this);

  @override
  String toString() => r'returnOrderItemsProvider';
}

@ProviderFor(allReturnOrderItems)
final allReturnOrderItemsProvider = AllReturnOrderItemsProvider._();

final class AllReturnOrderItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReturnOrderItemModel>>,
          List<ReturnOrderItemModel>,
          FutureOr<List<ReturnOrderItemModel>>
        >
    with
        $FutureModifier<List<ReturnOrderItemModel>>,
        $FutureProvider<List<ReturnOrderItemModel>> {
  AllReturnOrderItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allReturnOrderItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allReturnOrderItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReturnOrderItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReturnOrderItemModel>> create(Ref ref) {
    return allReturnOrderItems(ref);
  }
}

String _$allReturnOrderItemsHash() =>
    r'10496f45ee192b7a279550bb6d2669a7937fbb4e';

@ProviderFor(creditNotes)
final creditNotesProvider = CreditNotesProvider._();

final class CreditNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CreditNoteModel>>,
          List<CreditNoteModel>,
          FutureOr<List<CreditNoteModel>>
        >
    with
        $FutureModifier<List<CreditNoteModel>>,
        $FutureProvider<List<CreditNoteModel>> {
  CreditNotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'creditNotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$creditNotesHash();

  @$internal
  @override
  $FutureProviderElement<List<CreditNoteModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CreditNoteModel>> create(Ref ref) {
    return creditNotes(ref);
  }
}

String _$creditNotesHash() => r'f799160078536e0847ff8830e2b7b6d6f6cdfc06';

@ProviderFor(creditNoteItems)
final creditNoteItemsProvider = CreditNoteItemsFamily._();

final class CreditNoteItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CreditNoteItemModel>>,
          List<CreditNoteItemModel>,
          FutureOr<List<CreditNoteItemModel>>
        >
    with
        $FutureModifier<List<CreditNoteItemModel>>,
        $FutureProvider<List<CreditNoteItemModel>> {
  CreditNoteItemsProvider._({
    required CreditNoteItemsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'creditNoteItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$creditNoteItemsHash();

  @override
  String toString() {
    return r'creditNoteItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CreditNoteItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CreditNoteItemModel>> create(Ref ref) {
    final argument = this.argument as String;
    return creditNoteItems(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CreditNoteItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$creditNoteItemsHash() => r'0b7a31230f17db8bd3ab629d7d1fe3be9f56fe8b';

final class CreditNoteItemsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<CreditNoteItemModel>>, String> {
  CreditNoteItemsFamily._()
    : super(
        retry: null,
        name: r'creditNoteItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreditNoteItemsProvider call(String creditNoteId) =>
      CreditNoteItemsProvider._(argument: creditNoteId, from: this);

  @override
  String toString() => r'creditNoteItemsProvider';
}

@ProviderFor(allCreditNoteItems)
final allCreditNoteItemsProvider = AllCreditNoteItemsProvider._();

final class AllCreditNoteItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CreditNoteItemModel>>,
          List<CreditNoteItemModel>,
          FutureOr<List<CreditNoteItemModel>>
        >
    with
        $FutureModifier<List<CreditNoteItemModel>>,
        $FutureProvider<List<CreditNoteItemModel>> {
  AllCreditNoteItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCreditNoteItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCreditNoteItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<CreditNoteItemModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CreditNoteItemModel>> create(Ref ref) {
    return allCreditNoteItems(ref);
  }
}

String _$allCreditNoteItemsHash() =>
    r'de8b7d27af6d155f52a0a05421864db5e4102d6b';

@ProviderFor(invoices)
final invoicesProvider = InvoicesProvider._();

final class InvoicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InvoiceModel>>,
          List<InvoiceModel>,
          FutureOr<List<InvoiceModel>>
        >
    with
        $FutureModifier<List<InvoiceModel>>,
        $FutureProvider<List<InvoiceModel>> {
  InvoicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<InvoiceModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InvoiceModel>> create(Ref ref) {
    return invoices(ref);
  }
}

String _$invoicesHash() => r'1ae879d7f7b156c31494c260986b07964955b265';

@ProviderFor(stockReports)
final stockReportsProvider = StockReportsProvider._();

final class StockReportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StockReportSummary>>,
          List<StockReportSummary>,
          FutureOr<List<StockReportSummary>>
        >
    with
        $FutureModifier<List<StockReportSummary>>,
        $FutureProvider<List<StockReportSummary>> {
  StockReportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockReportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockReportsHash();

  @$internal
  @override
  $FutureProviderElement<List<StockReportSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StockReportSummary>> create(Ref ref) {
    return stockReports(ref);
  }
}

String _$stockReportsHash() => r'663655d75b01f2cd386d0a759434593cf91294de';

@ProviderFor(employees)
final employeesProvider = EmployeesProvider._();

final class EmployeesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EmployeeModel>>,
          List<EmployeeModel>,
          FutureOr<List<EmployeeModel>>
        >
    with
        $FutureModifier<List<EmployeeModel>>,
        $FutureProvider<List<EmployeeModel>> {
  EmployeesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeesHash();

  @$internal
  @override
  $FutureProviderElement<List<EmployeeModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EmployeeModel>> create(Ref ref) {
    return employees(ref);
  }
}

String _$employeesHash() => r'2f079e43b1121209b5353b65d0d55f0ea79b83f9';

@ProviderFor(expenses)
final expensesProvider = ExpensesProvider._();

final class ExpensesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExpenseModel>>,
          List<ExpenseModel>,
          FutureOr<List<ExpenseModel>>
        >
    with
        $FutureModifier<List<ExpenseModel>>,
        $FutureProvider<List<ExpenseModel>> {
  ExpensesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expensesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expensesHash();

  @$internal
  @override
  $FutureProviderElement<List<ExpenseModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExpenseModel>> create(Ref ref) {
    return expenses(ref);
  }
}

String _$expensesHash() => r'3fb4f8b2674043fc29b42935e9dd79d5b67e9ce8';

@ProviderFor(branchPayments)
final branchPaymentsProvider = BranchPaymentsProvider._();

final class BranchPaymentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BranchPaymentModel>>,
          List<BranchPaymentModel>,
          FutureOr<List<BranchPaymentModel>>
        >
    with
        $FutureModifier<List<BranchPaymentModel>>,
        $FutureProvider<List<BranchPaymentModel>> {
  BranchPaymentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'branchPaymentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$branchPaymentsHash();

  @$internal
  @override
  $FutureProviderElement<List<BranchPaymentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BranchPaymentModel>> create(Ref ref) {
    return branchPayments(ref);
  }
}

String _$branchPaymentsHash() => r'86f9e7ea3023a1f560bc2231699099d5248f13d3';

@ProviderFor(receipts)
final receiptsProvider = ReceiptsProvider._();

final class ReceiptsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ReceiptModel>>,
          List<ReceiptModel>,
          FutureOr<List<ReceiptModel>>
        >
    with
        $FutureModifier<List<ReceiptModel>>,
        $FutureProvider<List<ReceiptModel>> {
  ReceiptsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'receiptsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$receiptsHash();

  @$internal
  @override
  $FutureProviderElement<List<ReceiptModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ReceiptModel>> create(Ref ref) {
    return receipts(ref);
  }
}

String _$receiptsHash() => r'40442fd8670c248af098e8f6711c074d839957f7';

@ProviderFor(proformas)
final proformasProvider = ProformasProvider._();

final class ProformasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Profoma>>,
          List<Profoma>,
          FutureOr<List<Profoma>>
        >
    with $FutureModifier<List<Profoma>>, $FutureProvider<List<Profoma>> {
  ProformasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proformasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proformasHash();

  @$internal
  @override
  $FutureProviderElement<List<Profoma>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Profoma>> create(Ref ref) {
    return proformas(ref);
  }
}

String _$proformasHash() => r'eb3c13d4d9c49aa30e01f69b1349595f18f3575f';

@ProviderFor(wayBills)
final wayBillsProvider = WayBillsProvider._();

final class WayBillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WayBillModel>>,
          List<WayBillModel>,
          FutureOr<List<WayBillModel>>
        >
    with
        $FutureModifier<List<WayBillModel>>,
        $FutureProvider<List<WayBillModel>> {
  WayBillsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wayBillsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wayBillsHash();

  @$internal
  @override
  $FutureProviderElement<List<WayBillModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WayBillModel>> create(Ref ref) {
    return wayBills(ref);
  }
}

String _$wayBillsHash() => r'5243d2e16a7ca7bd759a0bcab8b81fa8a7808a04';

@ProviderFor(allProductDetails)
final allProductDetailsProvider = AllProductDetailsProvider._();

final class AllProductDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductDetails>>,
          List<ProductDetails>,
          FutureOr<List<ProductDetails>>
        >
    with
        $FutureModifier<List<ProductDetails>>,
        $FutureProvider<List<ProductDetails>> {
  AllProductDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allProductDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allProductDetailsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductDetails>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductDetails>> create(Ref ref) {
    return allProductDetails(ref);
  }
}

String _$allProductDetailsHash() => r'a9376b49a511bce52a1f605706943e0834b18f12';

@ProviderFor(proformaDetails)
final proformaDetailsProvider = ProformaDetailsFamily._();

final class ProformaDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductDetails>>,
          List<ProductDetails>,
          FutureOr<List<ProductDetails>>
        >
    with
        $FutureModifier<List<ProductDetails>>,
        $FutureProvider<List<ProductDetails>> {
  ProformaDetailsProvider._({
    required ProformaDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'proformaDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$proformaDetailsHash();

  @override
  String toString() {
    return r'proformaDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductDetails>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductDetails>> create(Ref ref) {
    final argument = this.argument as String;
    return proformaDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProformaDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$proformaDetailsHash() => r'562fb3e03bc49b09d52e9c02a996d837cdac19cc';

final class ProformaDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProductDetails>>, String> {
  ProformaDetailsFamily._()
    : super(
        retry: null,
        name: r'proformaDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProformaDetailsProvider call(String proformaId) =>
      ProformaDetailsProvider._(argument: proformaId, from: this);

  @override
  String toString() => r'proformaDetailsProvider';
}

@ProviderFor(wayBillDetails)
final wayBillDetailsProvider = WayBillDetailsFamily._();

final class WayBillDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductDetails>>,
          List<ProductDetails>,
          FutureOr<List<ProductDetails>>
        >
    with
        $FutureModifier<List<ProductDetails>>,
        $FutureProvider<List<ProductDetails>> {
  WayBillDetailsProvider._({
    required WayBillDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'wayBillDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$wayBillDetailsHash();

  @override
  String toString() {
    return r'wayBillDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductDetails>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductDetails>> create(Ref ref) {
    final argument = this.argument as String;
    return wayBillDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WayBillDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$wayBillDetailsHash() => r'c29b1459e0879910dd43c33643602fcf57a52547';

final class WayBillDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProductDetails>>, String> {
  WayBillDetailsFamily._()
    : super(
        retry: null,
        name: r'wayBillDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WayBillDetailsProvider call(String wayBillId) =>
      WayBillDetailsProvider._(argument: wayBillId, from: this);

  @override
  String toString() => r'wayBillDetailsProvider';
}

@ProviderFor(brands)
final brandsProvider = BrandsProvider._();

final class BrandsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Brand>>,
          List<Brand>,
          FutureOr<List<Brand>>
        >
    with $FutureModifier<List<Brand>>, $FutureProvider<List<Brand>> {
  BrandsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brandsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brandsHash();

  @$internal
  @override
  $FutureProviderElement<List<Brand>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Brand>> create(Ref ref) {
    return brands(ref);
  }
}

String _$brandsHash() => r'c67d7a88445282b1765e6703264ce9ec21079bb6';

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductCategory>>,
          List<ProductCategory>,
          FutureOr<List<ProductCategory>>
        >
    with
        $FutureModifier<List<ProductCategory>>,
        $FutureProvider<List<ProductCategory>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductCategory>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'b6c732e81c42d270b78a500584cbc842d6ffb48d';

@ProviderFor(subCategories)
final subCategoriesProvider = SubCategoriesProvider._();

final class SubCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSubCategory>>,
          List<ProductSubCategory>,
          FutureOr<List<ProductSubCategory>>
        >
    with
        $FutureModifier<List<ProductSubCategory>>,
        $FutureProvider<List<ProductSubCategory>> {
  SubCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductSubCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductSubCategory>> create(Ref ref) {
    return subCategories(ref);
  }
}

String _$subCategoriesHash() => r'f2f19813f89ebfb02768a65cb59a2c0a7d3aba85';

@ProviderFor(companySettings)
final companySettingsProvider = CompanySettingsProvider._();

final class CompanySettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<CompanyModel?>,
          CompanyModel?,
          FutureOr<CompanyModel?>
        >
    with $FutureModifier<CompanyModel?>, $FutureProvider<CompanyModel?> {
  CompanySettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companySettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companySettingsHash();

  @$internal
  @override
  $FutureProviderElement<CompanyModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CompanyModel?> create(Ref ref) {
    return companySettings(ref);
  }
}

String _$companySettingsHash() => r'3df31fb75dd5b91abd6d85e9ee0a34a393c76801';
