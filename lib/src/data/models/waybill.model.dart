import 'dart:convert';

import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';

class WayBill {
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

  WayBill({
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

  WayBill copyWith({
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
    return WayBill(
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
      'main_content': mainContent.toMap(),
      'order_number': orderNumber,
      'dispatch_doc_number': dispatchDocNumber,
      'delivery_note': deliveryNote,
      'sender_name': senderName,
      'destination': destination,
      'dispatch_date': dispatchDate.toIso8601String(),
      'party_name': partyName,
      'is_deleted': isDeleted,

      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory WayBill.fromMap(Map<String, dynamic> map) {
    return WayBill(
      id: map['id'] as String? ?? '',
      mainContent: map['mainContent'] == null
          ? Profoma(
              id: '',
              tax: [],
              totalQuantity: 0,
              isDeleted: 0,
              totalAmount: 0.0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now())
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
              ? DateTime.fromMillisecondsSinceEpoch(map['dispatchDate'] as int)
              : DateTime.parse(map['dispatchDate'] as String))
          : DateTime.now(),
      isDeleted: map['isDeleted'] as int? ?? 0,
      partyName: map['partyName'] as String? ?? '',
      createdBy: map['createdBy'] as String? ?? '',
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is int 
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : DateTime.parse(map['createdAt'] as String))
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] is int 
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : DateTime.parse(map['updatedAt'] as String))
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WayBill.fromJson(String source) =>
      WayBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
