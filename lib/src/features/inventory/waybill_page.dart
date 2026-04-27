import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/waybill_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/services/waybill_print_service.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/create_waybill_dialog.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/waybill_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class WaybillPage extends ConsumerStatefulWidget {
  const WaybillPage({super.key});

  @override
  ConsumerState<WaybillPage> createState() => _WaybillPageState();
}

class _WaybillPageState extends ConsumerState<WaybillPage> {
  late WaybillDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = WaybillDataGridSource(waybills: [], ref: ref);
  }

  void _showCreateWaybillDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CreateWaybillDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final waybillsAsync = ref.watch(filteredWaybillsProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: FCard(
                child: waybillsAsync.when(
                  data: (waybills) {
                    _dataGridSource.updateContext(context);
                    _dataGridSource.updateWaybills(waybills);
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final height = constraints.maxHeight.isFinite
                            ? constraints.maxHeight
                            : MediaQuery.sizeOf(context).height;
                        return Column(
                          children: [
                            SizedBox(
                              height: height - 190,
                              child: SfDataGridTheme(
                                data: SfDataGridThemeData(
                                  headerColor: Colors.black,
                                  gridLineColor: Colors.grey[200],
                                ),
                                child: SfDataGrid(
                                  source: _dataGridSource,
                                  columnWidthMode: ColumnWidthMode.fill,
                                  allowSorting: true,
                                  gridLinesVisibility: GridLinesVisibility.both,
                                  headerGridLinesVisibility:
                                      GridLinesVisibility.both,
                                  columns: _buildColumns(),
                                ),
                              ),
                            ),
                            const Divider(height: 1),
                            SfDataPager(
                              delegate: _dataGridSource,
                              pageCount: waybills.isEmpty
                                  ? 1
                                  : (waybills.length /
                                            _dataGridSource.rowsPerPage)
                                        .ceilToDouble(),
                              direction: Axis.horizontal,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
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
              "Dispatch Waybills",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Track and manage product dispatches and delivery notes",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 300,
              child: FTextField(
                hint: "Search by Order # or Client...",
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 18),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(waybillSearchQueryProvider.notifier).state =
                        v.text;
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            FButton(
              onPress: _showCreateWaybillDialog,
              prefix: const Icon(Icons.local_shipping_outlined),
              child: const Text("Generate Waybill"),
            ),
          ],
        ),
      ],
    );
  }

  List<GridColumn> _buildColumns() {
    final headerStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    return [
      GridColumn(
        columnName: 'orderNo',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Order #', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'party',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Client Name', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'sender',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Driver', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'destination',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Destination', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'date',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Dispatch Date', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'actions',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text('Actions', style: headerStyle),
        ),
      ),
    ];
  }
}

class WaybillDataGridSource extends DataGridSource {
  BuildContext? _context;
  final WidgetRef ref;
  final int rowsPerPage = 10;

  WaybillDataGridSource({
    required List<WayBillModel> waybills,
    required this.ref,
  }) {
    _waybills = waybills;
    _buildDataGridRows();
    _updatePaginatedRows(0);
  }

  List<WayBillModel> _waybills = [];
  List<DataGridRow> _dataGridRows = [];
  List<DataGridRow> _paginatedRows = [];

  void updateContext(BuildContext context) {
    _context = context;
  }

  void updateWaybills(List<WayBillModel> waybills) {
    _waybills = waybills;
    _buildDataGridRows();
    _updatePaginatedRows(0);
    notifyListeners();
  }

  void _updatePaginatedRows(int pageIndex) {
    int startIndex = pageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (startIndex < _dataGridRows.length) {
      _paginatedRows = _dataGridRows.sublist(
        startIndex,
        endIndex > _dataGridRows.length ? _dataGridRows.length : endIndex,
      );
    } else {
      _paginatedRows = [];
    }
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updatePaginatedRows(newPageIndex);
    notifyListeners();
    return true;
  }

  void _buildDataGridRows() {
    final dateFormat = DateFormat('dd MMM yyyy');
    _dataGridRows = _waybills.map<DataGridRow>((w) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'orderNo', value: w.orderNumber),
          DataGridCell<String>(columnName: 'party', value: w.partyName),
          DataGridCell<String>(columnName: 'sender', value: w.senderName),
          DataGridCell<String>(columnName: 'destination', value: w.destination),
          DataGridCell<String>(
            columnName: 'date',
            value: dateFormat.format(w.dispatchDate),
          ),
          DataGridCell<WayBillModel>(columnName: 'actions', value: w),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _paginatedRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'actions') {
          final waybill = dataGridCell.value as WayBillModel;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 20),
                tooltip: 'View Details',
                onPressed: () {
                  if (_context != null) {
                    showDialog(
                      context: _context!,
                      builder: (context) =>
                          WaybillDetailsDialog(waybill: waybill),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.print_outlined, size: 20),
                tooltip: 'Print Waybill',
                onPressed: () async {
                  if (_context != null) {
                    try {
                      final items = await ref.read(
                        waybillItemsProvider(waybill.id).future,
                      );
                      final company = await ref.read(companySettingsProvider.future);
                      if (_context!.mounted) {
                        await WaybillPrintService.showPreview(
                          context: _context!,
                          waybill: waybill,
                          items: items,
                          company: company,
                        );
                      }
                    } catch (e) {
                      if (_context!.mounted) {
                        ScaffoldMessenger.of(_context!).showSnackBar(
                          SnackBar(
                            content: Text('Error generating preview: $e'),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          );
        }

        return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(12.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}
