import 'package:supabase_flutter/supabase_flutter.dart';

class SalesRepository {
  final SupabaseClient supabase;

  SalesRepository({required this.supabase});

  /// Fetch all sale orders from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
    String? customerId,
  }) async {
    var query = supabase.from('ashfoam_sales').select();

    if (status != null) {
      query = query.eq('status', status);
    }
    if (customerId != null) {
      query = query.eq('customer_id', customerId);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert sale orders to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> orders,
  ) async {
    if (orders.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_sales')
        .upsert(orders)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch sale order items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String orderId) async {
    final response = await supabase
        .from('ashfoam_sale_order_items')
        .select()
        .eq('order_id', orderId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert sale order items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_sale_order_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
