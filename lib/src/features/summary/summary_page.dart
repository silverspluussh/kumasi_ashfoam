import 'package:ashfoam_sadiq/src/core/theme/app_colors.dart';
import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:ashfoam_sadiq/src/features/summary/providers/summary_providers.dart';
import 'package:ashfoam_sadiq/src/utils/date_extensions.dart';
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
    final trendAsync = ref.watch(salesTrendProvider);
    final timeframe = ref.watch(trendTimeframeProvider);

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
          _buildRecentTransactionsSection(context, ref),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(BuildContext context, WidgetRef ref) {
    final recentInvoicesAsync = ref.watch(invoiceListProvider);
    final recentSalesAsync = ref.watch(saleOrdersProvider);
    final isTabletView = MediaQuery.of(context).size.width < 1280;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        if (isTabletView) ...[
          FCard(
            title: const Text('Recent Sales'),
            child: recentSalesAsync.when(
              data: (sales) => _buildSimpleSalesTable(sales.take(5).toList()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
          const SizedBox(height: 16),
          FCard(
            title: const Text('Recent Invoices'),
            child: recentInvoicesAsync.when(
              data: (invoices) =>
                  _buildSimpleInvoicesTable(invoices.take(5).toList()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ),
        ],
        if (!isTabletView)
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
              const SizedBox(width: 15),
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

  Widget _buildSimpleSalesTable(List<SaleOrderModel> sales) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Order #')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Amount')),
      ],
      rows: sales.map((sale) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                sale.orderNumber.length > 8
                    ? sale.orderNumber.substring(0, 8)
                    : sale.orderNumber,
              ),
            ),
            DataCell(Text(sale.createdAt!.mmddyyyy)),

            DataCell(Text(sale.customerName ?? 'Walk-in')),
            DataCell(Text('GH₵ ${sale.totalAmount.toStringAsFixed(2)}')),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSimpleInvoicesTable(List<InvoiceModel> invoices) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Customer')),
        DataColumn(label: Text('Amount Paid')),
        DataColumn(label: Text('Balance')),
      ],
      rows: invoices.map((inv) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                inv.id.length > 8
                    ? inv.id.substring(0, 8).toUpperCase()
                    : inv.id.toUpperCase(),
              ),
            ),
            DataCell(Text(inv.customerName ?? 'Walk-in')),
            DataCell(Text('GH₵ ${inv.paidAmount.toStringAsFixed(2)}')),

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
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context, SummaryStats stats) {
    final currencyFormat = NumberFormat.currency(symbol: 'GH₵ ');
    final isTabletView = MediaQuery.of(context).size.width < 1280;

    return GridView.count(
      crossAxisCount: isTabletView ? 2 : 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 2,
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
          backgroundColor: AppColors.yellow12,
          textColor: Colors.black,
        ),
        _buildStatCard(
          context,
          title: 'Recent Sales',
          value: currencyFormat.format(stats.totalSales),
          subtitle: 'Gross revenue',
          icon: Icons.shopping_cart_outlined,
          color: Colors.green,
          backgroundColor: AppColors.green12,
          textColor: Colors.black,
        ),
        _buildStatCard(
          context,
          title: 'Total Payments',
          value: currencyFormat.format(stats.totalPayments),
          subtitle: 'Actual collected',
          icon: Icons.payments_outlined,
          color: Colors.amber,
          backgroundColor: AppColors.green13,
          textColor: Colors.white,
        ),

        _buildStatCard(
          context,
          title: 'Total Proformas',
          value: stats.totalProformas.toString(),
          subtitle: 'Pending quotes',
          icon: Icons.request_quote_outlined,
          color: Colors.indigo,
          backgroundColor: AppColors.green15,
          textColor: Colors.white,
        ),
        _buildStatCard(
          context,
          title: 'Total Waybills',
          value: stats.totalWaybills.toString(),
          subtitle: 'Dispatched orders',
          icon: Icons.local_shipping_outlined,
          color: Colors.orange,
          backgroundColor: AppColors.red34,
          textColor: Colors.white,
        ),

        _buildStatCard(
          context,
          title: 'Low Stock Items',
          value: stats.lowStockCount.toString(),
          subtitle: 'Requires attention',
          icon: Icons.inventory_outlined,
          color: stats.lowStockCount > 0 ? Colors.white : Colors.black,
          backgroundColor: AppColors.red34,
          textColor: Colors.white,
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
    Color? backgroundColor,
    Color? textColor,
  }) {
    return FCard(
      style: FCardStyleDelta.delta(
        decoration: DecorationDelta.boxDelta(
          border: Border.all(color: Colors.transparent),
          color: backgroundColor ?? Colors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor ?? Colors.black,
                ),
              ),
              Icon(icon, color: color.withValues(alpha: 0.7), size: 20),
            ],
          ),
          const SizedBox(height: 30),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: textColor ?? Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesTrendChart(
    BuildContext context,
    List<SalesTrendData> trend,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedTimeframe = ref.watch(trendTimeframeProvider);

        return FCard(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales Trend - ${toBeginningOfSentenceCase(selectedTimeframe.name)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                children: TrendTimeframe.values.map((timeframe) {
                  final isSelected = selectedTimeframe == timeframe;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FButton(
                      variant: isSelected
                          ? FButtonVariant.primary
                          : FButtonVariant.outline,
                      onPress: () {
                        ref.read(trendTimeframeProvider.notifier).state =
                            timeframe;
                      },
                      child: Text(toBeginningOfSentenceCase(timeframe.name)!),
                    ),
                  );
                }).toList(),
              ),
            ],
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
                  xValueMapper: (SalesTrendData data, _) => data.label,
                  yValueMapper: (SalesTrendData data, _) => data.sales,
                  name: 'Sales',
                  color: AppColors.red34,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
