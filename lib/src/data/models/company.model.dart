import 'dart:developer';

class CompanyModel {
  final String id;
  final String name;
  final String? postalAddress;
  final String? commercialAddress;
  final String? phonePrimary;
  final String? phoneSecondary;
  final String? faxId;
  final String? email;
  final String? website;
  final String? logoPath;
  final DateTime? updatedAt;

  CompanyModel({
    required this.id,
    required this.name,
    this.postalAddress,
    this.commercialAddress,
    this.phonePrimary,
    this.phoneSecondary,
    this.faxId,
    this.email,
    this.website,
    this.logoPath,
    this.updatedAt,
  });

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return CompanyModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      postalAddress: (map['postalAddress'] ?? map['postal_address']) as String?,
      commercialAddress:
          (map['commercialAddress'] ?? map['commercial_address']) as String?,
      phonePrimary: (map['phonePrimary'] ?? map['phone_primary']) as String?,
      phoneSecondary:
          (map['phoneSecondary'] ?? map['phone_secondary']) as String?,
      faxId: (map['faxId'] ?? map['fax_id'])?.toString(),
      email: map['email'] as String?,
      website: map['website'] as String?,
      logoPath: (map['logoPath'] ?? map['logo_path']) as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'postalAddress': postalAddress,
      'commercialAddress': commercialAddress,
      'phonePrimary': phonePrimary,
      'phoneSecondary': phoneSecondary,
      'faxId': faxId,
      'email': email,
      'website': website,
      'logoPath': logoPath,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }
}
