import 'package:ashfoam_sadiq/src/data/local/drift_extensions.dart';
import 'package:ashfoam_sadiq/src/data/models/stock_report.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to fetch all stock reports from local database
final stockReportsListProvider = FutureProvider<List<StockReportSummary>>((
  ref,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.getStockReports();
});

/// Provider for monthly date range filter [start, end]
/// Format: DateTime(year, month)
final stockReportFilterProvider = StateProvider<List<DateTime?>>(
  (ref) => [null, null],
);

/// Computed provider for filtered stock reports
final filteredStockReportsProvider =
    Provider<AsyncValue<List<StockReportSummary>>>((ref) {
      final reportsAsync = ref.watch(stockReportsListProvider);
      final filter = ref.watch(stockReportFilterProvider);

      final start = filter[0];
      final end = filter[1];

      return reportsAsync.whenData((reports) {
        if (start == null && end == null) return reports;

        return reports.where((report) {
          final reportDate = DateTime(
            report.createdAt.year,
            report.createdAt.month,
          );

          bool isAfterStart = true;
          if (start != null) {
            isAfterStart =
                reportDate.isAtSameMomentAs(start) || reportDate.isAfter(start);
          }

          bool isBeforeEnd = true;
          if (end != null) {
            isBeforeEnd =
                reportDate.isAtSameMomentAs(end) || reportDate.isBefore(end);
          }

          return isAfterStart && isBeforeEnd;
        }).toList();
      });
    });

/// Provider to trigger stock report generation
final generateStockReportProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);
  return ({required int month, required int year}) async {
    await dbService.generateMonthlyStockReport(
      month: month,
      year: year,
      createdBy: 'Local Admin',
    );
    // Invalidate the list to trigger a refresh
    ref.invalidate(stockReportsListProvider);
  };
});

/// Provider to delete a stock report
final deleteStockReportProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);
  return (String id) async {
    await dbService.deleteStockReport(id);
    // Invalidate the list to trigger a refresh
    ref.invalidate(stockReportsListProvider);
  };
});
