import 'dart:convert';

enum EmploymentStatus { active, inactive, suspended, terminated, probation }

class Employee {
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

  Employee({
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

  Employee copyWith({
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
    return Employee(
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

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      middleName: map['middle_name'] as String?,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      department: map['department'] as String,
      branchId: map['branch_id'] as String?,
      branchName: map['branch_name'] as String?,
      managerId: map['manager_id'] as String?,
      managerName: map['manager_name'] as String?,
      designation: map['designation'] as String?,
      status: map['status'] != null
          ? EmploymentStatus.values.firstWhere(
              (element) => element.name == map['status'] as String,
              orElse: () => EmploymentStatus.active,
            )
          : EmploymentStatus.active,
      isActive: map['is_active'] as bool? ?? true,
      hireDate: DateTime.parse(map['hire_date'] as String),
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date'] as String)
          : null,
      address: map['address'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);
}
