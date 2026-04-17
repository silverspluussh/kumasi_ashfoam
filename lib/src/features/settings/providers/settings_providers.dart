import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ashfoam_sadiq/src/data/local/app_database.dart';

final branchSettingsProvider = FutureProvider<Branche?>((ref) async {
  final dbService = ref.read(databaseServiceProvider);
  // Get all branches and take the first one
  final branches = await dbService.getBranches();
  return branches.isNotEmpty ? branches.first : null;
});

final updateBranchSettingsProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);
  return (String id, BranchesCompanion companion) async {
    await dbService.updateBranch(id, companion);
    // Invalidate to refresh
    ref.invalidate(branchSettingsProvider);
  };
});
