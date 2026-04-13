import 'dart:io';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

class SaleOrdersPage extends ConsumerStatefulWidget {
  const SaleOrdersPage({super.key});

  @override
  ConsumerState<SaleOrdersPage> createState() => _SaleOrdersPageState();
}

class _SaleOrdersPageState extends ConsumerState<SaleOrdersPage> {
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  late SaleOrderDataGridSource _dataGridSource;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataGridSource = SaleOrderDataGridSource(orders: []);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _exportToExcel() async {
    final workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/SaleOrders.xlsx');
    await file.writeAsBytes(bytes, flush: true);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to $path/SaleOrders.xlsx')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrdersAsync = ref.watch(filteredSaleOrdersProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Section
            _buildHeader(context),
            const SizedBox(height: 20),

            // Main Content
            Expanded(
              child: FCard(
                child: filteredOrdersAsync.when(
                  data: (orders) {
                    _dataGridSource.updateOrders(orders);
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
              "POS Sale Orders",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "View and manage all point of sale transactions",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            // Search Bar
            SizedBox(
              width: 300,
              child: FTextField(
                hint: 'Search by Order # or Customer...',
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 20),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(salesSearchQueryProvider.notifier).state = v.text;
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
        columnName: 'orderNo',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Order #', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'date',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Date', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'customer',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Customer', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'branch',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Branch', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'amount',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Total Amount', style: headerStyle),
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

class SaleOrderDataGridSource extends DataGridSource {
  SaleOrderDataGridSource({required List<SaleOrderModel> orders}) {
    _orders = orders;
    _buildDataGridRows();
  }

  List<SaleOrderModel> _orders = [];
  List<DataGridRow> _dataGridRows = [];

  void updateOrders(List<SaleOrderModel> orders) {
    _orders = orders;
    _buildDataGridRows();
    notifyListeners();
  }

  void _buildDataGridRows() {
    final currencyFormat = NumberFormat.currency(symbol: 'GH¢ ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    _dataGridRows = _orders.map<DataGridRow>((order) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'orderNo', value: order.orderNumber),
          DataGridCell<String>(
            columnName: 'date',
            value: order.createdAt != null
                ? dateFormat.format(order.createdAt!)
                : '-',
          ),
          DataGridCell<String>(
            columnName: 'customer',
            value: order.customerName ?? 'Walk-in',
          ),
          DataGridCell<String>(
            columnName: 'branch',
            value: order.branchName ?? 'Head Office',
          ),
          DataGridCell<String>(
            columnName: 'amount',
            value: currencyFormat.format(order.totalAmount),
          ),
          DataGridCell<String>(
            columnName: 'status',
            value: order.status.toUpperCase(),
          ),
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
        final bool isAmount = dataGridCell.columnName == 'amount';
        final bool isStatus = dataGridCell.columnName == 'status';

        return Container(
          alignment: isAmount
              ? Alignment.centerRight
              : (isStatus ? Alignment.center : Alignment.centerLeft),
          padding: const EdgeInsets.all(10.0),
          child: isStatus
              ? _buildStatusChip(dataGridCell.value.toString())
              : Text(dataGridCell.value.toString()),
        );
      }).toList(),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
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
    );
  }
}
