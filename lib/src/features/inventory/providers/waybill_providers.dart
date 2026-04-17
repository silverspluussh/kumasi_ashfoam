import 'dart:convert';
import 'package:ashfoam_sadiq/src/data/local/app_database.dart'
    as db
    hide WayBill;
import 'package:ashfoam_sadiq/src/data/models/waybill.model.dart';
import 'package:ashfoam_sadiq/src/data/models/profoma.model.dart' as model;
import 'package:ashfoam_sadiq/src/data/providers/database_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

final waybillListProvider = FutureProvider<List<WayBill>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  final items = await dbService.getWayBills();
  return items.map((i) {
    return WayBill(
      id: i.id,
      mainContent: i.mainContent != null 
          ? model.Profoma.fromJson(i.mainContent) 
          : model.Profoma(
              id: '', 
              tax: [], 
              totalQuantity: 0, 
              totalAmount: 0.0, 
              isDeleted: 0, 
              createdAt: DateTime.now(), 
              updatedAt: DateTime.now(),
            ),
      orderNumber: i.orderNumber,
      dispatchDocNumber: i.dispatchDocNumber,
      deliveryNote: i.deliveryNote,
      senderName: i.senderName,
      destination: i.destination,
      dispatchDate: i.dispatchDate,
      isDeleted: i.isDeleted,
      partyName: i.partyName,
      createdBy: i.createdBy,
      createdAt: i.createdAt,
      updatedAt: i.updatedAt,
    );
  }).toList();
});

final waybillSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredWaybillsProvider = Provider<AsyncValue<List<WayBill>>>((ref) {
  final query = ref.watch(waybillSearchQueryProvider).toLowerCase();
  final waybillsAsync = ref.watch(waybillListProvider);

  return waybillsAsync.whenData((waybills) {
    if (query.isEmpty) return waybills;
    return waybills.where((w) {
      return w.orderNumber.toLowerCase().contains(query) ||
          w.partyName.toLowerCase().contains(query) ||
          w.dispatchDocNumber.toLowerCase().contains(query);
    }).toList();
  });
});

final addWaybillProvider = Provider((ref) {
  final dbService = ref.read(databaseServiceProvider);

  return (WayBill waybill, List<model.ProductDetails> items) async {
    // 1. Save Waybill
    final waybillCompanion = db.WayBillsCompanion(
      id: Value(waybill.id),
      mainContent: Value(jsonEncode(waybill.mainContent.toMap())),
      orderNumber: Value(waybill.orderNumber),
      dispatchDocNumber: Value(waybill.dispatchDocNumber),
      deliveryNote: Value(waybill.deliveryNote),
      senderName: Value(waybill.senderName),
      destination: Value(waybill.destination),
      partyName: Value(waybill.partyName),
      dispatchDate: Value(waybill.dispatchDate),
      createdBy: Value(waybill.createdBy),
      isDeleted: Value(0),
      createdAt: Value(waybill.createdAt),
      updatedAt: Value(waybill.updatedAt),
    );

    // 2. Save Waybill Items
    final itemCompanions = items
        .map(
          (item) => db.ProductDetailsListCompanion(
            productId: Value(item.productId),
            productName: Value(item.productName),
            waybillId: Value(waybill.id), // Link to waybill
            quantity: Value(item.quantity),
            unitPrice: Value(item.unitprice),
            discountPercentage: Value(item.discountPercentage),
            totalAmount: Value(item.totalAmount),
          ),
        )
        .toList();

    await dbService.createWaybill(waybillCompanion, itemCompanions);
    ref.invalidate(waybillListProvider);
  };
});

final waybillItemsProvider =
    FutureProvider.family<List<model.ProductDetails>, String>((
      ref,
      waybillId,
    ) async {
      final dbService = ref.watch(databaseServiceProvider);
      final items = await dbService.getWayBillDetails(waybillId);
      return items
          .map((m) => model.ProductDetails(
                productId: m.productId,
                productName: m.productName,
                quantity: m.quantity,
                unitprice: m.unitPrice,
                discountPercentage: m.discountPercentage,
                totalAmount: m.totalAmount,
                proformaId: m.proformaId,
                waybillId: m.waybillId,
              ))
          .toList();
    });
