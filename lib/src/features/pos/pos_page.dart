import 'dart:developer';

import 'package:ashfoam_sadiq/src/features/pos/providers/pos_providers.dart';
import 'package:ashfoam_sadiq/src/utils/date_extensions.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ashfoam_sadiq/src/data/models/inventory.model.dart';
import 'package:forui/forui.dart';
import 'package:ashfoam_sadiq/src/features/pos/widgets/order_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PosView extends ConsumerStatefulWidget {
  const PosView({super.key});

  @override
  ConsumerState<PosView> createState() => _PosViewState();
}

class _PosViewState extends ConsumerState<PosView> {
  final _orderDateController = TextEditingController(
    text: DateTime.now().mmddyyyy,
  );
  final _rateController = TextEditingController();
  final _stockController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _discountController = TextEditingController(text: '0');
  final _subtotalController = TextEditingController();
  final _amountReceivedController = TextEditingController(text: '0');
  final _changeController = TextEditingController(text: '0.00');
  final _paymentMethodController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();

  @override
  void dispose() {
    _rateController.dispose();
    _stockController.dispose();
    _quantityController.dispose();
    _discountController.dispose();
    _subtotalController.dispose();
    _orderDateController.dispose();
    _amountReceivedController.dispose();
    _changeController.dispose();
    _paymentMethodController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final productsAsync = ref.watch(inventoryProductsProvider);
    final currentSelection = ref.watch(currentSaleItemProvider);
    final cartItems = ref.watch(cartProvider);
    final cartSummary = ref.watch(cartSummaryProvider);

    // Sync controllers with state when it changes from outside (e.g. product selection)
    ref.listen(currentSaleItemProvider, (previous, next) {
      if (previous?.product != next.product) {
        _rateController.text = next.rate.toStringAsFixed(2);
        _stockController.text = next.stock.toString();
        _quantityController.text = next.quantity.toString();
        _discountController.text = next.discountPercentage.toString();
      }
      _subtotalController.text = next.subtotal.toStringAsFixed(2);
      _calculateChange(cartSummary['grandTotal'] as double);
    });
    final itemStyle = Theme.of(context).textTheme.labelMedium;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          spacing: 15,
          children: [
            FCard(
              title: Text("Add Order"),
              subtitle: Text("Select and add sale orders below:"),
              child: SizedBox(
                height: size.height * 0.27,
                width: size.width,
                child: Form(
                  child: Column(
                    spacing: 15,
                    children: [
                      SizedBox(width: 20),
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: CustomDateField(
                              lable: "Order Date",
                              controller: _orderDateController,
                              onDateChanged: (date) {
                                _orderDateController.text = date.mmddyyyy;
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomField(
                              lable: "Customer Name*",
                              controller: _customerNameController,
                            ),
                          ),
                          Expanded(
                            child: CustomField(
                              lable: "Customer Phone",
                              controller: _customerPhoneController,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        key: const Key("product selection"),
                        child: Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: productsAsync.when(
                                data: (products) =>
                                    FSelect<InventoryModel>.searchBuilder(
                                      hint: 'Select a product',
                                      style: FSelectStyleDelta.delta(
                                        contentStyle:
                                            FSelectContentStyleDelta.delta(
                                              padding:
                                                  const EdgeInsetsGeometryDelta.value(
                                                    EdgeInsets.all(10),
                                                  ),
                                              decoration:
                                                  DecorationDelta.boxDelta(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                            ),
                                      ),
                                      label: Text(
                                        "Product*",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium,
                                      ),
                                      format: (s) => s.name,
                                      filter: (query) => query.isEmpty
                                          ? products
                                          : products
                                                .where(
                                                  (f) => f.name
                                                      .toLowerCase()
                                                      .contains(
                                                        query.toLowerCase(),
                                                      ),
                                                )
                                                .toList(),
                                      contentBuilder:
                                          (context, _, filteredProducts) => [
                                            for (final product
                                                in filteredProducts)
                                              FSelectItem.item(
                                                title: Text(product.name),
                                                value: product,
                                              ),
                                          ],
                                      control: FSelectControl.lifted(
                                        value: currentSelection.product,
                                        onChange: (value) {
                                          if (value != null) {
                                            ref
                                                .read(
                                                  currentSaleItemProvider
                                                      .notifier,
                                                )
                                                .selectProduct(value);
                                          }
                                        },
                                      ),
                                    ),
                                error: (e, s) =>
                                    Text("Error loading products: $e"),
                                loading: () => const LinearProgressIndicator(),
                              ),
                            ),
                            Expanded(
                              child: CustomField(
                                lable: "Rate(GHS)*",
                                controller: _rateController,
                                readOnly: true,
                                leading: Text("GHS"),
                              ),
                            ),
                            Expanded(
                              child: CustomField(
                                lable: "Current Stock*",
                                controller: _stockController,
                                readOnly: true,
                              ),
                            ),
                            Expanded(
                              child: CustomField(
                                lable: "Order Quantity*",
                                controller: _quantityController,
                                onChanged: (v) {
                                  final qty = int.tryParse(v) ?? 0;
                                  ref
                                      .read(currentSaleItemProvider.notifier)
                                      .updateQuantity(qty);
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomField(
                                lable: "Discount(%)*",
                                controller: _discountController,
                                onChanged: (v) {
                                  final disc = double.tryParse(v) ?? 0.0;
                                  ref
                                      .read(currentSaleItemProvider.notifier)
                                      .updateDiscount(disc);
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomField(
                                lable: "Sub Total(GHS)*",
                                controller: _subtotalController,
                                readOnly: true,
                                leading: Text("GHS"),
                              ),
                            ),
                            FButton(
                              prefix: Icon(Icons.add),
                              onPress: currentSelection.product == null
                                  ? null
                                  : () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .addItem(currentSelection);
                                      ref
                                          .read(
                                            currentSaleItemProvider.notifier,
                                          )
                                          .reset();
                                      _quantityController.text = '1';
                                      _discountController.text = '0';
                                    },
                              child: Text("Add"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              spacing: 15,
              children: [
                Expanded(
                  child: FCard(
                    title: Text("Order Summary"),
                    child: SizedBox(
                      width: double.infinity,
                      height: size.height * 0.5,
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 15,
                          children: [
                            SizedBox(),
                            Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: CustomField(
                                    lable: "Sub total (discounted)*",
                                    controller: TextEditingController(
                                      text: cartSummary['subtotal']
                                          ?.toStringAsFixed(2),
                                    ),
                                    readOnly: true,
                                    leading: Text("GHS"),
                                  ),
                                ),
                                Expanded(
                                  child: CustomField(
                                    lable: "Amount Received*",
                                    controller: _amountReceivedController,
                                    inputType: TextInputType.number,
                                    leading: Text("GHS"),
                                    onChanged: (v) => _calculateChange(
                                      cartSummary['grandTotal'] as double,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: CustomField(
                                    lable: "VAT(GHS)*",
                                    controller: TextEditingController(
                                      text: cartSummary['vatAmount']
                                          ?.toStringAsFixed(2),
                                    ),
                                    readOnly: true,
                                    leading: Text("GHS"),
                                  ),
                                ),
                                Expanded(
                                  child: CustomField(
                                    lable: "Change",
                                    controller: _changeController,
                                    readOnly: true,
                                    leading: Text("GH¢"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: CustomField(
                                    lable: "Grand Total",
                                    controller: TextEditingController(
                                      text: cartSummary['grandTotal']
                                          ?.toStringAsFixed(2),
                                    ),
                                    readOnly: true,
                                    leading: Text("GH¢"),
                                  ),
                                ),
                                Expanded(
                                  child: CustomField(
                                    lable: "Payment method*",
                                    hint:
                                        "eg momo, cash, bank transfer, cheque",
                                    controller: _paymentMethodController,
                                  ),
                                ),
                              ],
                            ),
                            FCheckbox(
                              label: const Text("Create Invoice"),
                              value: ref.watch(posInvoiceRequestedProvider),
                              onChange: (v) =>
                                  ref
                                          .read(
                                            posInvoiceRequestedProvider
                                                .notifier,
                                          )
                                          .state =
                                      v,
                            ),
                            Divider(height: 5, color: Colors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 30,
                              children: [
                                FButton(
                                  prefix: Icon(FIcons.plus),
                                  variant: FButtonVariant.primary,
                                  onPress: cartItems.isEmpty
                                      ? null
                                      : () async {
                                          if (_customerNameController
                                              .text
                                              .isEmpty) {
                                            Toastification().show(
                                              context: context,
                                              title: const Text(
                                                'Please enter customer name',
                                              ),
                                              type: ToastificationType.error,
                                              autoCloseDuration: 2.seconds,
                                            );
                                            return;
                                          }
                                          final result = await ref
                                              .read(
                                                createPOSOrderProvider.notifier,
                                              )
                                              .createOrder(
                                                customerName:
                                                    _customerNameController
                                                        .text,
                                                customerPhone:
                                                    _customerPhoneController
                                                        .text,
                                                paymentMethod:
                                                    _paymentMethodController
                                                        .text,
                                                channel:
                                                    'Retail', // Default channel
                                                createInvoice: ref.read(
                                                  posInvoiceRequestedProvider,
                                                ),
                                              );
                                          if (result != null &&
                                              context.mounted) {
                                            final (order, items) = result;
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  OrderSuccessDialog(
                                                    order: order,
                                                    items: items,
                                                  ),
                                            );
                                            Toastification().show(
                                              context: context,
                                              title: const Text(
                                                'Order created successfully',
                                              ),
                                              type: ToastificationType.success,
                                              autoCloseDuration: 2.seconds,
                                            );
                                            _customerNameController.clear();
                                            _customerPhoneController.clear();
                                            _paymentMethodController.clear();
                                            _amountReceivedController.text =
                                                '0';
                                            _changeController.text = '0.00';
                                            ref
                                                    .read(
                                                      posInvoiceRequestedProvider
                                                          .notifier,
                                                    )
                                                    .state =
                                                false;
                                          }
                                        },
                                  child: Text("Create Order"),
                                ),
                                FButton(
                                  prefix: Icon(FIcons.x),
                                  variant: FButtonVariant.destructive,
                                  onPress: () {
                                    ref.read(cartProvider.notifier).clear();
                                    ref
                                        .read(currentSaleItemProvider.notifier)
                                        .reset();
                                  },
                                  child: Text("Reset Order"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FCard(
                    title: Text("Order Details"),
                    child: SizedBox(
                      width: double.infinity,
                      height: size.height * 0.5,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Product", style: itemStyle),
                              Text("Quantity", style: itemStyle),
                              Text("Unit Price", style: itemStyle),
                              Text("Discount", style: itemStyle),
                              Text("Total Price", style: itemStyle),
                              Text("Actions", style: itemStyle),
                            ],
                          ),
                          Divider(color: Colors.black),
                          if (cartItems.isEmpty)
                            SizedBox(
                              height: 150,
                              width: 300,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FIcons.shoppingCart, size: 50),
                                    Text("No items in cart"),
                                  ],
                                ),
                              ),
                            ),
                          for (var item in cartItems)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.productName),
                                Text(item.quantity.toString()),
                                Text(
                                  "GH¢ ${item.unitPrice.toStringAsFixed(2)}",
                                ),
                                Text(
                                  "GH¢ ${item.discountAmount.toStringAsFixed(2)}",
                                ),
                                Text(
                                  "GH¢ ${item.totalPrice.toStringAsFixed(2)}",
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .removeItem(item.id);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _calculateChange(double grandTotal) {
    final received = double.tryParse(_amountReceivedController.text) ?? 0.0;
    final change = received - grandTotal;
    _changeController.text = change.toStringAsFixed(2);
  }
}

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.lable,
    this.controller,
    this.onChanged,
    this.hint,
    this.readOnly = false,
    this.leading,
    this.inputType,
  });
  final String lable;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final Widget? leading;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
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
      size: FTextFieldSizeVariant.lg,
      style: fieldStyle,
      enabled: true,
      readOnly: readOnly,
      keyboardType: inputType ?? TextInputType.text,

      label: Text(lable, style: Theme.of(context).textTheme.labelMedium),
      control: FTextFieldControl.managed(
        controller: controller,
        onChange: (value) {
          if (!readOnly) {
            onChanged?.call(value.text);
          }
        },
      ),
      prefixBuilder: (context, style, variants) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: leading ?? SizedBox.shrink(),
      ),
      hint: hint ?? 'Enter $lable',
    );
  }
}

class CustomDateField extends StatelessWidget {
  const CustomDateField({
    super.key,
    required this.lable,
    this.controller,
    this.onDateChanged,
  });
  final String lable;
  final TextEditingController? controller;
  final ValueChanged<DateTime>? onDateChanged;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

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
    return FTextFormField(
      onTap: () =>
          showDatePicker(
            context: context,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 30)),
          ).then((da) {
            if (da != null) {
              controller?.text = da.mmddyyyy;
              onDateChanged?.call(da);
            }
          }),
      size: FTextFieldSizeVariant.lg,
      style: fieldStyle,
      enabled: true,
      label: Text(lable, style: Theme.of(context).textTheme.labelMedium),
      prefixBuilder: (context, style, variants) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Icon(FIcons.calendar),
      ),
      control: FTextFieldControl.managed(
        controller: controller,
        onChange: (value) {
          if (value.text.isNotEmpty) {
            // Check if string is parseable by DateTime.parse (usually yyyy-mm-dd)
            // If not, we skip automatic parsing from text input for simplicity
            try {
              onDateChanged?.call(DateTime.parse(value.text));
            } catch (_) {}
          }
        },
      ),
      hint: date.mmddyyyy,
    );
  }
}
