import 'dart:io';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/add_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/excel_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';

class InventoryView extends ConsumerStatefulWidget {
  const InventoryView({super.key});

  @override
  ConsumerState<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends ConsumerState<InventoryView> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  late InventoryDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = InventoryDataGridSource(items: []);
  }

  Future<void> _exportToExcel() async {
    try {
      final items = ref.read(inventoryListProvider).value ?? [];
      final excelService = ref.read(excelServiceProvider);
      final bytes = await excelService.generateInventoryExport(items);

      if (Platform.isAndroid || Platform.isIOS) {
        await Printing.sharePdf(
          bytes: Uint8List.fromList(bytes),
          filename: 'InventoryReport.xlsx',
        );
        return;
      }

      final String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Inventory Report',
        fileName: 'InventoryReport.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsBytes(bytes, flush: true);

        if (mounted) {
          toastification.show(
            type: ToastificationType.success,
            title: const Text('Report exported successfully'),
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error exporting inventory: $e'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> _downloadTemplate() async {
    try {
      final excelService = ref.read(excelServiceProvider);
      final bytes = await excelService.generateTemplate();

      if (Platform.isAndroid || Platform.isIOS) {
        await Printing.sharePdf(
          bytes: Uint8List.fromList(bytes),
          filename: 'ProductTemplate.xlsx',
        );
        return;
      }

      final String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Product Template',
        fileName: 'ProductTemplate.xlsx',
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (outputFile == null) {
        // User cancelled the picker
        return;
      }

      final file = File(outputFile);
      await file.writeAsBytes(bytes, flush: true);

      if (mounted) {
        toastification.show(
          type: ToastificationType.success,
          title: const Text('Template saved successfully'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error downloading template: $e'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> _importExcel() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        // User cancelled the picker
        return;
      }

      final fileData = result.files.single;
      List<int>? bytes = fileData.bytes;

      if (bytes == null && fileData.path != null) {
        final file = File(fileData.path!);
        bytes = await file.readAsBytes();
      }

      if (bytes == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not read file data'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      final excelService = ref.read(excelServiceProvider);
      final companions = await excelService.parseProducts(bytes);

      if (companions.isEmpty) {
        if (mounted) {
          toastification.show(
            type: ToastificationType.error,
            title: const Text('No valid products found in Excel'),
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
        return;
      }

      final addItem = ref.read(addInventoryItemProvider);
      int successCount = 0;
      for (final companion in companions) {
        try {
          await addItem(companion);
          successCount++;
        } catch (e) {
          debugPrint('Error adding item: $e');
        }
      }

      if (mounted) {
        toastification.show(
          type: ToastificationType.success,
          title: Text('Successfully imported $successCount products'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error importing Excel: $e'),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredInventoryAsync = ref.watch(filteredInventoryProvider);
    final istablet = MediaQuery.of(context).size.width < 1280;
    return Scaffold(
      floatingActionButton: istablet
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const AddProductDialog(),
                  ),

                  label: Text("Add New"),
                  icon: Icon(Icons.add),
                ),
                const SizedBox(width: 15),
                FloatingActionButton.extended(
                  onPressed: _exportToExcel,
                  label: Text("Export"),
                  icon: Icon(Icons.file_download),
                ),
                const SizedBox(width: 15),
                FloatingActionButton.extended(
                  onPressed: _importExcel,
                  label: Text("Import"),
                  icon: Icon(Icons.file_upload),
                ),
                const SizedBox(width: 15),
                FloatingActionButton.extended(
                  onPressed: _downloadTemplate,
                  label: Text("Template"),
                  icon: Icon(Icons.file_download),
                ),
              ],
            )
          : null,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            const SizedBox(height: 20),

            // Table Content
            Expanded(
              child: filteredInventoryAsync.when(
                data: (items) {
                  _dataGridSource.updateItems(items);
                  return SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: Colors.red,
                      headerHoverColor: Colors.red[900],
                      gridLineColor: Colors.grey[300],
                      rowHoverColor: Colors.yellow[100],
                      selectionColor: Colors.red.withValues(alpha: 0.1),
                    ),
                    child: SfDataGrid(
                      key: _key,
                      source: _dataGridSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      allowFiltering: false,
                      allowSorting: false,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      columns: _buildColumns(),
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final istablet = MediaQuery.of(context).size.width < 1280;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Local Inventory",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "View all Stocks",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            SizedBox(
              width: 200,
              child: FTextField(
                hint: 'Search...',
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 20),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(inventorySearchQueryProvider.notifier).state =
                        v.text;
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (!istablet) ...[
              FButton(
                onPress: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const AddProductDialog(),
                ),
                prefix: const Icon(Icons.add),
                child: const Text("Add"),
              ),
              const SizedBox(width: 10),

              FButton(
                onPress: _exportToExcel,
                prefix: const Icon(Icons.file_download),
                child: const Text("Export"),
              ),
              const SizedBox(width: 10),
              FButton(
                onPress: _downloadTemplate,
                variant: FButtonVariant.outline,
                prefix: const Icon(Icons.description),
                child: const Text("Sample"),
              ),
              const SizedBox(width: 10),
              FButton(
                onPress: _importExcel,
                variant: FButtonVariant.outline,
                prefix: const Icon(Icons.upload_file),
                child: const Text("Import"),
              ),
            ],
          ],
        ),
      ],
    );
  }

  List<GridColumn> _buildColumns() {
    final headerStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );

    return [
      GridColumn(
        columnName: 'name',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Product Name', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'stock',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Current Stock', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'price',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Price (GHS)', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'category',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Category', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'sku',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('SKU', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'status',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('Status', style: headerStyle),
        ),
      ),
    ];
  }
}

class InventoryDataGridSource extends DataGridSource {
  InventoryDataGridSource({required List<InventoryModel> items}) {
    _items = items;
    _buildDataGridRows();
  }

  List<InventoryModel> _items = [];
  List<DataGridRow> _dataGridRows = [];

  void updateItems(List<InventoryModel> items) {
    _items = items;
    _buildDataGridRows();
    notifyListeners();
  }

  void _buildDataGridRows() {
    final curFormat = NumberFormat.currency(symbol: 'GH¢ ');

    _dataGridRows = _items.map<DataGridRow>((item) {
      String statusText;
      if (item.quantity == 0) {
        statusText = 'Out of Stock';
      } else if (item.quantity < 10) {
        statusText = 'Low';
      } else {
        statusText = 'High';
      }

      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'name', value: item.name),
          DataGridCell<int>(columnName: 'stock', value: item.quantity),
          DataGridCell<String>(
            columnName: 'price',
            value: curFormat.format(item.retailPrice ?? 0.0),
          ),
          DataGridCell<String>(
            columnName: 'category',
            value: item.category ?? 'Uncategorized',
          ),
          DataGridCell<String>(columnName: 'sku', value: item.sku),
          DataGridCell<String>(columnName: 'status', value: statusText),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'status') {
          final status = dataGridCell.value.toString();
          Color color;
          if (status == 'High') {
            color = Colors.green;
          } else if (status == 'Low') {
            color = Colors.orange;
          } else {
            color = Colors.red;
          }

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }

        final bool isNumeric =
            dataGridCell.columnName == 'stock' ||
            dataGridCell.columnName == 'price';

        return Container(
          alignment: isNumeric ? Alignment.centerRight : Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}
