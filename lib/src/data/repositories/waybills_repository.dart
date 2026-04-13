import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class WayBillsRepository {
  final ApiClient apiClient;

  WayBillsRepository({required this.apiClient});

  /// Fetch all waybills
  Future<List<Map<String, dynamic>>> getWayBills({
    int? page,
    int? limit,
    String? status,
  }) async {
    final response = await apiClient.get(
      '/waybills',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single waybill
  Future<Map<String, dynamic>> getWayBill(String wayBillId) async {
    final response = await apiClient.get('/waybills/$wayBillId');
    return response.data['data'] ?? {};
  }

  /// Create waybill
  Future<Map<String, dynamic>> createWayBill(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/waybills',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update waybill
  Future<Map<String, dynamic>> updateWayBill(
    String wayBillId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/waybills/$wayBillId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Mark waybill as dispatched
  Future<void> markAsDispatched(String wayBillId) async {
    await apiClient.post(
      '/waybills/$wayBillId/dispatch',
      data: {},
    );
  }

  /// Mark waybill as delivered
  Future<void> markAsDelivered(String wayBillId) async {
    await apiClient.post(
      '/waybills/$wayBillId/deliver',
      data: {},
    );
  }

  /// Get waybill tracking information
  Future<Map<String, dynamic>> getWayBillTracking(String wayBillId) async {
    final response = await apiClient.get('/waybills/$wayBillId/tracking');
    return response.data['data'] ?? {};
  }

  /// Get waybill details/items
  Future<List<Map<String, dynamic>>> getWayBillDetails(
    String wayBillId,
  ) async {
    final response = await apiClient.get('/waybills/$wayBillId/details');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Generate waybill PDF
  Future<String> generateWayBillPDF(String wayBillId) async {
    final response = await apiClient.get('/waybills/$wayBillId/pdf');
    return response.data['data']['pdfUrl'] ?? '';
  }

  /// Sync waybills
  Future<List<Map<String, dynamic>>> syncWayBills() async {
    final response = await apiClient.get('/waybills/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
