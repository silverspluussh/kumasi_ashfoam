import 'package:supabase_flutter/supabase_flutter.dart';

class ExpensesRepository {
  final SupabaseClient supabase;

  ExpensesRepository({required this.supabase});

  /// Fetch all expenses from Supabase (Fetch)
  Future<List<Map<String, dynamic>>> fetch({
    String? category,
    String? branchId,
  }) async {
    var query = supabase.from('ashfoam_expenses').select();

    if (category != null) {
      query = query.eq('category', category);
    }
    if (branchId != null) {
      query = query.eq('branch_id', branchId);
    }

    final response = await query.order('date', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert expenses to Supabase (Bulk Upload)
  Future<List<Map<String, dynamic>>> bulkUpload(
    List<Map<String, dynamic>> expenses,
  ) async {
    if (expenses.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_expenses')
        .upsert(expenses)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Note: Expenses usually don't have separate line items in this scope, 
  /// but added fetchItems and bulkUploadItems for consistency with the sync pattern.

  /// Fetch expense items (if applicable) from Supabase (Fetch Items)
  Future<List<Map<String, dynamic>>> fetchItems(String expenseId) async {
    final response = await supabase
        .from('ashfoam_expense_items')
        .select()
        .eq('expense_id', expenseId);
        
    return List<Map<String, dynamic>>.from(response);
  }

  /// Bulk upload/upsert expense items to Supabase (Bulk Upload Items)
  Future<List<Map<String, dynamic>>> bulkUploadItems(
    List<Map<String, dynamic>> items,
  ) async {
    if (items.isEmpty) return [];
    
    final response = await supabase
        .from('ashfoam_expense_items')
        .upsert(items)
        .select();
        
    return List<Map<String, dynamic>>.from(response);
  }
}
