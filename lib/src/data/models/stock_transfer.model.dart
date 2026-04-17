class StockTransfer {
  final String id;
  final String fromId;
  final String fromName;
  final String toId;
  final String toName;
  final int status;
  final String? note;
  final String? createdBy;
  final String createdAt;
  final String updatedAt;

  StockTransfer({
    required this.id,
    required this.fromId,
    required this.fromName,
    required this.toId,
    required this.toName,
    required this.status,
    this.note,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockTransfer.fromJson(Map<String, dynamic> json) {
    return StockTransfer(
      id: json['id'],
      fromId: json['from_id'],
      fromName: json['from_name'],
      toId: json['to_id'],
      toName: json['to_name'],
      status: json['status'],
      note: json['note'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_id': fromId,
      'from_name': fromName,
      'to_id': toId,
      'to_name': toName,
      'status': status,
      'note': note,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class StockTransferItem {
  final String id;
  final String stockTransferId;
  final String productId;
  final String productName;
  final int quantity;
  final String createdAt;
  final String updatedAt;

  StockTransferItem({
    required this.id,
    required this.stockTransferId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockTransferItem.fromJson(Map<String, dynamic> json) {
    return StockTransferItem(
      id: json['id'],
      stockTransferId: json['stock_transfer_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock_transfer_id': stockTransferId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
