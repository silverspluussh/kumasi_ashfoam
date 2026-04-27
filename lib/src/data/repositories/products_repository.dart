import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:drift/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsRepository {
  final SupabaseClient supabase;
  final DatabaseService databaseService;

  ProductsRepository({required this.supabase, required this.databaseService});

  /// Fetch all inventory items from local database
  Future<List<Map<String, dynamic>>> getInventoryItems({
    int? page,
    int? limit,
    String? search,
  }) async {
    final items = await databaseService.getInventoryItems();

    var filtered = items;
    if (search != null && search.isNotEmpty) {
      final query = search.toLowerCase();
      filtered = filtered
          .where(
            (item) =>
                item.name.toLowerCase().contains(query) ||
                item.sku.toLowerCase().contains(query),
          )
          .toList();
    }

    // Manual pagination
    if (page != null && limit != null) {
      final startIndex = (page - 1) * limit;
      if (startIndex < filtered.length) {
        filtered = filtered.skip(startIndex).take(limit).toList();
      } else {
        filtered = [];
      }
    }

    return filtered
        .map(
          (e) => {
            'id': e.id,
            'name': e.name,
            'sku': e.sku,
            'category': e.category,
            'catergory_id': e.catergoryId,
            'sub_category': e.subCategory,
            'size': e.size,
            'thickness': e.thickness,
            'material': e.material,
            'density': e.density,
            'brand': e.brand,
            'brand_id': e.brandId,
            'retail_price': e.retailPrice,
            'discount_price': e.discountPrice,
            'discount_percentage': e.discountPercentage,
            'quantity': e.quantity,
            'unit': e.unit,
            'branch_id': e.branchId,
            'is_available': e.isAvailable,
            'created_at': e.createdAt?.toIso8601String(),
            'updated_at': e.updatedAt?.toIso8601String(),
            'is_synced': e.isSynced == 1,
            'last_synced_at': e.lastSyncedAt?.toIso8601String(),
          },
        )
        .toList();
  }

  /// Get single inventory item from local database
  Future<Map<String, dynamic>> getInventoryItem(String itemId) async {
    final items = await databaseService.getInventoryItems();
    try {
      final e = items.firstWhere((element) => element.id == itemId);
      return {
        'id': e.id,
        'name': e.name,
        'sku': e.sku,
        'category': e.category,
        'catergory_id': e.catergoryId,
        'sub_category': e.subCategory,
        'size': e.size,
        'thickness': e.thickness,
        'material': e.material,
        'density': e.density,
        'brand': e.brand,
        'brand_id': e.brandId,
        'retail_price': e.retailPrice,
        'discount_price': e.discountPrice,
        'discount_percentage': e.discountPercentage,
        'quantity': e.quantity,
        'unit': e.unit,
        'branch_id': e.branchId,
        'is_available': e.isAvailable,
        'created_at': e.createdAt?.toIso8601String(),
        'updated_at': e.updatedAt?.toIso8601String(),
        'is_synced': e.isSynced == 1,
        'last_synced_at': e.lastSyncedAt?.toIso8601String(),
      };
    } catch (_) {
      return {};
    }
  }

  /// Delete inventory item (Local first)
  Future<void> deleteInventoryItem(String itemId) async {
    await databaseService.deleteInventoryItem(itemId);
  }

  /// Search inventory items locally
  Future<List<Map<String, dynamic>>> searchInventoryItems(String query) async {
    return getInventoryItems(search: query);
  }

  /// Get inventory by category locally
  Future<List<Map<String, dynamic>>> getInventoryByCategory(
    String categoryId,
  ) async {
    final items = await databaseService.getInventoryItems();
    final filtered = items.where((e) => e.catergoryId == categoryId).toList();
    return filtered
        .map(
          (e) => {
            'id': e.id,
            'name': e.name,
            'sku': e.sku,
            'category': e.category,
            'catergory_id': e.catergoryId,
            'retail_price': e.retailPrice,
            'quantity': e.quantity,
            'is_synced': e.isSynced == 1,
          },
        )
        .toList();
  }

  /// Fetch inventory from Supabase (standard pattern for Remote Sync)
  Future<List<Map<String, dynamic>>> fetch() async {
    final response = await supabase.from('ashfoam_inventory').select();

    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload inventory to Supabase (Bulk Upload pattern)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];

    final response = await supabase
        .from('ashfoam_inventory')
        .upsert(items)
        .select();

    return List<Map<String, dynamic>>.from(response);
  }

  /// Sync inventory from Supabase (Remote wins, legacy method kept for sync providers)
  Future<List<Map<String, dynamic>>> syncInventory() async {
    // 1. Fetch from Supabase
    final List<Map<String, dynamic>> remoteData = await fetch();

    // 2. Overwrite local Drift records
    await databaseService.appDatabase.transaction(() async {
        for (final Map<String, dynamic> remoteRecord in remoteData) {
          final companion = InventoryItemsCompanion(
            id: Value(remoteRecord['id'] as String),
            name: Value(remoteRecord['name'] as String? ?? ''),
            sku: Value(remoteRecord['sku'] as String? ?? ''),
            category: Value(remoteRecord['category'] as String?),
            categoryId: Value(remoteRecord['category_id'] as String?),
            subCategory: Value(remoteRecord['sub_category'] as String?),
            size: Value(remoteRecord['size'] as String?),
            thickness: Value(remoteRecord['thickness'] as String?),
            material: Value(remoteRecord['material'] as String?),
            density: Value(remoteRecord['density'] as String?),
            brand: Value(remoteRecord['brand'] as String?),
            brandId: Value(remoteRecord['brand_id'] as String?),
            retailPrice: Value(
              (remoteRecord['retail_price'] as num?)?.toDouble() ?? 0.0,
            ),
            discountPrice: Value(
              (remoteRecord['discount_price'] as num?)?.toDouble(),
            ),
            discountPercentage: Value(
              (remoteRecord['discount_percentage'] as num?)?.toDouble(),
            ),
            quantity: Value(
              (remoteRecord['quantity'] as num?)?.toInt() ?? 0,
            ),
            unit: Value(remoteRecord['unit'] as String?),
            branchId: Value(remoteRecord['branch_id'] as String?),
            isAvailable: Value(remoteRecord['is_available'] == true ? 1 : 0),
            createdAt: Value(
              remoteRecord['created_at'] != null
                  ? DateTime.tryParse(remoteRecord['created_at'].toString())
                  : null,
            ),
            updatedAt: Value(
              remoteRecord['updated_at'] != null
                  ? DateTime.tryParse(remoteRecord['updated_at'].toString())
                  : null,
            ),
            isSynced: const Value(1),
            lastSyncedAt: Value(DateTime.now()),
          );

          await databaseService.appDatabase
              .into(databaseService.appDatabase.inventoryItems)
              .insertOnConflictUpdate(companion);
        }
      });

    return remoteData;
  }
}
