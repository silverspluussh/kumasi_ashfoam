import 'dart:convert';

class InvoiceModel {
  final String id;
  final DateTime dueDate;
  final String? customerName;
  final double totalAmount;
  final double paidAmount;
  final InvoiceStatus status;
  final String? note;
  final String saleOrderId;
  final String? branchName;
  final String? branchId;

  InvoiceModel({
    required this.id,
    required this.dueDate,
    this.customerName,
    required this.totalAmount,
    required this.paidAmount,
    this.status = InvoiceStatus.pending,
    this.note,
    required this.saleOrderId,
    this.branchName,
    this.branchId,
  });

  InvoiceModel copyWith({
    String? id,
    DateTime? dueDate,
    String? customerName,
    double? totalAmount,
    double? paidAmount,
    InvoiceStatus? status,
    String? note,
    String? saleOrderId,
    String? branchName,
    String? branchId,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      dueDate: dueDate ?? this.dueDate,
      customerName: customerName ?? this.customerName,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      branchName: branchName ?? this.branchName,
      branchId: branchId ?? this.branchId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'due_date': dueDate.toIso8601String(),
      'customer_name': customerName,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'status': status.name,
      'note': note,
      'sale_order_id': saleOrderId,
      'branch_name': branchName,
      'branch_id': branchId,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    final dueDateValue = map['due_date'] ?? map['dueDate'];
    final parsedDueDate = dueDateValue is DateTime
        ? dueDateValue
        : dueDateValue is int
            ? DateTime.fromMillisecondsSinceEpoch(dueDateValue)
            : (dueDateValue != null
                ? (DateTime.tryParse(dueDateValue.toString()) ?? DateTime.now())
                : DateTime.now());

    final statusValue = map['status'];
    final parsedStatus = statusValue is InvoiceStatus
        ? statusValue
        : statusValue is String
            ? InvoiceStatus.values.firstWhere(
                (element) => element.name == statusValue,
                orElse: () => InvoiceStatus.pending,
              )
            : InvoiceStatus.pending;

    return InvoiceModel(
      id: map['id'] as String? ?? '',
      dueDate: parsedDueDate,
      customerName: map['customer_name'] as String? ?? map['customerName'] as String?,
      totalAmount: (map['total_amount'] as num? ?? map['totalAmount'] as num? ?? 0).toDouble(),
      paidAmount: (map['paid_amount'] as num? ?? map['paidAmount'] as num? ?? 0).toDouble(),
      status: parsedStatus,
      note: map['note'] as String?,
      saleOrderId: map['sale_order_id'] as String? ?? map['saleOrderId'] as String? ?? '',
      branchName: map['branch_name'] as String? ?? map['branchName'] as String?,
      branchId: map['branch_id'] as String? ?? map['branchId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  double get balanceDue => totalAmount - paidAmount;
}

enum InvoiceStatus {
  pending,
  partial,
  paid,
  overdue,
  cancelled,
}