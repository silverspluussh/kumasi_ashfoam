import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:uuid/uuid.dart';

/// Service to manage shopping cart for POS system
class CartService {
  final List<SaleOrderItem> _items = [];
  late String _orderId;

  CartService() {
    _orderId = const Uuid().v4();
  }

  /// Get current order ID
  String get orderId => _orderId;

  /// Get all items in cart
  List<SaleOrderItem> get items => List.unmodifiable(_items);

  /// Get number of items in cart
  int get itemCount => _items.length;

  /// Get total quantity of all items
  int get totalQuantity =>
      _items.fold<int>(0, (prev, item) => prev + item.quantity);

  /// Get subtotal (before tax and discounts)
  double get subtotal => _items.fold<double>(
    0,
    (prev, item) => prev + (item.unitPrice * item.quantity),
  );

  /// Get discount amount
  double get discountAmount =>
      _items.fold<double>(0, (prev, item) => prev + item.discountAmount);

  /// Get tax amount
  double get taxAmount =>
      _items.fold<double>(0, (prev, item) => prev + item.taxAmount);

  /// Get total (subtotal - discount + tax)
  double get total => subtotal - discountAmount + taxAmount;

  /// Add item to cart
  void addItem(SaleOrderItem item) {
    // Ensure item has the correct sale order ID
    final itemWithOrderId = item.copyWith(saleOrderId: _orderId);

    final existingIndex = _items.indexWhere(
      (i) => i.productId == itemWithOrderId.productId,
    );

    if (existingIndex >= 0) {
      // Update quantity if item already exists
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + itemWithOrderId.quantity,
      );
    } else {
      _items.add(itemWithOrderId);
    }
  }

  /// Add multiple items to cart
  void addItems(List<SaleOrderItem> items) {
    for (final item in items) {
      addItem(item);
    }
  }

  /// Remove item from cart by product ID
  bool removeItem(String productId) {
    final initialLength = _items.length;
    _items.removeWhere((item) => item.productId == productId);
    return _items.length < initialLength;
  }

  /// Update item quantity
  bool updateItemQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      return removeItem(productId);
    }

    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      return true;
    }
    return false;
  }

  /// Update item discount
  bool updateItemDiscount(String productId, double discountAmount) {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(discountAmount: discountAmount);
      return true;
    }
    return false;
  }

  /// Update item tax
  bool updateItemTax(String productId, double taxAmount) {
    final index = _items.indexWhere((i) => i.productId == productId);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(taxAmount: taxAmount);
      return true;
    }
    return false;
  }

  /// Get specific item by product ID
  SaleOrderItem? getItem(String productId) {
    try {
      return _items.firstWhere((i) => i.productId == productId);
    } catch (e) {
      return null;
    }
  }

  /// Clear all items from cart
  void clearCart() {
    _items.clear();
    _orderId = const Uuid().v4(); // Reset order ID
  }

  /// Get cart summary
  CartSummary getSummary() {
    return CartSummary(
      orderId: _orderId,
      itemCount: itemCount,
      totalQuantity: totalQuantity,
      subtotal: subtotal,
      discountAmount: discountAmount,
      taxAmount: taxAmount,
      total: total,
    );
  }

  /// Apply cart-wide discount (percentage)
  void applyCartDiscount(double discountPercentage) {
    if (discountPercentage < 0 || discountPercentage > 100) {
      throw ArgumentError('Discount percentage must be between 0 and 100');
    }

    final discountFactor = discountPercentage / 100;
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      final itemDiscount = (item.unitPrice * item.quantity) * discountFactor;
      _items[i] = item.copyWith(discountAmount: itemDiscount);
    }
  }

  /// Apply cart-wide tax (percentage)
  void applyCartTax(double taxPercentage) {
    if (taxPercentage < 0 || taxPercentage > 100) {
      throw ArgumentError('Tax percentage must be between 0 and 100');
    }

    final taxFactor = taxPercentage / 100;
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      final subtotalAfterDiscount =
          (item.unitPrice * item.quantity) - item.discountAmount;
      final itemTax = subtotalAfterDiscount * taxFactor;
      _items[i] = item.copyWith(taxAmount: itemTax);
    }
  }

  /// Check if cart is empty
  bool get isEmpty => _items.isEmpty;

  /// Check if cart has items
  bool get isNotEmpty => _items.isNotEmpty;

  /// Reset order ID (for new order)
  void resetOrderId() {
    _orderId = const Uuid().v4();
  }
}

/// Cart summary data class
class CartSummary {
  final String orderId;
  final int itemCount;
  final int totalQuantity;
  final double subtotal;
  final double discountAmount;
  final double taxAmount;
  final double total;

  CartSummary({
    required this.orderId,
    required this.itemCount,
    required this.totalQuantity,
    required this.subtotal,
    required this.discountAmount,
    required this.taxAmount,
    required this.total,
  });

  /// Convert to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'itemCount': itemCount,
      'totalQuantity': totalQuantity,
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'total': total,
    };
  }

  /// Convert to JSON
  String toJson() {
    return '''
    {
      "orderId": "$orderId",
      "itemCount": $itemCount,
      "totalQuantity": $totalQuantity,
      "subtotal": $subtotal,
      "discountAmount": $discountAmount,
      "taxAmount": $taxAmount,
      "total": $total
    }
    ''';
  }
}
