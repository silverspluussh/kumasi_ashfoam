// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InventoryModel {
  final String id;
  final String name;
  final String sku;
  final String? category;
  final String? catergoryId;
  final String? subCategory;
  final String? size;
  final String? thickness;
  final String? material;
  final String? density;
  final String? brand;
  final String? brandId;
  final String? supplier;
  final String? supplierId;
  final double retailPrice;
  final double? discountPrice;
  final double? discountPercentage;
  final int quantity;
  final String? unit;
  final String? branchId;
  final int isAvailable;
  final int isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  InventoryModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    this.subCategory,
    this.size,
    this.thickness,
    this.material,
    this.brand,
    this.supplier,
    this.density,
    required this.retailPrice,
    this.discountPrice,
    this.discountPercentage,
    required this.quantity,
    this.unit,
    this.branchId,
    required this.isAvailable,
    this.brandId,
    required this.catergoryId,
    this.supplierId,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  InventoryModel copyWith({
    String? id,
    String? name,
    String? sku,
    String? category,
    String? catergoryId,
    String? subCategory,
    String? size,
    String? thickness,
    String? material,
    String? density,
    String? brand,
    String? brandId,
    String? supplier,
    String? supplierId,
    double? retailPrice,
    double? discountPrice,
    double? discountPercentage,
    int? quantity,
    String? unit,
    String? branchId,
    int? isAvailable,
    int? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InventoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      catergoryId: catergoryId ?? this.catergoryId,
      subCategory: subCategory ?? this.subCategory,
      size: size ?? this.size,
      thickness: thickness ?? this.thickness,
      material: material ?? this.material,
      density: density ?? this.density,
      brand: brand ?? this.brand,
      brandId: brandId ?? this.brandId,
      supplier: supplier ?? this.supplier,
      supplierId: supplierId ?? this.supplierId,
      retailPrice: retailPrice ?? this.retailPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      branchId: branchId ?? this.branchId,
      isDeleted: isDeleted ?? this.isDeleted,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'catergory_id': catergoryId,
      'sub_category': subCategory,
      'size': size,
      'thickness': thickness,
      'material': material,
      'density': density,
      'brand': brand,
      'brand_id': brandId,
      'supplier': supplier,
      'supplier_id': supplierId,
      'retail_price': retailPrice,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'quantity': quantity,
      'unit': unit,
      'branch_id': branchId,
      'is_deleted': 0,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      sku: map['sku'] as String,
      category: map['category'] as String?,
      catergoryId: map['catergory_id'] as String?,
      subCategory: map['sub_category'] as String?,
      size: map['size'] as String?,
      thickness: map['thickness'] as String?,
      material: map['material'] as String?,
      density: map['density'] as String?,
      brand: map['brand'] as String?,
      brandId: map['brand_id'] as String?,
      supplier: map['supplier'] as String?,
      supplierId: map['supplier_id'] as String?,
      retailPrice: (map['retail_price'] as num).toDouble(),
      discountPrice: (map['discount_price'] as num?)?.toDouble(),
      discountPercentage: (map['discount_percentage'] as num?)?.toDouble(),
      quantity: (map['quantity'] as num).toInt(),
      unit: map['unit'] as String?,
      branchId: map['branch_id'] as String?,
      isAvailable: map['is_available'] as int,
      isDeleted: map['is_deleted'] as int? ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryModel.fromJson(String source) =>
      InventoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Brand {
  final String id;
  final String name;
  final DateTime createdAt;

  Brand({required this.id, required this.name, required this.createdAt});

  Brand copyWith({String? id, String? name, DateTime? createdAt}) {
    return Brand(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductCategory {
  final String id;
  final String name;
  final DateTime createdAt;

  ProductCategory({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  ProductCategory copyWith({String? id, String? name, DateTime? createdAt}) {
    return ProductCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCategory.fromJson(String source) =>
      ProductCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductSubCategory {
  final String id;
  final String categoryId;
  final String name;
  final DateTime createdAt;

  ProductSubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.createdAt,
  });

  ProductSubCategory copyWith({
    String? id,
    String? categoryId,
    String? name,
    DateTime? createdAt,
  }) {
    return ProductSubCategory(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_id': categoryId,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ProductSubCategory.fromMap(Map<String, dynamic> map) {
    return ProductSubCategory(
      id: map['id'] as String,
      categoryId: map['category_id'] as String,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSubCategory.fromJson(String source) =>
      ProductSubCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
