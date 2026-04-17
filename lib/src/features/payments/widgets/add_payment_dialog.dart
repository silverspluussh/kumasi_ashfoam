import 'package:ashfoam_sadiq/src/data/models/payments.model.dart';
import 'package:ashfoam_sadiq/src/features/payments/providers/payment_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:uuid/uuid.dart';

class AddPaymentDialog extends ConsumerStatefulWidget {
  const AddPaymentDialog({super.key});

  @override
  ConsumerState<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends ConsumerState<AddPaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final FDateFieldController _dateController = FDateFieldController(
    date: DateTime.now(),
  );

  String? _selectedBranchId;
  String? _selectedBranchName;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _selectedBranchId == null) {
      if (_selectedBranchId == null) {
        // Show an error message or similar if branch is not selected
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select a branch")));
      }
      return;
    }

    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    final payment = BranchPayment(
      id: const Uuid().v4(),
      title: _titleController.text,
      amount: amount,
      branchId: _selectedBranchId!,
      branchName: _selectedBranchName!,
      note: _notesController.text,
      createdAt: _dateController.value ?? DateTime.now(),
      createdBy: 'Admin', // In a real app, get from auth state
    );

    await ref.read(addPaymentProvider)(payment);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final branchesAsync = ref.watch(branchesListProvider);

    return FDialog(
      direction: Axis.horizontal,
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FButton(onPress: _submit, child: const Text("Save Payment")),
      ],
      title: const Text("Add New Payment"),
      body: Material(
        color: Colors.transparent,
        child: Container(
          width: 500,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // Date Picker
                FDateField.calendar(
                  label: const Text("Payment Date"),
                  control: FDateFieldControl.managed(
                    controller: _dateController,
                  ),
                ),

                const SizedBox(height: 16),

                // Branch Selector using FSelect
                FTextFormField(
                  label: const Text("Branch"),
                  hint: "e.g., Kumasi Main Branch",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a branch";
                    }
                    return null;
                  },
                  control: FTextFieldControl.managed(
                    onChange: (v) {
                      _selectedBranchId = v.text;
                      _selectedBranchName = v.text;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Title Field
                FTextFormField(
                  label: const Text("Payment Title"),
                  hint: "e.g., Weekly Rent, Utility Bill",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  control: FTextFieldControl.managed(
                    controller: _titleController,
                  ),
                ),

                const SizedBox(height: 16),

                // Amount Field
                FTextFormField(
                  label: const Text("Amount (GH₵)"),
                  hint: "0.00",
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an amount";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  },
                  control: FTextFieldControl.managed(
                    controller: _amountController,
                  ),
                ),

                const SizedBox(height: 16),

                // Notes Field
                FTextField(
                  label: const Text("Notes"),
                  hint: "Optional details...",
                  maxLines: 3,
                  control: FTextFieldControl.managed(
                    controller: _notesController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
