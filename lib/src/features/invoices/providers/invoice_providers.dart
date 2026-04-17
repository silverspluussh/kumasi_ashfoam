import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/sync_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to fetch all invoices from local database
final invoiceListProvider = FutureProvider<List<Invoice>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  final items = await dbService.getInvoices();
  // Map local drift objects to domain models manually since we don't have toMap for Invoices yet
  return items.map((p) => Invoice.fromMap({
    'id': p.id,
    'due_date': p.dueDate,
    'customer_name': p.customerName,
    'total_amount': p.totalAmount,
    'paid_amount': p.paidAmount,
    'status': p.status,
    'note': p.note,
    'sale_order_id': p.saleOrderId,
    'branch_name': p.branchName,
    'branch_id': p.branchId,
  })).toList();
});

/// Provider for searches
final invoiceSearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered invoices
final filteredInvoicesProvider = Provider<AsyncValue<List<Invoice>>>((ref) {
  final query = ref.watch(invoiceSearchQueryProvider).toLowerCase();
  final invoicesAsync = ref.watch(invoiceListProvider);

  return invoicesAsync.whenData((invoices) {
    if (query.isEmpty) return invoices;
    return invoices.where((i) {
      return (i.customerName ?? '').toLowerCase().contains(query) || 
             i.id.toLowerCase().contains(query);
    }).toList();
  });
});

/// Provider for updating invoice status
final updateInvoiceStatusProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);

  return (String invoiceId, InvoiceStatus status) async {
    final success = await dbService.updateInvoiceStatus(invoiceId, status.name);
    if (success) {
      ref.invalidate(invoiceListProvider);
    }
    return success;
  };
});

/// Provider to fetch items for a specific invoice via its sale order ID
final invoiceItemsProvider = FutureProvider.family<List<dynamic>, String>((ref, saleOrderId) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSaleOrderItems(saleOrderId);
});
