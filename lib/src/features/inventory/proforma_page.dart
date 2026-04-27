import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/providers/proforma_providers.dart';
import 'package:ashfoam_sadiq/src/features/inventory/services/proforma_print_service.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/create_proforma_dialog.dart';
import 'package:ashfoam_sadiq/src/features/inventory/widgets/proforma_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ProformaPage extends ConsumerStatefulWidget {
  const ProformaPage({super.key});

  @override
  ConsumerState<ProformaPage> createState() => _ProformaPageState();
}

class _ProformaPageState extends ConsumerState<ProformaPage> {
  late ProformaDataGridSource _dataGridSource;

  @override
  void initState() {
    super.initState();
    _dataGridSource = ProformaDataGridSource(proformas: [], ref: ref);
  }

  void _showCreateProformaDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CreateProformaDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proformasAsync = ref.watch(filteredProformasProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: FCard(
                child: proformasAsync.when(
                  data: (proformas) {
                    _dataGridSource.updateContext(context);
                    _dataGridSource.updateProformas(proformas);
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final height = constraints.maxHeight.isFinite
                            ? constraints.maxHeight
                            : MediaQuery.sizeOf(context).height;
                        ;
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
                              pageCount: proformas.isEmpty
                                  ? 1
                                  : (proformas.length /
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
              "Proforma Invoices",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Manage and issue proforma invoices to clients",
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
                hint: "Search by client name...",
                prefixBuilder: (context, style, variants) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, size: 18),
                ),
                control: FTextFieldControl.managed(
                  onChange: (v) {
                    ref.read(proformaSearchQueryProvider.notifier).state =
                        v.text;
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            FButton(
              onPress: _showCreateProformaDialog,
              prefix: const Icon(Icons.add),
              child: const Text("Create Proforma"),
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
        columnName: 'party',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Client Name', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'qty',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Total Qty', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'amount',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text('Total Amount', style: headerStyle),
        ),
      ),
      GridColumn(
        columnName: 'date',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text('Date', style: headerStyle),
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

class ProformaDataGridSource extends DataGridSource {
  BuildContext? _context;
  final WidgetRef ref;
  final int rowsPerPage = 10;

  ProformaDataGridSource({
    required List<Profoma> proformas,
    required this.ref,
  }) {
    _proformas = proformas;
    _buildDataGridRows();
    _updatePaginatedRows(0);
  }

  List<Profoma> _proformas = [];
  List<DataGridRow> _dataGridRows = [];
  List<DataGridRow> _paginatedRows = [];

  void updateContext(BuildContext context) {
    _context = context;
  }

  void updateProformas(List<Profoma> proformas) {
    _proformas = proformas;
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
    _dataGridRows = _proformas.map<DataGridRow>((p) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'party',
            value: p.partyName ?? 'Walk-in Client',
          ),
          DataGridCell<int>(columnName: 'qty', value: p.totalQuantity),
          DataGridCell<double>(columnName: 'amount', value: p.totalAmount),
          DataGridCell<DateTime>(columnName: 'date', value: p.createdAt),
          DataGridCell<Profoma>(columnName: 'actions', value: p),
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
          final proforma = dataGridCell.value as Profoma;
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
                          ProformaDetailsDialog(proforma: proforma),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.print_outlined, size: 20),
                tooltip: 'Print Proforma',
                onPressed: () async {
                  if (_context != null) {
                    // Show a simple loading indicator or just handle it
                    try {
                      final items = await ref.read(
                        proformaItemsProvider(proforma.id).future,
                      );
                      final company = await ref.read(companySettingsProvider.future);

                      if (_context!.mounted) {
                        await ProformaPrintService.showPreview(
                          context: _context!,
                          proforma: proforma,
                          items: items,
                          company: company,
                        );
                      }
                    } catch (e) {
                      if (_context!.mounted) {
                        ScaffoldMessenger.of(_context!).showSnackBar(
                          SnackBar(
                            content: Text('Error generating print preview: $e'),
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

        String value = '';
        Alignment alignment = Alignment.centerLeft;

        if (dataGridCell.value is DateTime) {
          value = DateFormat(
            'MMM dd, yyyy',
          ).format(dataGridCell.value as DateTime);
        } else if (dataGridCell.value is double) {
          value = NumberFormat.currency(
            symbol: 'GH₵ ',
          ).format(dataGridCell.value);
          alignment = Alignment.centerRight;
        } else if (dataGridCell.value is int) {
          value = dataGridCell.value.toString();
          alignment = Alignment.centerRight;
        } else {
          value = dataGridCell.value.toString();
        }

        return Container(
          alignment: alignment,
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: dataGridCell.columnName == 'amount'
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
