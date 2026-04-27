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
      'orderNumber': orderNumber,
      'customerName': customerName,
      'channel': channel,
      'branchId': branchId,
      'branchName': branchName,
      'totalQuantity': totalQuantity,
      'totalAmount': totalAmount,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'status': status,
      'isSynced': isSynced,
      'createdAt': createdAt?.toIso8601String(),
      'lastSyncedAt': lastSyncedAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }

  factory SaleOrderModel.fromMap(Map<String, dynamic> map) {
    return SaleOrderModel(
      id: map['id'] as String? ?? '',
      orderNumber: map['orderNumber'] as String? ?? 'N/A',
      totalQuantity: (map['totalQuantity'] as num?)?.toInt() ?? 0,
      customerName: map['customerName'] as String?,
      channel: map['channel'] as String?,
      branchName: map['branchName'] as String?,
      branchId: map['branchId'] as String?,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (map['discountAmount'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['taxAmount'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] as String? ?? 'pending',
      isSynced: map['isSynced'] as int? ?? 0,
      createdAt: (map['createdAt'] ?? map['created_at']) != null
          ? ((map['createdAt'] ?? map['created_at']) is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    (map['createdAt'] ?? map['created_at']) as int,
                  )
                : DateTime.tryParse(
                    (map['createdAt'] ?? map['created_at']).toString(),
                  ))
          : null,
      lastSyncedAt: (map['lastSyncedAt'] ?? map['last_synced_at']) != null
          ? ((map['lastSyncedAt'] ?? map['last_synced_at']) is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    (map['lastSyncedAt'] ?? map['last_synced_at']) as int,
                  )
                : (DateTime.tryParse(
                        (map['lastSyncedAt'] ?? map['last_synced_at'])
                            .toString(),
                      ) ??
                      DateTime.now()))
          : DateTime.now(),
      createdBy: map['createdBy'] as String? ?? 'system',
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
      id: map['id'] as String? ?? '',
      productId: map['productId'] as String?,
      saleOrderId: map['saleOrderId'] as String? ?? '',
      productName: map['productName'] as String? ?? 'Unknown Product',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unitPrice'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (map['discountAmount'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['taxAmount'] as num?)?.toDouble() ?? 0.0,
      isSynced: map['isSynced'] as int? ?? 0,
      lastSyncedAt: map['lastSyncedAt'] != null
          ? DateTime.tryParse(map['lastSyncedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'saleOrderId': saleOrderId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'discountAmount': discountAmount,
      'taxAmount': taxAmount,
      'isSynced': isSynced,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
    };
  }
}
