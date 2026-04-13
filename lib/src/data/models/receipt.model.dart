import 'dart:convert';

import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart';

class Receipt {
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

  Receipt({
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
   required  this.billNumber,


  });

  Receipt copyWith({
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
    return Receipt(
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
      billNumber: billNumber
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

  factory Receipt.fromMap(Map<String, dynamic> map) {
    final itemsData = map['items'];
    final taxData = map['tax'];

    final itemsList = itemsData is String
        ? json.decode(itemsData) as List<dynamic>
        : (itemsData as List<dynamic>);

    final taxList = taxData is String
        ? json.decode(taxData) as List<dynamic>
        : (taxData as List<dynamic>);

    return Receipt(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
      createdByName: map['created_by_name'] as String,
      branchId: map['branch_id'] as String,
      branchName: map['branch_name'] as String,
      items: itemsList
          .map((item) => SaleOrderItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      totalAmount: (map['total_amount'] as num).toDouble(),
      customerName: map['customer_name'] != null ? map['customer_name'] as String : null,
      customerAddress: map['customer_address'] != null ? map['customer_address'] as String : null,
      billNumber: map['bill_number'] as String,
      tax: taxList.map((entry) {
        final taxMap = entry['tax'] as Map<String, dynamic>;
        return TaxComponent(
          tax: Tax.fromMap(taxMap),
          taxAmount: (entry['tax_amount'] as num).toDouble(),
        );
      }).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Receipt.fromJson(String source) =>
      Receipt.fromMap(json.decode(source) as Map<String, dynamic>);
}
