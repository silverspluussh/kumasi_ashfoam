import 'dart:convert';

import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart';

class ReceiptModel {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String createdByName;
  final String branchId;
  final String branchName;
  final String billNumber;
  final String? customerName;
  final String? customerAddress;
  final List<SaleOrderItem> items;
  final double totalAmount;
  final List<TaxComponent> tax;

  ReceiptModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.createdByName,
    required this.branchId,
    required this.branchName,
    required this.items,
    required this.totalAmount,
    required this.tax,
    this.customerName,
    this.customerAddress,
    required this.billNumber,
  });

  ReceiptModel copyWith({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? createdByName,
    String? branchId,
    String? branchName,
    List<SaleOrderItem>? items,
    double? totalAmount,
    List<TaxComponent>? tax,
  }) {
    return ReceiptModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      tax: tax ?? this.tax,
      customerAddress: customerAddress,
      customerName: customerName,
      billNumber: billNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'created_by_name': createdByName,
      'branch_id': branchId,
      'branch_name': branchName,
      'items': items.map((item) => item.toMap()).toList(),
      'total_amount': totalAmount,
      'customer_name': customerName,
      'customer_address': customerAddress,
      'bill_number': billNumber,
      'tax': tax
          .map(
            (component) => {
              'tax': component.tax.toMap(),
              'tax_amount': component.taxAmount,
            },
          )
          .toList(),
    };
  }

  factory ReceiptModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> itemsList = [];
    try {
      final itemsData = map['items'];
      if (itemsData != null) {
        itemsList = itemsData is String
            ? json.decode(itemsData) as List<dynamic>
            : (itemsData as List<dynamic>);
      }
    } catch (_) {}

    List<dynamic> taxList = [];
    try {
      final taxData = map['tax'];
      if (taxData != null) {
        taxList = taxData is String
            ? json.decode(taxData) as List<dynamic>
            : (taxData as List<dynamic>);
      }
    } catch (_) {}

    return ReceiptModel(
      id: map['id']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      createdBy: map['created_by']?.toString() ?? '',
      createdByName: map['created_by_name']?.toString() ?? '',
      branchId: map['branch_id']?.toString() ?? '',
      branchName: map['branch_name']?.toString() ?? '',
      items: itemsList
          .whereType<Map<String, dynamic>>()
          .map((item) => SaleOrderItem.fromMap(item))
          .toList(),
      totalAmount: (map['total_amount'] as num?)?.toDouble() ?? 0.0,
      customerName: map['customer_name']?.toString(),
      customerAddress: map['customer_address']?.toString(),
      billNumber: map['bill_number']?.toString() ?? '',
      tax: taxList.whereType<Map<String, dynamic>>().map((entryMap) {
        final taxMap = entryMap['tax'];
        return TaxComponent(
          tax: taxMap is Map<String, dynamic>
              ? TaxModel.fromMap(taxMap)
              : TaxModel(id: '', name: '', valuePercentage: 0),
          taxAmount: (entryMap['tax_amount'] as num?)?.toDouble() ?? 0.0,
        );
      }).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceiptModel.fromJson(String source) =>
      ReceiptModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
