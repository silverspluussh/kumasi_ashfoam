import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WaybillDetailsDialog extends ConsumerWidget {
  final WayBillModel waybill;

  const WaybillDetailsDialog({super.key, required this.waybill});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(waybillItemsProvider(waybill.id));

    return Dialog(
      child: Container(
        width: 800,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const Divider(height: 32),
            _buildInfoGrid(context),
            const SizedBox(height: 24),
            const Text(
              "Dispatched Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: itemsAsync.when(
                data: (items) => _buildItemsTable(items),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
            ),
            const SizedBox(height: 16),
            _buildTaxSummary(context),
            if (waybill.deliveryNote.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                "Delivery Notes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(waybill.deliveryNote),
            ],
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Waybill Details",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text("Doc #: ${waybill.dispatchDocNumber}"),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue),
          ),
          child: const Text(
            "DISPATCHED",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 3,
      children: [
        _infoItem("Order Number", waybill.orderNumber),
        _infoItem("Dispatch Date", dateFormat.format(waybill.dispatchDate)),
        _infoItem("Driver", waybill.senderName),
        _infoItem("Client / Party", waybill.partyName),
        _infoItem("Destination", waybill.destination),
        _infoItem("Created By", waybill.createdBy),
      ],
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildItemsTable(List<dynamic> items) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey[100]!),
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[50]),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Product Name",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Quantity",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          ...items.map((item) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(item.productName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(item.quantity.toString(),
                        textAlign: TextAlign.right),
                  ),
                ],
              )),
        ],
      ),
    );
  }
  Widget _buildTaxSummary(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: 'GH¢');
    final proforma = waybill.mainContent;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _summaryRow("Subtotal", currencyFormat.format(proforma.totalAmount)),
          ...proforma.tax.map((t) => _summaryRow(
                t.tax.name,
                currencyFormat.format(t.taxAmount),
              )),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "GRAND TOTAL",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                currencyFormat.format(proforma.totalAmount),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
