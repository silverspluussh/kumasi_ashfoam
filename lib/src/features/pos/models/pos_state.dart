import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';

class CurrentSaleItem {
  final InventoryModel? product;
  final double rate;
  final int stock;
  final int quantity;
  final double discountPercentage;
  final double subtotal;

  CurrentSaleItem({
    this.product,
    this.rate = 0.0,
    this.stock = 0,
    this.quantity = 1,
    this.discountPercentage = 0.0,
    this.subtotal = 0.0,
  });

  CurrentSaleItem copyWith({
    InventoryModel? product,
    double? rate,
    int? stock,
    int? quantity,
    double? discountPercentage,
    double? subtotal,
  }) {
    return CurrentSaleItem(
      product: product ?? this.product,
      rate: rate ?? this.rate,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  factory CurrentSaleItem.initial() {
    return CurrentSaleItem();
  }
}
