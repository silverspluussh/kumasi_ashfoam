import 'package:supabase_flutter/supabase_flutter.dart';

class SuppliersRepository {
  final SupabaseClient supabase;

  SuppliersRepository({required this.supabase});

  /// Fetch all suppliers from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? search,
  }) async {
    var query = supabase.from('ashfoam_suppliers').select();

    if (search != null && search.isNotEmpty) {
      query = query.or('name.ilike.%$search%,supplier_code.ilike.%$search%,contact_name.ilike.%$search%');
    }

    final response = await query.order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert suppliers to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> suppliers,
  ) async {
    if (suppliers.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_suppliers')
        .upsert(suppliers)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
