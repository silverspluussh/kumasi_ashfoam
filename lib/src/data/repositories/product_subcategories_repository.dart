import 'package:supabase_flutter/supabase_flutter.dart';

class ProductSubCategoriesRepository {
  final SupabaseClient supabase;

  ProductSubCategoriesRepository({required this.supabase});

  /// Fetch all product sub-categories from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? categoryId,
    String? search,
  }) async {
    var query = supabase.from('ashfoam_product_subcategories').select();

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }
    if (search != null && search.isNotEmpty) {
      query = query.ilike('name', '%$search%');
    }

    final response = await query.order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert product sub-categories to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> subcategories,
  ) async {
    if (subcategories.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_product_subcategories')
        .upsert(subcategories)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
