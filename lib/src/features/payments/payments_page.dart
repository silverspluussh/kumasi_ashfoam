import 'package:ashfoam_sadiq/src/data/models/payments.model.dart';
import 'package:ashfoam_sadiq/src/features/payments/providers/payment_providers.dart';
import 'package:ashfoam_sadiq/src/features/payments/widgets/add_payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({super.key});

  @override
  ConsumerState<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends ConsumerState<PaymentsPage> {
  late PaymentDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = PaymentDataGridSource(payments: []);
  }

  void _showAddPaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) => const AddPaymentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentsAsync = ref.watch(filteredPaymentsProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: FCard(
                child: paymentsAsync.when(
                  data: (payments) {
                    _dataGridSource.updatePayments(payments);
                    return SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: Colors.black,
                        gridLineColor: Colors.grey[200],
                      ),
                      child: SfDataGrid(
                        source: _dataGridSource,
                        columnWidthMode: ColumnWidthMode.fill,
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
              "Payments",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Manage and track branch-level payments",
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
                hint: "Search payments or branches...",
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 18),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(paymentSearchQueryProvider.notifier).state =
                        v.text;
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            FButton(
              onPress: _showAddPaymentDialog,
              prefix: const Icon(Icons.add),
              child: const Text("Add New Payment"),
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
        columnName: 'title',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Title', style: headerStyle),
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
          child: Text('Amount', style: headerStyle),
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
        columnName: 'createdBy',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Created By', style: headerStyle),
        ),
      ),
    ];
  }
}

class PaymentDataGridSource extends DataGridSource {
  PaymentDataGridSource({required List<BranchPayment> payments}) {
    _payments = payments;
    _buildDataGridRows();
  }

  List<BranchPayment> _payments = [];
  List<DataGridRow> _dataGridRows = [];

  void updatePayments(List<BranchPayment> payments) {
    _payments = payments;
    _buildDataGridRows();
    notifyListeners();
  }

  void _buildDataGridRows() {
    _dataGridRows = _payments.map<DataGridRow>((payment) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'title', value: payment.title),
          DataGridCell<String>(columnName: 'branch', value: payment.branchName),
          DataGridCell<double>(columnName: 'amount', value: payment.amount),
          DataGridCell<DateTime>(columnName: 'date', value: payment.createdAt),
          DataGridCell<String>(
            columnName: 'createdBy',
            value: payment.createdBy,
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
        String value = '';
        Alignment alignment = Alignment.centerLeft;

        if (dataGridCell.value is DateTime) {
          value = DateFormat(
            'MMM dd, yyyy HH:mm',
          ).format(dataGridCell.value as DateTime);
        } else if (dataGridCell.value is double) {
          value = NumberFormat.currency(
            symbol: 'GH₵ ',
          ).format(dataGridCell.value);
          alignment = Alignment.centerRight;
        } else {
          value = dataGridCell.value.toString();
        }

        return Container(
          alignment: alignment,
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: dataGridCell.columnName == 'amount'
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
