import 'dart:convert';

class SupplierModel {
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

  SupplierModel({
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

  SupplierModel copyWith({
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
    return SupplierModel(
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

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      supplierCode: map['supplier_code']?.toString(),
      contactName: map['contact_name']?.toString(),
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      address: map['address']?.toString(),
      isActive: (map['is_active'] as num?)?.toInt() ?? 1,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierModel.fromJson(String source) =>
      SupplierModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
