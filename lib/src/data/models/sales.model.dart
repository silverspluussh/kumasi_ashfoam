// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SaleOrderModel {
  final String id;
  final String orderNumber;
  final String? customerName;
  final String? channel;
  final String? branchId;
  final String? branchName;
  final double totalAmount;
  final double discountAmount;
  final int totalQuantity;
  final double taxAmount;
  final String status;
  final int isSynced;
  final DateTime lastSyncedAt;
  final String createdBy;
  final DateTime? createdAt;

  SaleOrderModel({
    required this.id,
    required this.orderNumber,
    required this.totalQuantity,
    this.customerName,
    this.channel,
    this.branchId,
    this.branchName,
    required this.totalAmount,
    this.discountAmount = 0.0,
    this.taxAmount = 0.0,
    required this.status,
    this.isSynced = 0,
    required this.createdBy,
    required this.lastSyncedAt,
    this.createdAt,
  });

  SaleOrderModel copyWith({
    String? id,
    String? orderNumber,
    String? customerId,
    String? customerName,
    String? channel,
    int? totalQuantity,
    String? branchId,
    String? branchName,
    String? createdBy,
    double? totalAmount,
    double? discountAmount,
    double? taxAmount,
    String? status,
    int? isSynced,
    DateTime? createdAt,
    DateTime? lastSyncedAt,
  }) {
    return SaleOrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      channel: channel ?? this.channel,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      taxAmount: taxAmount ?? this.taxAmount,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_number': orderNumber,
      'customer_name': customerName,
      'channel': channel,
      'branch_id': branchId,
      'branch_name': branchName,
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'status': status,
      'is_synced': isSynced,
      'created_at': createdAt?.toIso8601String(),
      'last_synced_at': lastSyncedAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  factory SaleOrderModel.fromMap(Map<String, dynamic> map) {
    return SaleOrderModel(
      id: map['id'] as String,
      orderNumber: map['order_number'] as String,
     totalQuantity: map['total_quantity'] as int,

      customerName: map['customer_name'] != null
          ? map['customer_name'] as String
          : null,
      channel: map['channel'] != null ? map['channel'] as String : null,
      branchName: map['branch_name'] != null
          ? map['branch_name'] as String
          : null,
      branchId: map['branch_id'] != null ? map['branch_id'] as String : null,
      totalAmount: (map['total_amount'] as num).toDouble(),
      discountAmount: map['discount_amount'] != null
          ? (map['discount_amount'] as num).toDouble()
          : 0.0,
      taxAmount: map['tax_amount'] != null
          ? (map['tax_amount'] as num).toDouble()
          : 0.0,
      status: map['status'] as String,
      isSynced: map['is_synced'] as int? ?? 0,

      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,

      lastSyncedAt:  map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : DateTime.now(),
      createdBy: map['created_by'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleOrderModel.fromJson(String source) =>
      SaleOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SaleOrderItem {
  final String id;
  final String? productId;
  final String saleOrderId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double discountAmount;
  final double taxAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;

  SaleOrderItem({
    required this.id,
    this.productId,
    required this.saleOrderId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.discountAmount = 0.0,
    this.taxAmount = 0.0,
    this.isSynced = 0,
    this.lastSyncedAt,
  });

  SaleOrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? discountAmount,
    String? saleOrderId,
    double? taxAmount,
    int? isSynced,
    DateTime? lastSyncedAt,
  }) {
    return SaleOrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  factory SaleOrderItem.fromMap(Map<String, dynamic> map) {
    return SaleOrderItem(
      id: map['id'] as String,
      productId: map['product_id'] != null ? map['product_id'] as String : null,
      saleOrderId: map['sale_order_id'] as String,
      productName: map['product_name'] as String,
      quantity: map['quantity'] as int,
      unitPrice: (map['unit_price'] as num).toDouble(),
      totalPrice: (map['total_price'] as num).toDouble(),
      discountAmount: map['discount_amount'] != null
          ? (map['discount_amount'] as num).toDouble()
          : 0.0,
      taxAmount: map['tax_amount'] != null
          ? (map['tax_amount'] as num).toDouble()
          : 0.0,
      isSynced: map['is_synced'] as int? ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'sale_order_id': saleOrderId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }
}
