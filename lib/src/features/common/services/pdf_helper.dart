import 'package:ashfoam_sadiq/src/data/models/company.model.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHelper {
  static pw.Widget buildCompanyHeader(CompanyModel? company) {
    if (company == null) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'KUMASI ASHFOAM',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
          ),
        ],
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          company.name,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
        ),
        if (company.postalAddress != null && company.postalAddress!.isNotEmpty)
          pw.Text(
            'Postal: ${company.postalAddress}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        if (company.commercialAddress != null &&
            company.commercialAddress!.isNotEmpty)
          pw.Text(
            'Address: ${company.commercialAddress}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        if (company.phonePrimary != null && company.phonePrimary!.isNotEmpty)
          pw.Text(
            'Phone: ${company.phonePrimary}${company.phoneSecondary != null ? " / ${company.phoneSecondary}" : ""}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        if (company.email != null && company.email!.isNotEmpty)
          pw.Text(
            'Email: ${company.email}',
            style: const pw.TextStyle(fontSize: 10),
          ),
      ],
    );
  }

  static pw.Widget buildReceiptHeader(CompanyModel? company) {
    if (company == null) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'KUMASI ASHFOAM',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            'Authorized Distributor',
            style: const pw.TextStyle(fontSize: 8),
          ),
        ],
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          company.name,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
          textAlign: pw.TextAlign.center,
        ),
        if (company.postalAddress != null && company.postalAddress!.isNotEmpty)
          pw.Text(
            company.postalAddress!,
            style: const pw.TextStyle(fontSize: 7),
            textAlign: pw.TextAlign.center,
          ),
        if (company.commercialAddress != null &&
            company.commercialAddress!.isNotEmpty)
          pw.Text(
            company.commercialAddress!,
            style: const pw.TextStyle(fontSize: 7),
            textAlign: pw.TextAlign.center,
          ),
        if (company.phonePrimary != null && company.phonePrimary!.isNotEmpty)
          pw.Text(
            'Tel: ${company.phonePrimary}',
            style: const pw.TextStyle(fontSize: 7),
            textAlign: pw.TextAlign.center,
          ),
        if (company.email != null && company.email!.isNotEmpty)
          pw.Text(
            'Email: ${company.email}',
            style: const pw.TextStyle(fontSize: 7),
            textAlign: pw.TextAlign.center,
          ),
        pw.Text(
          'VAT INVOICE (VAT Reg Num: C0002718510)',
          style: const pw.TextStyle(fontSize: 7),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }
}
