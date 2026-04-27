import 'package:ashfoam_sadiq/src/data/models/sales.model.dart';
import 'package:ashfoam_sadiq/src/features/pos/providers/receipt_service.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

class OrderSuccessDialog extends ConsumerWidget {
  final SaleOrderModel order;
  final List<SaleOrderItem> items;

  const OrderSuccessDialog({
    super.key,
    required this.order,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FDialog(
      constraints: BoxConstraints(maxWidth: 400, maxHeight: 300),
      direction: Axis.horizontal,
      title: const Text('Order Completed Successfully'),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            Text(
              'Order #${order.orderNumber} has been recorded.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Total Amount: GH¢ ${order.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        FButton(
          onPress: () async {
            final company = await ref.read(companySettingsProvider.future);
            await ReceiptService.printReceipt(order, items, company: company);
          },
          prefix: const Icon(Icons.print),
          child: const Text('Print Receipt'),
        ),
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
