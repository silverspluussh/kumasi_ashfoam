import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ExpensesRepository {
  final ApiClient apiClient;

  ExpensesRepository({required this.apiClient});

  /// Fetch all expenses
  Future<List<Map<String, dynamic>>> getExpenses({
    int? page,
    int? limit,
    String? category,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/expenses',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (category != null) 'category': category,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single expense
  Future<Map<String, dynamic>> getExpense(String expenseId) async {
    final response = await apiClient.get('/expenses/$expenseId');
    return response.data['data'] ?? {};
  }

  /// Create new expense
  Future<Map<String, dynamic>> createExpense(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/expenses',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update expense
  Future<Map<String, dynamic>> updateExpense(
    String expenseId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/expenses/$expenseId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Approve expense
  Future<void> approveExpense(String expenseId) async {
    await apiClient.post(
      '/expenses/$expenseId/approve',
      data: {},
    );
  }

  /// Reject expense
  Future<void> rejectExpense(String expenseId, String reason) async {
    await apiClient.post(
      '/expenses/$expenseId/reject',
      data: {'reason': reason},
    );
  }

  /// Delete expense
  Future<void> deleteExpense(String expenseId) async {
    await apiClient.delete('/expenses/$expenseId');
  }

  /// Get expense report
  Future<Map<String, dynamic>> getExpenseReport({
    String? period,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/expenses/report',
      queryParameters: {
        if (period != null) 'period': period,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync expenses
  Future<List<Map<String, dynamic>>> syncExpenses() async {
    final response = await apiClient.get('/expenses/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
