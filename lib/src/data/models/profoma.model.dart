import 'dart:convert';

import 'package:ashfoam_sadiq/src/data/models/tax.model.dart';

class Profoma {
  final String id;
  final String? partyName;
  final String? partyAddress;
  final List<TaxComponent> tax;
  final int totalQuantity;
  final String? declaration;
  final double totalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isDeleted;

  Profoma({
    required this.id,
    required this.tax,
    required this.totalQuantity,
    required this.totalAmount,
    this.partyAddress,
    this.partyName,
    this.declaration,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  Profoma copyWith({
    String? id,
    String? partyName,
    String? partyAddress,
    List<TaxComponent>? tax,
    int? totalQuantity,
    String? declaration,
    double? totalAmount,
    int? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profoma(
      id: id ?? this.id,
      partyName: partyName ?? this.partyName,
      partyAddress: partyAddress ?? this.partyAddress,
      tax: tax ?? this.tax,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      declaration: declaration ?? this.declaration,
      totalAmount: totalAmount ?? this.totalAmount,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'party_name': partyName,
      'party_address': partyAddress,

      'tax': tax.map((component) => component.toMap()).toList(),
      'total_quantity': totalQuantity,
      'is_deleted': 0,
      'declaration': declaration,
      'total_amount': totalAmount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Profoma.fromJson(String source) =>
      Profoma.fromMap(json.decode(source));

  factory Profoma.fromMap(Map<String, dynamic> map) {
    return Profoma(
      id: (map['id'] ?? map['id'] ?? '') as String,
      partyName: (map['partyName'] ?? map['party_name']) as String?,
      partyAddress: (map['partyAddress'] ?? map['party_address']) as String?,
      tax: (map['tax'] as List<dynamic>?)
              ?.map((item) => TaxComponent.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalQuantity: (map['totalQuantity'] ?? map['total_quantity'] as num?)?.toInt() ?? 0,
      declaration: (map['declaration'] ?? map['declaration']) as String?,
      isDeleted: (map['isDeleted'] ?? map['is_deleted'] as int?) ?? 0,
      totalAmount: (map['totalAmount'] ?? map['total_amount'] as num?)?.toDouble() ?? 0.0,
      createdAt: (map['createdAt'] ?? map['created_at']) != null
          ? ((map['createdAt'] ?? map['created_at']) is int 
              ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? map['created_at']) as int)
              : DateTime.parse((map['createdAt'] ?? map['created_at']) as String))
          : DateTime.now(),
      updatedAt: (map['updatedAt'] ?? map['updated_at']) != null
          ? ((map['updatedAt'] ?? map['updated_at']) is int 
              ? DateTime.fromMillisecondsSinceEpoch((map['updatedAt'] ?? map['updated_at']) as int)
              : DateTime.parse((map['updatedAt'] ?? map['updated_at']) as String))
          : DateTime.now(),
    );
  }
}

class ProductDetails {
  final String productId;
  final String productName;
  final String? proformaId;
  final String? waybillId;
  final int quantity;
  final double unitprice;
  final double discountPercentage;
  final double totalAmount;

  ProductDetails({
    required this.productId,
    this.proformaId,
    this.waybillId,
    required this.productName,
    required this.quantity,
    required this.unitprice,
    required this.discountPercentage,
    required this.totalAmount,
  });

  ProductDetails copyWith({
    String? productId,
    String? proformaId,
    String? waybillId,
    String? productName,
    int? quantity,
    double? unitprice,
    double? discountPercentage,
    double? totalAmount,
  }) {
    return ProductDetails(
      productId: productId ?? this.productId,
      proformaId: proformaId ?? this.proformaId,
      waybillId: waybillId ?? this.waybillId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitprice: unitprice ?? this.unitprice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'proforma_id': proformaId,
      'waybill_id': waybillId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitprice,
      'discount_percentage': discountPercentage,
      'total_amount': totalAmount,
    };
  }

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      productId: map['productId'] as String? ?? 'N/A',
      proformaId: map['proformaId'] as String?,
      waybillId: map['waybillId'] as String?,
      productName: map['productName'] as String? ?? 'Unknown Product',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitprice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (map['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TaxComponent {
  final Tax tax;
  final double taxAmount;

  TaxComponent({required this.tax, required this.taxAmount});

  TaxComponent copyWith({Tax? tax, double? taxAmount}) {
    return TaxComponent(
      tax: tax ?? this.tax,
      taxAmount: taxAmount ?? this.taxAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {'tax': tax.toMap(), 'tax_amount': taxAmount};
  }

  factory TaxComponent.fromMap(Map<String, dynamic> map) {
    return TaxComponent(
      tax: Tax.fromMap(map['tax'] as Map<String, dynamic>),
      taxAmount: (map['tax_amount'] as num).toDouble(),
    );
  }
}
