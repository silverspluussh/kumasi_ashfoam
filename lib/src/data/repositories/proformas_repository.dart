import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ProformasRepository {
  final ApiClient apiClient;

  ProformasRepository({required this.apiClient});

  /// Fetch all proformas
  Future<List<Map<String, dynamic>>> getProformas({
    int? page,
    int? limit,
    String? status,
    String? customerId,
  }) async {
    final response = await apiClient.get(
      '/proformas',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (customerId != null) 'customerId': customerId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single proforma
  Future<Map<String, dynamic>> getProforma(String proformaId) async {
    final response = await apiClient.get('/proformas/$proformaId');
    return response.data['data'] ?? {};
  }

  /// Create proforma
  Future<Map<String, dynamic>> createProforma(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/proformas',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update proforma
  Future<Map<String, dynamic>> updateProforma(
    String proformaId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/proformas/$proformaId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Convert proforma to sale order
  Future<Map<String, dynamic>> convertProformaToOrder(
    String proformaId,
  ) async {
    final response = await apiClient.post(
      '/proformas/$proformaId/convert-to-order',
      data: {},
    );
    return response.data['data'] ?? {};
  }

  /// Get proforma details/items
  Future<List<Map<String, dynamic>>> getProformaDetails(
    String proformaId,
  ) async {
    final response = await apiClient.get('/proformas/$proformaId/details');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Generate proforma PDF
  Future<String> generateProformaPDF(String proformaId) async {
    final response = await apiClient.get('/proformas/$proformaId/pdf');
    return response.data['data']['pdfUrl'] ?? '';
  }

  /// Send proforma by email
  Future<void> sendProformaByEmail(
    String proformaId,
    String email,
  ) async {
    await apiClient.post(
      '/proformas/$proformaId/send-email',
      data: {'email': email},
    );
  }

  /// Sync proformas
  Future<List<Map<String, dynamic>>> syncProformas() async {
    final response = await apiClient.get('/proformas/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Push unsynced proformas to remote (local to remote sync)
  Future<List<Map<String, dynamic>>> pushUnsyncedProformas(
    List<Map<String, dynamic>> proformas,
  ) async {
    final response = await apiClient.post(
      '/proformas/bulk-sync',
      data: {'proformas': proformas},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
