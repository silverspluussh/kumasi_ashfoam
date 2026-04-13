import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/providers.dart';
import 'package:ashfoam_sadiq/src/features/pos/models/pos_state.dart';
import 'package:uuid/uuid.dart';

/// Provider for inventory products (fetched once)
final inventoryProductsProvider = FutureProvider<List<InventoryModel>>((ref) async {
  final repository = ref.watch(productsRepositoryProvider);
  final items = await repository.getInventoryItems(limit: 1000); // Fetch all
  return items.map((m) => InventoryModel.fromMap(m)).toList();
});

/// Provider for the current product selection in POS
final currentSaleItemProvider = NotifierProvider<CurrentSaleItemNotifier, CurrentSaleItem>(() {
  return CurrentSaleItemNotifier();
});

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
    final subtotal = (state.rate * state.quantity) * (1 - state.discountPercentage / 100);
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
      discountAmount: (currentItem.rate * currentItem.quantity) * (currentItem.discountPercentage / 100),
    );

    // Check if item already exists in cart, then update or add
    final existingIndex = state.indexWhere((item) => item.productId == newItem.productId);
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

  double get subtotal => state.fold(0, (sum, item) => sum + item.totalPrice);
  double get totalDiscount => state.fold(0, (sum, item) => sum + item.discountAmount);
  int get totalQuantity => state.fold(0, (sum, item) => sum + item.quantity);
}

/// Provider for cart summary totals
final cartSummaryProvider = Provider((ref) {
  final items = ref.watch(cartProvider);
  final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
  final totalDiscount = items.fold(0.0, (sum, item) => sum + item.discountAmount);
  final totalQuantity = items.fold(0, (sum, item) => sum + item.quantity);
  
  final vatAmount = subtotal * 0.15;
  final grandTotal = subtotal + vatAmount;
  
  return {
    'subtotal': subtotal,
    'totalDiscount': totalDiscount,
    'totalQuantity': totalQuantity,
    'vatAmount': vatAmount,
    'grandTotal': grandTotal,
  };
});
