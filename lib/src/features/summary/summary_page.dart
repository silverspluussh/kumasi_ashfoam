import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildSummaryCards(context),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildSalesTrendChart(context)),
              const SizedBox(width: 24),
              Expanded(flex: 1, child: _buildRecentActivities(context)),
            ],
          ),
          const SizedBox(height: 32),
          _buildPendingInvoicesTable(context),
        ],
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
              'Business Overview',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Real-time performance metrics and insights.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        FButton(
          child: const Text('Download Report'),
          onPress: () {},
          prefix: Icon(FIcons.download),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          title: 'Total Inventory',
          value: '4,520',
          subtitle: '+12% from last month',
          icon: FIcons.boxes,
          color: Colors.blue,
        ),
        _buildStatCard(
          context,
          title: 'Total Sales',
          value: 'GH₵ 128,450',
          subtitle: '+5.4% from last month',
          icon: FIcons.shoppingCart,
          color: Colors.green,
        ),
        _buildStatCard(
          context,
          title: 'Total Payments',
          value: 'GH₵ 98,200',
          subtitle: 'Active collection',
          icon: FIcons.currency,
          color: Colors.amber,
        ),
        _buildStatCard(
          context,
          title: 'Total Outstanding',
          value: 'GH₵ 30,250',
          subtitle: 'Requires attention',
          icon: FIcons.fileText,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: Colors.grey),
              ),
              Icon(icon, color: color.withOpacity(0.7), size: 20),
            ],
          ),
          const SizedBox(height: 30),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: subtitle.contains('+') ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesTrendChart(BuildContext context) {
    final List<_ChartData> chartData = [
      _ChartData('Mon', 1500),
      _ChartData('Tue', 2800),
      _ChartData('Wed', 2200),
      _ChartData('Thu', 3500),
      _ChartData('Fri', 4200),
      _ChartData('Sat', 3800),
      _ChartData('Sun', 2500),
    ];

    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales Trend',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.compactCurrency(symbol: 'GH₵ '),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_ChartData, String>>[
                AreaSeries<_ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.day,
                  yValueMapper: (_ChartData data, _) => data.sales,
                  name: 'Sales',
                  color: Colors.blue.withOpacity(0.3),
                  borderColor: Colors.blue,
                  borderWidth: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activities',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Sale #1234 - GH₵ 500',
            '2 mins ago',
            FIcons.shoppingCart,
            context,
          ),
          _buildActivityItem(
            'Payment from sadiq - GH₵ 200',
            '15 mins ago',
            FIcons.currency,
            context,
          ),
          _buildActivityItem(
            'Stock added - 50 items',
            '1 hour ago',
            FIcons.list,
            context,
          ),
          _buildActivityItem(
            'New Invoice #5521',
            '3 hours ago',
            FIcons.fileText,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingInvoicesTable(BuildContext context) {
    final List<_InvoiceData> invoices = [
      _InvoiceData('John Doe', 'INV-001', 500.0, '2024-03-20'),
      _InvoiceData('Alice Smith', 'INV-002', 1200.0, '2024-03-21'),
      _InvoiceData('Bob Johnson', 'INV-003', 450.0, '2024-03-22'),
      _InvoiceData('Sarah Wilson', 'INV-004', 3200.0, '2024-03-23'),
      _InvoiceData('Charlie Brown', 'INV-005', 150.0, '2024-03-24'),
    ];

    return FCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Invoices',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FButton(child: const Text('View All'), onPress: () {}),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: SfDataGrid(
              source: _InvoiceDataSource(invoices),
              columnWidthMode: ColumnWidthMode.fill,
              columns: [
                GridColumn(
                  columnName: 'customer',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: const Text('Customer'),
                  ),
                ),
                GridColumn(
                  columnName: 'invoiceNo',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: const Text('Invoice #'),
                  ),
                ),
                GridColumn(
                  columnName: 'amount',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: const Text('Amount Due'),
                  ),
                ),
                GridColumn(
                  columnName: 'date',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: const Text('Date'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.day, this.sales);
  final String day;
  final double sales;
}

class _InvoiceData {
  _InvoiceData(this.customer, this.invoiceNo, this.amount, this.date);
  final String customer;
  final String invoiceNo;
  final double amount;
  final String date;
}

class _InvoiceDataSource extends DataGridSource {
  _InvoiceDataSource(List<_InvoiceData> invoices) {
    _invoiceData = invoices
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'customer', value: e.customer),
              DataGridCell<String>(columnName: 'invoiceNo', value: e.invoiceNo),
              DataGridCell<double>(columnName: 'amount', value: e.amount),
              DataGridCell<String>(columnName: 'date', value: e.date),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _invoiceData = [];

  @override
  List<DataGridRow> get rows => _invoiceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: e.columnName == 'amount' || e.columnName == 'date'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.columnName == 'amount'
                ? NumberFormat.currency(symbol: 'GH₵ ').format(e.value)
                : e.value.toString(),
          ),
        );
      }).toList(),
    );
  }
}
