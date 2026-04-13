import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ReceiptsRepository {
  final ApiClient apiClient;

  ReceiptsRepository({required this.apiClient});

  /// Fetch all receipts
  Future<List<Map<String, dynamic>>> getReceipts({
    int? page,
    int? limit,
    String? status,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/receipts',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single receipt
  Future<Map<String, dynamic>> getReceipt(String receiptId) async {
    final response = await apiClient.get('/receipts/$receiptId');
    return response.data['data'] ?? {};
  }

  /// Create new receipt
  Future<Map<String, dynamic>> createReceipt(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/receipts',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update receipt
  Future<Map<String, dynamic>> updateReceipt(
    String receiptId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/receipts/$receiptId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Mark receipt as verified
  Future<void> verifyReceipt(String receiptId) async {
    await apiClient.post(
      '/receipts/$receiptId/verify',
      data: {},
    );
  }

  /// Generate receipt PDF
  Future<String> generateReceiptPDF(String receiptId) async {
    final response = await apiClient.get('/receipts/$receiptId/pdf');
    return response.data['data']['pdfUrl'] ?? '';
  }

  /// Get receipt summary
  Future<Map<String, dynamic>> getReceiptSummary({
    String? period,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/receipts/summary',
      queryParameters: {
        if (period != null) 'period': period,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync receipts
  Future<List<Map<String, dynamic>>> syncReceipts() async {
    final response = await apiClient.get('/receipts/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
