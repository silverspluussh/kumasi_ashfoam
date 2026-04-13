import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class SalesRepository {
  final ApiClient apiClient;

  SalesRepository({required this.apiClient});

  /// Fetch all sale orders
  Future<List<Map<String, dynamic>>> getSaleOrders({
    int? page,
    int? limit,
    String? status,
    String? customerId,
  }) async {
    final response = await apiClient.get(
      '/sales/orders',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (customerId != null) 'customerId': customerId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single sale order
  Future<Map<String, dynamic>> getSaleOrder(String orderId) async {
    final response = await apiClient.get('/sales/orders/$orderId');
    return response.data['data'] ?? {};
  }

  /// Create new sale order
  Future<Map<String, dynamic>> createSaleOrder(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/sales/orders',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update sale order
  Future<Map<String, dynamic>> updateSaleOrder(
    String orderId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/sales/orders/$orderId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Confirm/finalize sale order
  Future<Map<String, dynamic>> confirmSaleOrder(String orderId) async {
    final response = await apiClient.post(
      '/sales/orders/$orderId/confirm',
      data: {},
    );
    return response.data['data'] ?? {};
  }

  /// Cancel sale order
  Future<void> cancelSaleOrder(String orderId) async {
    await apiClient.post(
      '/sales/orders/$orderId/cancel',
      data: {},
    );
  }

  /// Delete sale order
  Future<void> deleteSaleOrder(String orderId) async {
    await apiClient.delete('/sales/orders/$orderId');
  }

  /// Fetch sale order items
  Future<List<Map<String, dynamic>>> getSaleOrderItems(
    String orderId,
  ) async {
    final response = await apiClient.get('/sales/orders/$orderId/items');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Add item to sale order
  Future<Map<String, dynamic>> addSaleOrderItem(
    String orderId,
    Map<String, dynamic> itemData,
  ) async {
    final response = await apiClient.post(
      '/sales/orders/$orderId/items',
      data: itemData,
    );
    return response.data['data'] ?? {};
  }

  /// Update sale order item
  Future<Map<String, dynamic>> updateSaleOrderItem(
    String orderId,
    String itemId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/sales/orders/$orderId/items/$itemId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Remove item from sale order
  Future<void> removeSaleOrderItem(String orderId, String itemId) async {
    await apiClient.delete('/sales/orders/$orderId/items/$itemId');
  }

  /// Get sales summary/reports
  Future<Map<String, dynamic>> getSalesSummary({
    String? period,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/sales/summary',
      queryParameters: {
        if (period != null) 'period': period,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync sales orders from remote
  Future<List<Map<String, dynamic>>> syncSalesOrders() async {
    final response = await apiClient.get('/sales/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Push unsynced sales orders to remote (local to remote sync)
  Future<List<Map<String, dynamic>>> pushUnsyncedSalesOrders(
    List<Map<String, dynamic>> orders,
  ) async {
    final response = await apiClient.post(
      '/sales/orders/bulk-sync',
      data: {'orders': orders},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Push unsynced sale order items to remote (local to remote sync)
  Future<List<Map<String, dynamic>>> pushUnsyncedSalesOrderItems(
    List<Map<String, dynamic>> items,
  ) async {
    final response = await apiClient.post(
      '/sales/orders/items/bulk-sync',
      data: {'items': items},
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
