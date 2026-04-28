import 'dart:typed_data';
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:ashfoam_sadiq/src/features/common/services/pdf_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ReceiptService {
  static final _currencyFormat = NumberFormat.currency(symbol: 'GH¢');
  static final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  static Future<void> printReceipt(
    SaleOrderModel order,
    List<SaleOrderItem> items, {
    CompanyModel? company,
    double paperWidth = 50,
  }) async {
    final pdf = await _generateReceipt(
      order,
      items,
      company: company,
      paperWidth: paperWidth,
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf,
      name: 'Receipt_${order.orderNumber}.pdf',
    );
  }

  static Future<void> showPreview(
    BuildContext context,
    SaleOrderModel order,
    List<SaleOrderItem> items, {
    CompanyModel? company,
  }) async {
    double selectedWidth = 80;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: Container(
              width: 500,
              height: 800,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Receipt Preview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Text('Width: '),
                          const SizedBox(width: 10),
                          DropdownButton<double>(
                            value: selectedWidth,
                            items: const [
                              DropdownMenuItem(value: 80, child: Text('80mm')),
                              DropdownMenuItem(value: 50, child: Text('50mm')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => selectedWidth = value);
                              }
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: PdfPreview(
                      build: (format) => _generateReceipt(
                        order,
                        items,
                        company: company,
                        paperWidth: selectedWidth,
                      ),
                      allowPrinting: true,
                      allowSharing: true,
                      canChangePageFormat: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<Uint8List> _generateReceipt(
    SaleOrderModel order,
    List<SaleOrderItem> items, {
    CompanyModel? company,
    double paperWidth = 80,
  }) async {
    final allTaxes = await DatabaseService.instance.getTaxes();
    final pdf = pw.Document();

    // Thermal paper sizes in points
    // 80mm = 226.77pt, 50mm = 141.73pt
    final double widthPoints = (paperWidth * 72) / 25.4;

    final PdfPageFormat format = PdfPageFormat(
      widthPoints,
      double.infinity,
      marginLeft: 5,
      marginRight: 5,
      marginTop: 10,
      marginBottom: 10,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              PdfHelper.buildReceiptHeader(company),
              pw.Divider(thickness: 1),

              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _receiptRow('Order #:', order.orderNumber),
                    _receiptRow(
                      'Date:',
                      _dateFormat.format(order.createdAt ?? DateTime.now()),
                    ),
                    _receiptRow('Customer:', order.customerName ?? 'Walk-in'),
                    _receiptRow('User:', order.createdBy ?? 'Walk-in'),
                  ],
                ),
              ),

              pw.SizedBox(height: 10),
              pw.Divider(thickness: 0.5),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Description',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 7,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      'Qty',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 7,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Rate',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 7,
                      ),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Total',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 7,
                      ),
                      textAlign: pw.TextAlign.right,
                    ),
                  ),
                ],
              ),
              pw.Divider(thickness: 0.5),

              ...items.map(
                (item) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          item.productName,
                          style: const pw.TextStyle(fontSize: 6),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                          item.quantity.toString(),
                          style: const pw.TextStyle(fontSize: 6),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          item.unitPrice.toStringAsFixed(2),
                          style: const pw.TextStyle(fontSize: 6),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          item.totalPrice.toStringAsFixed(2),
                          style: const pw.TextStyle(fontSize: 6),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              pw.Divider(thickness: 1),
              pw.Column(
                children: [
                  _receiptTotalRow(
                    'Subtotal',
                    order.totalAmount + order.discountAmount,
                  ),
                  if (order.discountAmount > 0)
                    _receiptTotalRow('Discount', -order.discountAmount),
                  ...allTaxes.map((tax) {
                    final calculatedTax =
                        order.totalAmount * (tax.valuePercentage / 100);
                    return _receiptTotalRow(
                      '${tax.name} (${tax.valuePercentage}%)',
                      calculatedTax,
                    );
                  }),
                  pw.Divider(thickness: 0.5),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'TOTAL',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                      pw.Text(
                        _currencyFormat.format(order.totalAmount),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),
              pw.Text(
                'Items bought are not returnable',
                style: const pw.TextStyle(fontSize: 7),
              ),
              pw.Text(
                'Please verify before leaving',
                style: const pw.TextStyle(fontSize: 6),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _receiptRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 7)),
          pw.Text(
            value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
          ),
        ],
      ),
    );
  }

  static pw.Widget _receiptTotalRow(String label, double value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 8)),
          pw.Text(
            value.toStringAsFixed(2),
            style: const pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
