import 'dart:typed_data';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ReceiptService {
  static final _currencyFormat = NumberFormat.currency(symbol: 'GH¢');
  static final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  static Future<void> printReceipt(SaleOrderModel order, List<SaleOrderItem> items) async {
    final pdf = await _generateReceipt(order, items);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf,
      name: 'Receipt_${order.orderNumber}.pdf',
    );
  }

  static Future<void> showPreview(
    BuildContext context,
    SaleOrderModel order,
    List<SaleOrderItem> items,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          height: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Receipt Preview - ${order.orderNumber}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
                  build: (format) => _generateReceipt(order, items),
                  allowSharing: true,
                  allowPrinting: true,
                  canChangePageFormat: false,
                  initialPageFormat: const PdfPageFormat(
                    226,
                    double.infinity,
                    marginLeft: 10,
                    marginRight: 10,
                    marginTop: 20,
                    marginBottom: 20,
                  ),
                  pdfFileName: 'Receipt_${order.orderNumber}.pdf',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<Uint8List> _generateReceipt(SaleOrderModel order, List<SaleOrderItem> items) async {
    final pdf = pw.Document();

    // Use a thermal printer friendly format (approx 80mm)
    // 1 inch = 72 points. 80mm = 3.15 inches = 226 points.
    const PdfPageFormat format = PdfPageFormat(
      226,
      double.infinity,
      marginLeft: 10,
      marginRight: 10,
      marginTop: 20,
      marginBottom: 20,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                'KUMASI ASHFOAM',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
              ),
              pw.SizedBox(height: 2),
              pw.Text('Authorized Distributor', style: const pw.TextStyle(fontSize: 8)),
              pw.SizedBox(height: 5),
              pw.Text('OFFICIAL RECEIPT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
              pw.Divider(thickness: 1),
              
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _receiptRow('Order #:', order.orderNumber),
                    _receiptRow('Date:', _dateFormat.format(order.createdAt ?? DateTime.now())),
                    _receiptRow('Customer:', order.customerName ?? 'Walk-in'),
                    _receiptRow('Cashier:', order.createdBy),
                  ],
                ),
              ),
              
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 0.5),
              pw.Row(
                children: [
                  pw.Expanded(flex: 3, child: pw.Text('Item', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8))),
                  pw.Expanded(flex: 1, child: pw.Text('Qty', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8), textAlign: pw.TextAlign.center)),
                  pw.Expanded(flex: 2, child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8), textAlign: pw.TextAlign.right)),
                  pw.Expanded(flex: 2, child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8), textAlign: pw.TextAlign.right)),
                ],
              ),
              pw.Divider(thickness: 0.5),

              ...items.map((item) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 2),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(flex: 3, child: pw.Text(item.productName, style: const pw.TextStyle(fontSize: 7))),
                    pw.Expanded(flex: 1, child: pw.Text(item.quantity.toString(), style: const pw.TextStyle(fontSize: 7), textAlign: pw.TextAlign.center)),
                    pw.Expanded(flex: 2, child: pw.Text(item.unitPrice.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 7), textAlign: pw.TextAlign.right)),
                    pw.Expanded(flex: 2, child: pw.Text(item.totalPrice.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 7), textAlign: pw.TextAlign.right)),
                  ],
                ),
              )),

              pw.Divider(thickness: 1),
              pw.Column(
                children: [
                   _receiptTotalRow('Subtotal', (order.totalAmount - order.taxAmount)),
                   if (order.discountAmount > 0)
                    _receiptTotalRow('Discount', -order.discountAmount),
                   _receiptTotalRow('VAT (15%)', order.taxAmount),
                   pw.Divider(thickness: 0.5),
                   pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('TOTAL', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                      pw.Text(_currencyFormat.format(order.totalAmount), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              
              pw.SizedBox(height: 20),
              pw.Text('THANK YOU FOR YOUR BUSINESS!', style: const pw.TextStyle(fontSize: 8)),
              pw.Text('Please visit again.', style: const pw.TextStyle(fontSize: 7)),
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
          pw.Text(label, style: const pw.TextStyle(fontSize: 8)),
          pw.Text(value, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
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
          pw.Text(value.toStringAsFixed(2), style: const pw.TextStyle(fontSize: 8)),
        ],
      ),
    );
  }
}
