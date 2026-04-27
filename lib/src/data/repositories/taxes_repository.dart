import 'package:supabase_flutter/supabase_flutter.dart';

class TaxesRepository {
  final SupabaseClient supabase;

  TaxesRepository({required this.supabase});

  /// Fetch all taxes from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch() async {
    final response = await supabase
        .from('ashfoam_taxes')
        .select()
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert taxes to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> taxes,
  ) async {
    if (taxes.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_taxes')
        .upsert(taxes)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Get active taxes (standardized naming for specific use cases)
  Future<List<Map<String, dynamic>>> getActiveTaxes() async {
    return fetch();
  }

  /// Sync taxes (Legacy method kept for sync providers compatibility)
  Future<List<Map<String, dynamic>>> syncTaxes() async {
    return fetch();
  }
}
