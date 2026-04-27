import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/payments/providers/payment_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

class SummaryStats {
  final int totalInventory;
  final double totalSales;
  final double totalPayments;
  final double totalOutstanding;
  final int totalInvoices;
  final int totalProformas;
  final int totalWaybills;
  final int lowStockCount;
  final double invoiceTotal;

  SummaryStats({
    required this.totalInventory,
    required this.totalSales,
    required this.totalPayments,
    required this.totalOutstanding,
    required this.totalInvoices,
    required this.totalProformas,
    required this.totalWaybills,
    required this.lowStockCount,
    this.invoiceTotal = 0.0,
  });
}

class SalesTrendData {
  final String label;
  final double sales;
  SalesTrendData(this.label, this.sales);
}

enum TrendTimeframe { daily, weekly, monthly, yearly }

final trendTimeframeProvider = StateProvider<TrendTimeframe>(
  (ref) => TrendTimeframe.daily,
);

final summaryStatsProvider = Provider<AsyncValue<SummaryStats>>((ref) {
  final inventoryAsync = ref.watch(inventoryListProvider);
  final salesAsync = ref.watch(saleOrdersProvider);
  final paymentsAsync = ref.watch(paymentsListProvider);
  final invoicesAsync = ref.watch(invoiceListProvider);
  final proformasAsync = ref.watch(proformaListProvider);
  final waybillsAsync = ref.watch(waybillListProvider);

  // Use a helper to avoid deeply nested .when
  if (inventoryAsync.isLoading ||
      salesAsync.isLoading ||
      paymentsAsync.isLoading ||
      invoicesAsync.isLoading ||
      proformasAsync.isLoading ||
      waybillsAsync.isLoading) {
    return const AsyncValue.loading();
  }

  // Handle all errors safely
  if (inventoryAsync.hasError ||
      salesAsync.hasError ||
      paymentsAsync.hasError ||
      invoicesAsync.hasError ||
      proformasAsync.hasError ||
      waybillsAsync.hasError) {
    return AsyncValue.error(
      inventoryAsync.error ??
          salesAsync.error ??
          paymentsAsync.error ??
          invoicesAsync.error ??
          proformasAsync.error ??
          waybillsAsync.error ??
          'Unknown error in summary stats',
      StackTrace.current,
    );
  }

  final inventory = inventoryAsync.value ?? [];
  final sales = salesAsync.value ?? [];
  final payments = paymentsAsync.value ?? [];
  final invoices = invoicesAsync.value ?? [];
  final proformas = proformasAsync.value ?? [];
  final waybills = waybillsAsync.value ?? [];

  final totalSales = sales.fold<double>(
    0,
    (sum, order) => sum + order.totalAmount,
  );
  final totalPayments = payments.fold<double>(
    0,
    (sum, payment) => sum + payment.amount,
  );
  final totalInvoicesVal = invoices.fold<double>(
    0,
    (sum, inv) => sum + inv.totalAmount,
  );
  final lowStockCount = inventory.where((item) => item.quantity < 10).length;

  return AsyncValue.data(
    SummaryStats(
      totalInventory: inventory.length,
      totalSales: totalSales,
      totalPayments: totalPayments,
      totalOutstanding: totalSales - totalPayments,
      totalInvoices: invoices.length,
      totalProformas: proformas.length,
      totalWaybills: waybills.length,
      lowStockCount: lowStockCount,
      invoiceTotal: totalInvoicesVal,
    ),
  );
});

final salesTrendProvider = Provider<AsyncValue<List<SalesTrendData>>>((ref) {
  final timeframe = ref.watch(trendTimeframeProvider);
  final salesAsync = ref.watch(saleOrdersProvider);

  return salesAsync.whenData((sales) {
    final now = DateTime.now();
    final Map<String, double> aggregatedData = {};
    late List<String> labels;

    // Helper to get normalized date key
    String getKey(DateTime dt) {
      switch (timeframe) {
        case TrendTimeframe.daily:
          return DateFormat('EEE').format(dt);
        case TrendTimeframe.weekly:
          // Return something like "Wk 14"
          final weekNum = ((dt.day - 1) / 7).floor() + 1;
          return 'Wk $weekNum ${DateFormat('MMM').format(dt)}';
        case TrendTimeframe.monthly:
          return DateFormat('MMM').format(dt);
        case TrendTimeframe.yearly:
          return DateFormat('yyyy').format(dt);
      }
    }

    // Initialize periods
    switch (timeframe) {
      case TrendTimeframe.daily:
        labels = List.generate(
          7,
          (i) => DateFormat('EEE').format(now.subtract(Duration(days: 6 - i))),
        );
        break;
      case TrendTimeframe.weekly:
        labels = List.generate(
          4,
          (i) => getKey(now.subtract(Duration(days: (3 - i) * 7))),
        );
        break;
      case TrendTimeframe.monthly:
        labels = List.generate(
          6,
          (i) => DateFormat(
            'MMM',
          ).format(DateTime(now.year, now.month - (5 - i), 1)),
        );
        break;
      case TrendTimeframe.yearly:
        labels = List.generate(
          5,
          (i) => DateFormat('yyyy').format(DateTime(now.year - (4 - i), 1, 1)),
        );
        break;
    }

    for (final label in labels) {
      aggregatedData[label] = 0;
    }

    // Aggregate real sales
    for (final sale in sales) {
      if (sale.createdAt != null) {
        final key = getKey(sale.createdAt!);
        if (aggregatedData.containsKey(key)) {
          aggregatedData[key] = (aggregatedData[key] ?? 0) + sale.totalAmount;
        }
      }
    }

    return labels
        .map((l) => SalesTrendData(l, aggregatedData[l] ?? 0))
        .toList();
  });
});

// For backward compatibility
final weeklySalesTrendProvider = salesTrendProvider;
