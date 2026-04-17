import 'dart:convert';

class Invoice {
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

  Invoice({
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

  Invoice copyWith({
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
    return Invoice(
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

  factory Invoice.fromMap(Map<String, dynamic> map) {
    final dueDateValue = map['due_date'];
    final parsedDueDate = dueDateValue is DateTime
        ? dueDateValue
        : dueDateValue is int
            ? DateTime.fromMillisecondsSinceEpoch(dueDateValue)
            : DateTime.parse(dueDateValue as String);

    final statusValue = map['status'];
    final parsedStatus = statusValue is InvoiceStatus
        ? statusValue
        : statusValue is String
            ? InvoiceStatus.values.firstWhere(
                (element) => element.name == statusValue,
                orElse: () => InvoiceStatus.pending,
              )
            : InvoiceStatus.pending;

    return Invoice(
      id: map['id'] as String,
      dueDate: parsedDueDate,
      customerName:
          map['customer_name'] != null ? map['customer_name'] as String : null,
      totalAmount: (map['total_amount'] as num).toDouble(),
      paidAmount: (map['paid_amount'] as num).toDouble(),
      status: parsedStatus,
      note: map['note'] != null ? map['note'] as String : null,
      saleOrderId: map['sale_order_id'] as String,
      branchName: map['branch_name'] != null ? map['branch_name'] as String : null,
      branchId: map['branch_id'] != null ? map['branch_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  double get balanceDue => totalAmount - paidAmount;
}

enum InvoiceStatus {
  pending,
  partial,
  paid,
  overdue,
  cancelled,
}