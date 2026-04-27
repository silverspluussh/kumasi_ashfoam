class ExpenseModel {
  final String id;
  final ExpenseType expenseType;
  final String? description;
  final double amount;
  final String paymentMethod;
  final DateTime createdAt;
  final String createdBy;
  final String branchId;
  final String branchName;
  final DateTime expenseDate;

  ExpenseModel({
    required this.id,
    required this.expenseType,
    this.description,
    required this.amount,

    required this.paymentMethod,
    required this.createdAt,
    required this.createdBy,
    required this.branchId,
    required this.branchName,
    required this.expenseDate,
  });

  ExpenseModel copyWith({
    String? id,
    ExpenseType? expenseType,
    String? description,
    double? amount,
    String? paymentMethod,
    DateTime? createdAt,
    String? createdBy,
    String? branchId,
    String? branchName,

    DateTime? expenseDate,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      expenseType: expenseType ?? this.expenseType,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      expenseDate: expenseDate ?? this.expenseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expense_type': expenseType.name.toLowerCase(),
      'description': description,
      'amount': amount,
      'payment_method': paymentMethod,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'branch_id': branchId,
      'branch_name': branchName,
      'expense_date': expenseDate.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id']?.toString() ?? '',
      expenseType: ExpenseTypeExtension.fromString(map['expense_type']?.toString() ?? 'other'),
      description: map['description']?.toString(),
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: map['payment_method']?.toString() ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      createdBy: map['created_by']?.toString() ?? '',
      branchId: map['branch_id']?.toString() ?? '',
      branchName: map['branch_name']?.toString() ?? '',
      expenseDate: map['expense_date'] != null
          ? DateTime.tryParse(map['expense_date'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

enum ExpenseType {
  utility,
  transportation,
  rent,
  salary,
  maintenance,
  officeSupplies,
  travel,
  marketing,
  other
}

extension ExpenseTypeExtension on ExpenseType {
  String get name {
    switch (this) {
      case ExpenseType.utility:
        return 'Utility';
      case ExpenseType.transportation:
        return 'Transportation';
      case ExpenseType.rent:
        return 'Rent';
      case ExpenseType.salary:
        return 'Salary';
      case ExpenseType.maintenance:
        return 'Maintenance';
      case ExpenseType.officeSupplies:
        return 'Shop Supplies';
      case ExpenseType.travel:
        return 'Travel';
      case ExpenseType.marketing:
        return 'Marketing';
      case ExpenseType.other:
        return 'Other';
    }
  }

  static ExpenseType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'utility':
        return ExpenseType.utility;
      case 'transportation':
        return ExpenseType.transportation;
      case 'rent':
        return ExpenseType.rent;
      case 'salary':
        return ExpenseType.salary;
      case 'maintenance':
        return ExpenseType.maintenance;
      case 'shopsupplies':
      case 'office supplies':
      case 'shop supplies':
      case 'officeSupplies':
        return ExpenseType.officeSupplies;
      case 'travel':
        return ExpenseType.travel;
      case 'marketing':
        return ExpenseType.marketing;
      default:
        return ExpenseType.other;
    }
  }
}