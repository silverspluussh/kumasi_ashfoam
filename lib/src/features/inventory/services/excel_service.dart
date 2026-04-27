import 'dart:io';

import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/payments.model.dart';
import 'package:drift/drift.dart';
import 'package:excel/excel.dart' as ex;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelService {
  static const List<String> headers = [
    'Product Name*',
    'Category',
    'Sub-Category',
    'Brand',
    'Retail Price*',
    'Initial Quantity*',
    'Unit',
    'Material',
    'Size',
    'Thickness',
    'Density',
  ];

  Future<List<int>> generateTemplate() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'Product Template';

    // Set headers
    for (int i = 0; i < headers.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
      sheet.getRangeByIndex(1, i + 1).cellStyle.bold = true;
      sheet.getRangeByIndex(1, i + 1).cellStyle.backColor = '#E0E0E0';
    }

    // Add a sample row (optional, but helpful for user context)
    sheet.getRangeByIndex(2, 1).setText('Sample Product');
    sheet.getRangeByIndex(2, 2).setText('Mattress');
    sheet.getRangeByIndex(2, 5).setNumber(1200.0);
    sheet.getRangeByIndex(2, 6).setNumber(10);
    sheet.getRangeByIndex(2, 7).setText('Pieces');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }

  Future<List<InventoryItemsCompanion>> parseProducts(List<int> bytes) async {
    final excel = ex.Excel.decodeBytes(bytes);
    final List<InventoryItemsCompanion> companions = [];

    for (var table in excel.tables.keys) {
      final sheet = excel.tables[table]!;
      // Skip header
      if (sheet.maxRows < 2) continue;

      for (int i = 1; i < sheet.maxRows; i++) {
        final row = sheet.rows[i];
        if (row.isEmpty || row[0] == null) continue;

        final name = row[0]?.value?.toString() ?? '';
        if (name.isEmpty) continue;

        final category = row.length > 1 ? row[1]?.value?.toString() : null;
        final subCategory = row.length > 2 ? row[2]?.value?.toString() : null;
        final brand = row.length > 3 ? row[3]?.value?.toString() : null;
        final price = row.length > 4
            ? double.tryParse(row[4]?.value?.toString() ?? '0') ?? 0.0
            : 0.0;
        final quantity = row.length > 5
            ? int.tryParse(row[5]?.value?.toString() ?? '0') ?? 0
            : 0;
        final unit = row.length > 6
            ? row[6]?.value?.toString() ?? 'Pieces'
            : 'Pieces';
        final material = row.length > 7 ? row[7]?.value?.toString() : null;
        final size = row.length > 8 ? row[8]?.value?.toString() : null;
        final thickness = row.length > 9 ? row[9]?.value?.toString() : null;
        final density = row.length > 10 ? row[10]?.value?.toString() : null;

        companions.add(
          InventoryItemsCompanion(
            name: Value(name),
            sku: Value(_generateSKU(name)),
            category: Value(category),
            subCategory: Value(subCategory),
            brand: Value(brand),
            retailPrice: Value(price),
            quantity: Value(quantity),
            unit: Value(unit),
            material: Value(material),
            size: Value(size),
            thickness: Value(thickness),
            density: Value(density),
            isAvailable: const Value(1),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    }

    return companions;
  }

  String _generateSKU(String name) {
    if (name.isEmpty) return '';

    final words = name.trim().toUpperCase().split(RegExp(r'\s+'));
    String prefix = '';
    if (words.length >= 2) {
      prefix = words.map((w) => w[0]).take(3).join();
    } else {
      prefix = words[0].substring(
        0,
        words[0].length >= 3 ? 3 : words[0].length,
      );
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(7);
    final date = DateTime.now().toString().split(' ')[0].replaceAll('-', '');

    return '$prefix-$date-$timestamp';
  }

  Future<List<int>> generateInventoryExport(List<InventoryModel> items) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'Inventory Export';

    final List<String> exportHeaders = [
      'ID',
      'Name',
      'SKU',
      'Category',
      'Category ID',
      'Sub-Category',
      'Size',
      'Thickness',
      'Material',
      'Density',
      'Brand',
      'Brand ID',
      'Retail Price',
      'Discount Price',
      'Discount Percentage',
      'Quantity',
      'Unit',
      'Branch ID',
      'Is Available',
      'Is Deleted',
      'Created At',
      'Updated At',
      'Is Synced',
      'Last Synced At',
    ];

    // Set headers
    for (int i = 0; i < exportHeaders.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(exportHeaders[i]);
      sheet.getRangeByIndex(1, i + 1).cellStyle.bold = true;
      sheet.getRangeByIndex(1, i + 1).cellStyle.backColor = '#4F81BD';
      sheet.getRangeByIndex(1, i + 1).cellStyle.fontColor = '#FFFFFF';
    }

    // Set data
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final r = i + 2;
      sheet.getRangeByIndex(r, 1).setText(item.id);
      sheet.getRangeByIndex(r, 2).setText(item.name);
      sheet.getRangeByIndex(r, 3).setText(item.sku);
      sheet.getRangeByIndex(r, 4).setText(item.category ?? '');
      sheet.getRangeByIndex(r, 5).setText(item.catergoryId ?? '');
      sheet.getRangeByIndex(r, 6).setText(item.subCategory ?? '');
      sheet.getRangeByIndex(r, 7).setText(item.size ?? '');
      sheet.getRangeByIndex(r, 8).setText(item.thickness ?? '');
      sheet.getRangeByIndex(r, 9).setText(item.material ?? '');
      sheet.getRangeByIndex(r, 10).setText(item.density ?? '');
      sheet.getRangeByIndex(r, 11).setText(item.brand ?? '');
      sheet.getRangeByIndex(r, 12).setText(item.brandId ?? '');
      sheet.getRangeByIndex(r, 13).setNumber(item.retailPrice);
      sheet.getRangeByIndex(r, 14).setNumber(item.discountPrice ?? 0.0);
      sheet.getRangeByIndex(r, 15).setNumber(item.discountPercentage ?? 0.0);
      sheet.getRangeByIndex(r, 16).setNumber(item.quantity.toDouble());
      sheet.getRangeByIndex(r, 17).setText(item.unit ?? '');
      sheet.getRangeByIndex(r, 18).setText(item.branchId ?? '');
      sheet.getRangeByIndex(r, 19).setNumber(item.isAvailable.toDouble());
      sheet.getRangeByIndex(r, 20).setNumber(item.isDeleted.toDouble());
      sheet
          .getRangeByIndex(r, 21)
          .setText(item.createdAt?.toIso8601String() ?? '');
      sheet
          .getRangeByIndex(r, 22)
          .setText(item.updatedAt?.toIso8601String() ?? '');
      sheet.getRangeByIndex(r, 23).setText(item.isSynced.toString());
      sheet
          .getRangeByIndex(r, 24)
          .setText(item.lastSyncedAt?.toIso8601String() ?? '');
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }

  Future<List<int>> generatePaymentsExport(
    List<BranchPaymentModel> payments,
  ) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'Payments Export';

    final List<String> exportHeaders = [
      'Payment ID',
      'Title',
      'Branch',
      'Amount (GHS)',
      'Note',
      'Date',
      'Created By',
    ];

    // Set headers
    for (int i = 0; i < exportHeaders.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(exportHeaders[i]);
      sheet.getRangeByIndex(1, i + 1).cellStyle.bold = true;
      sheet.getRangeByIndex(1, i + 1).cellStyle.backColor = '#4F81BD';
      sheet.getRangeByIndex(1, i + 1).cellStyle.fontColor = '#FFFFFF';
    }

    // Set data
    for (int i = 0; i < payments.length; i++) {
      final payment = payments[i];
      final r = i + 2;
      sheet.getRangeByIndex(r, 1).setText(payment.id);
      sheet.getRangeByIndex(r, 2).setText(payment.title);
      sheet.getRangeByIndex(r, 3).setText(payment.branchName);
      sheet.getRangeByIndex(r, 4).setNumber(payment.amount);
      sheet.getRangeByIndex(r, 5).setText(payment.note ?? '');
      sheet
          .getRangeByIndex(r, 6)
          .setText(payment.createdAt.toIso8601String());
      sheet.getRangeByIndex(r, 7).setText(payment.createdBy);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }

  Future<void> saveFile(List<int> bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
  }
}
