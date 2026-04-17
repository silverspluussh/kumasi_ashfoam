import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/features/settings/providers/tax_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:drift/drift.dart' as drift;

class TaxSettingsCard extends ConsumerWidget {
  const TaxSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taxesAsync = ref.watch(taxesListProvider);

    return FCard(
      title: const Text("Tax Management"),
      subtitle: const Text("Configure tax rates used for invoices and receipts."),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          taxesAsync.when(
            data: (taxes) {
              if (taxes.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 48, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        const Text("No taxes configured",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: taxes
                    .map((tax) => _TaxListItem(tax: tax, ref: ref))
                    .toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text("Error: $err"),
          ),
          const SizedBox(height: 24),
          FButton(
            onPress: () => _showTaxDialog(context, ref),
            prefix: const Icon(Icons.add, size: 16),
            child: const Text("Add New Tax"),
          ),
        ],
      ),
    );
  }

  void _showTaxDialog(BuildContext context, WidgetRef ref, [Taxe? tax]) {
    final nameController = TextEditingController(text: tax?.name);
    final percentController =
        TextEditingController(text: tax?.valuePercentage.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tax == null ? "Add Tax" : "Edit Tax"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FTextField(
              control: FTextFieldControl.managed(controller: nameController),
              label: const Text("Tax Name"),
              hint: "e.g. VAT, NHIL",
            ),
            const SizedBox(height: 16),
            FTextField(
              control: FTextFieldControl.managed(controller: percentController),
              label: const Text("Percentage (%)"),
              hint: "e.g. 15.0",
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          FButton(
            variant: FButtonVariant.ghost,
            onPress: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FButton(
            onPress: () async {
              final name = nameController.text;
              final percent = double.tryParse(percentController.text) ?? 0.0;
              if (name.isNotEmpty) {
                final companion = TaxesCompanion(
                  name: drift.Value(name),
                  valuePercentage: drift.Value(percent),
                );
                if (tax == null) {
                  await ref.read(taxManagementProvider).addTax(companion);
                } else {
                  await ref
                      .read(taxManagementProvider)
                      .updateTax(tax.id, companion);
                }
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(tax == null ? "Add" : "Save"),
          ),
        ],
      ),
    );
  }
}

class _TaxListItem extends StatelessWidget {
  final Taxe tax;
  final WidgetRef ref;

  const _TaxListItem({required this.tax, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tax.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${tax.valuePercentage}%",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () =>
                    const TaxSettingsCard()._showTaxDialog(context, ref, tax),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                onPressed: () => _showDeleteConfirm(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Tax?"),
        content: Text("Are you sure you want to delete '${tax.name}'?"),
        actions: [
          FButton(
            variant: FButtonVariant.ghost,
            onPress: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FButton(
            onPress: () async {
              await ref.read(taxManagementProvider).deleteTax(tax.id);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
