import 'dart:convert';
import 'dart:developer';

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
    log(map["createdAt"].runtimeType.toString());
    return StockReportSummary(
      id: map['id']?.toString() ?? '',
      branchId:
          map['branchId']?.toString() ?? map['branch_id']?.toString() ?? '',
      branchName:
          map['branchName']?.toString() ?? map['branch_name']?.toString() ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      createdBy:
          map['createdBy']?.toString() ?? map['created_by']?.toString() ?? '',
      currentStock: () {
        final data = map['currentStock'] ?? map['current_stock'];
        if (data == null) return <ProductStock>[];
        final List list = data is String
            ? jsonDecode(data) as List
            : data as List;
        return list
            .map((x) => ProductStock.fromMap(x as Map<String, dynamic>))
            .toList();
      }(),
      categoryStock: () {
        final data = map['categoryStock'] ?? map['category_stock'];
        if (data == null) return <CategoryStock>[];
        final List list = data is String
            ? jsonDecode(data) as List
            : data as List;
        return list
            .map((x) => CategoryStock.fromMap(x as Map<String, dynamic>))
            .toList();
      }(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branchId': branchId,
      'branchName': branchName,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'currentStock': jsonEncode(currentStock.map((x) => x.toMap()).toList()),
      'categoryStock': jsonEncode(categoryStock.map((x) => x.toMap()).toList()),
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
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      sku: map['sku']?.toString() ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      retailPrice:
          ((map['retailPrice'] ?? map['retail_price']) as num?)?.toDouble() ??
          0.0,
      quantitySold:
          ((map['quantitySold'] ?? map['quantity_sold']) as num?)?.toInt() ?? 0,
      totalSales:
          ((map['totalSales'] ?? map['total_sales']) as num?)?.toDouble() ??
          0.0,
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
      categoryId:
          map['categoryId']?.toString() ?? map['category_id']?.toString() ?? '',
      categoryName:
          map['categoryName']?.toString() ??
          map['category_name']?.toString() ??
          '',
      totalQuantity:
          ((map['totalQuantity'] ?? map['total_quantity']) as num?)?.toInt() ??
          0,
      totalValue:
          ((map['totalValue'] ?? map['total_value']) as num?)?.toDouble() ??
          0.0,
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
