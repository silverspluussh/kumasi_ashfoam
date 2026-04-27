import 'dart:typed_data';
import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:ashfoam_sadiq/src/features/common/services/pdf_helper.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class InvoicePrintService {
  static final _currencyFormat = NumberFormat.currency(symbol: 'GH¢');
  static final _dateFormat = DateFormat('dd MMM yyyy');

  static Future<void> showPreview({
    required BuildContext context,
    required InvoiceModel invoice,
    required List<dynamic> items,
    CompanyModel? company,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 1000,
          height: 800,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoice Preview - ${invoice.customerName ?? 'Client'}',
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
                  build: (format) => _generatePdf(invoice, items, company),
                  allowSharing: true,
                  allowPrinting: true,
                  canChangePageFormat: false,
                  initialPageFormat: PdfPageFormat.a4,
                  pdfFileName: 'Invoice_${invoice.id.substring(0, 8)}.pdf',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<Uint8List> _generatePdf(
    InvoiceModel invoice,
    List<dynamic> items,
    CompanyModel? company,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Company Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfHelper.buildCompanyHeader(company),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'TAX INVOICE',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                        color: PdfColors.blue900,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Invoice ID: ${invoice.id.substring(0, 8).toUpperCase()}',
                    ),
                    pw.Text('Due Date: ${_dateFormat.format(invoice.dueDate)}'),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 30),

            // Client Info
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'BILLED TO:',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        invoice.customerName ?? 'Walk-in Client',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(width: 50),
              ],
            ),

            pw.SizedBox(height: 30),

            // Items Table
            pw.Table(
              border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey400),
              columnWidths: {
                0: const pw.FlexColumnWidth(3),
                1: const pw.FlexColumnWidth(1),
                2: const pw.FlexColumnWidth(1.5),
                3: const pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                  children: [
                    _tableHeader('Item Description'),
                    _tableHeader('Qty', align: pw.TextAlign.center),
                    _tableHeader('Unit Price', align: pw.TextAlign.right),
                    _tableHeader('Total', align: pw.TextAlign.right),
                  ],
                ),
                ...items.map(
                  (item) => pw.TableRow(
                    children: [
                      _tableCell(item.productName),
                      _tableCell(
                        item.quantity.toString(),
                        align: pw.TextAlign.center,
                      ),
                      _tableCell(
                        _currencyFormat
                            .format(item.unitPrice)
                            .replaceAll('GH¢', ''),
                        align: pw.TextAlign.right,
                      ),
                      _tableCell(
                        _currencyFormat
                            .format(item.totalPrice)
                            .replaceAll('GH¢', ''),
                        align: pw.TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),

            // Summary Section
            pw.Row(
              children: [
                pw.Spacer(flex: 2),
                pw.Expanded(
                  flex: 1,
                  child: pw.Column(
                    children: [
                      _summaryRow(
                        'Grand Total',
                        _currencyFormat.format(invoice.totalAmount),
                      ),
                      _summaryRow(
                        'Paid Amount',
                        _currencyFormat.format(invoice.paidAmount),
                      ),
                      pw.Divider(thickness: 1),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'BALANCE DUE',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.red900,
                              ),
                            ),
                            pw.Text(
                              _currencyFormat.format(invoice.balanceDue),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.red900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 50),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Text(
                'Thank you for your business!',
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                  fontSize: 10,
                  color: PdfColors.grey700,
                ),
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _tableHeader(
    String text, {
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
      ),
    );
  }

  static pw.Widget _tableCell(
    String text, {
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        textAlign: align,
        style: const pw.TextStyle(fontSize: 9),
      ),
    );
  }

  static pw.Widget _summaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
          pw.Text(
            value,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
