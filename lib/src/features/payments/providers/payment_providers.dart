import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/models/payments.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to fetch all branch payments from local database
final paymentsListProvider = FutureProvider<List<BranchPaymentModel>>((
  ref,
) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.getBranchPayments();
});

/// Provider for payment search filter
final paymentSearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered payments
final filteredPaymentsProvider = Provider<AsyncValue<List<BranchPaymentModel>>>(
  (ref) {
    final query = ref.watch(paymentSearchQueryProvider).toLowerCase();
    final paymentsAsync = ref.watch(paymentsListProvider);

    return paymentsAsync.whenData((payments) {
      if (query.isEmpty) return payments;
      return payments.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.branchName.toLowerCase().contains(query);
      }).toList();
    });
  },
);

/// Provider to handle adding a new payment
final addPaymentProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);

  return (BranchPaymentModel payment) async {
    final companion = db.BranchPaymentsCompanion(
      id: Value(payment.id),
      title: Value(payment.title),
      branchId: Value(payment.branchId),
      branchName: Value(payment.branchName),
      amount: Value(payment.amount),
      note: Value(payment.note),
      createdAt: Value(payment.createdAt),
      createdBy: Value(payment.createdBy),
    );

    await dbService.addBranchPayment(companion);
    ref.invalidate(paymentsListProvider);
  };
});
