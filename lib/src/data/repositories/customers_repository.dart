import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class CustomersRepository {
  final ApiClient apiClient;

  CustomersRepository({required this.apiClient});

  /// Fetch all customers
  Future<List<Map<String, dynamic>>> getCustomers({
    int? page,
    int? limit,
    String? search,
  }) async {
    final response = await apiClient.get(
      '/customers',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (search != null) 'search': search,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single customer
  Future<Map<String, dynamic>> getCustomer(String customerId) async {
    final response = await apiClient.get('/customers/$customerId');
    return response.data['data'] ?? {};
  }

  /// Create new customer
  Future<Map<String, dynamic>> createCustomer(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/customers',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update customer
  Future<Map<String, dynamic>> updateCustomer(
    String customerId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/customers/$customerId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Delete customer
  Future<void> deleteCustomer(String customerId) async {
    await apiClient.delete('/customers/$customerId');
  }

  /// Search customers
  Future<List<Map<String, dynamic>>> searchCustomers(String query) async {
    final response = await apiClient.get(
      '/customers/search',
      queryParameters: {'q': query},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get customer orders
  Future<List<Map<String, dynamic>>> getCustomerOrders(
    String customerId,
  ) async {
    final response = await apiClient.get('/customers/$customerId/orders');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get customer credit balance
  Future<Map<String, dynamic>> getCustomerCreditBalance(
    String customerId,
  ) async {
    final response = await apiClient.get(
      '/customers/$customerId/credit-balance',
    );
    return response.data['data'] ?? {};
  }

  /// Get customer profile
  Future<Map<String, dynamic>> getCustomerProfile(String customerId) async {
    final response = await apiClient.get('/customers/$customerId/profile');
    return response.data['data'] ?? {};
  }

  /// Sync customers
  Future<List<Map<String, dynamic>>> syncCustomers() async {
    final response = await apiClient.get('/customers/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
