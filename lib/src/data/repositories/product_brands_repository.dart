import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ProductBrandsRepository {
  final ApiClient apiClient;

  ProductBrandsRepository({required this.apiClient});

  /// Fetch all product brands
  Future<List<Map<String, dynamic>>> getBrands({
    int? page,
    int? limit,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/products/brands',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single brand
  Future<Map<String, dynamic>> getBrand(String brandId) async {
    final response = await apiClient.get('/products/brands/$brandId');
    return response.data['data'] ?? {};
  }

  /// Create new brand
  Future<Map<String, dynamic>> createBrand(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/products/brands',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update brand
  Future<Map<String, dynamic>> updateBrand(
    String brandId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/products/brands/$brandId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete brand
  Future<void> deleteBrand(String brandId) async {
    await apiClient.delete('/products/brands/$brandId');
  }

  /// Get brand products
  Future<List<Map<String, dynamic>>> getBrandProducts(String brandId) async {
    final response = await apiClient.get('/products/brands/$brandId/products');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync brands
  Future<List<Map<String, dynamic>>> syncBrands() async {
    final response = await apiClient.get('/products/brands/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
