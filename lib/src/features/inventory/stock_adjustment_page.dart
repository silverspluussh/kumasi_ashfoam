import 'package:ashfoam_sadiq/src/data/models/stock_adjustment.model.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart'
    as proforma_model;
import 'package:ashfoam_sadiq/src/features/inventory/providers/inventory_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/stock_adjustment_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class StockAdjustmentPage extends ConsumerStatefulWidget {
  const StockAdjustmentPage({super.key});

  @override
  ConsumerState<StockAdjustmentPage> createState() =>
      _StockAdjustmentPageState();
}

class _StockAdjustmentPageState extends ConsumerState<StockAdjustmentPage> {
  final _manualQtyController = TextEditingController();
  final _reasonController = TextEditingController();
  final _searchController = TextEditingController();

  String? _selectedProductId;
  String? _selectedWaybillId;
  String _adjustmentType = 'Manual'; // 'Manual' or 'Waybill'

  List<proforma_model.ProductDetails> _waybillItems = [];
  bool _isLoadingItems = false;

  @override
  void dispose() {
    _manualQtyController.dispose();
    _reasonController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Consumer(
            builder: (context, ref, child) {
              final logsAsync = ref.watch(stockAdjustmentLogsProvider);
              return _buildHistoryView(logsAsync);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _fetchWaybillItems(String waybillId) async {
    setState(() => _isLoadingItems = true);
    try {
      final items = await ref.read(waybillItemsProvider(waybillId).future);
      setState(() {
        _waybillItems = items;
        _isLoadingItems = false;
      });
    } catch (e) {
      setState(() => _isLoadingItems = false);
      if (mounted) {
        Toastification().show(
          title: const Text('Error'),
          description: Text('Failed to load waybill items: $e'),
          type: ToastificationType.error,
        );
      }
    }
  }

  Future<void> _submitManualAdjustment() async {
    if (_selectedProductId == null || _manualQtyController.text.isEmpty) return;

    final qty = int.tryParse(_manualQtyController.text);
    if (qty == null) return;

    try {
      await ref.read(adjustStockProvider)(
        productId: _selectedProductId!,
        quantityChange: qty,
        type: 'Manual',
        reason: _reasonController.text.isEmpty ? null : _reasonController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Stock adjusted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _manualQtyController.clear();
        _reasonController.clear();
        setState(() => _selectedProductId = null);
      }
    } catch (e) {
      if (mounted) {
        Toastification().show(
          title: const Text('Error'),
          description: Text('Failed to adjust stock: $e'),
          type: ToastificationType.error,
        );
      }
    }
  }

  Future<void> _receiveWaybillStock() async {
    if (_selectedWaybillId == null || _waybillItems.isEmpty) return;

    try {
      final adjustStock = ref.read(adjustStockProvider);

      for (final item in _waybillItems) {
        await adjustStock(
          productId: item.productId,
          quantityChange: item.quantity,
          type: 'Waybill',
          referenceId: _selectedWaybillId,
          reason: 'Received from Waybill: $_selectedWaybillId',
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Waybill stock received successfully'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _selectedWaybillId = null;
          _waybillItems = [];
        });
      }
    } catch (e) {
      if (mounted) {
        Toastification().show(
          title: const Text('Error'),
          description: Text('Failed to receive stock: $e'),
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryAsync = ref.watch(inventoryListProvider);
    final waybillsAsync = ref.watch(waybillListProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),

            Expanded(
              child: _buildAdjustmentView(inventoryAsync, waybillsAsync),
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
              "Inventory Control",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Precision stock adjustments and inbound receiving",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
            ),
          ],
        ),
        FButton(
          onPress: _showHistoryDialog,
          variant: FButtonVariant.outline,
          prefix: const Icon(Icons.history, size: 18),
          child: const Text("View Audit Logs"),
        ),
      ],
    );
  }

  Widget _buildAdjustmentView(
    AsyncValue<List<InventoryModel>> inventoryAsync,
    AsyncValue<List<WayBillModel>> waybillsAsync,
  ) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMethodTabs(),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: The Form
                      Expanded(
                        flex: 5,
                        child: _adjustmentType == 'Manual'
                            ? _buildManualForm(inventoryAsync)
                            : _buildWaybillForm(waybillsAsync),
                      ),
                      const SizedBox(width: 48),
                      // Right: The Preview/Context
                      Expanded(
                        flex: 5,
                        child:
                            _adjustmentType == 'Waybill' &&
                                _selectedWaybillId != null
                            ? _buildWaybillPreview()
                            : _buildContextPanel(inventoryAsync),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tabItem("Manual Adjustment", _adjustmentType == 'Manual', () {
            setState(() {
              _adjustmentType = 'Manual';
              _selectedWaybillId = null;
            });
          }),
          _tabItem("Receive from Waybill", _adjustmentType == 'Waybill', () {
            setState(() {
              _adjustmentType = 'Waybill';
              _selectedProductId = null;
            });
          }),
        ],
      ),
    );
  }

  Widget _tabItem(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? Colors.blue.shade700 : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManualForm(AsyncValue<List<InventoryModel>> inventoryAsync) {
    return inventoryAsync.when(
      data: (items) {
        final filteredItems = items.where((i) {
          final query = _searchController.text.toLowerCase();
          return i.name.toLowerCase().contains(query) ||
              i.sku.toLowerCase().contains(query);
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Selection",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Search Input
            FTextField(
              hint: "Search by name or SKU...",
              control: FTextFieldControl.managed(
                controller: _searchController,
                onChange: (v) => setState(() {}),
              ),
              prefixBuilder: (context, style, variants) => const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(Icons.search, size: 18),
              ),
            ),

            const SizedBox(height: 12),

            // Dropdown
            DropdownButtonFormField<String>(
              value: _selectedProductId,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              hint: const Text("Pick a product"),
              items: filteredItems
                  .map(
                    (i) => DropdownMenuItem(
                      value: i.id,
                      child: Text("${i.name} [${i.sku}]"),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedProductId = v),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quantity Delta",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      FTextField(
                        control: FTextFieldControl.managed(
                          controller: _manualQtyController,
                          onChange: (v) => setState(() {}),
                        ),
                        hint: "+ Increase / - Decrease",
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Reason for Adjustment",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            FTextField(
              control: FTextFieldControl.managed(controller: _reasonController),
              hint: "e.g. Broken packaging, Inbound receipt...",
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: FButton(
                onPress:
                    _selectedProductId != null &&
                        _manualQtyController.text.isNotEmpty
                    ? _submitManualAdjustment
                    : null,
                child: const Text("Commit Adjustment"),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
    );
  }

  Widget _buildWaybillForm(AsyncValue<List<WayBillModel>> waybillsAsync) {
    return waybillsAsync.when(
      data: (waybills) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Active Waybills",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedWaybillId,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            hint: const Text("Select inbound waybill"),
            items: waybills
                .map(
                  (w) => DropdownMenuItem(
                    value: w.id,
                    child: Text(
                      "${w.partyName} • ${DateFormat('MMM dd yyyy').format(w.createdAt)}",
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() => _selectedWaybillId = v);
              if (v != null) _fetchWaybillItems(v);
            },
          ),

          const SizedBox(height: 40),

          if (_selectedWaybillId != null)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FButton(
                onPress: _receiveWaybillStock,
                child: const Text("Confirm & Transfer to Local Stock"),
              ),
            ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
    );
  }

  Widget _buildContextPanel(AsyncValue<List<InventoryModel>> inventoryAsync) {
    InventoryModel? currentItem;
    if (_selectedProductId != null) {
      currentItem = inventoryAsync.value?.firstWhere(
        (i) => i.id == _selectedProductId,
      );
    }

    return Column(
      children: [
        if (currentItem != null) ...[
          _buildStockPreviewCard(
            currentItem,
            int.tryParse(_manualQtyController.text) ?? 0,
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _buildStockPreviewCard(InventoryModel item, int delta) {
    final isIncrease = delta >= 0;
    final newTotal = item.quantity + delta;

    return FCard(
      title: const Text("Summary of Change"),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metric("Status Quo", item.quantity.toString(), Colors.grey),
              Icon(Icons.arrow_forward_rounded, color: Colors.grey.shade300),
              _metric(
                "Adjustment",
                "${isIncrease ? '+' : ''}$delta",
                isIncrease ? Colors.green : Colors.red,
              ),
              Icon(Icons.arrow_forward_rounded, color: Colors.grey.shade300),
              _metric("Post-Action", newTotal.toString(), Colors.blue.shade700),
            ],
          ),
          const Divider(height: 48),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                "You are modifying ${item.name} (${item.sku})",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildWaybillPreview() {
    if (_isLoadingItems) {
      return FCard(child: const Center(child: CircularProgressIndicator()));
    }

    final totalQty = _waybillItems.fold<int>(0, (sum, i) => sum + i.quantity);

    return FCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Inbound Goods Manifest"),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "${_waybillItems.length} Items",
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: _waybillItems.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey.shade50),
              itemBuilder: (context, index) {
                final item = _waybillItems[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item.productName,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    "Qty: ${item.quantity}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Manifest Total:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                totalQty.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView(AsyncValue<List<AdjustmentLog>> logsAsync) {
    return FCard(
      title: const Text("Adjustment Audit Logs"),
      subtitle: const Text("Historical record of all stock modifications"),

      child: SizedBox(
        height: 600,
        width: 800,
        child: Column(
          children: [
            Expanded(
              child: logsAsync.when(
                data: (logs) {
                  if (logs.isEmpty) {
                    return const Center(
                      child: Text("No adjustment logs found"),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: false,
                    itemCount: logs.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade100),
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final isIncrease = log.quantityChange >= 0;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isIncrease
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          child: Icon(
                            isIncrease ? Icons.add : Icons.remove,
                            color: isIncrease ? Colors.green : Colors.red,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          log.productName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "${log.type} • ${log.reason ?? 'No reason provided'}",
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${isIncrease ? '+' : ''}${log.quantityChange}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isIncrease ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              DateFormat('MMM dd, HH:mm').format(log.createdAt),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: $e")),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FButton(
                  onPress: () => Navigator.pop(context),
                  variant: FButtonVariant.outline,
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
