import 'package:ashfoam_sadiq/src/data/models/invoice.model.dart';
import 'package:ashfoam_sadiq/src/features/invoices/providers/invoice_providers.dart';
import 'package:ashfoam_sadiq/src/features/invoices/services/invoice_print_service.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class InvoiceDetailsDialog extends ConsumerWidget {
  final InvoiceModel invoice;

  const InvoiceDetailsDialog({super.key, required this.invoice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(invoiceItemsProvider(invoice.saleOrderId));

    final currencyFormat = NumberFormat.currency(symbol: 'GH₵ ');
    final dateFormat = DateFormat('MMM dd, yyyy');

    return FDialog(
      title: Text(
        "Invoice Details: ${invoice.id.substring(0, 8).toUpperCase()}",
      ),
      direction: Axis.horizontal,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      actions: [
        FButton(
          onPress: () async {
            final items = await ref.read(invoiceItemsProvider(invoice.saleOrderId).future);
            final company = await ref.read(companySettingsProvider.future);
            if (context.mounted) {
              await InvoicePrintService.showPreview(
                context: context,
                invoice: invoice,
                items: items,
                company: company,
              );
            }
          },
          prefix: const Icon(Icons.print),
          child: const Text("Print Invoice"),
        ),
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection(context, dateFormat),
          const Divider(height: 32),
          const Text(
            "Itemized Breakdown",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: itemsAsync.when(
              data: (items) => _buildItemsList(items, currencyFormat),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text("Error loading items: $e")),
            ),
          ),
          const Divider(height: 32),
          _buildSummarySection(currencyFormat),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, DateFormat dateFormat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoLabel("Customer Name"),
              Text(
                invoice.customerName ?? "Walk-in Client",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _infoLabel("Branch"),
              Text(invoice.branchName ?? "Main Branch"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoLabel("Due Date"),
              Text(
                dateFormat.format(invoice.dueDate),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _infoLabel("Status"),
              _statusBadge(invoice.status),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _statusBadge(InvoiceStatus status) {
    Color color;
    switch (status) {
      case InvoiceStatus.paid:
        color = Colors.green;
        break;
      case InvoiceStatus.pending:
        color = Colors.orange;
        break;
      case InvoiceStatus.cancelled:
        color = Colors.red;
        break;
      default:
        color = Colors.blue;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildItemsList(List<dynamic> items, NumberFormat currencyFormat) {
    if (items.isEmpty) {
      return const Center(child: Text("No items found for this invoice."));
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Qty: ${item.quantity} x ${currencyFormat.format(item.unitPrice)}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  currencyFormat.format(item.totalPrice),
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummarySection(NumberFormat currencyFormat) {
    return Column(
      children: [
        _summaryRow("Paid Amount", currencyFormat.format(invoice.paidAmount)),
        const SizedBox(height: 4),
        _summaryRow(
          "Balance Due",
          currencyFormat.format(invoice.balanceDue),
          isBold: true,
          color: invoice.balanceDue > 0 ? Colors.red : Colors.green,
        ),
        const Divider(height: 16),
        _summaryRow(
          "Total Amount",
          currencyFormat.format(invoice.totalAmount),
          isBold: true,
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 14,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: fontSize)),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}
