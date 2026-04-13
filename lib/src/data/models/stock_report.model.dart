
class StockReport {
  final String id;
  final String branchId;
  final String branchName;
  final List<ProductStock> currentStock;
  final List<CategoryStock> categoryStock;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;

  StockReport({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.currentStock,
    required this.categoryStock,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
  });

  StockReport copyWith({
    String? id,
    String? branchId,
    String? branchName,
    List<ProductStock>? currentStock,
    List<CategoryStock>? categoryStock,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
  }) {
    return StockReport(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      currentStock: currentStock ?? this.currentStock,
      categoryStock: categoryStock ?? this.categoryStock,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'branch_name': branchName,
      'current_stock': currentStock.map((stock) => stock.toMap()).toList(),
      'category_stock': categoryStock.map((stock) => stock.toMap()).toList(),
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory StockReport.fromMap(Map<String, dynamic> map) {
    return StockReport(
      id: map['id'] as String,
      branchId: map['branch_id'] as String,
      branchName: map['branch_name'] as String,
      currentStock: (map['current_stock'] as List<dynamic>)
          .map((item) => ProductStock.fromMap(item as Map<String, dynamic>))
          .toList(),
      categoryStock: (map['category_stock'] as List<dynamic>)
          .map((item) => CategoryStock.fromMap(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

class ProductStock {
  final String productId;
  final String productName;
  final int openingStock;
  final int closingStock;
  final int quantitySold;
  final int quantityReturned;

  ProductStock({
    required this.productId,
    required this.productName,
    required this.openingStock,
    required this.closingStock,
    required this.quantitySold,
    required this.quantityReturned,
  });

  ProductStock copyWith({
    String? productId,
    String? productName,
    int? openingStock,
    int? closingStock,
    int? quantitySold,
    int? quantityReturned,
  }) {
    return ProductStock(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      openingStock: openingStock ?? this.openingStock,
      closingStock: closingStock ?? this.closingStock,
      quantitySold: quantitySold ?? this.quantitySold,
      quantityReturned: quantityReturned ?? this.quantityReturned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'opening_stock': openingStock,
      'closing_stock': closingStock,
      'quantity_sold': quantitySold,
      'quantity_returned': quantityReturned,
    };
  }

  factory ProductStock.fromMap(Map<String, dynamic> map) {
    return ProductStock(
      productId: map['product_id'] as String,
      productName: map['product_name'] as String,
      openingStock: (map['opening_stock'] as num).toInt(),
      closingStock: (map['closing_stock'] as num).toInt(),
      quantitySold: (map['quantity_sold'] as num).toInt(),
      quantityReturned: (map['quantity_returned'] as num).toInt(),
    );
  }
}

class CategoryStock {
  final String categoryId;
  final String categoryName;
  final int quantity;

  CategoryStock({
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
  });

  CategoryStock copyWith({
    String? categoryId,
    String? categoryName,
    int? quantity,
  }) {
    return CategoryStock(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'quantity': quantity,
    };
  }

  factory CategoryStock.fromMap(Map<String, dynamic> map) {
    return CategoryStock(
      categoryId: map['category_id'] as String,
      categoryName: map['category_name'] as String,
      quantity: (map['quantity'] as num).toInt(),
    );
  }
}
