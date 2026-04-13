import 'dart:convert';

enum ReturnOrderStatus { pending, approved, rejected, completed }

enum CreditNoteStatus { draft, issued, applied, voided }

class ReturnOrder {
  final String id;
  final String returnOrderNumber;
  final String saleOrderId;
  final String? invoiceId;
  final String? customerName;
  final String? branchId;
  final String? branchName;
  final int totalItems;
  final double totalAmount;
  final double refundAmount;
  final double totalTax;
  final ReturnOrderStatus status;
  final String? reason;
  final String createdBy;
  final DateTime returnDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isSynced;
  final DateTime? lastSyncedAt;

  ReturnOrder({
    required this.id,
    required this.returnOrderNumber,
    required this.saleOrderId,
    this.invoiceId,
    this.customerName,
    this.branchId,
    this.branchName,
    required this.totalItems,
    required this.totalAmount,
    required this.refundAmount,
    required this.totalTax,
    this.status = ReturnOrderStatus.pending,
    this.reason,
    required this.createdBy,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = 0,
    this.lastSyncedAt,
  });

  ReturnOrder copyWith({
    String? id,
    String? returnOrderNumber,
    String? saleOrderId,
    String? invoiceId,
    String? customerName,
    String? branchId,
    String? branchName,
    int? totalItems,
    double? totalAmount,
    double? refundAmount,
    double? totalTax,
    ReturnOrderStatus? status,
    String? reason,
    String? createdBy,
    DateTime? returnDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isSynced,
    DateTime? lastSyncedAt,
  }) {
    return ReturnOrder(
      id: id ?? this.id,
      returnOrderNumber: returnOrderNumber ?? this.returnOrderNumber,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      invoiceId: invoiceId ?? this.invoiceId,
      customerName: customerName ?? this.customerName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalItems: totalItems ?? this.totalItems,
      totalAmount: totalAmount ?? this.totalAmount,
      refundAmount: refundAmount ?? this.refundAmount,
      totalTax: totalTax ?? this.totalTax,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      createdBy: createdBy ?? this.createdBy,
      returnDate: returnDate ?? this.returnDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'return_order_number': returnOrderNumber,
      'sale_order_id': saleOrderId,
      'invoice_id': invoiceId,
      'customer_name': customerName,
      'branch_id': branchId,
      'branch_name': branchName,
      'total_items': totalItems,
      'total_amount': totalAmount,
      'refund_amount': refundAmount,
      'total_tax': totalTax,
      'status': status.name,
      'reason': reason,
      'created_by': createdBy,
      'return_date': returnDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }

  factory ReturnOrder.fromMap(Map<String, dynamic> map) {
    return ReturnOrder(
      id: map['id'] as String,
      returnOrderNumber: map['return_order_number'] as String,
      saleOrderId: map['sale_order_id'] as String,
      invoiceId: map['invoice_id'] as String?,
      customerName: map['customer_name'] as String?,
      branchId: map['branch_id'] as String?,
      branchName: map['branch_name'] as String?,
      totalItems: map['total_items'] as int,
      totalAmount: (map['total_amount'] as num).toDouble(),
      refundAmount: (map['refund_amount'] as num).toDouble(),
      totalTax: (map['total_tax'] as num).toDouble(),
      status: map['status'] != null
          ? ReturnOrderStatus.values.firstWhere(
              (element) => element.name == map['status'] as String,
              orElse: () => ReturnOrderStatus.pending,
            )
          : ReturnOrderStatus.pending,
      reason: map['reason'] as String?,
      createdBy: map['created_by'] as String,
      returnDate: DateTime.parse(map['return_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      isSynced: map['is_synced'] as int? ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReturnOrder.fromJson(String source) =>
      ReturnOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReturnOrderItem {
  final String id;
  final String? productId;
  final String returnOrderId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double taxAmount;
  final String? reason;
  final double refundAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;

  ReturnOrderItem({
    required this.id,
    this.productId,
    required this.returnOrderId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.taxAmount = 0.0,
    this.reason,
    required this.refundAmount,
    this.isSynced = 0,
    this.lastSyncedAt,
  });

  ReturnOrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? taxAmount,
    String? returnOrderId,
    String? reason,
    double? refundAmount,
    int? isSynced,
    DateTime? lastSyncedAt,
  }) {
    return ReturnOrderItem(
      id: id ?? this.id,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      taxAmount: taxAmount ?? this.taxAmount,
      reason: reason ?? this.reason,
      refundAmount: refundAmount ?? this.refundAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'return_order_id': returnOrderId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'tax_amount': taxAmount,
      'reason': reason,
      'refund_amount': refundAmount,
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }

  factory ReturnOrderItem.fromMap(Map<String, dynamic> map) {
    return ReturnOrderItem(
      id: map['id'] as String,
      productId: map['product_id'] as String?,
      returnOrderId:  map['return_order_id'] as String,
      productName: map['product_name'] as String,
      quantity: (map['quantity'] as num).toInt(),
      unitPrice: (map['unit_price'] as num).toDouble(),
      totalPrice: (map['total_price'] as num).toDouble(),
      taxAmount: map['tax_amount'] != null
          ? (map['tax_amount'] as num).toDouble()
          : 0.0,
      reason: map['reason'] as String?,
      refundAmount: (map['refund_amount'] as num).toDouble(),
      isSynced: map['is_synced'] as int? ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : null,
    );
  }
}

class CreditNote {
  final String id;
  final String creditNoteNumber;
  final String? invoiceId;
  final String? returnOrderId;
  final String? customerName;
  final String? branchId;
  final String? branchName;
  final int totalItems;
  final double totalAmount;
  final double appliedAmount;
  final CreditNoteStatus status;
  final String? note;
  final String createdBy;
  final DateTime issuedAt;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isSynced;
  final DateTime? lastSyncedAt;

  CreditNote({
    required this.id,
    required this.creditNoteNumber,
    this.invoiceId,
    this.returnOrderId,
    this.customerName,
    this.branchId,
    this.branchName,
    required this.totalItems,
    required this.totalAmount,
    this.appliedAmount = 0.0,
    this.status = CreditNoteStatus.draft,
    this.note,
    required this.createdBy,
    required this.issuedAt,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = 0,
    this.lastSyncedAt,
  });

  CreditNote copyWith({
    String? id,
    String? creditNoteNumber,
    String? invoiceId,
    String? returnOrderId,
    String? customerName,
    String? branchId,
    String? branchName,
    int? totalItems,
    double? totalAmount,
    double? appliedAmount,
    CreditNoteStatus? status,
    String? note,
    String? createdBy,
    DateTime? issuedAt,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isSynced,
    DateTime? lastSyncedAt,
  }) {
    return CreditNote(
      id: id ?? this.id,
      creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
      invoiceId: invoiceId ?? this.invoiceId,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      customerName: customerName ?? this.customerName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalItems: totalItems ?? this.totalItems,
      totalAmount: totalAmount ?? this.totalAmount,
      appliedAmount: appliedAmount ?? this.appliedAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      createdBy: createdBy ?? this.createdBy,
      issuedAt: issuedAt ?? this.issuedAt,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  double get balanceDue => totalAmount - appliedAmount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'credit_note_number': creditNoteNumber,
      'invoice_id': invoiceId,
      'return_order_id': returnOrderId,
      'customer_name': customerName,
      'branch_id': branchId,
      'branch_name': branchName,
      'total_items': totalItems,
      'total_amount': totalAmount,
      'applied_amount': appliedAmount,
      'status': status.name,
      'note': note,
      'created_by': createdBy,
      'issued_at': issuedAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }

  factory CreditNote.fromMap(Map<String, dynamic> map) {
    return CreditNote(
      id: map['id'] as String,
      creditNoteNumber: map['credit_note_number'] as String,
      invoiceId: map['invoice_id'] as String?,
      returnOrderId: map['return_order_id'] as String?,
      customerName: map['customer_name'] as String?,
      branchId: map['branch_id'] as String?,
      branchName: map['branch_name'] as String?,
      totalItems: map['total_items'] as int,
      totalAmount: (map['total_amount'] as num).toDouble(),
      appliedAmount: map['applied_amount'] != null
          ? (map['applied_amount'] as num).toDouble()
          : 0.0,
      status: map['status'] != null
          ? CreditNoteStatus.values.firstWhere(
              (element) => element.name == map['status'] as String,
              orElse: () => CreditNoteStatus.draft,
            )
          : CreditNoteStatus.draft,
      note: map['note'] as String?,
      createdBy: map['created_by'] as String,
      issuedAt: DateTime.parse(map['issued_at'] as String),
      dueDate: map['due_date'] != null
          ? DateTime.parse(map['due_date'] as String)
          : null,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      isSynced: map['is_synced'] as int? ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditNote.fromJson(String source) =>
      CreditNote.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CreditNoteItem {
  final String id;
  final String creditNoteId;
  final String? productId;
  final String description;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double taxAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;

  CreditNoteItem({
    required this.id,
    this.productId,
    required this.creditNoteId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.taxAmount = 0.0,
    this.isSynced = 0,
    this.lastSyncedAt,
  });

  CreditNoteItem copyWith({
    String? id,
    String? productId,
    String? description,
    String? creditNoteId,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? taxAmount,
    int? isSynced,
    DateTime? lastSyncedAt,
  }) {
    return CreditNoteItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      creditNoteId: creditNoteId ?? this.creditNoteId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      taxAmount: taxAmount ?? this.taxAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'description': description,
      'quantity': quantity,
      'credit_note_id': creditNoteId,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'tax_amount': taxAmount,
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }

  factory CreditNoteItem.fromMap(Map<String, dynamic> map) {
    return CreditNoteItem(
      id: map['id'] as String,
      productId: map['product_id'] as String?,
      creditNoteId: map['credit_note_id'] as String,
      description: map['description'] as String,
      quantity: (map['quantity'] as num).toInt(),
      unitPrice: (map['unit_price'] as num).toDouble(),
      totalPrice: (map['total_price'] as num).toDouble(),
      taxAmount: map['tax_amount'] != null
          ? (map['tax_amount'] as num).toDouble()
          : 0.0,
      isSynced: map['is_synced'] as int? ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.parse(map['last_synced_at'] as String)
          : null,
    );
  }
}
