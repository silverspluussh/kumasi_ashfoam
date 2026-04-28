import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart'
    show InvoiceModel, InvoiceStatus;
import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/invoices/widgets/invoice_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class InvoicesView extends ConsumerStatefulWidget {
  const InvoicesView({super.key});

  @override
  ConsumerState<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends ConsumerState<InvoicesView> {
  late InvoiceDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = InvoiceDataGridSource(invoices: [], ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final invoicesAsync = ref.watch(filteredInvoicesProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: invoicesAsync.when(
                data: (invoices) {
                  _dataGridSource.updateInvoices(invoices);
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invoices",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Track billing and payment status for all records",
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
                hint: "Search by customer or invoice ID...",
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 18),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(invoiceSearchQueryProvider.notifier).state =
                        v.text;
                  },
                ),
              ),
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
        columnName: 'customer',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Customer', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'total',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Total Amount', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'balance',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Balance Due', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'dueDate',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Due Date', style: headerStyle),
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

class InvoiceDataGridSource extends DataGridSource {
  final WidgetRef ref;
  InvoiceDataGridSource({
    required List<InvoiceModel> invoices,
    required this.ref,
  }) {
    _invoices = invoices;
    _buildDataGridRows();
  }

  List<InvoiceModel> _invoices = [];
  List<DataGridRow> _dataGridRows = [];

  void updateInvoices(List<InvoiceModel> invoices) {
    _invoices = invoices;
    _buildDataGridRows();
    notifyListeners();
  }

  void _buildDataGridRows() {
    _dataGridRows = _invoices.map<DataGridRow>((i) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'customer',
            value: i.customerName ?? 'Walk-in Client',
          ),
          DataGridCell<double>(columnName: 'total', value: i.totalAmount),
          DataGridCell<double>(columnName: 'balance', value: i.balanceDue),
          DataGridCell<DateTime>(columnName: 'dueDate', value: i.dueDate),
          DataGridCell<InvoiceStatus>(columnName: 'status', value: i.status),
          DataGridCell<InvoiceModel>(columnName: 'actions', value: i),
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
        String value = '';
        Alignment alignment = Alignment.centerLeft;
        Widget? customWidget;

        if (dataGridCell.value is DateTime) {
          value = DateFormat(
            'MMM dd, yyyy',
          ).format(dataGridCell.value as DateTime);
        } else if (dataGridCell.value is double) {
          value = NumberFormat.currency(
            symbol: 'GH₵ ',
          ).format(dataGridCell.value);
          alignment = Alignment.centerRight;
        } else if (dataGridCell.value is InvoiceStatus) {
          final status = dataGridCell.value as InvoiceStatus;
          alignment = Alignment.center;
          customWidget = _buildStatusBadge(status);
        } else if (dataGridCell.value is InvoiceModel) {
          alignment = Alignment.center;
          customWidget = _buildActions(dataGridCell.value as InvoiceModel);
        } else {
          value = dataGridCell.value.toString();
        }

        return Container(
          alignment: alignment,
          padding: const EdgeInsets.all(12.0),
          child:
              customWidget ??
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style:
                    dataGridCell.columnName == 'balance' &&
                        (row.getCells()[2].value as double) > 0
                    ? const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      )
                    : null,
              ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(InvoiceStatus status) {
    Color color;
    String label;

    switch (status) {
      case InvoiceStatus.paid:
        color = Colors.green;
        label = "PAID";
        break;
      case InvoiceStatus.pending:
        color = Colors.orange;
        label = "PENDING";
        break;
      case InvoiceStatus.partial:
        color = Colors.blue;
        label = "PARTIAL";
        break;
      case InvoiceStatus.overdue:
        color = Colors.red;
        label = "OVERDUE";
        break;
      case InvoiceStatus.cancelled:
        color = Colors.red;
        label = "CANCELLED";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActions(InvoiceModel invoice) {
    final context = ref.context;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility_outlined, size: 18),
          color: Colors.blue,
          tooltip: 'View Details',
          onPressed: () => showDialog(
            context: context,
            builder: (context) => InvoiceDetailsDialog(invoice: invoice),
          ),
        ),
        PopupMenuButton<InvoiceStatus>(
          icon: const Icon(Icons.more_vert, size: 18),
          tooltip: 'Change Status',
          onSelected: (status) async {
            await ref.read(updateInvoiceStatusProvider)(invoice.id, status);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: InvoiceStatus.pending,
              child: Text("Set as Pending"),
            ),
            const PopupMenuItem(
              value: InvoiceStatus.paid,
              child: Text("Set as Paid"),
            ),
            const PopupMenuItem(
              value: InvoiceStatus.cancelled,
              child: Text("Set as Cancelled"),
            ),
          ],
        ),
      ],
    );
  }
}
