import 'package:supabase_flutter/supabase_flutter.dart';

class WayBillsRepository {
  final SupabaseClient supabase;

  WayBillsRepository({required this.supabase});

  /// Fetch all waybills from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
  }) async {
    var query = supabase.from('ashfoam_waybills').select();

    if (status != null) {
      query = query.eq('status', status);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert waybills to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> waybills,
  ) async {
    if (waybills.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_waybills')
        .upsert(waybills)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch waybill details/items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String wayBillId) async {
    final response = await supabase
        .from('ashfoam_waybill_items')
        .select()
        .eq('waybill_id', wayBillId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert waybill items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_waybill_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
