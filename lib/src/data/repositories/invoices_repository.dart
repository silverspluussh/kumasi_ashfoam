import 'package:ashfoam_sadiq/src/data/remote/api_client.dart';

class InvoicesRepository {
  final ApiClient apiClient;

  InvoicesRepository({required this.apiClient});

  /// Fetch all invoices
  Future<List<Map<String, dynamic>>> getInvoices({
    int? page,
    int? limit,
    String? status,
    String? customerId,
  }) async {
    final response = await apiClient.get(
      '/invoices',
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (status != null) 'status': status,
        if (customerId != null) 'customerId': customerId,
      },
    );
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }

  /// Get single invoice
  Future<Map<String, dynamic>> getInvoice(String invoiceId) async {
    final response = await apiClient.get('/invoices/$invoiceId');
    return response.data['data'] ?? {};
  }

  /// Create invoice from sale order
  Future<Map<String, dynamic>> createInvoice(
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.post(
      '/invoices',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Update invoice
  Future<Map<String, dynamic>> updateInvoice(
    String invoiceId,
    Map<String, dynamic> data,
  ) async {
    final response = await apiClient.put(
      '/invoices/$invoiceId',
      data: data,
    );
    return response.data['data'] ?? {};
  }

  /// Mark invoice as sent
  Future<void> markInvoiceAsSent(String invoiceId) async {
    await apiClient.post(
      '/invoices/$invoiceId/mark-sent',
      data: {},
    );
  }

  /// Mark invoice as paid
  Future<void> markInvoiceAsPaid(String invoiceId) async {
    await apiClient.post(
      '/invoices/$invoiceId/mark-paid',
      data: {},
    );
  }

  /// Generate invoice PDF
  Future<String> generateInvoicePDF(String invoiceId) async {
    final response = await apiClient.get('/invoices/$invoiceId/pdf');
    return response.data['data']['pdfUrl'] ?? '';
  }

  /// Send invoice by email
  Future<void> sendInvoiceByEmail(
    String invoiceId,
    String email,
  ) async {
    await apiClient.post(
      '/invoices/$invoiceId/send-email',
      data: {'email': email},
    );
  }

  /// Get invoice summary/report
  Future<Map<String, dynamic>> getInvoiceSummary({
    String? period,
    String? branchId,
  }) async {
    final response = await apiClient.get(
      '/invoices/summary',
      queryParameters: {
        if (period != null) 'period': period,
        if (branchId != null) 'branchId': branchId,
      },
    );
    return response.data['data'] ?? {};
  }

  /// Sync invoices
  Future<List<Map<String, dynamic>>> syncInvoices() async {
    final response = await apiClient.get('/invoices/sync');
    return List<Map<String, dynamic>>.from(response.data['data'] ?? []);
  }
}
