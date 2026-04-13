import 'dart:io';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

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
    final workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/InventoryReport.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to ${directory.path}/InventoryReport.xlsx')),
      );
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
                  loading: () => const Center(child: CircularProgressIndicator()),
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
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
                    ref.read(inventorySearchQueryProvider.notifier).state = v.text;
                  },
                ),
              ),
            ),
            const SizedBox(width: 15),
            FButton(
              onPress: _exportToExcel,
              prefix: const Icon(Icons.file_download),
              child: const Text("Export Excel"),
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
        columnName: 'subCategory',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Sub Category', style: headerStyle),
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
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'name', value: item.name),
        DataGridCell<int>(columnName: 'stock', value: item.quantity),
        DataGridCell<String>(columnName: 'price', value: curFormat.format(item.retailPrice)),
        DataGridCell<String>(columnName: 'category', value: item.category ?? 'Uncategorized'),
        DataGridCell<String>(columnName: 'subCategory', value: item.subCategory ?? 'NA'),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        final bool isNumeric = dataGridCell.columnName == 'stock' || dataGridCell.columnName == 'price';

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
