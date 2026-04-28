import 'package:ashfoam_sadiq/src/data/models/stock_report.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/stock_report_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/services/stock_report_print_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:toastification/toastification.dart';

class StockReportsView extends ConsumerStatefulWidget {
  const StockReportsView({super.key});

  @override
  ConsumerState<StockReportsView> createState() => _StockReportsViewState();
}

class _StockReportsViewState extends ConsumerState<StockReportsView> {
  late StockReportDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = StockReportDataGridSource(
      reports: [],
      onViewDetails: _showDetails,
      onPrint: (report) async {
        final company = await ref.read(companySettingsProvider.future);
        StockReportPrintService.showPreview(context, report, company: company);
      },
      onDelete: _confirmDelete,
    );
  }

  void _confirmDelete(StockReportSummary report) {
    showDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text("Delete Report"),
        body: Text(
          "Are you sure you want to delete the stock report for ${DateFormat('MMMM yyyy').format(report.createdAt)}? This action cannot be undone.",
        ),
        actions: [
          FButton(
            variant: FButtonVariant.outline,
            onPress: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FButton(
            onPress: () async {
              try {
                await ref.read(deleteStockReportProvider)(report.id);
                if (mounted) {
                  Navigator.pop(context);
                  toastification.show(
                    type: ToastificationType.success,
                    title: Text("Report deleted successfully"),
                    autoCloseDuration: const Duration(seconds: 2),
                  );
                }
              } catch (e) {
                if (mounted) {
                  toastification.show(
                    type: ToastificationType.error,
                    title: Text("Error deleting report: $e"),
                    autoCloseDuration: const Duration(seconds: 2),
                  );
                }
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _showDetails(StockReportSummary report) {
    showDialog(
      context: context,
      builder: (context) => _StockReportDetailsModal(report: report),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredReportsAsync = ref.watch(filteredStockReportsProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: FCard(
                child: filteredReportsAsync.when(
                  data: (reports) {
                    _dataGridSource.updateReports(reports);
                    return SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: Colors.red,
                        headerHoverColor: Colors.red[900],
                        gridLineColor: Colors.grey[300],
                        rowHoverColor: Colors.yellow[100],
                        selectionColor: Colors.red.withValues(alpha: 0.1),
                      ),
                      child: SfDataGrid(
                        source: _dataGridSource,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSorting: false,
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
              "Stock Reports",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Monthly inventory levels",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            _MonthlyFilterBar(),
            const SizedBox(width: 12),
            FButton(
              onPress: () => _showGenerateDialog(),
              child: const Text("Generate New"),
            ),
          ],
        ),
      ],
    );
  }

  void _showGenerateDialog() {
    showDialog(
      context: context,
      builder: (context) => const _GenerateReportDialog(),
    );
  }

  List<GridColumn> _buildColumns() {
    final headerStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return [
      GridColumn(
        columnName: 'date',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Generated On', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'month',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Report Month', style: headerStyle),
        ),
      ),

      GridColumn(
        columnName: 'createdBy',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Created By', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'actions',
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: Text('Actions', style: headerStyle),
        ),
      ),
    ];
  }
}

class _MonthlyFilterBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(stockReportFilterProvider);
    final start = filter[0];
    final end = filter[1];

    return Row(
      children: [
        _MonthPickerButton(
          label: start == null
              ? "Start Month"
              : DateFormat('MMM yyyy').format(start),
          onSelect: (date) {
            ref.read(stockReportFilterProvider.notifier).state = [date, end];
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
        ),
        _MonthPickerButton(
          label: end == null ? "End Month" : DateFormat('MMM yyyy').format(end),
          onSelect: (date) {
            ref.read(stockReportFilterProvider.notifier).state = [start, date];
          },
        ),
        if (start != null || end != null)
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.red),
            onPressed: () {
              ref.read(stockReportFilterProvider.notifier).state = [null, null];
            },
          ),
      ],
    );
  }
}

class _MonthPickerButton extends StatelessWidget {
  final String label;
  final Function(DateTime) onSelect;

  const _MonthPickerButton({required this.label, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return FButton(
      variant: FButtonVariant.outline,
      onPress: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2101),
          helpText: "Select Month",
        );
        if (picked != null) {
          onSelect(DateTime(picked.year, picked.month));
        }
      },
      child: Text(label),
    );
  }
}

class StockReportDataGridSource extends DataGridSource {
  StockReportDataGridSource({
    required List<StockReportSummary> reports,
    required this.onViewDetails,
    required this.onPrint,
    required this.onDelete,
  }) {
    _reports = reports;
    _buildDataGridRows();
  }

  List<StockReportSummary> _reports = [];
  List<DataGridRow> _dataGridRows = [];
  final Function(StockReportSummary) onViewDetails;
  final Function(StockReportSummary) onPrint;
  final Function(StockReportSummary) onDelete;

  void updateReports(List<StockReportSummary> reports) {
    _reports = reports;
    _buildDataGridRows();
    notifyListeners();
  }

  void _buildDataGridRows() {
    _dataGridRows = _reports.map<DataGridRow>((report) {
      return DataGridRow(
        cells: [
          DataGridCell<DateTime>(columnName: 'date', value: report.createdAt),
          DataGridCell<DateTime>(columnName: 'month', value: report.createdAt),
          DataGridCell<String>(
            columnName: 'createdBy',
            value: report.createdBy,
          ),

          DataGridCell<StockReportSummary>(
            columnName: 'actions',
            value: report,
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
        if (dataGridCell.columnName == 'actions') {
          final report = dataGridCell.value as StockReportSummary;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 20),
                  tooltip: 'View Details',
                  color: Colors.blue[700],
                  onPressed: () => onViewDetails(report),
                ),
                IconButton(
                  icon: const Icon(Icons.print_outlined, size: 20),
                  tooltip: 'Print Report',
                  color: Colors.green[700],
                  onPressed: () => onPrint(report),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  tooltip: 'Delete Report',
                  color: Colors.red[700],
                  onPressed: () => onDelete(report),
                ),
              ],
            ),
          );
        }

        String value = '';
        if (dataGridCell.columnName == 'month') {
          value = DateFormat('MMMM').format(dataGridCell.value as DateTime);
        } else if (dataGridCell.columnName == 'date') {
          value = DateFormat(
            'dd MMMM yyyy h:mm a',
          ).format(dataGridCell.value as DateTime);
        } else {
          value = dataGridCell.value.toString();
        }

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}

class _StockReportDetailsModal extends StatelessWidget {
  final StockReportSummary report;

  const _StockReportDetailsModal({required this.report});

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    final totalQtySold = report.currentStock.fold<int>(
      0,
      (sum, item) => sum + item.quantitySold,
    );
    final totalSalesVal = report.currentStock.fold<double>(
      0,
      (sum, item) => sum + item.totalSales,
    );
    final totalCurrentStock = report.currentStock.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Dialog(
      child: Container(
        width: 900,
        height: 700,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stock Report Details",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${DateFormat('dd MMMM yyyy').format(report.createdAt)} - ${report.branchName}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 32),

            // Summary Cards
            Row(
              children: [
                _buildSummaryCard(
                  context,
                  "Total Sales",
                  NumberFormat.currency(symbol: 'GH¢ ').format(totalSalesVal),
                  Icons.payments_outlined,
                  Colors.green,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  context,
                  "Total Sold",
                  "$totalQtySold Items",
                  Icons.shopping_cart_outlined,
                  Colors.blue,
                ),
                const SizedBox(width: 16),
                _buildSummaryCard(
                  context,
                  "Current Stock",
                  "$totalCurrentStock Items",
                  Icons.inventory_2_outlined,
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 24),
            Text(
              "Product Breakdown",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Product List Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Product",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "SKU",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Current",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Sold",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Total Sales",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: report.currentStock.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final prod = report.currentStock[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            prod.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prod.sku,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${prod.quantity}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${prod.quantitySold}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            NumberFormat.currency(
                              symbol: 'GH¢ ',
                            ).format(prod.totalSales),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GenerateReportDialog extends ConsumerStatefulWidget {
  const _GenerateReportDialog();

  @override
  ConsumerState<_GenerateReportDialog> createState() =>
      _GenerateReportDialogState();
}

class _GenerateReportDialogState extends ConsumerState<_GenerateReportDialog> {
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: const Text("Generate Monthly Report"),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select the month and year you would like to generate a stock report for. This will analyze all local inventory and sales data for that period.",
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 20),
          FButton(
            variant: FButtonVariant.outline,
            onPress: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = DateTime(picked.year, picked.month);
                });
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(DateFormat('MMMM yyyy').format(_selectedDate)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: _isLoading ? null : () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FButton(
          onPress: _isLoading
              ? null
              : () async {
                  setState(() => _isLoading = true);
                  try {
                    await ref.read(generateStockReportProvider)(
                      month: _selectedDate.month,
                      year: _selectedDate.year,
                    );
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Report generated successfully"),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      setState(() => _isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error generating report: $e")),
                      );
                    }
                  }
                },
          child: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text("Generate"),
        ),
      ],
    );
  }
}
