import 'dart:convert';

enum ReturnOrderStatus { pending, approved, rejected, completed }

enum CreditNoteStatus { draft, issued, applied, voided }

class ReturnOrderModel {
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

  ReturnOrderModel({
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

  ReturnOrderModel copyWith({
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
    return ReturnOrderModel(
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

  factory ReturnOrderModel.fromMap(Map<String, dynamic> map) {
    return ReturnOrderModel(
      id: map['id']?.toString() ?? '',
      returnOrderNumber: map['return_order_number']?.toString() ?? '',
      saleOrderId: map['sale_order_id']?.toString() ?? '',
      invoiceId: map['invoice_id']?.toString(),
      customerName: map['customer_name']?.toString(),
      branchId: map['branch_id']?.toString(),
      branchName: map['branch_name']?.toString(),
      totalItems: (map['total_items'] as num?)?.toInt() ?? 0,
      totalAmount: (map['total_amount'] as num?)?.toDouble() ?? 0.0,
      refundAmount: (map['refund_amount'] as num?)?.toDouble() ?? 0.0,
      totalTax: (map['total_tax'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] != null
          ? ReturnOrderStatus.values.firstWhere(
              (element) => element.name == map['status']?.toString(),
              orElse: () => ReturnOrderStatus.pending,
            )
          : ReturnOrderStatus.pending,
      reason: map['reason']?.toString(),
      createdBy: map['created_by']?.toString() ?? '',
      returnDate: map['return_date'] != null
          ? DateTime.tryParse(map['return_date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isSynced: (map['is_synced'] as num?)?.toInt() ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.tryParse(map['last_synced_at'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReturnOrderModel.fromJson(String source) =>
      ReturnOrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReturnOrderItemModel {
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

  ReturnOrderItemModel({
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

  ReturnOrderItemModel copyWith({
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
    return ReturnOrderItemModel(
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

  factory ReturnOrderItemModel.fromMap(Map<String, dynamic> map) {
    return ReturnOrderItemModel(
      id: map['id']?.toString() ?? '',
      productId: map['product_id']?.toString(),
      returnOrderId: map['return_order_id']?.toString() ?? '',
      productName: map['product_name']?.toString() ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unit_price'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (map['total_price'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['tax_amount'] as num?)?.toDouble() ?? 0.0,
      reason: map['reason']?.toString(),
      refundAmount: (map['refund_amount'] as num?)?.toDouble() ?? 0.0,
      isSynced: (map['is_synced'] as num?)?.toInt() ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.tryParse(map['last_synced_at'].toString())
          : null,
    );
  }
}

class CreditNoteModel {
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

  CreditNoteModel({
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

  CreditNoteModel copyWith({
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
    return CreditNoteModel(
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

  factory CreditNoteModel.fromMap(Map<String, dynamic> map) {
    return CreditNoteModel(
      id: map['id']?.toString() ?? '',
      creditNoteNumber: map['credit_note_number']?.toString() ?? '',
      invoiceId: map['invoice_id']?.toString(),
      returnOrderId: map['return_order_id']?.toString(),
      customerName: map['customer_name']?.toString(),
      branchId: map['branch_id']?.toString(),
      branchName: map['branch_name']?.toString(),
      totalItems: (map['total_items'] as num?)?.toInt() ?? 0,
      totalAmount: (map['total_amount'] as num?)?.toDouble() ?? 0.0,
      appliedAmount: (map['applied_amount'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] != null
          ? CreditNoteStatus.values.firstWhere(
              (element) => element.name == map['status']?.toString(),
              orElse: () => CreditNoteStatus.draft,
            )
          : CreditNoteStatus.draft,
      note: map['note']?.toString(),
      createdBy: map['created_by']?.toString() ?? '',
      issuedAt: map['issued_at'] != null
          ? DateTime.tryParse(map['issued_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      dueDate: map['due_date'] != null
          ? DateTime.tryParse(map['due_date'].toString())
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isSynced: (map['is_synced'] as num?)?.toInt() ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.tryParse(map['last_synced_at'].toString())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditNoteModel.fromJson(String source) =>
      CreditNoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CreditNoteItemModel {
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

  CreditNoteItemModel({
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

  CreditNoteItemModel copyWith({
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
    return CreditNoteItemModel(
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

  factory CreditNoteItemModel.fromMap(Map<String, dynamic> map) {
    return CreditNoteItemModel(
      id: map['id']?.toString() ?? '',
      productId: map['product_id']?.toString(),
      creditNoteId: map['credit_note_id']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (map['unit_price'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (map['total_price'] as num?)?.toDouble() ?? 0.0,
      taxAmount: (map['tax_amount'] as num?)?.toDouble() ?? 0.0,
      isSynced: (map['is_synced'] as num?)?.toInt() ?? 0,
      lastSyncedAt: map['last_synced_at'] != null
          ? DateTime.tryParse(map['last_synced_at'].toString())
          : null,
    );
  }
}
