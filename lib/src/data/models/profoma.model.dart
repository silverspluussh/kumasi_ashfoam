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
    List<ProductDetails>? productDetails,
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
      isDeleted:  isDeleted ?? this.isDeleted,
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

  factory Profoma.fromMap(Map<String, dynamic> map) {
    return Profoma(
      id: map['id'] as String,
      partyName: map['party_name'] as String?,
      partyAddress: map['party_address'] as String?,
      tax: (map['tax'] as List<dynamic>)
          .map((item) => TaxComponent.fromMap(item as Map<String, dynamic>))
          .toList(),
      totalQuantity: (map['total_quantity'] as num).toInt(),
      declaration: map['declaration'] as String?,
      isDeleted: map['is_deleted'] as int,
      totalAmount: (map['total_amount'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
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
      productId: map['product_id'] as String,
      proformaId: map['proforma_id'] as String?,
      waybillId: map['waybill_id'] as String?,
      productName: map['product_name'] as String,
      quantity: (map['quantity'] as num).toInt(),
      unitprice: (map['unit_price'] as num).toDouble(),
      discountPercentage: (map['discount_percentage'] as num).toDouble(),
      totalAmount: (map['total_amount'] as num).toDouble(),
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
