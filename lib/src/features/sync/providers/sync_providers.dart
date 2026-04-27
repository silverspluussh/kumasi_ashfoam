import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final bulkSyncProvider =
    StateNotifierProvider<BulkSyncNotifier, AsyncValue<String?>>((ref) {
      return BulkSyncNotifier();
    });

class BulkSyncNotifier extends StateNotifier<AsyncValue<String?>> {
  BulkSyncNotifier() : super(const AsyncValue.data(null));

  Future<void> uploadAllUnsynced() async {
    state = const AsyncValue.loading();
    try {
      final db = DatabaseService.instance;
      final supabase = Supabase.instance.client;

      int totalSynced = 0;

      // 1. Sale Orders
      final sales = await db.getUnsyncedSaleOrders();
      if (sales.isNotEmpty) {
        final maps = sales.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_sale_orders').upsert(maps);
        for (var sale in sales) {
          await db.markSaleOrderAsSynced(sale.id);
        }
        totalSynced += sales.length;
      }

      // 1b. Sale Order Items
      final saleItems = await db.getUnsyncedSaleOrderItems();
      if (saleItems.isNotEmpty) {
        final maps = saleItems.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_sale_order_items').upsert(maps);
        for (var item in saleItems) {
          await db.markSaleOrderItemAsSynced(item.id);
        }
        // Items are synced, we just count the parent objects to not overinflate user counts.
      }

      // 2. Invoices
      final invoices = await db.getUnsyncedInvoices();
      if (invoices.isNotEmpty) {
        final maps = invoices.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_invoices').upsert(maps);
        for (var inv in invoices) {
          await db.markInvoiceAsSynced(inv.id.toString());
        }
        totalSynced += invoices.length;
      }

      // 3. Payments (Branch Payments)
      final payments = await db.getUnsyncedPayments();
      if (payments.isNotEmpty) {
        final maps = payments.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_branch_payments').upsert(maps);
        for (var p in payments) {
          await db.markPaymentAsSynced(p.id);
        }
        totalSynced += payments.length;
      }

      // 4. Returns
      final returns = await db.getUnsyncedReturnOrders();
      if (returns.isNotEmpty) {
        final maps = returns.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_return_orders').upsert(maps);
        for (var r in returns) {
          await db.markReturnOrderAsSynced(r.id.toString());
        }
        totalSynced += returns.length;
      }

      // 4b. Return Items
      final returnItems = await db.getUnsyncedReturnOrderItems();
      if (returnItems.isNotEmpty) {
        final maps = returnItems.map((e) => e.toMap()).toList();
        await supabase.from('ashfoam_return_order_items').upsert(maps);
        for (var r in returnItems) {
          await db.markReturnOrderItemAsSynced(r.id.toString());
        }
      }

      state = AsyncValue.data('Successfully synced $totalSynced records.');
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  // Add helper for counts calculation
  Future<Map<String, int>> getPendingCounts() async {
    final db = DatabaseService.instance;
    return {
      'Sales': (await db.getUnsyncedSaleOrders()).length,
      'Invoices': (await db.getUnsyncedInvoices()).length,
      'Payments': (await db.getUnsyncedPayments()).length,
      'Returns': (await db.getUnsyncedReturnOrders()).length,
    };
  }
}
