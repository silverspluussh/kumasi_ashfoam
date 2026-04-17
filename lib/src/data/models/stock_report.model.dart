import 'dart:convert';

class StockReportSummary {
  final String id;
  final String branchId;
  final String branchName;
  final DateTime createdAt;
  final String createdBy;
  final List<ProductStock> currentStock;
  final List<CategoryStock> categoryStock;

  StockReportSummary({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.createdAt,
    required this.createdBy,
    required this.currentStock,
    required this.categoryStock,
  });

  factory StockReportSummary.fromMap(Map<String, dynamic> map) {
    return StockReportSummary(
      id: map['id'] as String,
      branchId: map['branch_id'] as String,
      branchName: map['branch_name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      currentStock: (jsonDecode(map['current_stock'] as String) as List)
          .map((x) => ProductStock.fromMap(x as Map<String, dynamic>))
          .toList(),
      categoryStock: (jsonDecode(map['category_stock'] as String) as List)
          .map((x) => CategoryStock.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'branch_name': branchName,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'current_stock': jsonEncode(currentStock.map((x) => x.toMap()).toList()),
      'category_stock': jsonEncode(categoryStock.map((x) => x.toMap()).toList()),
    };
  }
}

class ProductStock {
  final String id;
  final String name;
  final String sku;
  final int quantity;
  final double retailPrice;
  final int quantitySold;
  final double totalSales;

  ProductStock({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
    required this.retailPrice,
    required this.quantitySold,
    required this.totalSales,
  });

  factory ProductStock.fromMap(Map<String, dynamic> map) {
    return ProductStock(
      id: map['id'] as String,
      name: map['name'] as String,
      sku: map['sku'] as String,
      quantity: (map['quantity'] as num).toInt(),
      retailPrice: (map['retail_price'] as num).toDouble(),
      quantitySold: (map['quantity_sold'] as num).toInt(),
      totalSales: (map['total_sales'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'quantity': quantity,
      'retail_price': retailPrice,
      'quantity_sold': quantitySold,
      'total_sales': totalSales,
    };
  }
}

class CategoryStock {
  final String categoryId;
  final String categoryName;
  final int totalQuantity;
  final double totalValue;

  CategoryStock({
    required this.categoryId,
    required this.categoryName,
    required this.totalQuantity,
    required this.totalValue,
  });

  factory CategoryStock.fromMap(Map<String, dynamic> map) {
    return CategoryStock(
      categoryId: map['category_id'] as String,
      categoryName: map['category_name'] as String,
      totalQuantity: (map['total_quantity'] as num).toInt(),
      totalValue: (map['total_value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'total_quantity': totalQuantity,
      'total_value': totalValue,
    };
  }
}
