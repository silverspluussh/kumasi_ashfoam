import 'package:ashfoam_sadiq/src/features/inventory/inventory_page.dart';
import 'package:ashfoam_sadiq/src/features/inventory/proforma_page.dart';
import 'package:ashfoam_sadiq/src/features/inventory/waybill_page.dart';
import 'package:ashfoam_sadiq/src/features/inventory/stockreports.dart';
import 'package:ashfoam_sadiq/src/features/inventory/stock_adjustment_page.dart';
import 'package:ashfoam_sadiq/src/features/payments/payments_page.dart';
import 'package:ashfoam_sadiq/src/features/invoices/invoices_page.dart';
import 'package:ashfoam_sadiq/src/features/management/brand_category_page.dart';
import 'package:ashfoam_sadiq/src/features/pos/pos_page.dart';
import 'package:ashfoam_sadiq/src/features/sales/sale_orders_page.dart';
import 'package:ashfoam_sadiq/src/features/settings/settings_page.dart';
import 'package:ashfoam_sadiq/src/features/summary/summary_page.dart';
import 'package:ashfoam_sadiq/src/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';

class StarterApp extends ConsumerStatefulWidget {
  const StarterApp({super.key});

  @override
  ConsumerState<StarterApp> createState() => _StarterAppState();
}

ValueNotifier<bool> isExpanded = ValueNotifier(true);
ValueNotifier<int> selectedIndex = ValueNotifier(0);

class _StarterAppState extends ConsumerState<StarterApp> {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      scaffoldStyle: FScaffoldStyleDelta.delta(
        backgroundColor: Colors.grey.shade50,
      ),
      sidebar: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (context, value, child) {
          return Container(
            constraints: BoxConstraints(maxWidth: isExpanded.value ? 230 : 80),
            child: FSidebar(
              style: FSidebarStyleDelta.delta(
                headerPadding: EdgeInsetsGeometryDelta.value(
                  EdgeInsetsGeometry.fromLTRB(0, 16, 0, 0),
                ),
                decoration: DecorationDelta.boxDelta(
                  color: Colors.amber.withValues(alpha: 0.01),
                ),
              ),

              header: FHeader(
                title: isExpanded.value ? Text("ASHFOAM") : SizedBox.shrink(),
              ),
              children: [
                FSidebarGroup(
                  children: [
                    _sidebarItem(
                      icon: FIcons.house,
                      label: "Summary",
                      action: () {
                        selectedIndex.value = 0;
                      },
                    ),

                    _sidebarItem(
                      icon: FIcons.shoppingCart,
                      label: "Point of Sale",
                      action: () {
                        selectedIndex.value = 1;
                      },
                    ),
                    if (isExpanded.value)
                      _sidebarItem(
                        icon: FIcons.list,
                        label: "Sale Orders",
                        chren: [
                          FSidebarItem(
                            icon: Icon(FIcons.list),
                            label: isExpanded.value ? Text("POS Sales") : null,
                            onPress: () {
                              selectedIndex.value = 2;
                              // Handle navigation to Home
                            },
                          ),
                          FSidebarItem(
                            icon: Icon(FIcons.fileCheck),
                            label: isExpanded.value ? Text("Invoices") : null,
                            onPress: () {
                              selectedIndex.value = 3;
                              // Handle navigation to Home
                            },
                          ),
                        ],
                        action: () {
                          // Handle navigation to Home
                        },
                      ),
                    if (isExpanded.value == false) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: Icon(FIcons.list),
                          label: isExpanded.value ? Text("POS Sales") : null,
                          onPress: () {
                            selectedIndex.value = 2;
                            // Handle navigation to Home
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: Icon(FIcons.fileCheck),
                          label: isExpanded.value ? Text("Invoices") : null,
                          onPress: () {
                            // Handle navigation to Home
                            selectedIndex.value = 3;
                          },
                        ),
                      ),
                    ],

                    if (isExpanded.value)
                      _sidebarItem(
                        icon: FIcons.boxes,
                        label: "Inventory",
                        action: () {
                          // Handle navigation to Home
                        },
                        chren: [
                          FSidebarItem(
                            icon: Icon(FIcons.boxes),
                            label: isExpanded.value ? Text("Products") : null,
                            onPress: () {
                              selectedIndex.value = 4;
                              // Handle navigation to Home
                            },
                          ),
                          FSidebarItem(
                            icon: Icon(FIcons.warehouse),
                            label: isExpanded.value
                                ? Text("Stock Reports")
                                : null,
                            onPress: () {
                              // Handle navigation to Home
                              selectedIndex.value = 5;
                            },
                          ),
                          FSidebarItem(
                            icon: const Icon(Icons.tune),
                            label: isExpanded.value
                                ? const Text("Stock Adjustment")
                                : null,
                            onPress: () {
                              selectedIndex.value = 13;
                            },
                          ),
                        ],
                      ),
                    if (isExpanded.value == false) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: Icon(FIcons.boxes),
                          label: isExpanded.value ? Text("Products") : null,
                          onPress: () {
                            // Handle navigation to Home
                            selectedIndex.value = 4;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: Icon(FIcons.warehouse),
                          label: isExpanded.value
                              ? Text("Stock Reports")
                              : null,
                          onPress: () {
                            // Handle navigation to Home
                            selectedIndex.value = 5;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: const Icon(Icons.tune),
                          label: isExpanded.value
                              ? const Text("Stock Adjustment")
                              : null,
                          onPress: () {
                            selectedIndex.value = 13;
                          },
                        ),
                      ),
                    ],

                    if (isExpanded.value)
                      _sidebarItem(
                        icon: FIcons.currency,
                        label: "Payments",
                        action: () {
                          // Handle navigation to Home
                          selectedIndex.value = 7;
                        },
                      ),
                    if (isExpanded.value == false) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FSidebarItem(
                          icon: Icon(FIcons.currency),
                          label: isExpanded.value ? Text("All Payments") : null,
                          onPress: () {
                            // Handle navigation to Home
                            selectedIndex.value = 7;
                          },
                        ),
                      ),
                    ],

                    _sidebarItem(
                      icon: FIcons.receipt,
                      label: "Profomas",
                      action: () {
                        selectedIndex.value = 9;
                      },
                    ),
                    _sidebarItem(
                      icon: FIcons
                          .truck, // Assuming truck icon exists in the FIcons set
                      label: "Waybills",
                      action: () {
                        selectedIndex.value = 11;
                      },
                    ),

                    _sidebarItem(
                      icon: FIcons.settings,
                      label: "Settings",
                      action: () {
                        selectedIndex.value = 10;
                        // Handle navigation to Settings
                      },
                      chren: isExpanded.value
                          ? [
                              FSidebarItem(
                                icon: Icon(FIcons.list),
                                label: const Text("Brands & Categories"),
                                onPress: () {
                                  selectedIndex.value = 12;
                                },
                              ),
                            ]
                          : [],
                    ),
                  ],
                ),
              ],
              footer: FSidebarItem(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: isExpanded.value ? const Text("Logout", style: TextStyle(color: Colors.red)) : null,
                onPress: () {
                  ref.read(authNotifierProvider.notifier).signOut();
                },
              ),
            ),
          );
        },
      ),
      childPad: false,

      child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, child) {
          if (value == 0) {
            return const SummaryPage();
          } else if (value == 1) {
            return PosView();
          } else if (value == 2) {
            return const SaleOrdersPage();
          } else if (value == 3) {
            return const InvoicesView();
          } else if (value == 4) {
            return const InventoryView();
          } else if (value == 5) {
            return const StockReportsView();
          } else if (value == 6) {
            return const ProformaPage();
          } else if (value == 7) {
            return const PaymentsPage();
          } else if (value == 9) {
            return const ProformaPage();
          } else if (value == 10) {
            return const SettingsPage();
          } else if (value == 11) {
            return const WaybillPage();
          } else if (value == 12) {
            return const BrandCategoryManagementPage();
          } else if (value == 13) {
            return const StockAdjustmentPage();
          }
          return const SummaryPage();
        },
      ),
    );
  }

  Widget _sidebarItem({
    required String label,
    required IconData icon,
    VoidCallback? action,
    List<Widget> chren = const [],
  }) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: FSidebarItem(
      icon: Icon(icon),
      label: isExpanded.value ? Text(label) : null,
      onPress: action,
      children: chren,
    ),
  );
}
