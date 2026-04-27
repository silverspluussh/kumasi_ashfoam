import 'package:ashfoam_sadiq/src/data/local/drift_extensions.dart';
import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to fetch all sale orders from local database
final saleOrdersProvider = FutureProvider<List<SaleOrderModel>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  final localOrders = await dbService.getSalesOrders();
  // Map local drift objects to domain models using the toMap extension
  return localOrders.map((m) => SaleOrderModel.fromMap(m.toMap())).toList();
});

/// Provider for sales search filter
final salesSearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered sale orders
final filteredSaleOrdersProvider = Provider<AsyncValue<List<SaleOrderModel>>>((
  ref,
) {
  final ordersAsync = ref.watch(saleOrdersProvider);
  final query = ref.watch(salesSearchQueryProvider).toLowerCase();

  return ordersAsync.whenData((orders) {
    if (query.isEmpty) return orders;
    return orders.where((order) {
      final orderNo = order.orderNumber.toLowerCase();
      final customer = (order.customerName ?? '').toLowerCase();
      final branch = (order.branchName ?? '').toLowerCase();
      return orderNo.contains(query) ||
          customer.contains(query) ||
          branch.contains(query);
    }).toList();
  });
});

/// Provider to fetch items for a specific sale order
final saleOrderItemsProvider =
    FutureProvider.family<List<SaleOrderItem>, String>((ref, orderId) async {
      final dbService = ref.watch(databaseServiceProvider);
      final localItems = await dbService.getSaleOrderItems(orderId);
      return localItems.map((m) => SaleOrderItem.fromMap(m.toMap())).toList();
    });
