import 'package:supabase_flutter/supabase_flutter.dart';

class InvoicesRepository {
  final SupabaseClient supabase;

  InvoicesRepository({required this.supabase});

  /// Fetch all invoices from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
    String? customerId,
  }) async {
    var query = supabase.from('ashfoam_invoices').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (customerId != null) {
      query = query.eq('customer_id', customerId);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert invoices to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> invoices,
  ) async {
    if (invoices.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_invoices')
        .upsert(invoices)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Note: Invoices in this schema usually share items with the Sale Order 
  /// or have a dedicated ashfoam_invoice_items table. 
  /// Added fetchItems and bulkUploadItems for consistency.

  /// Fetch invoice items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String invoiceId) async {
    final response = await supabase
        .from('ashfoam_invoice_items')
        .select()
        .eq('invoice_id', invoiceId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert invoice items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_invoice_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
