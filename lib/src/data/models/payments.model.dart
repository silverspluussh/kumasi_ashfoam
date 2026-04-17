class BranchPayment {
  final String id;
  final String branchId;
  final String branchName;
  final double amount;
  final String? note;
  final String title;
  final DateTime createdAt;
  final String createdBy;

  BranchPayment({
    required this.id,
    required this.title,
    this.note,
    required this.branchId,
    required this.branchName,
    required this.amount,
    required this.createdAt,
    required this.createdBy,
  });

  BranchPayment copyWith({
    String? id,
    String? branchId,
    String? branchName,
    double? amount,
    String? note,
    String? title,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return BranchPayment(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'branch_name': branchName,
      'amount': amount,
      'note': note,
      'title': title,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }

  factory BranchPayment.fromMap(Map<String, dynamic> map) {
    return BranchPayment(
      id: map['id'] as String,
      branchId: map['branch_id'] as String,
      branchName: map['branch_name'] as String,
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] as String?,
      title: map['title'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      createdBy: map['created_by'] as String,
    );
  }
}