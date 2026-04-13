import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ProductSubCategoriesRepository {
  final ApiClient apiClient;

  ProductSubCategoriesRepository({required this.apiClient});

  /// Fetch all product sub-categories
  Future<List<Map<String, dynamic>>> getSubCategories({
    int? page,
    int? limit,
    String? categoryId,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/products/subcategories',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (categoryId != null) 'categoryId': categoryId,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single sub-category
  Future<Map<String, dynamic>> getSubCategory(String subCategoryId) async {
    final response = await apiClient.get(
      '/products/subcategories/$subCategoryId',
    );
    return response.data['data'] ?? {};
  }

  /// Create new sub-category
  Future<Map<String, dynamic>> createSubCategory(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/products/subcategories',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update sub-category
  Future<Map<String, dynamic>> updateSubCategory(
    String subCategoryId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/products/subcategories/$subCategoryId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete sub-category
  Future<void> deleteSubCategory(String subCategoryId) async {
    await apiClient.delete('/products/subcategories/$subCategoryId');
  }

  /// Get sub-category products
  Future<List<Map<String, dynamic>>> getSubCategoryProducts(
    String subCategoryId,
  ) async {
    final response = await apiClient.get(
      '/products/subcategories/$subCategoryId/products',
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync sub-categories
  Future<List<Map<String, dynamic>>> syncSubCategories() async {
    final response = await apiClient.get('/products/subcategories/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
