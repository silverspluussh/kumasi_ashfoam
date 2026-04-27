import 'package:ashfoam_sadiq/src/data/models/stock_adjustment.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adjustStockProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);

  return ({
    required String productId,
    required int quantityChange,
    required String type,
    String? reason,
    String? referenceId,
  }) async {
    await dbService.adjustInventoryStock(
      productId: productId,
      quantityChange: quantityChange,
      type: type,
      reason: reason,
      referenceId: referenceId,
      createdBy: 'Admin', // In a real app, get from auth provider
    );
    // Invalidate inventory providers to refresh UI
    ref.invalidate(inventoryListProvider);
    ref.invalidate(filteredInventoryProvider);
    ref.invalidate(stockAdjustmentLogsProvider);
  };
});

final stockAdjustmentLogsProvider = FutureProvider<List<AdjustmentLog>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.getStockAdjustmentLogs();
});
