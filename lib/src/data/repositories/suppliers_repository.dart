import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class SuppliersRepository {
  final ApiClient apiClient;

  SuppliersRepository({required this.apiClient});

  /// Fetch all suppliers
  Future<List<Map<String, dynamic>>> getSuppliers({
    int? page,
    int? limit,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/suppliers',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single supplier
  Future<Map<String, dynamic>> getSupplier(String supplierId) async {
    final response = await apiClient.get('/suppliers/$supplierId');
    return response.data['data'] ?? {};
  }

  /// Create new supplier
  Future<Map<String, dynamic>> createSupplier(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/suppliers',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update supplier
  Future<Map<String, dynamic>> updateSupplier(
    String supplierId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/suppliers/$supplierId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete supplier
  Future<void> deleteSupplier(String supplierId) async {
    await apiClient.delete('/suppliers/$supplierId');
  }

  /// Search suppliers
  Future<List<Map<String, dynamic>>> searchSuppliers(String query) async {
    final response = await apiClient.get(
      '/suppliers/search',
      queryParameters: {'q': query},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get supplier products
  Future<List<Map<String, dynamic>>> getSupplierProducts(
    String supplierId,
  ) async {
    final response = await apiClient.get('/suppliers/$supplierId/products');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get supplier orders
  Future<List<Map<String, dynamic>>> getSupplierOrders(
    String supplierId,
  ) async {
    final response = await apiClient.get('/suppliers/$supplierId/orders');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync suppliers
  Future<List<Map<String, dynamic>>> syncSuppliers() async {
    final response = await apiClient.get('/suppliers/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
