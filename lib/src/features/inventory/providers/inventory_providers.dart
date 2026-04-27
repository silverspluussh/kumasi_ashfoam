import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to fetch all inventory items from local database
final inventoryListProvider = FutureProvider<List<InventoryModel>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.getInventoryItems();
});

/// Provider for inventory search filter
final inventorySearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered inventory
final filteredInventoryProvider = Provider<AsyncValue<List<InventoryModel>>>((
  ref,
) {
  final inventoryAsync = ref.watch(inventoryListProvider);
  final query = ref.watch(inventorySearchQueryProvider).toLowerCase();

  return inventoryAsync.whenData((items) {
    if (query.isEmpty) return items;
    return items.where((item) {
      final name = item.name.toLowerCase();
      final sku = item.sku.toLowerCase();
      final category = (item.category ?? '').toLowerCase();
      return name.contains(query) ||
          sku.contains(query) ||
          category.contains(query);
    }).toList();
  });
});

final addInventoryItemProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (InventoryItemsCompanion item) async {
    await dbService.addInventoryItem(item);
    ref.invalidate(inventoryListProvider);
  };
});
