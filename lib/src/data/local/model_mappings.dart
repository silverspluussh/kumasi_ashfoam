import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:ashfoam_sadiq/src/data/models/employee.model.dart';
import 'package:ashfoam_sadiq/src/data/models/expenses.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart' as sales_model;
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart'
    as inventory_model;
import 'package:ashfoam_sadiq/src/data/models/customer.model.dart'
    as customer_model;
import 'package:ashfoam_sadiq/src/data/models/supplier.model.dart'
    as supplier_model;
import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart'
    as invoice_model;
import 'package:ashfoam_sadiq/src/data/models/receipt.model.dart'
    as receipt_model;
import 'package:ashfoam_sadiq/src/data/models/return_order.model.dart'
    as return_model;
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart';
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart'
    as waybill_model;
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart'
    as proforma_model;
import 'package:ashfoam_sadiq/src/data/models/payments.model.dart'
    as payment_model;

extension InventoryItemMapper on db.InventoryItem {
  inventory_model.InventoryModel toModel() {
    return inventory_model.InventoryModel.fromMap(toJson());
  }
}

extension SaleOrderMapper on db.SaleOrder {
  sales_model.SaleOrderModel toModel() {
    return sales_model.SaleOrderModel.fromMap(toJson());
  }
}

extension SaleOrderItemMapper on db.SaleOrderItem {
  sales_model.SaleOrderItem toModel() {
    return sales_model.SaleOrderItem.fromMap(toJson());
  }
}

extension CustomerMapper on db.Customer {
  customer_model.CustomerModel toModel() {
    final map = toJson();
    return customer_model.CustomerModel.fromMap(map);
  }
}

extension SupplierModelMapper on db.Supplier {
  supplier_model.SupplierModel toModel() {
    return supplier_model.SupplierModel.fromMap(toJson());
  }
}

extension InvoiceModelMapper on db.Invoice {
  invoice_model.InvoiceModel toModel() {
    return invoice_model.InvoiceModel.fromMap(toJson());
  }
}

extension ReceiptModelMapper on db.Receipt {
  receipt_model.ReceiptModel toModel() {
    final map = toJson();
    map['items'] = [];
    map['tax'] = [];
    map['bill_number'] = '';
    return receipt_model.ReceiptModel.fromMap(map);
  }
}

extension ReturnOrderModelMapper on db.ReturnOrder {
  return_model.ReturnOrderModel toModel() {
    return return_model.ReturnOrderModel.fromMap(toJson());
  }
}

extension ReturnOrderItemModelMapper on db.ReturnOrderItem {
  return_model.ReturnOrderItemModel toModel() {
    return return_model.ReturnOrderItemModel.fromMap(toJson());
  }
}

extension CreditNoteModelMapper on db.CreditNote {
  return_model.CreditNoteModel toModel() {
    return return_model.CreditNoteModel.fromMap(toJson());
  }
}

extension WayBillModelMapper on db.WayBill {
  waybill_model.WayBillModel toModel() {
    return waybill_model.WayBillModel.fromMap(toJson());
  }
}

extension ProformaMapper on db.Proforma {
  proforma_model.Profoma toModel() {
    return proforma_model.Profoma.fromMap(toJson());
  }
}

extension BrandMapper on db.ProductBrand {
  inventory_model.Brand toModel() {
    return inventory_model.Brand(id: id, name: name, createdAt: createdAt);
  }
}

extension CategoryMapper on db.ProductCategory {
  inventory_model.ProductCategory toModel() {
    return inventory_model.ProductCategory(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }
}

extension SubCategoryMapper on db.ProductSubCategory {
  inventory_model.ProductSubCategory toModel() {
    return inventory_model.ProductSubCategory(
      id: id,
      categoryId: categoryId,
      name: name,
      createdAt: createdAt,
    );
  }
}

extension CreditNoteItemModelMapper on db.CreditNoteItem {
  return_model.CreditNoteItemModel toModel() {
    return return_model.CreditNoteItemModel.fromMap(toJson());
  }
}

extension BranchPaymentModelMapper on db.BranchPayment {
  payment_model.BranchPaymentModel toModel() {
    return payment_model.BranchPaymentModel.fromMap(toJson());
  }
}

extension EmployeeModelMapper on db.Employee {
  EmployeeModel toModel() {
    return EmployeeModel.fromMap(toJson());
  }
}

extension ExpenseModelMapper on db.Expense {
  ExpenseModel toModel() {
    return ExpenseModel.fromMap(toJson());
  }
}

extension ProductDetailsMapper on db.ProductDetailsListData {
  proforma_model.ProductDetails toModel() {
    return proforma_model.ProductDetails(
      productId: productId,
      productName: productName,
      proformaId: proformaId,
      waybillId: waybillId,
      quantity: quantity,
      unitprice: unitPrice,
      discountPercentage: discountPercentage,
      totalAmount: totalAmount,
    );
  }
}

extension TaxModelMapper on db.Taxe {
  TaxModel toModel() {
    return TaxModel.fromMap(toJson());
  }
}

extension CompanySettingsMapper on db.CompanySetting {
  CompanyModel toModel() {
    return CompanyModel.fromMap(toJson());
  }
}
