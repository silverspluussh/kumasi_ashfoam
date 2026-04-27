import 'package:supabase_flutter/supabase_flutter.dart';

class ReturnOrdersRepository {
  final SupabaseClient supabase;

  ReturnOrdersRepository({required this.supabase});

  /// Fetch all return orders from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? status,
  }) async {
    var query = supabase.from('ashfoam_return_orders').select();

    if (status != null) {
      query = query.eq('status', status);
    }

    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert return orders to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> orders,
  ) async {
    if (orders.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_return_orders')
        .upsert(orders)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Fetch return order items from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String orderId) async {
    final response = await supabase
        .from('ashfoam_return_order_items')
        .select()
        .eq('return_order_id', orderId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert return order items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_return_order_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
