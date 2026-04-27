import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart' as model;
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart'
    hide allTaxesProvider;
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:uuid/uuid.dart';

class CreateProformaDialog extends ConsumerStatefulWidget {
  const CreateProformaDialog({super.key});

  @override
  ConsumerState<CreateProformaDialog> createState() =>
      _CreateProformaDialogState();
}

class _CreateProformaDialogState extends ConsumerState<CreateProformaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _partyNameController = TextEditingController();
  final _partyAddressController = TextEditingController();
  final _declarationController = TextEditingController(
    text:
        "We declare that this proforma invoice shows the actual price of the goods described and that all particulars are true and correct.",
  );

  final List<ProductDetails> _selectedItems = [];
  final List<TaxComponent> _selectedTaxes = [];

  void _addItem(ProductDetails item) {
    setState(() {
      _selectedItems.add(item);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _selectedItems.removeAt(index);
    });
  }

  void _updateItem(int index, {int? quantity, double? discount}) {
    setState(() {
      final item = _selectedItems[index];
      final newQty = quantity ?? item.quantity;
      final newDisc = discount ?? item.discountPercentage;

      final subtotal = item.unitprice * newQty;
      final total = subtotal * (1 - newDisc / 100);

      _selectedItems[index] = item.copyWith(
        quantity: newQty,
        discountPercentage: newDisc,
        totalAmount: total,
      );
    });
  }

  void _addTax(model.TaxModel tax) {
    if (_selectedTaxes.any((t) => t.tax.id == tax.id)) return;
    setState(() {
      _selectedTaxes.add(TaxComponent(tax: tax, taxAmount: 0));
    });
    _calculateTotals();
  }

  double get _subtotal =>
      _selectedItems.fold(0, (sum, item) => sum + item.totalAmount);

  double get _totalTax {
    double total = 0;
    for (var component in _selectedTaxes) {
      total += _subtotal * (component.tax.valuePercentage / 100);
    }
    return total;
  }

  double get _grandTotal => _subtotal + _totalTax;

  void _calculateTotals() {
    setState(() {});
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedItems.isEmpty) {
      // Show error if items empty
      return;
    }

    final proforma = Profoma(
      id: const Uuid().v4(),
      partyName: _partyNameController.text,
      partyAddress: _partyAddressController.text,
      tax: _selectedTaxes
          .map(
            (t) => t.copyWith(
              taxAmount: _subtotal * (t.tax.valuePercentage / 100),
            ),
          )
          .toList(),
      totalQuantity: _selectedItems.fold(0, (sum, item) => sum + item.quantity),
      totalAmount: _grandTotal,
      declaration: _declarationController.text,
      isDeleted: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref.read(addProformaProvider)(proforma, _selectedItems);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final taxesAsync = ref.watch(allTaxesProvider);

    return FDialog(
      title: const Text("Create Profoma Invoice"),
      direction: Axis.horizontal,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),

      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FButton(onPress: _submit, child: const Text("Create Profoma")),
      ],
      body: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Material(
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Client Info & Declaration
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Client Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        FTextFormField(
                          label: const Text("Party Name"),
                          hint: "Enter client name",
                          validator: (v) =>
                              (v?.isEmpty ?? true) ? "Required" : null,
                          control: FTextFieldControl.managed(
                            controller: _partyNameController,
                          ),
                        ),
                        FTextFormField(
                          label: const Text("Party Address"),
                          hint: "Enter client address",
                          control: FTextFieldControl.managed(
                            controller: _partyAddressController,
                          ),
                          maxLines: 2,
                        ),
                        const Divider(),
                        const Text(
                          "Declaration",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        FTextFormField(
                          label: const Text("Declaration Text"),
                          control: FTextFieldControl.managed(
                            controller: _declarationController,
                          ),
                          maxLines: 3,
                        ),
                        const Divider(),
                        _buildTaxSection(taxesAsync),
                      ],
                    ),
                  ),
                ),

                const VerticalDivider(width: 48),

                // Right Column: Items & Summary
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Products & Services",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          _buildAddProductButton(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(child: _buildItemsList()),
                      const Divider(height: 32),
                      _buildSummarySection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddProductButton() {
    return FButton(
      variant: FButtonVariant.outline,
      prefix: const Icon(Icons.add_shopping_cart, size: 16),
      onPress: () => showDialog(
        context: context,
        builder: (context) => ProductItemFormDialog(onAdd: _addItem),
      ),
      child: const Text("Add Product"),
    );
  }

  Widget _buildItemsList() {
    if (_selectedItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              "No products added yet",
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _selectedItems.length,
      itemBuilder: (context, index) {
        final item = _selectedItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FCard(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rate: GH₵ ${item.unitprice}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FTextField(
                      hint: "Qty",
                      keyboardType: TextInputType.number,
                      control: FTextFieldControl.managed(
                        controller: TextEditingController(
                          text: item.quantity.toString(),
                        ),
                        onChange: (v) =>
                            _updateItem(index, quantity: int.tryParse(v.text)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "GH₵ ${item.totalAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () => _removeItem(index),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTaxSection(AsyncValue<List<model.TaxModel>> taxesAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Taxes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            taxesAsync.when(
              data: (taxes) => PopupMenuButton<model.TaxModel>(
                onSelected: _addTax,
                child: const Text(
                  "+ Add Tax",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                itemBuilder: (context) => taxes
                    .map(
                      (t) => PopupMenuItem(
                        value: t,
                        child: Text("${t.name} (${t.valuePercentage}%)"),
                      ),
                    )
                    .toList(),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _selectedTaxes
              .map(
                (t) => Chip(
                  label: Text(
                    "${t.tax.name} (${t.tax.valuePercentage}%)",
                    style: const TextStyle(fontSize: 11),
                  ),
                  onDeleted: () {
                    setState(() => _selectedTaxes.remove(t));
                    _calculateTotals();
                  },
                  deleteIconColor: Colors.red,
                  backgroundColor: Colors.blue[50],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Column(
      children: [
        _summaryRow("Subtotal", _subtotal),
        ..._selectedTaxes.map(
          (t) => _summaryRow(
            t.tax.name,
            _subtotal * (t.tax.valuePercentage / 100),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Grand Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "GH₵ ${_grandTotal.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _summaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text("GH₵ ${amount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}

class ProductItemFormDialog extends ConsumerStatefulWidget {
  final Function(ProductDetails) onAdd;

  const ProductItemFormDialog({super.key, required this.onAdd});

  @override
  ConsumerState<ProductItemFormDialog> createState() =>
      _ProductItemFormDialogState();
}

class _ProductItemFormDialogState extends ConsumerState<ProductItemFormDialog> {
  final _qtyController = TextEditingController(text: "1");
  final _priceController = TextEditingController(text: "0");
  final _discountController = TextEditingController(text: "0");

  InventoryModel? _selectedProduct;
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    final qty = double.tryParse(_qtyController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    final disc = double.tryParse(_discountController.text) ?? 0;

    setState(() {
      _total = (qty * price) * (1 - disc / 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(inventoryListProvider);

    return FDialog(
      title: const Text("Add Product Details"),
      actions: [
        FButton(
          
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FButton(
          onPress: () {
            if (_selectedProduct == null) return;
            final qty = int.tryParse(_qtyController.text) ?? 1;
            final price = double.tryParse(_priceController.text) ?? 0.0;
            final disc = double.tryParse(_discountController.text) ?? 0.0;

            widget.onAdd(
              ProductDetails(
                productId: _selectedProduct!.id,
                productName: _selectedProduct!.name,
                quantity: qty,
                unitprice: price,
                discountPercentage: disc,
                totalAmount: _total,
              ),
            );
            Navigator.pop(context);
          },
          child: const Text("Add to List"),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              // Standardized FSelect searchBuilder Usage
              inventoryAsync.when(
                data: (items) => FSelect<InventoryModel>.searchBuilder(
                  hint: 'Choose from inventory',
                  label: Text(
                    "Select Product",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  format: (s) => s.name,
                  filter: (query) => query.isEmpty
                      ? items
                      : items
                            .where(
                              (f) => f.name.toLowerCase().contains(
                                query.toLowerCase(),
                              ),
                            )
                            .toList(),
                  contentBuilder: (context, _, filteredItems) => [
                    for (final item in filteredItems)
                      FSelectItem.item(title: Text(item.name), value: item),
                  ],
                  control: FSelectControl.lifted(
                    value: _selectedProduct,
                    onChange: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedProduct = value;
                          _priceController.text =
                              value.retailPrice?.toString() ?? "0";
                        });
                        _calculateTotal();
                      }
                    },
                  ),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (err, _) => Text("Error: $err"),
              ),

              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: FTextField(
                      label: const Text("Quantity"),
                      control: FTextFieldControl.managed(
                        controller: _qtyController,
                        onChange: (v) => _calculateTotal(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: FTextField(
                      label: const Text("Unit Price (GH₵)"),
                      control: FTextFieldControl.managed(
                        controller: _priceController,
                        onChange: (v) => _calculateTotal(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              FTextField(
                label: const Text("Discount (%)"),
                control: FTextFieldControl.managed(
                  controller: _discountController,
                  onChange: (v) => _calculateTotal(),
                ),
                keyboardType: TextInputType.number,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Calculated Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "GH₵ ${_total.toStringAsFixed(2)}",
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }
}
