import 'package:supabase_flutter/supabase_flutter.dart';

class BranchPaymentsRepository {
  final SupabaseClient supabase;

  BranchPaymentsRepository({required this.supabase});

  /// Fetch all branch payments from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? branchId,
    String? status,
  }) async {
    var query = supabase.from('ashfoam_branch_payments').select();

    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }
    if (status != null) {
      query = query.eq('status', status);
    }

    final response = await query.order('date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert branch payments to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> payments,
  ) async {
    if (payments.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_branch_payments')
        .upsert(payments)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Note: Added fetchItems and bulkUploadItems for pattern consistency.

  /// Fetch branch payment items (if applicable) from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String paymentId) async {
    final response = await supabase
        .from('ashfoam_branch_payment_items')
        .select()
        .eq('payment_id', paymentId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert branch payment items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_branch_payment_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
