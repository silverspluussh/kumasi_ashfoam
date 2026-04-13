import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class EmployeesRepository {
  final ApiClient apiClient;

  EmployeesRepository({required this.apiClient});

  /// Fetch all employees
  Future<List<Map<String, dynamic>>> getEmployees({
    int? page,
    int? limit,
    String? search,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/employees',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single employee
  Future<Map<String, dynamic>> getEmployee(String employeeId) async {
    final response = await apiClient.get('/employees/$employeeId');
    return response.data['data'] ?? {};
  }

  /// Create new employee
  Future<Map<String, dynamic>> createEmployee(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/employees',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update employee
  Future<Map<String, dynamic>> updateEmployee(
    String employeeId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/employees/$employeeId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete employee
  Future<void> deleteEmployee(String employeeId) async {
    await apiClient.delete('/employees/$employeeId');
  }

  /// Get employee performance
  Future<Map<String, dynamic>> getEmployeePerformance(
    String employeeId,
  ) async {
    final response = await apiClient.get(
      '/employees/$employeeId/performance',
    );
    return response.data['data'] ?? {};
  }

  /// Get employee sales
  Future<Map<String, dynamic>> getEmployeeSales(
    String employeeId, {
    String? period,
  }) async {
    final response = await apiClient.get(
      '/employees/$employeeId/sales',
      queryParameters: {
        if (period != null) 'period': period,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Search employees
  Future<List<Map<String, dynamic>>> searchEmployees(String query) async {
    final response = await apiClient.get(
      '/employees/search',
      queryParameters: {'q': query},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Sync employees
  Future<List<Map<String, dynamic>>> syncEmployees() async {
    final response = await apiClient.get('/employees/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
