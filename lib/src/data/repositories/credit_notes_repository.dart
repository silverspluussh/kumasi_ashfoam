import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class CreditNotesRepository {
  final ApiClient apiClient;

  CreditNotesRepository({required this.apiClient});

  /// Fetch all credit notes
  Future<List<Map<String, dynamic>>> getCreditNotes({
    int? page,
    int? limit,
    String? status,
    String? customerId,
  }) async {
    final response = await apiClient.get(
      '/credits/notes',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (customerId != null) 'customerId': customerId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single credit note
  Future<Map<String, dynamic>> getCreditNote(String noteId) async {
    final response = await apiClient.get('/credits/notes/$noteId');
    return response.data['data'] ?? {};
  }

  /// Create new credit note
  Future<Map<String, dynamic>> createCreditNote(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/credits/notes',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update credit note
  Future<Map<String, dynamic>> updateCreditNote(
    String noteId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/credits/notes/$noteId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Approve credit note
  Future<Map<String, dynamic>> approveCreditNote(String noteId) async {
    final response = await apiClient.post(
      '/credits/notes/$noteId/approve',
      data: {},
    );
    return response.data['data'] ?? {};
  }

  /// Get credit note items
  Future<List<Map<String, dynamic>>> getCreditNoteItems(
    String noteId,
  ) async {
    final response = await apiClient.get('/credits/notes/$noteId/items');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Add item to credit note
  Future<Map<String, dynamic>> addCreditNoteItem(
    String noteId,
    Map<String, dynamic> itemData,
  ) async {
    final response = await apiClient.post(
      '/credits/notes/$noteId/items',
      data: itemData,
    );
    return response.data['data'] ?? {};
  }

  /// Remove item from credit note
  Future<void> removeCreditNoteItem(String noteId, String itemId) async {
    await apiClient.delete('/credits/notes/$noteId/items/$itemId');
  }

  /// Sync credit notes
  Future<List<Map<String, dynamic>>> syncCreditNotes() async {
    final response = await apiClient.get('/credits/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
