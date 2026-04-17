import 'package:ashfoam_sadiq/src/data/local/app_database.dart' as db;
import 'package:ashfoam_sadiq/src/data/local/drift_extensions.dart' as ext;
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart';
import 'package:ashfoam_sadiq/src/data/models/tax.model.dart' as model;
import 'package:ashfoam_sadiq/src/data/providers/sync_providers.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

/// Provider to fetch all proformas from local database
final proformaListProvider = FutureProvider<List<Profoma>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  final items = await dbService.getProformas();
  return items.map((p) {
    return Profoma(
      id: p.id,
      partyName: p.partyName,
      partyAddress: p.partyAddress,
      tax: (jsonDecode(p.tax) as List)
          .map((t) => TaxComponent.fromMap(t as Map<String, dynamic>))
          .toList(),
      totalQuantity: p.totalQuantity,
      declaration: p.declaration,
      totalAmount: p.totalAmount,
      isDeleted: p.isDeleted,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
    );
  }).toList();
});

/// Provider to fetch all taxes for the dropdown
final allTaxesProvider = FutureProvider<List<model.Tax>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  final taxes = await dbService.getTaxes();
  return taxes.map((t) => model.Tax.fromMap(ext.TaxeToMap(t).toMap())).toList();
});

/// Provider for searching proformas
final proformaSearchQueryProvider = StateProvider<String>((ref) => '');

/// Computed provider for filtered proformas
final filteredProformasProvider = Provider<AsyncValue<List<Profoma>>>((ref) {
  final query = ref.watch(proformaSearchQueryProvider).toLowerCase();
  final proformasAsync = ref.watch(proformaListProvider);

  return proformasAsync.whenData((proformas) {
    if (query.isEmpty) return proformas;
    return proformas.where((p) {
      return (p.partyName ?? '').toLowerCase().contains(query);
    }).toList();
  });
});

/// Provider to handle adding a new proforma and its items
final addProformaProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);

  return (Profoma proforma, List<ProductDetails> items) async {
    // 1. Save Proforma
    final proformaCompanion = db.ProformasCompanion(
      id: Value(proforma.id),
      partyName: Value(proforma.partyName),
      partyAddress: Value(proforma.partyAddress),
      tax: Value(jsonEncode(proforma.tax.map((e) => e.toMap()).toList())),
      totalQuantity: Value(proforma.totalQuantity),
      declaration: Value(proforma.declaration),
      totalAmount: Value(proforma.totalAmount),
      isDeleted: Value(0),
      createdAt: Value(proforma.createdAt),
      updatedAt: Value(proforma.updatedAt),
    );

    await dbService.addProforma(proformaCompanion);

    // 2. Save Proforma Items
    final itemCompanions = items.map((item) => db.ProductDetailsListCompanion(
      productId: Value(item.productId),
      productName: Value(item.productName),
      proformaId: Value(proforma.id), // Link to proforma
      quantity: Value(item.quantity),
      unitPrice: Value(item.unitprice),
      discountPercentage: Value(item.discountPercentage),
      totalAmount: Value(item.totalAmount),
    )).toList();

    await dbService.addProductDetailsList(itemCompanions);

    ref.invalidate(proformaListProvider);
  };
});

/// Provider to fetch items for a specific proforma
final proformaItemsProvider = FutureProvider.family<List<ProductDetails>, String>((ref, proformaId) async {
  final dbService = ref.watch(databaseServiceProvider);
  final items = await dbService.getProformaDetails(proformaId);
  return items.map((m) => ProductDetails(
    productId: m.productId,
    productName: m.productName,
    quantity: m.quantity,
    unitprice: m.unitPrice,
    discountPercentage: m.discountPercentage,
    totalAmount: m.totalAmount,
    proformaId: m.proformaId,
    waybillId: m.waybillId,
  )).toList();
});
