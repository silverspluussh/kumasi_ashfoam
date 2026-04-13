import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ProductCategoriesRepository {
  final ApiClient apiClient;

  ProductCategoriesRepository({required this.apiClient});

  /// Fetch all product categories
  Future<List<Map<String, dynamic>>> getCategories({
    int? page,
    int? limit,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/products/categories',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single category
  Future<Map<String, dynamic>> getCategory(String categoryId) async {
    final response = await apiClient.get('/products/categories/$categoryId');
    return response.data['data'] ?? {};
  }

  /// Create new category
  Future<Map<String, dynamic>> createCategory(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/products/categories',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update category
  Future<Map<String, dynamic>> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/products/categories/$categoryId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete category
  Future<void> deleteCategory(String categoryId) async {
    await apiClient.delete('/products/categories/$categoryId');
  }

  /// Get category products
  Future<List<Map<String, dynamic>>> getCategoryProducts(
    String categoryId,
  ) async {
    final response = await apiClient.get(
      '/products/categories/$categoryId/products',
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get category subcategories
  Future<List<Map<String, dynamic>>> getCategorySubCategories(
    String categoryId,
  ) async {
    final response = await apiClient.get(
      '/products/categories/$categoryId/subcategories',
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync categories
  Future<List<Map<String, dynamic>>> syncCategories() async {
    final response = await apiClient.get('/products/categories/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
