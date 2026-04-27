import 'package:supabase_flutter/supabase_flutter.dart';

class ProformasRepository {
  final SupabaseClient supabase;

  ProformasRepository({required this.supabase});

  /// Fetch all proformas from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
    String? customerId,
  }) async {
    var query = supabase.from('ashfoam_proformas').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (customerId != null) {
      query = query.eq('customer_id', customerId);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert proformas to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> proformas,
  ) async {
    if (proformas.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_proformas')
        .upsert(proformas)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch proforma details/items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String proformaId) async {
    final response = await supabase
        .from('ashfoam_proforma_items')
        .select()
        .eq('proforma_id', proformaId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert proforma items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_proforma_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
