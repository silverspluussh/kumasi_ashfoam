import 'package:ashfoam_sadiq/src/data/local/app_database.dart'
    hide SaleOrderItem;
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart'
    hide saleOrdersProvider;
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';
import 'package:ashfoam_sadiq/src/features/auth/providers/auth_provider.dart';
import 'package:ashfoam_sadiq/src/features/pos/models/pos_state.dart';

/// Provider for inventory products (fetched once)
final inventoryProductsProvider = Provider<AsyncValue<List<InventoryModel>>>((
  ref,
) {
  return ref.watch(inventoryListProvider);
});

/// Provider for the current product selection in POS
final currentSaleItemProvider =
    NotifierProvider<CurrentSaleItemNotifier, CurrentSaleItem>(() {
      return CurrentSaleItemNotifier();
    });

/// Provider for the invoice checker state
final posInvoiceRequestedProvider = StateProvider<bool>((ref) => false);

class CurrentSaleItemNotifier extends Notifier<CurrentSaleItem> {
  @override
  CurrentSaleItem build() {
    return CurrentSaleItem.initial();
  }

  void selectProduct(InventoryModel product) {
    state = state.copyWith(
      product: product,
      rate: product.retailPrice,
      stock: product.quantity,
    );
    _calculateSubtotal();
  }

  void updateQuantity(int quantity) {
    state = state.copyWith(quantity: quantity);
    _calculateSubtotal();
  }

  void updateDiscount(double discountPercentage) {
    state = state.copyWith(discountPercentage: discountPercentage);
    _calculateSubtotal();
  }

  void _calculateSubtotal() {
    final subtotal =
        (state.rate * state.quantity) * (1 - state.discountPercentage / 100);
    state = state.copyWith(subtotal: subtotal);
  }

  void reset() {
    state = CurrentSaleItem.initial();
  }
}

/// Provider for the cart (list of sale order items)
final cartProvider = NotifierProvider<CartNotifier, List<SaleOrderItem>>(() {
  return CartNotifier();
});

class CartNotifier extends Notifier<List<SaleOrderItem>> {
  @override
  List<SaleOrderItem> build() {
    return [];
  }

  void addItem(CurrentSaleItem currentItem) {
    if (currentItem.product == null) return;

    final newItem = SaleOrderItem(
      id: const Uuid().v4(),
      productId: currentItem.product!.id,
      saleOrderId: 'PENDING', // Will be set when order is created
      productName: currentItem.product!.name,
      quantity: currentItem.quantity,
      unitPrice: currentItem.rate,
      totalPrice: currentItem.subtotal,
      discountAmount:
          (currentItem.rate * currentItem.quantity) *
          (currentItem.discountPercentage / 100),
      taxAmount: _calculateItemTax(currentItem.subtotal),
    );

    // Check if item already exists in cart, then update or add
    final existingIndex = state.indexWhere(
      (item) => item.productId == newItem.productId,
    );
    if (existingIndex != -1) {
      final existingItem = state[existingIndex];
      state = [
        ...state.sublist(0, existingIndex),
        existingItem.copyWith(
          quantity: existingItem.quantity + newItem.quantity,
          totalPrice: existingItem.totalPrice + newItem.totalPrice,
          discountAmount: existingItem.discountAmount + newItem.discountAmount,
        ),
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      state = [...state, newItem];
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clear() {
    state = [];
  }

  double get subtotal => state.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get totalDiscount =>
      state.fold(0.0, (sum, item) => sum + item.discountAmount);
  double get totalQuantity => state.fold(0, (sum, item) => sum + item.quantity);

  double _calculateItemTax(double subtotal) {
    final taxesAsync = ref.read(allTaxesProvider);
    final taxes = taxesAsync.value ?? [];
    if (taxes.isEmpty) return 0.0;

    final totalTaxPercentage = taxes.fold(
      0.0,
      (sum, tax) => sum + tax.valuePercentage,
    );
    final baseAmount = subtotal / (1 + totalTaxPercentage / 100);
    return subtotal - baseAmount;
  }
}

/// Provider for cart summary totals
final cartSummaryProvider = Provider((ref) {
  final items = ref.watch(cartProvider);
  final taxesAsync = ref.watch(allTaxesProvider);

  final subtotal = items.fold(0.0, (sum, item) => sum + (item.totalPrice));
  final totalDiscount = items.fold(
    0.0,
    (sum, item) => sum + (item.discountAmount),
  );
  final totalQuantity = items.fold(0, (sum, item) => sum + item.quantity);

  final taxes = taxesAsync.value ?? [];
  final totalTaxPercentage = taxes.fold(
    0.0,
    (sum, tax) => sum + tax.valuePercentage,
  );

  // Tax included formula: Base = Total / (1 + Rate)
  final baseAmount = subtotal / (1 + totalTaxPercentage / 100);

  final taxDetails = taxes.map((tax) {
    return {
      'name': tax.name,
      'percentage': tax.valuePercentage,
      'amount': baseAmount * (tax.valuePercentage / 100),
    };
  }).toList();

  final totalTaxAmount = taxDetails.fold(
    0.0,
    (sum, tax) => sum + (tax['amount'] as double),
  );

  // Since taxes are already included in the selling price, grandTotal is subtotal
  final grandTotal = subtotal;

  return {
    'subtotal': subtotal,
    'totalDiscount': totalDiscount,
    'totalQuantity': totalQuantity,
    'vatAmount': totalTaxAmount, // For backward compatibility
    'grandTotal': grandTotal,
    'taxes': taxDetails,
  };
});

/// Provider for creating a sale order
final createPOSOrderProvider =
    NotifierProvider<CreatePOSOrderNotifier, AsyncValue<void>>(() {
      return CreatePOSOrderNotifier();
    });

class CreatePOSOrderNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<(SaleOrderModel, List<SaleOrderItem>)?> createOrder({
    required String customerName,
    required String customerPhone,
    required String paymentMethod,
    required String channel,
    String? createdByManual,
    bool createInvoice = false,
  }) async {
    state = const AsyncValue.loading();

    try {
      final dbService = ref.read(databaseServiceProvider);
      final cartItems = ref.read(cartProvider);
      final summary = ref.read(cartSummaryProvider);

      if (cartItems.isEmpty) {
        state = const AsyncValue.data(null);
        return null;
      }

      final orderId = const Uuid().v4();
      final orderNumber =
          'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      final now = DateTime.now();

      String createdBy = 'User';
      if (createdByManual != null && createdByManual.trim().isNotEmpty) {
        createdBy = createdByManual.trim();
      } else {
        final user = ref.read(userProvider);
        if (user != null) {
          final employeeName = await ref
              .read(employeesRepositoryProvider)
              .fetchFirstNameByAuthId(user.id);
          if (employeeName != null) {
            createdBy = employeeName;
          }
        }
      }

      // 1. Create Sale Order Companion
      final orderCompanion = SaleOrdersCompanion(
        id: Value(orderId),
        orderNumber: Value(orderNumber),
        customerName: Value(customerName),
        channel: Value(channel),
        totalAmount: Value(summary['grandTotal'] as double),
        discountAmount: Value(summary['totalDiscount'] as double),
        totalQuantity: Value(summary['totalQuantity'] as int),
        taxAmount: Value(summary['vatAmount'] as double),
        status: const Value('Paid'),
        createdBy: Value(createdBy),
        lastSyncedAt: Value(now),
        createdAt: Value(now),
      );

      // 2. Create Customer Companion
      final customerCompanion = CustomersCompanion(
        id: Value(DateTime.now().millisecondsSinceEpoch),
        name: Value(customerName),
        phone: Value(customerPhone),
        email: const Value(''),
        segment: const Value('Retail'),
        ordersCount: const Value(1),
        lifetimeValue: Value(summary['grandTotal'] as double),
        lastOrderDate: Value(now),
        status: const Value('Active'),
      );

      // 3. Create Sale Order Items Companions
      final itemCompanions = cartItems.map((item) {
        return SaleOrderItemsCompanion(
          id: Value(const Uuid().v4()),
          productId: Value(item.productId),
          saleOrderId: Value(orderId),
          productName: Value(item.productName),
          quantity: Value(item.quantity),
          unitPrice: Value(item.unitPrice),
          totalPrice: Value(item.totalPrice),
          discountAmount: Value(item.discountAmount),
          taxAmount: Value(item.taxAmount),
          isSynced: const Value(0),
        );
      }).toList();

      // 4. Persist to Database within critical section
      await dbService.database.transaction(() async {
        await dbService.createPOSOrder(orderCompanion, itemCompanions);
        await dbService.addCustomer(customerCompanion);

        if (createInvoice) {
          final invoiceCompanion = InvoicesCompanion(
            id: Value(const Uuid().v4()),
            saleOrderId: Value(orderId),
            customerName: Value(customerName),
            totalAmount: Value(summary['grandTotal'] as double),
            paidAmount: Value(summary['grandTotal'] as double),
            status: const Value('paid'),
            dueDate: Value(now),
            branchId: const Value('Main'), // Default branch
            branchName: const Value('Kumasi Ashfoam'),
          );
          await dbService.addInvoice(invoiceCompanion);
        }
      });

      // Prepare return data before cleanup
      final createdOrder = SaleOrderModel(
        id: orderId,
        orderNumber: orderNumber,
        totalQuantity: summary['totalQuantity'] as int,
        customerName: customerName,
        channel: channel,
        totalAmount: summary['grandTotal'] as double,
        discountAmount: summary['totalDiscount'] as double,
        taxAmount: summary['vatAmount'] as double,
        status: 'Paid',
        createdBy: 'User',
        lastSyncedAt: now,
        createdAt: now,
      );

      final createdItems = cartItems;

      // 5. Cleanup and Invalidate
      ref.invalidate(saleOrdersProvider);
      ref.invalidate(inventoryListProvider);
      ref.read(cartProvider.notifier).clear();
      ref.read(currentSaleItemProvider.notifier).reset();

      state = const AsyncValue.data(null);
      return (createdOrder, createdItems);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}
