import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/create_proforma_dialog.dart'; // Reuse ProductItemFormDialog
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CreateWaybillDialog extends ConsumerStatefulWidget {
  const CreateWaybillDialog({super.key});

  @override
  ConsumerState<CreateWaybillDialog> createState() => _CreateWaybillDialogState();
}

class _CreateWaybillDialogState extends ConsumerState<CreateWaybillDialog> {
  final _formKey = GlobalKey<FormState>();
  final _orderNoController = TextEditingController();
  final _dispatchDocController = TextEditingController();
  final _deliveryNoteController = TextEditingController();
  final _senderNameController = TextEditingController(text: "Kumasi Ashfoam");
  final _destinationController = TextEditingController();
  final _partyNameController = TextEditingController();
  
  DateTime _dispatchDate = DateTime.now();
  final List<ProductDetails> _selectedItems = [];
  
  Profoma? _sourceProforma;

  void _importFromProforma(Profoma proforma) async {
    setState(() {
      _sourceProforma = proforma;
      _partyNameController.text = proforma.partyName ?? "";
      _destinationController.text = proforma.partyAddress ?? "";
      _orderNoController.text = proforma.id.substring(0, 8).toUpperCase();
    });

    // Fetch items for this proforma
    final items = await ref.read(proformaItemsProvider(proforma.id).future);
    setState(() {
      _selectedItems.clear();
      _selectedItems.addAll(items);
    });
  }

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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedItems.isEmpty) {
      return;
    }

    final waybill = WayBill(
      id: const Uuid().v4(),
      mainContent: _sourceProforma ?? Profoma(
        id: "MANUAL-${const Uuid().v4().substring(0, 8)}",
        tax: [],
        totalQuantity: _selectedItems.fold(0, (sum, item) => sum + item.quantity),
        totalAmount: _selectedItems.fold(0, (sum, item) => sum + item.totalAmount),
        isDeleted: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        partyName: _partyNameController.text,
        partyAddress: _destinationController.text,
      ),
      orderNumber: _orderNoController.text.isEmpty
          ? "ORD-${DateFormat('yyyyMMdd').format(DateTime.now())}-${const Uuid().v4().substring(0, 4).toUpperCase()}"
          : _orderNoController.text,
      dispatchDocNumber: "WB-${DateFormat('yyyyMMdd').format(DateTime.now())}-${const Uuid().v4().substring(0, 4).toUpperCase()}",
      deliveryNote: _deliveryNoteController.text,
      senderName: _senderNameController.text,
      destination: _destinationController.text,
      dispatchDate: _dispatchDate,
      partyName: _partyNameController.text,
      createdBy: "Administrator", // Replace with actual user if available
      isDeleted: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await ref.read(addWaybillProvider)(waybill, _selectedItems);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final proformasAsync = ref.watch(proformaListProvider);

    return FDialog(
      title: const Text("Create Dispatch Waybill"),
      direction: Axis.horizontal,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      actions: [
        FButton(
          variant: FButtonVariant.outline,
          onPress: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FButton(onPress: _submit, child: const Text("Generate Waybill")),
      ],
      body: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.all(24),
        child: Material(
          child: Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Waybill Details
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProformaPicker(proformasAsync),
                        const Divider(),
                        const Text(
                          "Dispatch Header",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        FTextFormField(
                          label: const Text("Driver Name"),
                          hint: "Enter driver's name",
                          validator: (v) => (v?.isEmpty ?? true) ? "Required" : null,
                          control: FTextFieldControl.managed(controller: _senderNameController),
                        ),
                        FTextFormField(
                          label: const Text("Destination Address"),
                          hint: "Warehouse / Client Location",
                          validator: (v) => (v?.isEmpty ?? true) ? "Required" : null,
                          control: FTextFieldControl.managed(controller: _destinationController),
                        ),
                        FTextFormField(
                          label: const Text("Receiver / Party Name"),
                          hint: "Individual or Company Name",
                          validator: (v) => (v?.isEmpty ?? true) ? "Required" : null,
                          control: FTextFieldControl.managed(controller: _partyNameController),
                        ),
                        _buildDatePicker(),
                        FTextFormField(
                          label: const Text("Delivery Note"),
                          hint: "Special instructions for delivery...",
                          control: FTextFieldControl.managed(controller: _deliveryNoteController),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),

                const VerticalDivider(width: 48),

                // Right Column: Items
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dispatched Products",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          _buildAddProductButton(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(child: _buildItemsList()),
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

  Widget _buildProformaPicker(AsyncValue<List<Profoma>> proformasAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Import Source (Optional)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        proformasAsync.when(
          data: (items) => FSelect<Profoma>.searchBuilder(
            hint: 'Select an existing Proforma',
            format: (s) => "${s.partyName ?? 'Unnamed Client'} (${s.id.substring(0, 8).toUpperCase()})",
            filter: (query) => query.isEmpty 
              ? items 
              : items.where((f) => (f.partyName ?? 'Unnamed Client').toLowerCase().contains(query.toLowerCase())).toList(),
            contentBuilder: (context, _, filteredItems) => [
              for (final item in filteredItems)
                FSelectItem.item(
                  title: Text("${item.partyName ?? 'Unnamed Client'} - GH₵ ${item.totalAmount.toStringAsFixed(2)}"),
                  value: item,
                ),
            ],
            control: FSelectControl.lifted(
              value: _sourceProforma,
              onChange: (value) {
                if (value != null) _importFromProforma(value);
              },
            ),
          ),
          loading: () => const LinearProgressIndicator(),
          error: (err, _) => Text("Error: $err"),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Dispatch Date", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _dispatchDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) setState(() => _dispatchDate = picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateFormat.format(_dispatchDate)),
                const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddProductButton() {
    return FButton(
      variant: FButtonVariant.outline,
      prefix: const Icon(Icons.add, size: 16),
      onPress: () => showDialog(
        context: context,
        builder: (context) => ProductItemFormDialog(onAdd: _addItem),
      ),
      child: const Text("Add Manual Item"),
    );
  }

  Widget _buildItemsList() {
    if (_selectedItems.isEmpty) {
      return Center(
        child: Text("No items added yet", style: TextStyle(color: Colors.grey[500])),
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
                    child: Text(item.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Text("Qty: ${item.quantity}"),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
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
}
