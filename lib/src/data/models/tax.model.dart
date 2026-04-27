import 'dart:convert';

class TaxModel {
  final String id;
  final String name;
  final double valuePercentage;

  const TaxModel({
    required this.id,
    required this.name,
    required this.valuePercentage,
  });

  TaxModel copyWith({String? id, String? name, double? valuePercentage}) {
    return TaxModel(
      id: id ?? this.id,
      name: name ?? this.name,
      valuePercentage: valuePercentage ?? this.valuePercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'value_percentage': valuePercentage};
  }

  factory TaxModel.fromMap(Map<String, dynamic> map) {
    final value = map['value_percentage'] ?? map['valuePercentage'];
    return TaxModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      valuePercentage: (value as num?)?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaxModel.fromJson(String source) =>
      TaxModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
