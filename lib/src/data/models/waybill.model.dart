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
      id: map['id'] as String,
      mainContent: Profoma.fromMap(map['main_content'] as Map<String, dynamic>),
      orderNumber: map['order_number'] as String,
      dispatchDocNumber: map['dispatch_doc_number'] as String,
      deliveryNote: map['delivery_note'] as String,
      senderName: map['sender_name'] as String,
      destination: map['destination'] as String,
      dispatchDate: DateTime.parse(map['dispatch_date'] as String),
      isDeleted: map['is_deleted'] as int? ?? 0,
      partyName: map['party_name'] as String,
      createdBy: map['created_by'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory WayBill.fromJson(String source) =>
      WayBill.fromMap(json.decode(source) as Map<String, dynamic>);
}
