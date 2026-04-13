import 'dart:convert';

class Tax {
  final String id;
  final String name;
  final double valuePercentage;

  const Tax({
    required this.id,
    required this.name,
    required this.valuePercentage,
  });

  Tax copyWith({String? id, String? name, double? valuePercentage}) {
    return Tax(
      id: id ?? this.id,
      name: name ?? this.name,
      valuePercentage: valuePercentage ?? this.valuePercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'value_percentage': valuePercentage};
  }

  factory Tax.fromMap(Map<String, dynamic> map) {
    final value = map['value_percentage'] ?? map['valuePercentage'];
    return Tax(
      id: map['id'] as String,
      name: map['name'] as String,
      valuePercentage: (value as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tax.fromJson(String source) =>
      Tax.fromMap(json.decode(source) as Map<String, dynamic>);
}
