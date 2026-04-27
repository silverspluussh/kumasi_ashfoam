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
      tax: () {
        final data = map['tax'];
        if (data == null || data == '') return <TaxComponent>[];
        try {
          final List list = data is String ? jsonDecode(data) as List : data as List;
          return list.map((item) {
            if (item is TaxComponent) return item;
            if (item is String) {
               try { item = jsonDecode(item); } catch(_) {}
            }
            if (item is Map) return TaxComponent.fromMap(Map<String, dynamic>.from(item));
            return null;
          }).whereType<TaxComponent>().toList();
        } catch (_) {
          return <TaxComponent>[];
        }
      }(),
      totalQuantity:
          (map['totalQuantity'] as num? ?? map['total_quantity'] as num? ?? 0).toInt(),
      declaration: (map['declaration'] ?? map['declaration']) as String?,
      isDeleted: (map['isDeleted'] as int? ?? map['is_deleted'] as int? ?? 0),
      totalAmount:
          (map['totalAmount'] as num? ?? map['total_amount'] as num? ?? 0.0).toDouble(),
      createdAt: (map['createdAt'] ?? map['created_at']) != null
          ? ((map['createdAt'] ?? map['created_at']) is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    (map['createdAt'] ?? map['created_at']) as int,
                  )
                : (DateTime.tryParse((map['createdAt'] ?? map['created_at']).toString()) ?? DateTime.now()))
          : DateTime.now(),
      updatedAt: (map['updatedAt'] ?? map['updated_at']) != null
          ? ((map['updatedAt'] ?? map['updated_at']) is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    (map['updatedAt'] ?? map['updated_at']) as int,
                  )
                : (DateTime.tryParse((map['updatedAt'] ?? map['updated_at']).toString()) ?? DateTime.now()))
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
      productId: map['productId']?.toString() ?? map['product_id']?.toString() ?? 'N/A',
      proformaId: map['proformaId']?.toString() ?? map['proforma_id']?.toString(),
      waybillId: map['waybillId']?.toString() ?? map['waybill_id']?.toString(),
      productName: map['productName']?.toString() ?? map['product_name']?.toString() ?? 'Unknown Product',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitprice: ((map['unitPrice'] ?? map['unit_price']) as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          ((map['discountPercentage'] ?? map['discount_percentage']) as num?)?.toDouble() ?? 0.0,
      totalAmount: ((map['totalAmount'] ?? map['total_amount']) as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TaxComponent {
  final TaxModel tax;
  final double taxAmount;

  TaxComponent({required this.tax, required this.taxAmount});

  TaxComponent copyWith({TaxModel? tax, double? taxAmount}) {
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
      tax: TaxModel.fromMap(map['tax'] as Map<String, dynamic>? ?? {}),
      taxAmount: (map['tax_amount'] as num? ?? map['taxAmount'] as num? ?? 0.0).toDouble(),
    );
  }
}
