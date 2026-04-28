import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart'
    hide saleOrderItemsProvider;
import 'package:ashfoam_sadiq/src/features/pos/providers/receipt_service.dart';
import 'package:ashfoam_sadiq/src/features/sales/providers/sales_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class OrderDetailsDialog extends ConsumerWidget {
  final SaleOrderModel order;

  const OrderDetailsDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(saleOrderItemsProvider(order.id));
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    final currencyFormat = NumberFormat.currency(symbol: 'GH¢ ');

    return FDialog(
      direction: Axis.horizontal,
      title: Text('Order Details - ${order.orderNumber}'),
      body: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metadata Section
            _buildDetailRow('Customer', order.customerName ?? 'Walk-in'),
            _buildDetailRow(
              'Date Created',
              dateFormat.format(order.createdAt ?? DateTime.now()),
            ),
            _buildDetailRow('Order Number', order.orderNumber.toString()),
            _buildDetailRow('Total Quantity', order.totalQuantity.toString()),
            const SizedBox(height: 10),
            Divider(),

            const Text(
              'Order Items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Items Table
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: itemsAsync.when(
                data: (items) => SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Qty',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Rate',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      ...items.map(
                        (item) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(item.productName),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item.quantity.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                currencyFormat.format(item.unitPrice),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                currencyFormat.format(item.totalPrice),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Error loading items: $err'),
              ),
            ),

            const Divider(height: 32),

            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total Amount: ${currencyFormat.format(order.totalAmount)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        FButton(
          onPress: () async {
            final items = await ref.read(
              saleOrderItemsProvider(order.id).future,
            );
            final company = await ref.read(companySettingsProvider.future);
            if (context.mounted) {
              ReceiptService.showPreview(
                context,
                order,
                items,
                company: company,
              );
            }
          },
          prefix: const Icon(Icons.print),
          child: const Text("Print Receipt"),
        ),
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.black, fontSize: 12)),
          if (isStatus)
            _buildStatusChip(value)
          else
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color =
        status.toLowerCase() == 'paid' || status.toLowerCase() == 'completed'
        ? Colors.green
        : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
