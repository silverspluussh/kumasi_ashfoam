import 'package:ashfoam_sadiq/src/data/local/app_database.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  const AddProductDialog({super.key});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController(text: '0');
  final _unitController = TextEditingController(text: 'Pieces');

  // Optional specs
  final _materialController = TextEditingController();
  final _thicknessController = TextEditingController();
  final _densityController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _materialController.dispose();
    _thicknessController.dispose();
    _densityController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  String _generateSKU(String name) {
    if (name.isEmpty) return '';

    // Clean name: take first 3 letters of each word or just first 3 of string
    final words = name.trim().toUpperCase().split(RegExp(r'\s+'));
    String prefix = '';
    if (words.length >= 2) {
      prefix = words.map((w) => w[0]).take(3).join();
    } else {
      prefix = words[0].substring(
        0,
        words[0].length >= 3 ? 3 : words[0].length,
      );
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(7);
    final date = DateTime.now().toString().split(' ')[0].replaceAll('-', '');

    return '$prefix-$date-$timestamp';
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final addItem = ref.read(addInventoryItemProvider);

        final companion = InventoryItemsCompanion(
          name: Value(_nameController.text),
          sku: Value(_generateSKU(_nameController.text)),
          category: Value(
            _categoryController.text.isEmpty ? null : _categoryController.text,
          ),
          retailPrice: Value(double.tryParse(_priceController.text) ?? 0.0),
          quantity: Value(int.tryParse(_quantityController.text) ?? 0),
          unit: Value(
            _unitController.text.isEmpty ? 'Pieces' : _unitController.text,
          ),
          material: Value(
            _materialController.text.isEmpty ? null : _materialController.text,
          ),
          thickness: Value(
            _thicknessController.text.isEmpty
                ? null
                : _thicknessController.text,
          ),
          density: Value(
            _densityController.text.isEmpty ? null : _densityController.text,
          ),
          size: Value(
            _sizeController.text.isEmpty ? null : _sizeController.text,
          ),
          isAvailable: const Value(1),
        );

        await addItem(companion);
        if (mounted) {
          Navigator.of(context).pop();
          // Optional: Show success toast/notification if available in forui
        }
      } catch (e) {
        // Handle error e.g. show alert
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FDialog(
      direction: Axis.vertical,
      title: const Text('Add New Product'),
      body: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                _buildField(
                  label: 'Product Name*',
                  controller: _nameController,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _buildField(
                        label: 'Category',
                        controller: _categoryController,
                      ),
                    ),
                    Expanded(
                      child: _buildField(
                        label: 'Unit (e.g. Pieces, Sets)',
                        controller: _unitController,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _buildField(
                        label: 'Retail Price (GH₵)*',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    Expanded(
                      child: _buildField(
                        label: 'Initial Quantity*',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const Text(
                  'Technical Specifications (Optional)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _buildField(
                        label: 'Material',
                        controller: _materialController,
                      ),
                    ),
                    Expanded(
                      child: _buildField(
                        label: 'Size',
                        controller: _sizeController,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _buildField(
                        label: 'Thickness',
                        controller: _thicknessController,
                      ),
                    ),
                    Expanded(
                      child: _buildField(
                        label: 'Density',
                        controller: _densityController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FButton(onPress: _submit, child: const Text('Save Product')),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final fieldStyle = const FTextFieldStyleDelta.delta(
      contentPadding: EdgeInsetsGeometryDelta.value(
        EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
      ),
      labelPadding: EdgeInsetsGeometryDelta.add(
        EdgeInsetsGeometry.only(bottom: 5),
      ),
      border: FVariants.all(
        OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
      ),
    );
    return FTextField(
      label: Text(label),
      keyboardType: keyboardType,
      style: fieldStyle,
      control: FTextFieldControl.managed(
        controller: controller,
        onChange: (v) {
          // Trigger validation if needed
        },
      ),
    );
  }
}
