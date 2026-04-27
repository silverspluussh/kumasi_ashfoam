import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeesRepository {
  final SupabaseClient supabase;

  EmployeesRepository({required this.supabase});

  /// Fetch all employees from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? branchId,
    String? search,
  }) async {
    var query = supabase.from('ashfoam_employees').select();

    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }
    if (search != null && search.isNotEmpty) {
      query = query.or(
        'first_name.ilike.%$search%,last_name.ilike.%$search%,email.ilike.%$search%',
      );
    }

    final response = await query.order('last_name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert employees to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> employees,
  ) async {
    if (employees.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_employees')
        .upsert(employees)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
