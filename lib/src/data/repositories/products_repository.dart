import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ProductsRepository {
  final ApiClient apiClient;

  ProductsRepository({required this.apiClient});

  /// Fetch all inventory items from remote API
  Future<List<Map<String, dynamic>>> getInventoryItems({
    int? page,
    int? limit,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/products/inventory',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single inventory item by ID
  Future<Map<String, dynamic>> getInventoryItem(String itemId) async {
    final response = await apiClient.get('/products/inventory/$itemId');
    return response.data['data'] ?? {};
  }

  /// Create new inventory item
  Future<Map<String, dynamic>> createInventoryItem(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/products/inventory',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update inventory item
  Future<Map<String, dynamic>> updateInventoryItem(
    String itemId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/products/inventory/$itemId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete inventory item
  Future<void> deleteInventoryItem(String itemId) async {
    await apiClient.delete('/products/inventory/$itemId');
  }

  /// Search inventory items
  Future<List<Map<String, dynamic>>> searchInventoryItems(
    String query,
  ) async {
    final response = await apiClient.get(
      '/products/inventory/search',
      queryParameters: {'q': query},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get inventory by category
  Future<List<Map<String, dynamic>>> getInventoryByCategory(
    String categoryId,
  ) async {
    final response = await apiClient.get(
      '/products/inventory/category/$categoryId',
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync inventory from remote
  Future<List<Map<String, dynamic>>> syncInventory() async {
    final response = await apiClient.get('/products/inventory/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
