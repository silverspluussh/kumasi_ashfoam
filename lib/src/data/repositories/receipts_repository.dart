import 'package:supabase_flutter/supabase_flutter.dart';

class ReceiptsRepository {
  final SupabaseClient supabase;

  ReceiptsRepository({required this.supabase});

  /// Fetch all receipts from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
    String? branchId,
  }) async {
    var query = supabase.from('ashfoam_receipts').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert receipts to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> receipts,
  ) async {
    if (receipts.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_receipts')
        .upsert(receipts)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch receipt items (if applicable) from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String receiptId) async {
    final response = await supabase
        .from('ashfoam_receipt_items')
        .select()
        .eq('receipt_id', receiptId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert receipt items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_receipt_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
