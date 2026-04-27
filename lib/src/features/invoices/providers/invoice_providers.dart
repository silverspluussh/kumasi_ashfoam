import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to fetch all invoices from local database
final invoiceListProvider = FutureProvider<List<InvoiceModel>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getInvoices();
});

/// Provider for searches
final invoiceSearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered invoices
final filteredInvoicesProvider = Provider<AsyncValue<List<InvoiceModel>>>((
  ref,
) {
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
final invoiceItemsProvider = FutureProvider.family<List<dynamic>, String>((
  ref,
  saleOrderId,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getSaleOrderItems(saleOrderId);
});
