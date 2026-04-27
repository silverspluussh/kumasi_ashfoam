class AdjustmentLog {
  final String id;
  final String productId;
  final String productName;
  final int quantityChange;
  final String type;
  final String? reason;
  final String? referenceId;
  final DateTime createdAt;
  final String createdBy;

  AdjustmentLog({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantityChange,
    required this.type,
    this.reason,
    this.referenceId,
    required this.createdAt,
    required this.createdBy,
  });

  factory AdjustmentLog.fromDb(dynamic row) {
    // This allows us to map from the database even if the generated class 
    // hasn't been created yet by build_runner, by using the row's toJson or map
    return AdjustmentLog(
      id: row.id,
      productId: row.productId,
      productName: row.productName,
      quantityChange: row.quantityChange,
      type: row.type,
      reason: row.reason,
      referenceId: row.referenceId,
      createdAt: row.createdAt,
      createdBy: row.createdBy,
    );
  }
}
