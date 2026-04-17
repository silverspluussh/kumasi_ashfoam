import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:ashfoam_sadiq/src/features/summary/providers/summary_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SummaryPage extends ConsumerWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(summaryStatsProvider);
    final trendAsync = ref.watch(weeklySalesTrendProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          statsAsync.when(
            data: (stats) => _buildSummaryCards(context, stats),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error loading stats: $err')),
          ),
          const SizedBox(height: 32),
          const SizedBox(height: 32),
          trendAsync.when(
            data: (trend) => _buildSalesTrendChart(context, trend),
            loading: () => const SizedBox(
              height: 400,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => Center(child: Text('Error loading trend: $err')),
          ),
          const SizedBox(height: 32),
          const SizedBox(height: 32),
          _buildRecentTransactionsSection(context, ref),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(BuildContext context, WidgetRef ref) {
    final recentInvoicesAsync = ref.watch(invoiceListProvider);
    final recentSalesAsync = ref.watch(saleOrdersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FCard(
                title: const Text('Recent Sales'),
                child: recentSalesAsync.when(
                  data: (sales) =>
                      _buildSimpleSalesTable(sales.take(5).toList()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: FCard(
                title: const Text('Recent Invoices'),
                child: recentInvoicesAsync.when(
                  data: (invoices) =>
                      _buildSimpleInvoicesTable(invoices.take(5).toList()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSimpleSalesTable(List<dynamic> sales) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Order #')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Amount')),
      ],
      rows: sales.map((sale) {
        return DataRow(
          cells: [
            DataCell(Text(sale.orderNumber.toString().substring(0, 8))),
            DataCell(Text(sale.customerName ?? 'Walk-in')),
            DataCell(Text('GH₵ ${sale.totalAmount.toStringAsFixed(2)}')),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSimpleInvoicesTable(List<dynamic> invoices) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Invoice ID')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Balance')),
      ],
      rows: invoices.map((inv) {
        return DataRow(
          cells: [
            DataCell(Text(inv.id.toString().substring(0, 8).toUpperCase())),
            DataCell(Text(inv.customerName ?? 'Walk-in')),
            DataCell(Text('GH₵ ${inv.balanceDue.toStringAsFixed(2)}')),
          ],
        );
      }).toList(),
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
          prefix: const Icon(Icons.download),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context, SummaryStats stats) {
    final currencyFormat = NumberFormat.currency(symbol: 'GH₵ ');

    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildStatCard(
          context,
          title: 'All Inventory',
          value: NumberFormat.decimalPattern().format(stats.totalInventory),
          subtitle: 'Items in stock',
          icon: Icons.inventory_2_outlined,
          color: Colors.blue,
        ),
        _buildStatCard(
          context,
          title: 'Recent Sales',
          value: currencyFormat.format(stats.totalSales),
          subtitle: 'Gross revenue',
          icon: Icons.shopping_cart_outlined,
          color: Colors.green,
        ),
        _buildStatCard(
          context,
          title: 'Total Payments',
          value: currencyFormat.format(stats.totalPayments),
          subtitle: 'Actual collected',
          icon: Icons.payments_outlined,
          color: Colors.amber,
        ),
        _buildStatCard(
          context,
          title: 'Invoices Total',
          value: currencyFormat.format(stats.invoiceTotal),
          subtitle: '${stats.totalInvoices} invoices generated',
          icon: Icons.description_outlined,
          color: Colors.purple,
        ),
        _buildStatCard(
          context,
          title: 'Total Proformas',
          value: stats.totalProformas.toString(),
          subtitle: 'Pending quotes',
          icon: Icons.request_quote_outlined,
          color: Colors.indigo,
        ),
        _buildStatCard(
          context,
          title: 'Total Waybills',
          value: stats.totalWaybills.toString(),
          subtitle: 'Dispatched orders',
          icon: Icons.local_shipping_outlined,
          color: Colors.orange,
        ),
        _buildStatCard(
          context,
          title: 'Total Outstanding',
          value: currencyFormat.format(stats.totalOutstanding),
          subtitle: 'Awaiting payment',
          icon: Icons.warning_amber_outlined,
          color: Colors.red,
        ),
        _buildStatCard(
          context,
          title: 'Low Stock Items',
          value: stats.lowStockCount.toString(),
          subtitle: 'Requires attention',
          icon: Icons.inventory_outlined,
          color: stats.lowStockCount > 0 ? Colors.red : Colors.green,
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
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesTrendChart(
    BuildContext context,
    List<SalesTrendData> trend,
  ) {
    return FCard(
      title: Text(
        'Weekly Sales Trend',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      child: SizedBox(
        height: 400,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compactCurrency(symbol: 'GH₵ '),
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<SalesTrendData, String>>[
            ColumnSeries<SalesTrendData, String>(
              dataSource: trend,
              xValueMapper: (SalesTrendData data, _) => data.day,
              yValueMapper: (SalesTrendData data, _) => data.sales,
              name: 'Sales',
              color: Colors.blue,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
