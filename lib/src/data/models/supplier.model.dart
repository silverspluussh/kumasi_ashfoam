import 'dart:convert';

class Supplier {
  final String id;
  final String name;
  final String? supplierCode;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? address;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Supplier({
    required this.id,
    required this.name,
    this.supplierCode,
    this.contactName,
    this.email,
    this.phone,
    this.address,
    this.isActive = 1,
    required this.createdAt,
    required this.updatedAt,
  });

  Supplier copyWith({
    String? id,
    String? name,
    String? supplierCode,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      supplierCode: supplierCode ?? this.supplierCode,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'supplier_code': supplierCode,
      'contact_name': contactName,
      'email': email,
      'phone': phone,
      'address': address,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as String,
      name: map['name'] as String,
      supplierCode: map['supplier_code'] as String?,
      contactName: map['contact_name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      isActive: map['is_active'] as int? ?? 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Supplier.fromJson(String source) =>
      Supplier.fromMap(json.decode(source) as Map<String, dynamic>);
}
