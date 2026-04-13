import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class BranchesRepository {
  final ApiClient apiClient;

  BranchesRepository({required this.apiClient});

  /// Fetch all branches
  Future<List<Map<String, dynamic>>> getBranches({
    int? page,
    int? limit,
  }) async {
    final response = await apiClient.get(
      '/branches',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single branch
  Future<Map<String, dynamic>> getBranch(String branchId) async {
    final response = await apiClient.get('/branches/$branchId');
    return response.data['data'] ?? {};
  }

  /// Create new branch
  Future<Map<String, dynamic>> createBranch(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/branches',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update branch
  Future<Map<String, dynamic>> updateBranch(
    String branchId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/branches/$branchId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete branch
  Future<void> deleteBranch(String branchId) async {
    await apiClient.delete('/branches/$branchId');
  }

  /// Get branch stores
  Future<List<Map<String, dynamic>>> getBranchStores(String branchId) async {
    final response = await apiClient.get('/branches/$branchId/stores');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get branch summary
  Future<Map<String, dynamic>> getBranchSummary(String branchId) async {
    final response = await apiClient.get('/branches/$branchId/summary');
    return response.data['data'] ?? {};
  }

  /// Sync branches
  Future<List<Map<String, dynamic>>> syncBranches() async {
    final response = await apiClient.get('/branches/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
