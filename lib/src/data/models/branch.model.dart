import 'dart:convert';

class Branch {
  final String id;
  final String storeId;
  final String storeName;
  final String branchName;
  final String? branchAddress;
  final String? contact;
  final int isActive;
  final String? branchManagerName;
  final String? branchManagerId;
  final int isDeleted;
  final String companyDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  Branch({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.branchName,
    this.branchAddress,
    this.contact,
    required this.isActive,
    this.branchManagerName,
    this.branchManagerId,
    required this.isDeleted,
    required this.companyDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  Branch copyWith({
    String? id,
    String? storeId,
    String? storeName,
    String? branchName,
    String? branchAddress,
    String? contact,
    int? isActive,
    String? branchManagerName,
    String? branchManagerId,
    int? isDeleted,
    String? companyDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Branch(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      contact: contact ?? this.contact,
      isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
      companyDetails: companyDetails ?? this.companyDetails,
      branchManagerName: branchManagerName ?? this.branchManagerName,
      branchManagerId: branchManagerId ?? this.branchManagerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'store_id': storeId,
      'store_name': storeName,
      'branch_name': branchName,
      'branch_address': branchAddress,
      'contact': contact,
      'is_active': isActive,
      'is_deleted': isDeleted,
      'company_details': jsonEncode(companyDetails),
      'branch_manager_name': branchManagerName,
      'branch_manager_id': branchManagerId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'] as String,
      storeId: map['store_id'] as String,
      storeName: map['store_name'] as String,
      branchName: map['branch_name'] as String,
      branchAddress: map['branch_address'] as String?,
      contact: map['contact'] as String?,
      isActive: map['is_active'] as int,
      isDeleted: map['is_deleted'] as int,
      companyDetails: jsonDecode(map['company_details'] as String) as String,
      branchManagerName: map['branch_manager_name'] as String?,
      branchManagerId: map['branch_manager_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}


class Store{
  final String id;
  final DateTime createdAt;
  final String name;
  final String address;
  final int isActive;

  Store({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.address,
    required this.isActive,
  });

  Store copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? address,
    int? isActive,
  }) {
    return Store(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'address': address,
      'is_active': isActive,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      name: map['name'] as String,
      address: map['address'] as String,
      isActive: map['is_active'] as int,
    );
  }
}