class CustomerModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? segment;
  final int? ordersCount;
  final double? lifetimeValue;
  final DateTime? lastOrderDate;
  final String? status;

  const CustomerModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.segment,
    this.ordersCount,
    this.lifetimeValue,
    this.lastOrderDate,
    this.status,
  });

  CustomerModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? segment,
    int? ordersCount,
    double? lifetimeValue,
    DateTime? lastOrderDate,
    String? status,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      segment: segment ?? this.segment,
      ordersCount: ordersCount ?? this.ordersCount,
      lifetimeValue: lifetimeValue ?? this.lifetimeValue,
      lastOrderDate: lastOrderDate ?? this.lastOrderDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'segment': segment,
      'orders_count': ordersCount,
      'lifetime_value': lifetimeValue,
      'last_order_date': lastOrderDate?.toIso8601String(),
      'status': status,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString(),
      phone: map['phone']?.toString(),
      segment: map['segment']?.toString(),
      ordersCount: (map['orders_count'] as num?)?.toInt(),
      lifetimeValue: (map['lifetime_value'] as num?)?.toDouble(),
      lastOrderDate: map['last_order_date'] != null
          ? DateTime.tryParse(map['last_order_date'].toString())
          : null,
      status: map['status']?.toString(),
    );
  }
}
