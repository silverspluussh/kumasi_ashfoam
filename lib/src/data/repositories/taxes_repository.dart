import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class TaxesRepository {
  final ApiClient apiClient;

  TaxesRepository({required this.apiClient});

  /// Fetch all taxes
  Future<List<Map<String, dynamic>>> getTaxes({
    int? page,
    int? limit,
  }) async {
    final response = await apiClient.get(
      '/taxes',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single tax
  Future<Map<String, dynamic>> getTax(String taxId) async {
    final response = await apiClient.get('/taxes/$taxId');
    return response.data['data'] ?? {};
  }

  /// Create new tax
  Future<Map<String, dynamic>> createTax(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/taxes',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update tax
  Future<Map<String, dynamic>> updateTax(
    String taxId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/taxes/$taxId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete tax
  Future<void> deleteTax(String taxId) async {
    await apiClient.delete('/taxes/$taxId');
  }

  /// Get active taxes
  Future<List<Map<String, dynamic>>> getActiveTaxes() async {
    final response = await apiClient.get('/taxes/active');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync taxes
  Future<List<Map<String, dynamic>>> syncTaxes() async {
    final response = await apiClient.get('/taxes/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
