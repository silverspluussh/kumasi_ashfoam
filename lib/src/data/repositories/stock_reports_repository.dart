import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class StockReportsRepository {
  final ApiClient apiClient;

  StockReportsRepository({required this.apiClient});

  /// Fetch all stock reports
  Future<List<Map<String, dynamic>>> getStockReports({
    int? page,
    int? limit,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/stock-reports',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single stock report
  Future<Map<String, dynamic>> getStockReport(String reportId) async {
    final response = await apiClient.get('/stock-reports/$reportId');
    return response.data['data'] ?? {};
  }

  /// Create new stock report
  Future<Map<String, dynamic>> createStockReport(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/stock-reports',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update stock report
  Future<Map<String, dynamic>> updateStockReport(
    String reportId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/stock-reports/$reportId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Get current stock levels
  Future<List<Map<String, dynamic>>> getCurrentStockLevels({
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/stock-reports/current-levels',
      queryParameters: {
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get low stock items
  Future<List<Map<String, dynamic>>> getLowStockItems({
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/stock-reports/low-stock',
      queryParameters: {
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get stock movement report
  Future<Map<String, dynamic>> getStockMovementReport({
    String? period,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/stock-reports/movement',
      queryParameters: {
        if (period != null) 'period': period,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync stock reports
  Future<List<Map<String, dynamic>>> syncStockReports() async {
    final response = await apiClient.get('/stock-reports/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
