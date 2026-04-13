import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class StoresRepository {
  final ApiClient apiClient;

  StoresRepository({required this.apiClient});

  /// Fetch all stores
  Future<List<Map<String, dynamic>>> getStores({
    int? page,
    int? limit,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/stores',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single store
  Future<Map<String, dynamic>> getStore(String storeId) async {
    final response = await apiClient.get('/stores/$storeId');
    return response.data['data'] ?? {};
  }

  /// Create new store
  Future<Map<String, dynamic>> createStore(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/stores',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update store
  Future<Map<String, dynamic>> updateStore(
    String storeId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/stores/$storeId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete store
  Future<void> deleteStore(String storeId) async {
    await apiClient.delete('/stores/$storeId');
  }

  /// Get store inventory
  Future<List<Map<String, dynamic>>> getStoreInventory(String storeId) async {
    final response = await apiClient.get('/stores/$storeId/inventory');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync stores
  Future<List<Map<String, dynamic>>> syncStores() async {
    final response = await apiClient.get('/stores/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
