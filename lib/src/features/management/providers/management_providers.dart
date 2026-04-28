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

final updateBrandProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (String id, ProductBrandsCompanion brand) async {
    await dbService.updateBrand(id, brand);
    ref.invalidate(brandListProvider);
  };
});

final deleteBrandProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (String id) async {
    await dbService.deleteBrand(id);
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

final updateCategoryProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (String id, ProductCategoriesCompanion category) async {
    await dbService.updateCategory(id, category);
    ref.invalidate(categoryListProvider);
  };
});

final deleteCategoryProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return (String id) async {
    await dbService.deleteCategory(id);
    ref.invalidate(categoryListProvider);
  };
});
