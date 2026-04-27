import 'package:supabase_flutter/supabase_flutter.dart';

class ProductCategoriesRepository {
  final SupabaseClient supabase;

  ProductCategoriesRepository({required this.supabase});

  /// Fetch all product categories directly from Supabase
  Future<List<Map<String, dynamic>>> getCategories({
    int? page,
    int? limit,
    String? search,
  }) async {
    var query = supabase.from('ashfoam_product_categories').select();

    if (search != null && search.isNotEmpty) {
      query = query.ilike('name', '%$search%');
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get single category directly from Supabase
  Future<Map<String, dynamic>> getCategory(String categoryId) async {
    final response = await supabase
        .from('ashfoam_product_categories')
        .select()
        .eq('id', categoryId)
        .maybeSingle();
    return response ?? {};
  }

  /// Create new category directly in Supabase
  Future<Map<String, dynamic>> createCategory(Map<String, dynamic> data) async {
    final response = await supabase
        .from('ashfoam_product_categories')
        .insert(data)
        .select()
        .single();
    return response;
  }

  /// Update category directly in Supabase
  Future<Map<String, dynamic>> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    final response = await supabase
        .from('ashfoam_product_categories')
        .update(data)
        .eq('id', categoryId)
        .select()
        .single();
    return response;
  }

  /// Delete category directly in Supabase
  Future<void> deleteCategory(String categoryId) async {
    await supabase
        .from('ashfoam_product_categories')
        .delete()
        .eq('id', categoryId);
  }

  /// Get category products (Remote only)
  Future<List<Map<String, dynamic>>> getCategoryProducts(
    String categoryId,
  ) async {
    final response = await supabase
        .from('ashfoam_inventory')
        .select()
        .eq('category_id', categoryId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get category subcategories (Remote only)
  Future<List<Map<String, dynamic>>> getCategorySubCategories(
    String categoryId,
  ) async {
    final response = await supabase
        .from('ashfoam_product_subcategories')
        .select()
        .eq('category_id', categoryId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Sync categories (No-op for direct repository)
  Future<List<Map<String, dynamic>>> syncCategories() async {
    return getCategories();
  }
}
