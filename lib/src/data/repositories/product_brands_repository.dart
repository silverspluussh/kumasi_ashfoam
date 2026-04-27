import 'package:supabase_flutter/supabase_flutter.dart';

class ProductBrandsRepository {
  final SupabaseClient supabase;

  ProductBrandsRepository({required this.supabase});

  /// Fetch all product brands directly from Supabase
  Future<List<Map<String, dynamic>>> getBrands({
    int? page,
    int? limit,
    String? search,
  }) async {
    var query = supabase.from('ashfoam_product_brands').select();

    if (search != null && search.isNotEmpty) {
      query = query.ilike('name', '%$search%');
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get single brand directly from Supabase
  Future<Map<String, dynamic>> getBrand(String brandId) async {
    final response = await supabase
        .from('ashfoam_product_brands')
        .select()
        .eq('id', brandId)
        .maybeSingle();
    return response ?? {};
  }

  /// Create new brand directly in Supabase
  Future<Map<String, dynamic>> createBrand(Map<String, dynamic> data) async {
    final response = await supabase
        .from('ashfoam_product_brands')
        .insert(data)
        .select()
        .single();
    return response;
  }

  /// Update brand directly in Supabase
  Future<Map<String, dynamic>> updateBrand(
    String brandId,
    Map<String, dynamic> data,
  ) async {
    final response = await supabase
        .from('ashfoam_product_brands')
        .update(data)
        .eq('id', brandId)
        .select()
        .single();
    return response;
  }

  /// Delete brand directly in Supabase
  Future<void> deleteBrand(String brandId) async {
    await supabase.from('ashfoam_product_brands').delete().eq('id', brandId);
  }

  /// Get brand products (Remote only)
  Future<List<Map<String, dynamic>>> getBrandProducts(String brandId) async {
    final response = await supabase
        .from('ashfoam_inventory')
        .select()
        .eq('brand_id', brandId);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Sync brands (No-op for direct repository)
  Future<List<Map<String, dynamic>>> syncBrands() async {
    return getBrands();
  }
}
