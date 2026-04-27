import 'package:supabase_flutter/supabase_flutter.dart';

class StoresRepository {
  final SupabaseClient supabase;

  StoresRepository({required this.supabase});

  /// Fetch all stores from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? branchId,
  }) async {
    var query = supabase.from('ashfoam_stores').select();

    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }

    final response = await query.order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert stores to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> stores,
  ) async {
    if (stores.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_stores')
        .upsert(stores)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
