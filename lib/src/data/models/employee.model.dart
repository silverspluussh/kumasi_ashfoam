import 'dart:convert';

enum EmploymentStatus { active, inactive, suspended, terminated, probation }

class EmployeeModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String email;
  final String phone;
  final String role;
  final String department;
  final String? branchId;
  final String? branchName;
  final String? managerId;
  final String? managerName;
  final String? designation;
  final EmploymentStatus status;
  final bool isActive;
  final DateTime hireDate;
  final DateTime? endDate;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.email,
    required this.phone,
    required this.role,
    required this.department,
    this.branchId,
    this.branchName,
    this.managerId,
    this.managerName,
    this.designation,
    this.status = EmploymentStatus.active,
    this.isActive = true,
    required this.hireDate,
    this.endDate,
    this.address,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => [
    firstName,
    middleName,
    lastName,
  ].where((part) => part != null && part.isNotEmpty).join(' ');

  EmployeeModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? phone,
    String? role,
    String? department,
    String? branchId,
    String? branchName,
    String? managerId,
    String? managerName,
    String? designation,
    EmploymentStatus? status,
    bool? isActive,
    DateTime? hireDate,
    DateTime? endDate,
    String? address,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      department: department ?? this.department,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      designation: designation ?? this.designation,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      hireDate: hireDate ?? this.hireDate,
      endDate: endDate ?? this.endDate,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email': email,
      'phone': phone,
      'role': role,
      'department': department,
      'branch_id': branchId,
      'branch_name': branchName,
      'manager_id': managerId,
      'manager_name': managerName,
      'designation': designation,
      'status': status.name,
      'is_active': isActive,
      'hire_date': hireDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'address': address,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id']?.toString() ?? '',
      firstName: map['first_name']?.toString() ?? '',
      lastName: map['last_name']?.toString() ?? '',
      middleName: map['middle_name']?.toString(),
      email: map['email']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      department: map['department']?.toString() ?? '',
      branchId: map['branch_id']?.toString(),
      branchName: map['branch_name']?.toString(),
      managerId: map['manager_id']?.toString(),
      managerName: map['manager_name']?.toString(),
      designation: map['designation']?.toString(),
      status: map['status'] != null
          ? EmploymentStatus.values.firstWhere(
              (element) => element.name == map['status']?.toString(),
              orElse: () => EmploymentStatus.active,
            )
          : EmploymentStatus.active,
      isActive: map['is_active'] == true || map['is_active'] == 1,
      hireDate: map['hire_date'] != null
          ? DateTime.tryParse(map['hire_date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      endDate: map['end_date'] != null
          ? DateTime.tryParse(map['end_date'].toString())
          : null,
      address: map['address']?.toString(),
      notes: map['notes']?.toString(),
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
