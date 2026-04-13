import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class ReturnOrdersRepository {
  final ApiClient apiClient;

  ReturnOrdersRepository({required this.apiClient});

  /// Fetch all return orders
  Future<List<Map<String, dynamic>>> getReturnOrders({
    int? page,
    int? limit,
    String? status,
  }) async {
    final response = await apiClient.get(
      '/returns/orders',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single return order
  Future<Map<String, dynamic>> getReturnOrder(String orderId) async {
    final response = await apiClient.get('/returns/orders/$orderId');
    return response.data['data'] ?? {};
  }

  /// Create new return order
  Future<Map<String, dynamic>> createReturnOrder(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/returns/orders',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update return order
  Future<Map<String, dynamic>> updateReturnOrder(
    String orderId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/returns/orders/$orderId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Approve return order
  Future<Map<String, dynamic>> approveReturnOrder(String orderId) async {
    final response = await apiClient.post(
      '/returns/orders/$orderId/approve',
      data: {},
    );
    return response.data['data'] ?? {};
  }

  /// Reject return order
  Future<void> rejectReturnOrder(String orderId, String reason) async {
    await apiClient.post(
      '/returns/orders/$orderId/reject',
      data: {'reason': reason},
    );
  }

  /// Get return order items
  Future<List<Map<String, dynamic>>> getReturnOrderItems(
    String orderId,
  ) async {
    final response = await apiClient.get('/returns/orders/$orderId/items');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Add item to return order
  Future<Map<String, dynamic>> addReturnOrderItem(
    String orderId,
    Map<String, dynamic> itemData,
  ) async {
    final response = await apiClient.post(
      '/returns/orders/$orderId/items',
      data: itemData,
    );
    return response.data['data'] ?? {};
  }

  /// Remove item from return order
  Future<void> removeReturnOrderItem(String orderId, String itemId) async {
    await apiClient.delete('/returns/orders/$orderId/items/$itemId');
  }

  /// Sync return orders
  Future<List<Map<String, dynamic>>> syncReturnOrders() async {
    final response = await apiClient.get('/returns/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Push unsynced return orders to remote (local to remote sync)
  Future<List<Map<String, dynamic>>> pushUnsyncedReturnOrders(
    List<Map<String, dynamic>> orders,
  ) async {
    final response = await apiClient.post(
      '/returns/orders/bulk-sync',
      data: {'orders': orders},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Push unsynced return order items to remote (local to remote sync)
  Future<List<Map<String, dynamic>>> pushUnsyncedReturnOrderItems(
    List<Map<String, dynamic>> items,
  ) async {
    final response = await apiClient.post(
      '/returns/orders/items/bulk-sync',
      data: {'items': items},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
