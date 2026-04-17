import 'dart:typed_data';
import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class ProformaPrintService {
  static final _currencyFormat = NumberFormat.currency(symbol: 'GH¢');
  static final _dateFormat = DateFormat('dd MMM yyyy HH:mm');

  static Future<void> showPreview({
    required BuildContext context,
    required Profoma proforma,
    required List<ProductDetails> items,
    required Branche? branch,
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
                    'Proforma Preview - ${proforma.partyName ?? 'Client'}',
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
                  build: (format) => _generatePdf(proforma, items, branch),
                  allowSharing: true,
                  allowPrinting: true,
                  canChangePageFormat: false,
                  initialPageFormat: PdfPageFormat.a4,
                  pdfFileName: 'Proforma_${proforma.id.substring(0, 8)}.pdf',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<Uint8List> _generatePdf(
    Profoma proforma,
    List<ProductDetails> items,
    Branche? branch,
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
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'KUMASI ASHFOAM',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    if (branch != null) ...[
                      pw.Text(
                        branch.branchName,
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      if (branch.branchAddress != null)
                        pw.Text(
                          branch.branchAddress!,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      if (branch.contact != null)
                        pw.Text(
                          'Contact: ${branch.contact!}',
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                    ],
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'PROFORMA INVOICE',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                        color: PdfColors.blue900,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text('Date: ${_dateFormat.format(proforma.createdAt)}'),
                    pw.Text('ID: ${proforma.id.substring(0, 8).toUpperCase()}'),
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
                        proforma.partyName ?? 'Customer',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      if (proforma.partyAddress != null)
                        pw.Text(
                          proforma.partyAddress!,
                          style: const pw.TextStyle(fontSize: 10),
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
                3: const pw.FlexColumnWidth(1),
                4: const pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.blue50),
                  children: [
                    _tableHeader('Item Description'),
                    _tableHeader('Qty', align: pw.TextAlign.center),
                    _tableHeader('Unit Price', align: pw.TextAlign.right),
                    _tableHeader('Disc %', align: pw.TextAlign.center),
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
                            .format(item.unitprice)
                            .replaceAll('GH¢', ''),
                        align: pw.TextAlign.right,
                      ),
                      _tableCell(
                        '${item.discountPercentage}%',
                        align: pw.TextAlign.center,
                      ),
                      _tableCell(
                        _currencyFormat
                            .format(item.totalAmount)
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
                        'Subtotal',
                        _currencyFormat.format(proforma.totalAmount),
                      ),
                      ...proforma.tax.map(
                        (t) => _summaryRow(
                          t.tax.name,
                          _currencyFormat.format(t.taxAmount),
                        ),
                      ),
                      pw.Divider(thickness: 1),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'GRAND TOTAL',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blue900,
                              ),
                            ),
                            pw.Text(
                              _currencyFormat.format(proforma.totalAmount),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.blue900,
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

            if (proforma.declaration != null &&
                proforma.declaration!.isNotEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'DECLARATION:',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      proforma.declaration!,
                      style: const pw.TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),

            pw.Padding(
              padding: const pw.EdgeInsets.only(top: 60),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: 150,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(
                              width: 0.5,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ),
                      pw.Text(
                        'Customer Signature',
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: 150,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(
                              width: 0.5,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ),
                      pw.Text(
                        'Authorized Seal & Sign',
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.only(top: 20),
            child: pw.Text(
              'Thank you for your business!',
              style: pw.TextStyle(
                fontStyle: pw.FontStyle.italic,
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
          );
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
