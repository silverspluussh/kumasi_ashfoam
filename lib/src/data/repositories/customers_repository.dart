import 'package:supabase_flutter/supabase_flutter.dart';

class CustomersRepository {
  final SupabaseClient supabase;

  CustomersRepository({required this.supabase});

  /// Fetch all customers from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? search,
  }) async {
    var query = supabase.from('ashfoam_customers').select();

    if (search != null && search.isNotEmpty) {
      query = query.or(
        'name.ilike.%$search%,email.ilike.%$search%,phone.ilike.%$search%',
      );
    }

    final response = await query.order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert customers to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> customers,
  ) async {
    if (customers.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_customers')
        .upsert(customers)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
