import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taxesListProvider = FutureProvider<List<Taxe>>((ref) async {
  final dbService = ref.read(databaseServiceProvider);
  return await dbService.getTaxes();
});

final taxManagementProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);

  return TaxManagement(dbService, ref);
});

class TaxManagement {
  final DatabaseService db;
  final Ref ref;

  TaxManagement(this.db, this.ref);

  Future<void> addTax(TaxesCompanion tax) async {
    await db.addTax(tax);
    ref.invalidate(taxesListProvider);
  }

  Future<void> updateTax(String id, TaxesCompanion tax) async {
    await db.updateTax(id, tax);
    ref.invalidate(taxesListProvider);
  }

  Future<void> deleteTax(String id) async {
    await db.deleteTax(id);
    ref.invalidate(taxesListProvider);
  }
}
