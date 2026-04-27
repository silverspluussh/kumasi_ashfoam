import 'package:ashfoam_sadiq/src/data/local/app_database.dart'
    hide ProductCategory;
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brandListProvider = FutureProvider<List<Brand>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.getBrands();
});

final categoryListProvider = FutureProvider<List<ProductCategory>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.getCategories();
});

final addBrandProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (ProductBrandsCompanion brand) async {
    await dbService.addBrand(brand);
    ref.invalidate(brandListProvider);
  };
});

final addCategoryProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (ProductCategoriesCompanion category) async {
    await dbService.addCategory(category);
    ref.invalidate(categoryListProvider);
  };
});
