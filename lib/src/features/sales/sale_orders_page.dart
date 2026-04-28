import 'dart:io';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart'
    hide saleOrderItemsProvider;
import 'package:ashfoam_sadiq/src/features/pos/providers/receipt_service.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/widgets/order_details_dialog.dart';
import 'package:ashfoam_sadiq/src/utils/date_extensions.dart';
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
    _dataGridSource = SaleOrderDataGridSource(orders: [], context: context);
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
    const int rowsPerPage = 40;

    return // Soft background for premium feel
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "POS Sale Orders",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
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
                FButton(
                  onPress: _exportToExcel,
                  prefix: const Icon(Icons.file_download),
                  child: const Text("Export Excel"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Table Area
            Expanded(
              child: filteredOrdersAsync.when(
                data: (orders) {
                  _dataGridSource.updateOrders(orders);
                  return Column(
                    children: [
                      // DataGrid wrapped in Card
                      Expanded(
                        child: SfDataGridTheme(
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

                            gridLinesVisibility: GridLinesVisibility.both,
                            headerGridLinesVisibility: GridLinesVisibility.both,
                            columns: _buildColumns(),
                            rowsPerPage: rowsPerPage,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Pager at the bottom, outside the Card to avoid padding issues
                      SizedBox(
                        height: 60,
                        child: SfDataPager(
                          delegate: _dataGridSource,
                          pageCount: orders.isEmpty
                              ? 1
                              : (orders.length / rowsPerPage).ceilToDouble(),
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
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
        columnName: 'totalItems',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Total Items', style: headerStyle),
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
        columnName: 'amount',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Total Amount', style: headerStyle),
        ),
      ),

      GridColumn(
        columnName: 'actions',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('Actions', style: headerStyle),
        ),
      ),
    ];
  }
}

class SaleOrderDataGridSource extends DataGridSource {
  final BuildContext context;
  SaleOrderDataGridSource({
    required List<SaleOrderModel> orders,
    required this.context,
  }) {
    _orders = orders;
    _paginatedOrders = orders;
    _buildDataGridRows();
  }

  List<SaleOrderModel> _orders = [];
  List<SaleOrderModel> _paginatedOrders = [];
  List<DataGridRow> _dataGridRows = [];

  void updateOrders(List<SaleOrderModel> orders) {
    _orders = orders;
    _paginatedOrders = orders;
    _buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    const int rowsPerPage = 40;
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (endIndex > _orders.length) {
      endIndex = _orders.length;
    }

    _paginatedOrders = _orders.getRange(startIndex, endIndex).toList();
    _buildDataGridRows();
    notifyListeners();
    return true;
  }

  void _buildDataGridRows() {
    final currencyFormat = NumberFormat.currency(symbol: 'GH¢ ');

    _dataGridRows = _paginatedOrders.map<DataGridRow>((order) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'orderNo', value: order.orderNumber),
          DataGridCell<String>(
            columnName: 'totalItems',
            value: order.totalQuantity.toString(),
          ),

          DataGridCell<String>(
            columnName: 'date',
            value: order.createdAt != null ? order.createdAt?.fullDate : '-',
          ),
          DataGridCell<String>(
            columnName: 'customer',
            value: order.customerName ?? 'Walk-in',
          ),

          DataGridCell<String>(
            columnName: 'amount',
            value: currencyFormat.format(order.totalAmount),
          ),

          DataGridCell<SaleOrderModel>(columnName: 'actions', value: order),
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
        final bool isActions = dataGridCell.columnName == 'actions';

        if (isActions) {
          final order = dataGridCell.value as SaleOrderModel;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // View Details
              IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 20),
                tooltip: 'View Details',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => OrderDetailsDialog(order: order),
                  );
                },
              ),
              // Quick Print
              IconButton(
                icon: const Icon(Icons.print_outlined, size: 20),
                tooltip: 'Print Receipt',
                onPressed: () async {
                  // Need to fetch items first
                  final container = ProviderScope.containerOf(context);
                  final items = await container.read(
                    saleOrderItemsProvider(order.id).future,
                  );
                  final company = await container.read(
                    companySettingsProvider.future,
                  );
                  if (context.mounted) {
                    ReceiptService.showPreview(
                      context,
                      order,
                      items,
                      company: company,
                    );
                  }
                },
              ),
            ],
          );
        }

        return Container(
          alignment: isAmount
              ? Alignment.centerRight
              : (isStatus ? Alignment.center : Alignment.centerLeft),
          padding: const EdgeInsets.all(10.0),
          child: isStatus
              ? _buildStatusChip(dataGridCell.value.toString())
              : Text(
                  dataGridCell.value.toString(),
                  style: TextStyle(fontSize: 12),
                ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
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
