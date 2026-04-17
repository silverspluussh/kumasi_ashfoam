import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/payments/providers/payment_providers.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final String day;
  final double sales;
  SalesTrendData(this.day, this.sales);
}

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
          waybillsAsync.error!,
      StackTrace.current,
    );
  }

  final inventory = inventoryAsync.value!;
  final sales = salesAsync.value!;
  final payments = paymentsAsync.value!;
  final invoices = invoicesAsync.value!;
  final proformas = proformasAsync.value!;
  final waybills = waybillsAsync.value!;

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

final weeklySalesTrendProvider = Provider<AsyncValue<List<SalesTrendData>>>((
  ref,
) {
  final salesAsync = ref.watch(saleOrdersProvider);

  return salesAsync.whenData((sales) {
    final now = DateTime.now();
    final last7Days = List.generate(
      7,
      (index) => now.subtract(Duration(days: 6 - index)),
    );

    final Map<String, double> salesByDay = {};
    final dateFormat = DateFormat('E');

    // Initialize all 7 days with 0
    for (final date in last7Days) {
      salesByDay[dateFormat.format(date)] = 0;
    }

    // Aggregate real sales
    for (final sale in sales) {
      if (sale.createdAt != null) {
        final day = dateFormat.format(sale.createdAt!);
        if (salesByDay.containsKey(day)) {
          salesByDay[day] = (salesByDay[day] ?? 0) + sale.totalAmount;
        }
      }
    }

    return salesByDay.entries
        .map((e) => SalesTrendData(e.key, e.value))
        .toList();
  });
});
