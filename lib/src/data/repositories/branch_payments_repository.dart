import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class BranchPaymentsRepository {
  final ApiClient apiClient;

  BranchPaymentsRepository({required this.apiClient});

  /// Fetch all branch payments
  Future<List<Map<String, dynamic>>> getBranchPayments({
    int? page,
    int? limit,
    String? branchId,
    String? status,
  }) async {
    final response = await apiClient.get(
      '/branch-payments',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (branchId != null) 'branchId': branchId,
        if (status != null) 'status': status,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single branch payment
  Future<Map<String, dynamic>> getBranchPayment(String paymentId) async {
    final response = await apiClient.get('/branch-payments/$paymentId');
    return response.data['data'] ?? {};
  }

  /// Create new branch payment
  Future<Map<String, dynamic>> createBranchPayment(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/branch-payments',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update branch payment
  Future<Map<String, dynamic>> updateBranchPayment(
    String paymentId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/branch-payments/$paymentId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Approve branch payment
  Future<void> approveBranchPayment(String paymentId) async {
    await apiClient.post(
      '/branch-payments/$paymentId/approve',
      data: {},
    );
  }

  /// Reject branch payment
  Future<void> rejectBranchPayment(String paymentId, String reason) async {
    await apiClient.post(
      '/branch-payments/$paymentId/reject',
      data: {'reason': reason},
    );
  }

  /// Get branch payment summary
  Future<Map<String, dynamic>> getBranchPaymentSummary({
    String? branchId,
    String? period,
  }) async {
    final response = await apiClient.get(
      '/branch-payments/summary',
      queryParameters: {
        if (branchId != null) 'branchId': branchId,
        if (period != null) 'period': period,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync branch payments
  Future<List<Map<String, dynamic>>> syncBranchPayments() async {
    final response = await apiClient.get('/branch-payments/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
