import 'package:supabase_flutter/supabase_flutter.dart';

class CreditNotesRepository {
  final SupabaseClient supabase;

  CreditNotesRepository({required this.supabase});

  /// Fetch all credit notes from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
    String? customerId,
  }) async {
    var query = supabase.from('ashfoam_credit_notes').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (customerId != null) {
      query = query.eq('customer_id', customerId);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert credit notes to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> creditNotes,
  ) async {
    if (creditNotes.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_credit_notes')
        .upsert(creditNotes)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch credit note items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String noteId) async {
    final response = await supabase
        .from('ashfoam_credit_note_items')
        .select()
        .eq('credit_note_id', noteId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert credit note items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_credit_note_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
