// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseServiceHash() => r'823f3daaaa9caaca38697456e0cac9b2fa5bd157';

/// See also [databaseService].
@ProviderFor(databaseService)
final databaseServiceProvider = AutoDisposeProvider<DatabaseService>.internal(
  databaseService,
  name: r'databaseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$databaseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseServiceRef = AutoDisposeProviderRef<DatabaseService>;
String _$inventoryItemsHash() => r'626e21d247b32c29af3ce5fa75d176e8f1c900e7';

/// See also [inventoryItems].
@ProviderFor(inventoryItems)
final inventoryItemsProvider =
    AutoDisposeFutureProvider<List<InventoryItem>>.internal(
      inventoryItems,
      name: r'inventoryItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryItemsRef = AutoDisposeFutureProviderRef<List<InventoryItem>>;
String _$suppliersHash() => r'2b1c6512dfdea747f437a8fe36cfc99819b4846c';

/// See also [suppliers].
@ProviderFor(suppliers)
final suppliersProvider = AutoDisposeFutureProvider<List<Supplier>>.internal(
  suppliers,
  name: r'suppliersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$suppliersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SuppliersRef = AutoDisposeFutureProviderRef<List<Supplier>>;
String _$saleOrdersHash() => r'abc48f885745ae7d24ecdbe7ba8b4f3188008a8b';

/// See also [saleOrders].
@ProviderFor(saleOrders)
final saleOrdersProvider = AutoDisposeFutureProvider<List<SaleOrder>>.internal(
  saleOrders,
  name: r'saleOrdersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$saleOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SaleOrdersRef = AutoDisposeFutureProviderRef<List<SaleOrder>>;
String _$saleOrderItemsHash() => r'40130deea2f3c5f72282e4cd46bcab508707091e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [saleOrderItems].
@ProviderFor(saleOrderItems)
const saleOrderItemsProvider = SaleOrderItemsFamily();

/// See also [saleOrderItems].
class SaleOrderItemsFamily extends Family<AsyncValue<List<SaleOrderItem>>> {
  /// See also [saleOrderItems].
  const SaleOrderItemsFamily();

  /// See also [saleOrderItems].
  SaleOrderItemsProvider call(String saleOrderId) {
    return SaleOrderItemsProvider(saleOrderId);
  }

  @override
  SaleOrderItemsProvider getProviderOverride(
    covariant SaleOrderItemsProvider provider,
  ) {
    return call(provider.saleOrderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saleOrderItemsProvider';
}

/// See also [saleOrderItems].
class SaleOrderItemsProvider
    extends AutoDisposeFutureProvider<List<SaleOrderItem>> {
  /// See also [saleOrderItems].
  SaleOrderItemsProvider(String saleOrderId)
    : this._internal(
        (ref) => saleOrderItems(ref as SaleOrderItemsRef, saleOrderId),
        from: saleOrderItemsProvider,
        name: r'saleOrderItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$saleOrderItemsHash,
        dependencies: SaleOrderItemsFamily._dependencies,
        allTransitiveDependencies:
            SaleOrderItemsFamily._allTransitiveDependencies,
        saleOrderId: saleOrderId,
      );

  SaleOrderItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.saleOrderId,
  }) : super.internal();

  final String saleOrderId;

  @override
  Override overrideWith(
    FutureOr<List<SaleOrderItem>> Function(SaleOrderItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaleOrderItemsProvider._internal(
        (ref) => create(ref as SaleOrderItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        saleOrderId: saleOrderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SaleOrderItem>> createElement() {
    return _SaleOrderItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaleOrderItemsProvider && other.saleOrderId == saleOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, saleOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SaleOrderItemsRef on AutoDisposeFutureProviderRef<List<SaleOrderItem>> {
  /// The parameter `saleOrderId` of this provider.
  String get saleOrderId;
}

class _SaleOrderItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<SaleOrderItem>>
    with SaleOrderItemsRef {
  _SaleOrderItemsProviderElement(super.provider);

  @override
  String get saleOrderId => (origin as SaleOrderItemsProvider).saleOrderId;
}

String _$allSaleOrderItemsHash() => r'3255d5c1b2b0ce137328d93194cb14e6e01e3037';

/// See also [allSaleOrderItems].
@ProviderFor(allSaleOrderItems)
final allSaleOrderItemsProvider =
    AutoDisposeFutureProvider<List<SaleOrderItem>>.internal(
      allSaleOrderItems,
      name: r'allSaleOrderItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allSaleOrderItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllSaleOrderItemsRef =
    AutoDisposeFutureProviderRef<List<SaleOrderItem>>;
String _$customersHash() => r'6da35f037bd81f73f04cef8e721e67cc1b092e78';

/// See also [customers].
@ProviderFor(customers)
final customersProvider = AutoDisposeFutureProvider<List<Customer>>.internal(
  customers,
  name: r'customersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomersRef = AutoDisposeFutureProviderRef<List<Customer>>;
String _$returnOrdersHash() => r'9c69fc2b02d2b87b917b4515cb88e24db2b63728';

/// See also [returnOrders].
@ProviderFor(returnOrders)
final returnOrdersProvider =
    AutoDisposeFutureProvider<List<ReturnOrder>>.internal(
      returnOrders,
      name: r'returnOrdersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$returnOrdersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReturnOrdersRef = AutoDisposeFutureProviderRef<List<ReturnOrder>>;
String _$returnOrderItemsHash() => r'cf3fb19e60f1336a757c76b2dc796d4f922a6f2c';

/// See also [returnOrderItems].
@ProviderFor(returnOrderItems)
const returnOrderItemsProvider = ReturnOrderItemsFamily();

/// See also [returnOrderItems].
class ReturnOrderItemsFamily extends Family<AsyncValue<List<ReturnOrderItem>>> {
  /// See also [returnOrderItems].
  const ReturnOrderItemsFamily();

  /// See also [returnOrderItems].
  ReturnOrderItemsProvider call(String returnOrderId) {
    return ReturnOrderItemsProvider(returnOrderId);
  }

  @override
  ReturnOrderItemsProvider getProviderOverride(
    covariant ReturnOrderItemsProvider provider,
  ) {
    return call(provider.returnOrderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'returnOrderItemsProvider';
}

/// See also [returnOrderItems].
class ReturnOrderItemsProvider
    extends AutoDisposeFutureProvider<List<ReturnOrderItem>> {
  /// See also [returnOrderItems].
  ReturnOrderItemsProvider(String returnOrderId)
    : this._internal(
        (ref) => returnOrderItems(ref as ReturnOrderItemsRef, returnOrderId),
        from: returnOrderItemsProvider,
        name: r'returnOrderItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$returnOrderItemsHash,
        dependencies: ReturnOrderItemsFamily._dependencies,
        allTransitiveDependencies:
            ReturnOrderItemsFamily._allTransitiveDependencies,
        returnOrderId: returnOrderId,
      );

  ReturnOrderItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.returnOrderId,
  }) : super.internal();

  final String returnOrderId;

  @override
  Override overrideWith(
    FutureOr<List<ReturnOrderItem>> Function(ReturnOrderItemsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReturnOrderItemsProvider._internal(
        (ref) => create(ref as ReturnOrderItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        returnOrderId: returnOrderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ReturnOrderItem>> createElement() {
    return _ReturnOrderItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReturnOrderItemsProvider &&
        other.returnOrderId == returnOrderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, returnOrderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReturnOrderItemsRef
    on AutoDisposeFutureProviderRef<List<ReturnOrderItem>> {
  /// The parameter `returnOrderId` of this provider.
  String get returnOrderId;
}

class _ReturnOrderItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<ReturnOrderItem>>
    with ReturnOrderItemsRef {
  _ReturnOrderItemsProviderElement(super.provider);

  @override
  String get returnOrderId =>
      (origin as ReturnOrderItemsProvider).returnOrderId;
}

String _$allReturnOrderItemsHash() =>
    r'5a25941d0f1cd525e6d76499ca092047c72504da';

/// See also [allReturnOrderItems].
@ProviderFor(allReturnOrderItems)
final allReturnOrderItemsProvider =
    AutoDisposeFutureProvider<List<ReturnOrderItem>>.internal(
      allReturnOrderItems,
      name: r'allReturnOrderItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allReturnOrderItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllReturnOrderItemsRef =
    AutoDisposeFutureProviderRef<List<ReturnOrderItem>>;
String _$creditNotesHash() => r'438eb2f61c7aa725d253b1494b596e6912c2eb6d';

/// See also [creditNotes].
@ProviderFor(creditNotes)
final creditNotesProvider =
    AutoDisposeFutureProvider<List<CreditNote>>.internal(
      creditNotes,
      name: r'creditNotesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$creditNotesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreditNotesRef = AutoDisposeFutureProviderRef<List<CreditNote>>;
String _$creditNoteItemsHash() => r'89b9d2d9c42a9d71ba1e14b58a353afd156d8bec';

/// See also [creditNoteItems].
@ProviderFor(creditNoteItems)
const creditNoteItemsProvider = CreditNoteItemsFamily();

/// See also [creditNoteItems].
class CreditNoteItemsFamily extends Family<AsyncValue<List<CreditNoteItem>>> {
  /// See also [creditNoteItems].
  const CreditNoteItemsFamily();

  /// See also [creditNoteItems].
  CreditNoteItemsProvider call(String creditNoteId) {
    return CreditNoteItemsProvider(creditNoteId);
  }

  @override
  CreditNoteItemsProvider getProviderOverride(
    covariant CreditNoteItemsProvider provider,
  ) {
    return call(provider.creditNoteId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'creditNoteItemsProvider';
}

/// See also [creditNoteItems].
class CreditNoteItemsProvider
    extends AutoDisposeFutureProvider<List<CreditNoteItem>> {
  /// See also [creditNoteItems].
  CreditNoteItemsProvider(String creditNoteId)
    : this._internal(
        (ref) => creditNoteItems(ref as CreditNoteItemsRef, creditNoteId),
        from: creditNoteItemsProvider,
        name: r'creditNoteItemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$creditNoteItemsHash,
        dependencies: CreditNoteItemsFamily._dependencies,
        allTransitiveDependencies:
            CreditNoteItemsFamily._allTransitiveDependencies,
        creditNoteId: creditNoteId,
      );

  CreditNoteItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.creditNoteId,
  }) : super.internal();

  final String creditNoteId;

  @override
  Override overrideWith(
    FutureOr<List<CreditNoteItem>> Function(CreditNoteItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreditNoteItemsProvider._internal(
        (ref) => create(ref as CreditNoteItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        creditNoteId: creditNoteId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CreditNoteItem>> createElement() {
    return _CreditNoteItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreditNoteItemsProvider &&
        other.creditNoteId == creditNoteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, creditNoteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreditNoteItemsRef on AutoDisposeFutureProviderRef<List<CreditNoteItem>> {
  /// The parameter `creditNoteId` of this provider.
  String get creditNoteId;
}

class _CreditNoteItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<CreditNoteItem>>
    with CreditNoteItemsRef {
  _CreditNoteItemsProviderElement(super.provider);

  @override
  String get creditNoteId => (origin as CreditNoteItemsProvider).creditNoteId;
}

String _$allCreditNoteItemsHash() =>
    r'55c4eaa9aaea764a6cb051fd8aaf59d4533d002a';

/// See also [allCreditNoteItems].
@ProviderFor(allCreditNoteItems)
final allCreditNoteItemsProvider =
    AutoDisposeFutureProvider<List<CreditNoteItem>>.internal(
      allCreditNoteItems,
      name: r'allCreditNoteItemsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allCreditNoteItemsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCreditNoteItemsRef =
    AutoDisposeFutureProviderRef<List<CreditNoteItem>>;
String _$invoicesHash() => r'f89ae9a27dcf7b89821091acaf6af343a5472b79';

/// See also [invoices].
@ProviderFor(invoices)
final invoicesProvider = AutoDisposeFutureProvider<List<Invoice>>.internal(
  invoices,
  name: r'invoicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvoicesRef = AutoDisposeFutureProviderRef<List<Invoice>>;
String _$stockReportsHash() => r'909d52e058630ede24f4da28a50dfe6a38a4389b';

/// See also [stockReports].
@ProviderFor(stockReports)
final stockReportsProvider =
    AutoDisposeFutureProvider<List<StockReport>>.internal(
      stockReports,
      name: r'stockReportsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stockReportsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StockReportsRef = AutoDisposeFutureProviderRef<List<StockReport>>;
String _$employeesHash() => r'4673f6af14d8f868c8c259b83827ed33498262d9';

/// See also [employees].
@ProviderFor(employees)
final employeesProvider = AutoDisposeFutureProvider<List<Employee>>.internal(
  employees,
  name: r'employeesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$employeesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmployeesRef = AutoDisposeFutureProviderRef<List<Employee>>;
String _$expensesHash() => r'bb1948177f28e5e3094a3d127a525a6b12421af6';

/// See also [expenses].
@ProviderFor(expenses)
final expensesProvider = AutoDisposeFutureProvider<List<Expense>>.internal(
  expenses,
  name: r'expensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExpensesRef = AutoDisposeFutureProviderRef<List<Expense>>;
String _$branchPaymentsHash() => r'5a6364881a1c0bbed283c5e578343a98ef12db11';

/// See also [branchPayments].
@ProviderFor(branchPayments)
final branchPaymentsProvider =
    AutoDisposeFutureProvider<List<BranchPayment>>.internal(
      branchPayments,
      name: r'branchPaymentsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$branchPaymentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BranchPaymentsRef = AutoDisposeFutureProviderRef<List<BranchPayment>>;
String _$receiptsHash() => r'6f449d00fea8aac5e0acb7dcffabb5e0531e1b00';

/// See also [receipts].
@ProviderFor(receipts)
final receiptsProvider = AutoDisposeFutureProvider<List<Receipt>>.internal(
  receipts,
  name: r'receiptsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$receiptsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReceiptsRef = AutoDisposeFutureProviderRef<List<Receipt>>;
String _$proformasHash() => r'fa8578fcdf53c870f676e01edbe6759d1a9be181';

/// See also [proformas].
@ProviderFor(proformas)
final proformasProvider = AutoDisposeFutureProvider<List<Proforma>>.internal(
  proformas,
  name: r'proformasProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proformasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProformasRef = AutoDisposeFutureProviderRef<List<Proforma>>;
String _$wayBillsHash() => r'b39eca130e4f9e194040bb9d6cf624467e666b1b';

/// See also [wayBills].
@ProviderFor(wayBills)
final wayBillsProvider = AutoDisposeFutureProvider<List<WayBill>>.internal(
  wayBills,
  name: r'wayBillsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wayBillsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WayBillsRef = AutoDisposeFutureProviderRef<List<WayBill>>;
String _$allProductDetailsHash() => r'c2cf3b66c201df319f41d1776266b6b1ab720e52';

/// See also [allProductDetails].
@ProviderFor(allProductDetails)
final allProductDetailsProvider =
    AutoDisposeFutureProvider<List<ProductDetailsListData>>.internal(
      allProductDetails,
      name: r'allProductDetailsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allProductDetailsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllProductDetailsRef =
    AutoDisposeFutureProviderRef<List<ProductDetailsListData>>;
String _$proformaDetailsHash() => r'e8a74cb9f3dd64e6d5376c71f31f6a19d03a1282';

/// See also [proformaDetails].
@ProviderFor(proformaDetails)
const proformaDetailsProvider = ProformaDetailsFamily();

/// See also [proformaDetails].
class ProformaDetailsFamily
    extends Family<AsyncValue<List<ProductDetailsListData>>> {
  /// See also [proformaDetails].
  const ProformaDetailsFamily();

  /// See also [proformaDetails].
  ProformaDetailsProvider call(String proformaId) {
    return ProformaDetailsProvider(proformaId);
  }

  @override
  ProformaDetailsProvider getProviderOverride(
    covariant ProformaDetailsProvider provider,
  ) {
    return call(provider.proformaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'proformaDetailsProvider';
}

/// See also [proformaDetails].
class ProformaDetailsProvider
    extends AutoDisposeFutureProvider<List<ProductDetailsListData>> {
  /// See also [proformaDetails].
  ProformaDetailsProvider(String proformaId)
    : this._internal(
        (ref) => proformaDetails(ref as ProformaDetailsRef, proformaId),
        from: proformaDetailsProvider,
        name: r'proformaDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$proformaDetailsHash,
        dependencies: ProformaDetailsFamily._dependencies,
        allTransitiveDependencies:
            ProformaDetailsFamily._allTransitiveDependencies,
        proformaId: proformaId,
      );

  ProformaDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.proformaId,
  }) : super.internal();

  final String proformaId;

  @override
  Override overrideWith(
    FutureOr<List<ProductDetailsListData>> Function(ProformaDetailsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProformaDetailsProvider._internal(
        (ref) => create(ref as ProformaDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        proformaId: proformaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductDetailsListData>>
  createElement() {
    return _ProformaDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProformaDetailsProvider && other.proformaId == proformaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, proformaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProformaDetailsRef
    on AutoDisposeFutureProviderRef<List<ProductDetailsListData>> {
  /// The parameter `proformaId` of this provider.
  String get proformaId;
}

class _ProformaDetailsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductDetailsListData>>
    with ProformaDetailsRef {
  _ProformaDetailsProviderElement(super.provider);

  @override
  String get proformaId => (origin as ProformaDetailsProvider).proformaId;
}

String _$wayBillDetailsHash() => r'441459b9db750ead6bd9840a2b61b9cc32336c5b';

/// See also [wayBillDetails].
@ProviderFor(wayBillDetails)
const wayBillDetailsProvider = WayBillDetailsFamily();

/// See also [wayBillDetails].
class WayBillDetailsFamily
    extends Family<AsyncValue<List<ProductDetailsListData>>> {
  /// See also [wayBillDetails].
  const WayBillDetailsFamily();

  /// See also [wayBillDetails].
  WayBillDetailsProvider call(String wayBillId) {
    return WayBillDetailsProvider(wayBillId);
  }

  @override
  WayBillDetailsProvider getProviderOverride(
    covariant WayBillDetailsProvider provider,
  ) {
    return call(provider.wayBillId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'wayBillDetailsProvider';
}

/// See also [wayBillDetails].
class WayBillDetailsProvider
    extends AutoDisposeFutureProvider<List<ProductDetailsListData>> {
  /// See also [wayBillDetails].
  WayBillDetailsProvider(String wayBillId)
    : this._internal(
        (ref) => wayBillDetails(ref as WayBillDetailsRef, wayBillId),
        from: wayBillDetailsProvider,
        name: r'wayBillDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$wayBillDetailsHash,
        dependencies: WayBillDetailsFamily._dependencies,
        allTransitiveDependencies:
            WayBillDetailsFamily._allTransitiveDependencies,
        wayBillId: wayBillId,
      );

  WayBillDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.wayBillId,
  }) : super.internal();

  final String wayBillId;

  @override
  Override overrideWith(
    FutureOr<List<ProductDetailsListData>> Function(WayBillDetailsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WayBillDetailsProvider._internal(
        (ref) => create(ref as WayBillDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        wayBillId: wayBillId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductDetailsListData>>
  createElement() {
    return _WayBillDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WayBillDetailsProvider && other.wayBillId == wayBillId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, wayBillId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WayBillDetailsRef
    on AutoDisposeFutureProviderRef<List<ProductDetailsListData>> {
  /// The parameter `wayBillId` of this provider.
  String get wayBillId;
}

class _WayBillDetailsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductDetailsListData>>
    with WayBillDetailsRef {
  _WayBillDetailsProviderElement(super.provider);

  @override
  String get wayBillId => (origin as WayBillDetailsProvider).wayBillId;
}

String _$brandsHash() => r'9522229039b1bdfa9ad124a217cad31a78aeb394';

/// See also [brands].
@ProviderFor(brands)
final brandsProvider = AutoDisposeFutureProvider<List<ProductBrand>>.internal(
  brands,
  name: r'brandsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$brandsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BrandsRef = AutoDisposeFutureProviderRef<List<ProductBrand>>;
String _$categoriesHash() => r'b6c732e81c42d270b78a500584cbc842d6ffb48d';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider =
    AutoDisposeFutureProvider<List<ProductCategory>>.internal(
      categories,
      name: r'categoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoriesRef = AutoDisposeFutureProviderRef<List<ProductCategory>>;
String _$subCategoriesHash() => r'f2f19813f89ebfb02768a65cb59a2c0a7d3aba85';

/// See also [subCategories].
@ProviderFor(subCategories)
final subCategoriesProvider =
    AutoDisposeFutureProvider<List<ProductSubCategory>>.internal(
      subCategories,
      name: r'subCategoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$subCategoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubCategoriesRef =
    AutoDisposeFutureProviderRef<List<ProductSubCategory>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
