import 'dart:convert';

import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';

class WayBillModel {
  final String id;
  final Profoma mainContent;
  final String orderNumber;
  final String dispatchDocNumber;
  final String deliveryNote;
  final String senderName;
  final String destination;
  final DateTime dispatchDate;
  final String partyName;
  final String createdBy;
  final int isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  WayBillModel({
    required this.id,
    required this.mainContent,
    required this.orderNumber,
    required this.dispatchDocNumber,
    required this.deliveryNote,
    required this.senderName,
    required this.destination,
    required this.dispatchDate,
    required this.partyName,
    required this.createdBy,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  WayBillModel copyWith({
    String? id,
    Profoma? mainContent,
    String? orderNumber,
    String? dispatchDocNumber,
    String? deliveryNote,
    String? senderName,
    String? destination,
    DateTime? dispatchDate,
    String? partyName,
    String? createdBy,
    int? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WayBillModel(
      id: id ?? this.id,
      mainContent: mainContent ?? this.mainContent,
      orderNumber: orderNumber ?? this.orderNumber,
      dispatchDocNumber: dispatchDocNumber ?? this.dispatchDocNumber,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      senderName: senderName ?? this.senderName,
      destination: destination ?? this.destination,
      dispatchDate: dispatchDate ?? this.dispatchDate,
      isDeleted: isDeleted ?? this.isDeleted,
      partyName: partyName ?? this.partyName,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mainContent': mainContent.toMap(),
      'orderNumber': orderNumber,
      'dispatchDocNumber': dispatchDocNumber,
      'deliveryNote': deliveryNote,
      'senderName': senderName,
      'destination': destination,
      'dispatchDate': dispatchDate.toIso8601String(),
      'partyName': partyName,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory WayBillModel.fromMap(Map<String, dynamic> map) {
    return WayBillModel(
      id: map['id'] as String? ?? '',
      mainContent: map['mainContent'] == null
          ? Profoma(
              id: '',
              tax: [],
              totalQuantity: 0,
              isDeleted: 0,
              totalAmount: 0.0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )
          : (map['mainContent'] is String
                ? Profoma.fromJson(map['mainContent'] as String)
                : Profoma.fromMap(map['mainContent'] as Map<String, dynamic>)),
      orderNumber: map['orderNumber'] as String? ?? '',
      dispatchDocNumber: map['dispatchDocNumber'] as String? ?? '',
      deliveryNote: map['deliveryNote'] as String? ?? '',
      senderName: map['senderName'] as String? ?? '',
      destination: map['destination'] as String? ?? '',
      dispatchDate: map['dispatchDate'] != null
          ? (map['dispatchDate'] is int
                ? DateTime.fromMillisecondsSinceEpoch(
                    map['dispatchDate'] as int,
                  )
                : DateTime.tryParse(map['dispatchDate'].toString()) ??
                    DateTime.now())
          : DateTime.now(),
      isDeleted: (map['isDeleted'] as num?)?.toInt() ?? 0,
      partyName: map['partyName']?.toString() ?? '',
      createdBy: map['createdBy']?.toString() ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is int
                ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
                : DateTime.tryParse(map['createdAt'].toString()) ??
                    DateTime.now())
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] is int
                ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
                : DateTime.tryParse(map['updatedAt'].toString()) ??
                    DateTime.now())
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WayBillModel.fromJson(String source) =>
      WayBillModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
