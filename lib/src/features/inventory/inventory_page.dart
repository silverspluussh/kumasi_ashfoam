import 'dart:io';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/add_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/excel_providers.dart';
import 'package:file_picker/file_picker.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Report exported successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting inventory: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _downloadTemplate() async {
    try {
      final excelService = ref.read(excelServiceProvider);
      final bytes = await excelService.generateTemplate();

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Template saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading template: $e'),
            backgroundColor: Colors.red,
          ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No valid products found in Excel'),
              backgroundColor: Colors.orange,
            ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported $successCount products'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error importing Excel: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredInventoryAsync = ref.watch(filteredInventoryProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            const SizedBox(height: 20),

            // Table Content
            Expanded(
              child: FCard(
                child: filteredInventoryAsync.when(
                  data: (items) {
                    _dataGridSource.updateItems(items);
                    return SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: Colors.black,
                        headerHoverColor: Colors.grey[900],
                        gridLineColor: Colors.grey[300],
                        rowHoverColor: Colors.grey[100],
                        selectionColor: Colors.blue.withValues(alpha: 0.1),
                      ),
                      child: SfDataGrid(
                        key: _key,
                        source: _dataGridSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowFiltering: true,
                        allowSorting: true,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        columns: _buildColumns(),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              "Live stock levels across all categories",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 300,
              child: FTextField(
                hint: 'Search by Product or SKU...',
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
            const SizedBox(width: 15),
            FButton(
              onPress: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AddProductDialog(),
              ),
              prefix: const Icon(Icons.add),
              child: const Text("Add Product"),
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
              child: const Text("Get Sample"),
            ),
            const SizedBox(width: 10),
            FButton(
              onPress: _importExcel,
              variant: FButtonVariant.outline,
              prefix: const Icon(Icons.upload_file),
              child: const Text("Import"),
            ),
          ],
        ),
      ],
    );
  }

  List<GridColumn> _buildColumns() {
    final headerStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
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
          ),
        );
      }).toList(),
    );
  }
}
