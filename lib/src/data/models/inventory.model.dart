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
  final bool isSynced;
  final DateTime? lastSyncedAt;

  InventoryModel({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    this.subCategory,
    this.size,
    this.thickness,
    this.material,
    this.brand,
    this.density,
    required this.retailPrice,
    this.discountPrice,
    this.discountPercentage,
    required this.quantity,
    this.unit,
    this.branchId,
    this.isAvailable = 1,
    this.brandId,
    this.catergoryId,
    this.isDeleted = 0,
    this.createdAt,
    this.updatedAt,
    this.isSynced = false,
    this.lastSyncedAt,
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
    bool? isSynced,
    DateTime? lastSyncedAt,
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
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'catergory_id': catergoryId,
      'subCategory': subCategory,
      'size': size,
      'thickness': thickness,
      'material': material,
      'density': density,
      'brand': brand,
      'brandId': brandId,
      'retailPrice': retailPrice,
      'discountPrice': discountPrice,
      'discountPercentage': discountPercentage,
      'quantity': quantity,
      'unit': unit,
      'branchId': branchId,
      'isDeleted': 0,
      'isAvailable': isAvailable,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isSynced': isSynced,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
    };
  }

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      sku: map['sku']?.toString() ?? '',
      category: map['category']?.toString(),
      catergoryId: (map['catergoryId'] ?? map['categoryId'])?.toString(),
      subCategory: map['subCategory']?.toString(),
      size: map['size']?.toString(),
      thickness: map['thickness']?.toString(),
      material: map['material']?.toString(),
      density: map['density']?.toString(),
      brand: map['brand']?.toString(),
      brandId: map['brand_id']?.toString(),
      retailPrice: (map['retailPrice'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (map['discountPrice'] as num?)?.toDouble(),
      discountPercentage: (map['discountPercentage'] as num?)?.toDouble(),
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unit: map['unit']?.toString(),
      branchId: map['branchId']?.toString(),
      isAvailable: (map['isAvailable'] as int?) ?? 1,
      isDeleted: (map['isDeleted'] as int?) ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString())
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'].toString())
          : null,
      isSynced: map['isSynced'] == true || map['isSynced'] == 1,
      lastSyncedAt: map['lastSyncedAt'] != null
          ? DateTime.tryParse(map['lastSyncedAt'].toString())
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
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
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
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
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
      id: map['id']?.toString() ?? '',
      categoryId: map['category_id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSubCategory.fromJson(String source) =>
      ProductSubCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
