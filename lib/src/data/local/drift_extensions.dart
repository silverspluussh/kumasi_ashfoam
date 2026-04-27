import 'package:ashfoam_sadiq/src/data/local/app_database.dart';

/// Extension methods to add toMap() to Drift-generated classes
/// This allows Drift objects to be serialized to maps for API requests

extension InventoryItemToMap on InventoryItem {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'category_id': categoryId,
      'sub_category': subCategory,
      'size': size,
      'thickness': thickness,
      'material': material,
      'density': density,
      'brand': brand,
      'brand_id': brandId,
      'supplier': supplier,
      'supplier_id': supplierId,
      'retail_price': retailPrice,
      'discount_price': discountPrice,
      'discount_percentage': discountPercentage,
      'quantity': quantity,
      'unit': unit,
      'branch_id': branchId,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

extension SaleOrderToMap on SaleOrder {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_number': orderNumber,
      'customer_name': customerName,
      'channel': channel,
      'branch_id': branchId,
      'branch_name': branchName,
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'status': status,
      'is_synced': isSynced,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}

extension SaleOrderItemToMap on SaleOrderItem {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'sale_order_id': saleOrderId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }
}

extension ReturnOrderToMap on ReturnOrder {
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
      'status': status,
      'created_by': createdBy,
      'return_date': returnDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_synced': isSynced,
      'last_synced_at': lastSyncedAt?.toIso8601String(),
    };
  }
}

extension ReturnOrderItemToMap on ReturnOrderItem {
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
}

extension ProformaToMap on Proforma {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'party_name': partyName,
      'party_address': partyAddress,
      'tax': tax, // tax is stored as JSON string
      'total_quantity': totalQuantity,
      'is_deleted': isDeleted,
      'declaration': declaration,
      'total_amount': totalAmount,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

extension StockReportToMap on StockReport {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'branch_name': branchName,
      'current_stock': currentStock,
      'category_stock': categoryStock,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

extension BranchPaymentToMap on BranchPayment {
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
}

extension TaxeToMap on Taxe {
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'value_percentage': valuePercentage};
  }
}

extension ProductDetailsListDataToMap on ProductDetailsListData {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'proforma_id': proformaId,
      'waybill_id': waybillId,
      'unit_price': unitPrice,
      'quantity': quantity,
      'discount_percentage': discountPercentage,
      'total_amount': totalAmount,
    };
  }
}
