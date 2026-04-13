import 'package:ashfoam_sadiq/src/utils/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class StarterApp extends StatefulWidget {
  const StarterApp({super.key});

  @override
  State<StarterApp> createState() => _StarterAppState();
}

ValueNotifier<bool> isExpanded = ValueNotifier(true);

class _StarterAppState extends State<StarterApp> {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      sidebar: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (context, value, child) {
          return Container(
            constraints: BoxConstraints(maxWidth: isExpanded.value ? 200 : 80),
            child: FSidebar(
              style: .delta(
                headerPadding: .value(.fromLTRB(0, 16, 0, 0)),
                decoration: DecorationDelta.boxDelta(
                  color: Colors.amber.withValues(alpha: .01),
                ),
              ),

              header: FHeader(
                title: isExpanded.value
                    ? Text("ASHFOAM")
                    : SizedBox.shrink(),
              ),
              children: [
                FSidebarGroup(

                  children: [
                    _sidebarItem(
                      icon: FIcons.house,
                      label: "Summary",
                      action: () {
                        // Handle navigation to Home
                      },
                    ),

                    _sidebarItem(
                      icon: FIcons.shoppingCart,
                      label: "Point of Sale",
                      action: () {},
                    ),
                    if(isExpanded.value)
                 _sidebarItem(
                      icon: FIcons.list,
                      label: "Sale Orders",
                      chren: [
                        FSidebarItem(
                          icon: Icon(FIcons.list),
                          label:isExpanded.value? Text("POS Sales"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                        ),
                        FSidebarItem(
                          icon: Icon(FIcons.fileCheck),
                          label:isExpanded.value? Text("Invoices"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                        ),
                      ],
                      action: () {
                        // Handle navigation to Home
                      },
                    ),
                    if(isExpanded.value ==false)
                    ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(FIcons.list),
                            label:isExpanded.value? Text("POS Sales"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                        )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(FIcons.fileCheck),
                            label:isExpanded.value? Text("Invoices"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                        )),
                    ],


if(isExpanded.value)
                    _sidebarItem(
                      icon: FIcons.boxes,
                      label: "Inventory",
                      action: () {
                        // Handle navigation to Home
                      },
                      chren: [
                        FSidebarItem(
                          icon: Icon(FIcons.boxes),
                          label:isExpanded.value? Text("Products"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                                                ),
                        FSidebarItem(
                          icon: Icon(FIcons.warehouse),
                          label: isExpanded.value?Text("Low Stock"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                                                ),
                        FSidebarItem(
                          icon: Icon(Icons.report),
                          label: isExpanded.value?Text("Report"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                                                ),
                      ],
                    ),
                    if(isExpanded.value ==false)
                    ...[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(FIcons.boxes),
                            label:isExpanded.value? Text("Products"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(FIcons.warehouse),
                            label: isExpanded.value?Text("Low Stock"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(Icons.report),
                            label: isExpanded.value?Text("Report"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                          ),
                        ),
                    ],

                    if(isExpanded.value)
                    _sidebarItem(
                      icon: FIcons.currency,
                      label: "Payments",

                      chren: [
                        FSidebarItem(
                          icon: Icon(FIcons.currency),
                          label:isExpanded.value? Text("All Payments"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                        ),
                        FSidebarItem(
                          icon: Icon(FIcons.chartBar),
                          label: isExpanded.value? Text("Reports"):null,
                          onPress: () {
                            // Handle navigation to Home
                          },
                        ),
                      ],
                    ),
                    if(isExpanded.value == false)
                    ...[ Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FSidebarItem(
                            icon: Icon(FIcons.currency),
                            label:isExpanded.value? Text("All Payments"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                          ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FSidebarItem(
                            icon: Icon(FIcons.chartBar),
                            label: isExpanded.value? Text("Reports"):null,
                            onPress: () {
                              // Handle navigation to Home
                            },
                          ),
                        ),],

                    _sidebarItem(
                      icon: FIcons.receipt,
                      label: "Proformas",
                      action: () {
                        // Handle navigation to Home
                      },
                    ),

                    _sidebarItem(
                      icon: FIcons.settings,
                      label: "Settings",
                      action: () {
                        // Handle navigation to Settings
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      childPad: false,
      header: FHeader(

        title: Text('Dashboard', textAlign: TextAlign.center),

        suffixes: [Text(DateTime.now().fullDate)],
      ),
      child: SizedBox(),
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
      label:isExpanded.value? Text(label):null,
      onPress: action,
      children: chren,
    ),
  );
}
