import 'package:supabase_flutter/supabase_flutter.dart';

class StockReportsRepository {
  final SupabaseClient supabase;

  StockReportsRepository({required this.supabase});

  /// Fetch all stock reports from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? branchId,
  }) async {
    var query = supabase.from('ashfoam_stock_reports').select();

    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }

    final response = await query.order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert stock reports to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> reports,
  ) async {
    if (reports.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_stock_reports')
        .upsert(reports)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Note: Stock reports usually don't have separate line items in this scope, 
  /// but added fetchItems and bulkUploadItems for consistency with the sync pattern.

  /// Fetch stock report items (if applicable) from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String reportId) async {
    final response = await supabase
        .from('ashfoam_stock_report_items')
        .select()
        .eq('report_id', reportId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert stock report items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_stock_report_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
