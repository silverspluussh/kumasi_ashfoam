// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _storeIdMeta = const VerificationMeta(
    'storeId',
  );
  @override
  late final GeneratedColumn<String> storeId = GeneratedColumn<String>(
    'store_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeNameMeta = const VerificationMeta(
    'storeName',
  );
  @override
  late final GeneratedColumn<String> storeName = GeneratedColumn<String>(
    'store_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchAddressMeta = const VerificationMeta(
    'branchAddress',
  );
  @override
  late final GeneratedColumn<String> branchAddress = GeneratedColumn<String>(
    'branch_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactMeta = const VerificationMeta(
    'contact',
  );
  @override
  late final GeneratedColumn<String> contact = GeneratedColumn<String>(
    'contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<int> isDeleted = GeneratedColumn<int>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _companyDetailsMeta = const VerificationMeta(
    'companyDetails',
  );
  @override
  late final GeneratedColumn<String> companyDetails = GeneratedColumn<String>(
    'company_details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchManagerNameMeta = const VerificationMeta(
    'branchManagerName',
  );
  @override
  late final GeneratedColumn<String> branchManagerName =
      GeneratedColumn<String>(
        'branch_manager_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _branchManagerIdMeta = const VerificationMeta(
    'branchManagerId',
  );
  @override
  late final GeneratedColumn<String> branchManagerId = GeneratedColumn<String>(
    'branch_manager_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    storeId,
    storeName,
    branchName,
    branchAddress,
    contact,
    isActive,
    isDeleted,
    companyDetails,
    branchManagerName,
    branchManagerId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_id')) {
      context.handle(
        _storeIdMeta,
        storeId.isAcceptableOrUnknown(data['store_id']!, _storeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_storeIdMeta);
    }
    if (data.containsKey('store_name')) {
      context.handle(
        _storeNameMeta,
        storeName.isAcceptableOrUnknown(data['store_name']!, _storeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_storeNameMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('branch_address')) {
      context.handle(
        _branchAddressMeta,
        branchAddress.isAcceptableOrUnknown(
          data['branch_address']!,
          _branchAddressMeta,
        ),
      );
    }
    if (data.containsKey('contact')) {
      context.handle(
        _contactMeta,
        contact.isAcceptableOrUnknown(data['contact']!, _contactMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('company_details')) {
      context.handle(
        _companyDetailsMeta,
        companyDetails.isAcceptableOrUnknown(
          data['company_details']!,
          _companyDetailsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyDetailsMeta);
    }
    if (data.containsKey('branch_manager_name')) {
      context.handle(
        _branchManagerNameMeta,
        branchManagerName.isAcceptableOrUnknown(
          data['branch_manager_name']!,
          _branchManagerNameMeta,
        ),
      );
    }
    if (data.containsKey('branch_manager_id')) {
      context.handle(
        _branchManagerIdMeta,
        branchManagerId.isAcceptableOrUnknown(
          data['branch_manager_id']!,
          _branchManagerIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      storeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_id'],
      )!,
      storeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_name'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      branchAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_address'],
      ),
      contact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_deleted'],
      )!,
      companyDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_details'],
      )!,
      branchManagerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_manager_name'],
      ),
      branchManagerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_manager_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branche extends DataClass implements Insertable<Branche> {
  final String id;
  final String storeId;
  final String storeName;
  final String branchName;
  final String? branchAddress;
  final String? contact;
  final int isActive;
  final int isDeleted;
  final String companyDetails;
  final String? branchManagerName;
  final String? branchManagerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Branche({
    required this.id,
    required this.storeId,
    required this.storeName,
    required this.branchName,
    this.branchAddress,
    this.contact,
    required this.isActive,
    required this.isDeleted,
    required this.companyDetails,
    this.branchManagerName,
    this.branchManagerId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['store_id'] = Variable<String>(storeId);
    map['store_name'] = Variable<String>(storeName);
    map['branch_name'] = Variable<String>(branchName);
    if (!nullToAbsent || branchAddress != null) {
      map['branch_address'] = Variable<String>(branchAddress);
    }
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String>(contact);
    }
    map['is_active'] = Variable<int>(isActive);
    map['is_deleted'] = Variable<int>(isDeleted);
    map['company_details'] = Variable<String>(companyDetails);
    if (!nullToAbsent || branchManagerName != null) {
      map['branch_manager_name'] = Variable<String>(branchManagerName);
    }
    if (!nullToAbsent || branchManagerId != null) {
      map['branch_manager_id'] = Variable<String>(branchManagerId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      storeId: Value(storeId),
      storeName: Value(storeName),
      branchName: Value(branchName),
      branchAddress: branchAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(branchAddress),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      companyDetails: Value(companyDetails),
      branchManagerName: branchManagerName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchManagerName),
      branchManagerId: branchManagerId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchManagerId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Branche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branche(
      id: serializer.fromJson<String>(json['id']),
      storeId: serializer.fromJson<String>(json['storeId']),
      storeName: serializer.fromJson<String>(json['storeName']),
      branchName: serializer.fromJson<String>(json['branchName']),
      branchAddress: serializer.fromJson<String?>(json['branchAddress']),
      contact: serializer.fromJson<String?>(json['contact']),
      isActive: serializer.fromJson<int>(json['isActive']),
      isDeleted: serializer.fromJson<int>(json['isDeleted']),
      companyDetails: serializer.fromJson<String>(json['companyDetails']),
      branchManagerName: serializer.fromJson<String?>(
        json['branchManagerName'],
      ),
      branchManagerId: serializer.fromJson<String?>(json['branchManagerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'storeId': serializer.toJson<String>(storeId),
      'storeName': serializer.toJson<String>(storeName),
      'branchName': serializer.toJson<String>(branchName),
      'branchAddress': serializer.toJson<String?>(branchAddress),
      'contact': serializer.toJson<String?>(contact),
      'isActive': serializer.toJson<int>(isActive),
      'isDeleted': serializer.toJson<int>(isDeleted),
      'companyDetails': serializer.toJson<String>(companyDetails),
      'branchManagerName': serializer.toJson<String?>(branchManagerName),
      'branchManagerId': serializer.toJson<String?>(branchManagerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Branche copyWith({
    String? id,
    String? storeId,
    String? storeName,
    String? branchName,
    Value<String?> branchAddress = const Value.absent(),
    Value<String?> contact = const Value.absent(),
    int? isActive,
    int? isDeleted,
    String? companyDetails,
    Value<String?> branchManagerName = const Value.absent(),
    Value<String?> branchManagerId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Branche(
    id: id ?? this.id,
    storeId: storeId ?? this.storeId,
    storeName: storeName ?? this.storeName,
    branchName: branchName ?? this.branchName,
    branchAddress: branchAddress.present
        ? branchAddress.value
        : this.branchAddress,
    contact: contact.present ? contact.value : this.contact,
    isActive: isActive ?? this.isActive,
    isDeleted: isDeleted ?? this.isDeleted,
    companyDetails: companyDetails ?? this.companyDetails,
    branchManagerName: branchManagerName.present
        ? branchManagerName.value
        : this.branchManagerName,
    branchManagerId: branchManagerId.present
        ? branchManagerId.value
        : this.branchManagerId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Branche copyWithCompanion(BranchesCompanion data) {
    return Branche(
      id: data.id.present ? data.id.value : this.id,
      storeId: data.storeId.present ? data.storeId.value : this.storeId,
      storeName: data.storeName.present ? data.storeName.value : this.storeName,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      branchAddress: data.branchAddress.present
          ? data.branchAddress.value
          : this.branchAddress,
      contact: data.contact.present ? data.contact.value : this.contact,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      companyDetails: data.companyDetails.present
          ? data.companyDetails.value
          : this.companyDetails,
      branchManagerName: data.branchManagerName.present
          ? data.branchManagerName.value
          : this.branchManagerName,
      branchManagerId: data.branchManagerId.present
          ? data.branchManagerId.value
          : this.branchManagerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branche(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('storeName: $storeName, ')
          ..write('branchName: $branchName, ')
          ..write('branchAddress: $branchAddress, ')
          ..write('contact: $contact, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('companyDetails: $companyDetails, ')
          ..write('branchManagerName: $branchManagerName, ')
          ..write('branchManagerId: $branchManagerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    storeId,
    storeName,
    branchName,
    branchAddress,
    contact,
    isActive,
    isDeleted,
    companyDetails,
    branchManagerName,
    branchManagerId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branche &&
          other.id == this.id &&
          other.storeId == this.storeId &&
          other.storeName == this.storeName &&
          other.branchName == this.branchName &&
          other.branchAddress == this.branchAddress &&
          other.contact == this.contact &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.companyDetails == this.companyDetails &&
          other.branchManagerName == this.branchManagerName &&
          other.branchManagerId == this.branchManagerId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BranchesCompanion extends UpdateCompanion<Branche> {
  final Value<String> id;
  final Value<String> storeId;
  final Value<String> storeName;
  final Value<String> branchName;
  final Value<String?> branchAddress;
  final Value<String?> contact;
  final Value<int> isActive;
  final Value<int> isDeleted;
  final Value<String> companyDetails;
  final Value<String?> branchManagerName;
  final Value<String?> branchManagerId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.storeName = const Value.absent(),
    this.branchName = const Value.absent(),
    this.branchAddress = const Value.absent(),
    this.contact = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.companyDetails = const Value.absent(),
    this.branchManagerName = const Value.absent(),
    this.branchManagerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    this.id = const Value.absent(),
    required String storeId,
    required String storeName,
    required String branchName,
    this.branchAddress = const Value.absent(),
    this.contact = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required String companyDetails,
    this.branchManagerName = const Value.absent(),
    this.branchManagerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : storeId = Value(storeId),
       storeName = Value(storeName),
       branchName = Value(branchName),
       companyDetails = Value(companyDetails);
  static Insertable<Branche> custom({
    Expression<String>? id,
    Expression<String>? storeId,
    Expression<String>? storeName,
    Expression<String>? branchName,
    Expression<String>? branchAddress,
    Expression<String>? contact,
    Expression<int>? isActive,
    Expression<int>? isDeleted,
    Expression<String>? companyDetails,
    Expression<String>? branchManagerName,
    Expression<String>? branchManagerId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeId != null) 'store_id': storeId,
      if (storeName != null) 'store_name': storeName,
      if (branchName != null) 'branch_name': branchName,
      if (branchAddress != null) 'branch_address': branchAddress,
      if (contact != null) 'contact': contact,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (companyDetails != null) 'company_details': companyDetails,
      if (branchManagerName != null) 'branch_manager_name': branchManagerName,
      if (branchManagerId != null) 'branch_manager_id': branchManagerId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith({
    Value<String>? id,
    Value<String>? storeId,
    Value<String>? storeName,
    Value<String>? branchName,
    Value<String?>? branchAddress,
    Value<String?>? contact,
    Value<int>? isActive,
    Value<int>? isDeleted,
    Value<String>? companyDetails,
    Value<String?>? branchManagerName,
    Value<String?>? branchManagerId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      branchName: branchName ?? this.branchName,
      branchAddress: branchAddress ?? this.branchAddress,
      contact: contact ?? this.contact,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      companyDetails: companyDetails ?? this.companyDetails,
      branchManagerName: branchManagerName ?? this.branchManagerName,
      branchManagerId: branchManagerId ?? this.branchManagerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (storeId.present) {
      map['store_id'] = Variable<String>(storeId.value);
    }
    if (storeName.present) {
      map['store_name'] = Variable<String>(storeName.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (branchAddress.present) {
      map['branch_address'] = Variable<String>(branchAddress.value);
    }
    if (contact.present) {
      map['contact'] = Variable<String>(contact.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<int>(isDeleted.value);
    }
    if (companyDetails.present) {
      map['company_details'] = Variable<String>(companyDetails.value);
    }
    if (branchManagerName.present) {
      map['branch_manager_name'] = Variable<String>(branchManagerName.value);
    }
    if (branchManagerId.present) {
      map['branch_manager_id'] = Variable<String>(branchManagerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('storeName: $storeName, ')
          ..write('branchName: $branchName, ')
          ..write('branchAddress: $branchAddress, ')
          ..write('contact: $contact, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('companyDetails: $companyDetails, ')
          ..write('branchManagerName: $branchManagerName, ')
          ..write('branchManagerId: $branchManagerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoresTable extends Stores with TableInfo<$StoresTable, Store> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Store> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Store(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoresTable createAlias(String alias) {
    return $StoresTable(attachedDatabase, alias);
  }
}

class Store extends DataClass implements Insertable<Store> {
  final String id;
  final String name;
  final String address;
  final int isActive;
  final DateTime createdAt;
  const Store({
    required this.id,
    required this.name,
    required this.address,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Store.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Store(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Store copyWith({
    String? id,
    String? name,
    String? address,
    int? isActive,
    DateTime? createdAt,
  }) => Store(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Store copyWithCompanion(StoresCompanion data) {
    return Store(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<int> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String address,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       address = Value(address);
  static Insertable<Store> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoresCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<int>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _managerIdMeta = const VerificationMeta(
    'managerId',
  );
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
    'manager_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _managerNameMeta = const VerificationMeta(
    'managerName',
  );
  @override
  late final GeneratedColumn<String> managerName = GeneratedColumn<String>(
    'manager_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _hireDateMeta = const VerificationMeta(
    'hireDate',
  );
  @override
  late final GeneratedColumn<DateTime> hireDate = GeneratedColumn<DateTime>(
    'hire_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    middleName,
    email,
    phone,
    role,
    department,
    branchId,
    branchName,
    managerId,
    managerName,
    designation,
    status,
    isActive,
    hireDate,
    endDate,
    address,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    } else if (isInserting) {
      context.missing(_departmentMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    }
    if (data.containsKey('manager_id')) {
      context.handle(
        _managerIdMeta,
        managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta),
      );
    }
    if (data.containsKey('manager_name')) {
      context.handle(
        _managerNameMeta,
        managerName.isAcceptableOrUnknown(
          data['manager_name']!,
          _managerNameMeta,
        ),
      );
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('hire_date')) {
      context.handle(
        _hireDateMeta,
        hireDate.isAcceptableOrUnknown(data['hire_date']!, _hireDateMeta),
      );
    } else if (isInserting) {
      context.missing(_hireDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      ),
      managerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_id'],
      ),
      managerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_name'],
      ),
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      hireDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hire_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final String id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String email;
  final String phone;
  final String role;
  final String department;
  final String? branchId;
  final String? branchName;
  final String? managerId;
  final String? managerName;
  final String? designation;
  final String status;
  final int isActive;
  final DateTime hireDate;
  final DateTime? endDate;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.email,
    required this.phone,
    required this.role,
    required this.department,
    this.branchId,
    this.branchName,
    this.managerId,
    this.managerName,
    this.designation,
    required this.status,
    required this.isActive,
    required this.hireDate,
    this.endDate,
    this.address,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || middleName != null) {
      map['middle_name'] = Variable<String>(middleName);
    }
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['role'] = Variable<String>(role);
    map['department'] = Variable<String>(department);
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    if (!nullToAbsent || managerId != null) {
      map['manager_id'] = Variable<String>(managerId);
    }
    if (!nullToAbsent || managerName != null) {
      map['manager_name'] = Variable<String>(managerName);
    }
    if (!nullToAbsent || designation != null) {
      map['designation'] = Variable<String>(designation);
    }
    map['status'] = Variable<String>(status);
    map['is_active'] = Variable<int>(isActive);
    map['hire_date'] = Variable<DateTime>(hireDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      middleName: middleName == null && nullToAbsent
          ? const Value.absent()
          : Value(middleName),
      email: Value(email),
      phone: Value(phone),
      role: Value(role),
      department: Value(department),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      managerId: managerId == null && nullToAbsent
          ? const Value.absent()
          : Value(managerId),
      managerName: managerName == null && nullToAbsent
          ? const Value.absent()
          : Value(managerName),
      designation: designation == null && nullToAbsent
          ? const Value.absent()
          : Value(designation),
      status: Value(status),
      isActive: Value(isActive),
      hireDate: Value(hireDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      middleName: serializer.fromJson<String?>(json['middleName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      department: serializer.fromJson<String>(json['department']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      managerId: serializer.fromJson<String?>(json['managerId']),
      managerName: serializer.fromJson<String?>(json['managerName']),
      designation: serializer.fromJson<String?>(json['designation']),
      status: serializer.fromJson<String>(json['status']),
      isActive: serializer.fromJson<int>(json['isActive']),
      hireDate: serializer.fromJson<DateTime>(json['hireDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'middleName': serializer.toJson<String?>(middleName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'role': serializer.toJson<String>(role),
      'department': serializer.toJson<String>(department),
      'branchId': serializer.toJson<String?>(branchId),
      'branchName': serializer.toJson<String?>(branchName),
      'managerId': serializer.toJson<String?>(managerId),
      'managerName': serializer.toJson<String?>(managerName),
      'designation': serializer.toJson<String?>(designation),
      'status': serializer.toJson<String>(status),
      'isActive': serializer.toJson<int>(isActive),
      'hireDate': serializer.toJson<DateTime>(hireDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Employee copyWith({
    String? id,
    String? firstName,
    String? lastName,
    Value<String?> middleName = const Value.absent(),
    String? email,
    String? phone,
    String? role,
    String? department,
    Value<String?> branchId = const Value.absent(),
    Value<String?> branchName = const Value.absent(),
    Value<String?> managerId = const Value.absent(),
    Value<String?> managerName = const Value.absent(),
    Value<String?> designation = const Value.absent(),
    String? status,
    int? isActive,
    DateTime? hireDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Employee(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    middleName: middleName.present ? middleName.value : this.middleName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    department: department ?? this.department,
    branchId: branchId.present ? branchId.value : this.branchId,
    branchName: branchName.present ? branchName.value : this.branchName,
    managerId: managerId.present ? managerId.value : this.managerId,
    managerName: managerName.present ? managerName.value : this.managerName,
    designation: designation.present ? designation.value : this.designation,
    status: status ?? this.status,
    isActive: isActive ?? this.isActive,
    hireDate: hireDate ?? this.hireDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      department: data.department.present
          ? data.department.value
          : this.department,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      managerName: data.managerName.present
          ? data.managerName.value
          : this.managerName,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      status: data.status.present ? data.status.value : this.status,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      hireDate: data.hireDate.present ? data.hireDate.value : this.hireDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('middleName: $middleName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('department: $department, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('managerId: $managerId, ')
          ..write('managerName: $managerName, ')
          ..write('designation: $designation, ')
          ..write('status: $status, ')
          ..write('isActive: $isActive, ')
          ..write('hireDate: $hireDate, ')
          ..write('endDate: $endDate, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    firstName,
    lastName,
    middleName,
    email,
    phone,
    role,
    department,
    branchId,
    branchName,
    managerId,
    managerName,
    designation,
    status,
    isActive,
    hireDate,
    endDate,
    address,
    notes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.middleName == this.middleName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.department == this.department &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.managerId == this.managerId &&
          other.managerName == this.managerName &&
          other.designation == this.designation &&
          other.status == this.status &&
          other.isActive == this.isActive &&
          other.hireDate == this.hireDate &&
          other.endDate == this.endDate &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> middleName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> role;
  final Value<String> department;
  final Value<String?> branchId;
  final Value<String?> branchName;
  final Value<String?> managerId;
  final Value<String?> managerName;
  final Value<String?> designation;
  final Value<String> status;
  final Value<int> isActive;
  final Value<DateTime> hireDate;
  final Value<DateTime?> endDate;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.department = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.managerId = const Value.absent(),
    this.managerName = const Value.absent(),
    this.designation = const Value.absent(),
    this.status = const Value.absent(),
    this.isActive = const Value.absent(),
    this.hireDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    this.middleName = const Value.absent(),
    required String email,
    required String phone,
    required String role,
    required String department,
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.managerId = const Value.absent(),
    this.managerName = const Value.absent(),
    this.designation = const Value.absent(),
    this.status = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime hireDate,
    this.endDate = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       email = Value(email),
       phone = Value(phone),
       role = Value(role),
       department = Value(department),
       hireDate = Value(hireDate);
  static Insertable<Employee> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? middleName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<String>? department,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<String>? managerId,
    Expression<String>? managerName,
    Expression<String>? designation,
    Expression<String>? status,
    Expression<int>? isActive,
    Expression<DateTime>? hireDate,
    Expression<DateTime>? endDate,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (middleName != null) 'middle_name': middleName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (department != null) 'department': department,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (managerId != null) 'manager_id': managerId,
      if (managerName != null) 'manager_name': managerName,
      if (designation != null) 'designation': designation,
      if (status != null) 'status': status,
      if (isActive != null) 'is_active': isActive,
      if (hireDate != null) 'hire_date': hireDate,
      if (endDate != null) 'end_date': endDate,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeesCompanion copyWith({
    Value<String>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? middleName,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? role,
    Value<String>? department,
    Value<String?>? branchId,
    Value<String?>? branchName,
    Value<String?>? managerId,
    Value<String?>? managerName,
    Value<String?>? designation,
    Value<String>? status,
    Value<int>? isActive,
    Value<DateTime>? hireDate,
    Value<DateTime?>? endDate,
    Value<String?>? address,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      department: department ?? this.department,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      designation: designation ?? this.designation,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      hireDate: hireDate ?? this.hireDate,
      endDate: endDate ?? this.endDate,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (managerName.present) {
      map['manager_name'] = Variable<String>(managerName.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (hireDate.present) {
      map['hire_date'] = Variable<DateTime>(hireDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('middleName: $middleName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('department: $department, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('managerId: $managerId, ')
          ..write('managerName: $managerName, ')
          ..write('designation: $designation, ')
          ..write('status: $status, ')
          ..write('isActive: $isActive, ')
          ..write('hireDate: $hireDate, ')
          ..write('endDate: $endDate, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _segmentMeta = const VerificationMeta(
    'segment',
  );
  @override
  late final GeneratedColumn<String> segment = GeneratedColumn<String>(
    'segment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordersCountMeta = const VerificationMeta(
    'ordersCount',
  );
  @override
  late final GeneratedColumn<int> ordersCount = GeneratedColumn<int>(
    'orders_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lifetimeValueMeta = const VerificationMeta(
    'lifetimeValue',
  );
  @override
  late final GeneratedColumn<double> lifetimeValue = GeneratedColumn<double>(
    'lifetime_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastOrderDateMeta = const VerificationMeta(
    'lastOrderDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastOrderDate =
      GeneratedColumn<DateTime>(
        'last_order_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    phone,
    segment,
    ordersCount,
    lifetimeValue,
    lastOrderDate,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('segment')) {
      context.handle(
        _segmentMeta,
        segment.isAcceptableOrUnknown(data['segment']!, _segmentMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentMeta);
    }
    if (data.containsKey('orders_count')) {
      context.handle(
        _ordersCountMeta,
        ordersCount.isAcceptableOrUnknown(
          data['orders_count']!,
          _ordersCountMeta,
        ),
      );
    }
    if (data.containsKey('lifetime_value')) {
      context.handle(
        _lifetimeValueMeta,
        lifetimeValue.isAcceptableOrUnknown(
          data['lifetime_value']!,
          _lifetimeValueMeta,
        ),
      );
    }
    if (data.containsKey('last_order_date')) {
      context.handle(
        _lastOrderDateMeta,
        lastOrderDate.isAcceptableOrUnknown(
          data['last_order_date']!,
          _lastOrderDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastOrderDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      segment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segment'],
      )!,
      ordersCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orders_count'],
      )!,
      lifetimeValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lifetime_value'],
      )!,
      lastOrderDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_order_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String segment;
  final int ordersCount;
  final double lifetimeValue;
  final DateTime lastOrderDate;
  final String status;
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.segment,
    required this.ordersCount,
    required this.lifetimeValue,
    required this.lastOrderDate,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['segment'] = Variable<String>(segment);
    map['orders_count'] = Variable<int>(ordersCount);
    map['lifetime_value'] = Variable<double>(lifetimeValue);
    map['last_order_date'] = Variable<DateTime>(lastOrderDate);
    map['status'] = Variable<String>(status);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      phone: Value(phone),
      segment: Value(segment),
      ordersCount: Value(ordersCount),
      lifetimeValue: Value(lifetimeValue),
      lastOrderDate: Value(lastOrderDate),
      status: Value(status),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      segment: serializer.fromJson<String>(json['segment']),
      ordersCount: serializer.fromJson<int>(json['ordersCount']),
      lifetimeValue: serializer.fromJson<double>(json['lifetimeValue']),
      lastOrderDate: serializer.fromJson<DateTime>(json['lastOrderDate']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'segment': serializer.toJson<String>(segment),
      'ordersCount': serializer.toJson<int>(ordersCount),
      'lifetimeValue': serializer.toJson<double>(lifetimeValue),
      'lastOrderDate': serializer.toJson<DateTime>(lastOrderDate),
      'status': serializer.toJson<String>(status),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? segment,
    int? ordersCount,
    double? lifetimeValue,
    DateTime? lastOrderDate,
    String? status,
  }) => Customer(
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
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      segment: data.segment.present ? data.segment.value : this.segment,
      ordersCount: data.ordersCount.present
          ? data.ordersCount.value
          : this.ordersCount,
      lifetimeValue: data.lifetimeValue.present
          ? data.lifetimeValue.value
          : this.lifetimeValue,
      lastOrderDate: data.lastOrderDate.present
          ? data.lastOrderDate.value
          : this.lastOrderDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('segment: $segment, ')
          ..write('ordersCount: $ordersCount, ')
          ..write('lifetimeValue: $lifetimeValue, ')
          ..write('lastOrderDate: $lastOrderDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    phone,
    segment,
    ordersCount,
    lifetimeValue,
    lastOrderDate,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.segment == this.segment &&
          other.ordersCount == this.ordersCount &&
          other.lifetimeValue == this.lifetimeValue &&
          other.lastOrderDate == this.lastOrderDate &&
          other.status == this.status);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> segment;
  final Value<int> ordersCount;
  final Value<double> lifetimeValue;
  final Value<DateTime> lastOrderDate;
  final Value<String> status;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.segment = const Value.absent(),
    this.ordersCount = const Value.absent(),
    this.lifetimeValue = const Value.absent(),
    this.lastOrderDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String phone,
    required String segment,
    this.ordersCount = const Value.absent(),
    this.lifetimeValue = const Value.absent(),
    required DateTime lastOrderDate,
    required String status,
  }) : name = Value(name),
       email = Value(email),
       phone = Value(phone),
       segment = Value(segment),
       lastOrderDate = Value(lastOrderDate),
       status = Value(status);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? segment,
    Expression<int>? ordersCount,
    Expression<double>? lifetimeValue,
    Expression<DateTime>? lastOrderDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (segment != null) 'segment': segment,
      if (ordersCount != null) 'orders_count': ordersCount,
      if (lifetimeValue != null) 'lifetime_value': lifetimeValue,
      if (lastOrderDate != null) 'last_order_date': lastOrderDate,
      if (status != null) 'status': status,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? segment,
    Value<int>? ordersCount,
    Value<double>? lifetimeValue,
    Value<DateTime>? lastOrderDate,
    Value<String>? status,
  }) {
    return CustomersCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (segment.present) {
      map['segment'] = Variable<String>(segment.value);
    }
    if (ordersCount.present) {
      map['orders_count'] = Variable<int>(ordersCount.value);
    }
    if (lifetimeValue.present) {
      map['lifetime_value'] = Variable<double>(lifetimeValue.value);
    }
    if (lastOrderDate.present) {
      map['last_order_date'] = Variable<DateTime>(lastOrderDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('segment: $segment, ')
          ..write('ordersCount: $ordersCount, ')
          ..write('lifetimeValue: $lifetimeValue, ')
          ..write('lastOrderDate: $lastOrderDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TaxesTable extends Taxes with TableInfo<$TaxesTable, Taxe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valuePercentageMeta = const VerificationMeta(
    'valuePercentage',
  );
  @override
  late final GeneratedColumn<double> valuePercentage = GeneratedColumn<double>(
    'value_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, valuePercentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Taxe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value_percentage')) {
      context.handle(
        _valuePercentageMeta,
        valuePercentage.isAcceptableOrUnknown(
          data['value_percentage']!,
          _valuePercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_valuePercentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Taxe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Taxe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      valuePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value_percentage'],
      )!,
    );
  }

  @override
  $TaxesTable createAlias(String alias) {
    return $TaxesTable(attachedDatabase, alias);
  }
}

class Taxe extends DataClass implements Insertable<Taxe> {
  final String id;
  final String name;
  final double valuePercentage;
  const Taxe({
    required this.id,
    required this.name,
    required this.valuePercentage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['value_percentage'] = Variable<double>(valuePercentage);
    return map;
  }

  TaxesCompanion toCompanion(bool nullToAbsent) {
    return TaxesCompanion(
      id: Value(id),
      name: Value(name),
      valuePercentage: Value(valuePercentage),
    );
  }

  factory Taxe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Taxe(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      valuePercentage: serializer.fromJson<double>(json['valuePercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'valuePercentage': serializer.toJson<double>(valuePercentage),
    };
  }

  Taxe copyWith({String? id, String? name, double? valuePercentage}) => Taxe(
    id: id ?? this.id,
    name: name ?? this.name,
    valuePercentage: valuePercentage ?? this.valuePercentage,
  );
  Taxe copyWithCompanion(TaxesCompanion data) {
    return Taxe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      valuePercentage: data.valuePercentage.present
          ? data.valuePercentage.value
          : this.valuePercentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Taxe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('valuePercentage: $valuePercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, valuePercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Taxe &&
          other.id == this.id &&
          other.name == this.name &&
          other.valuePercentage == this.valuePercentage);
}

class TaxesCompanion extends UpdateCompanion<Taxe> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> valuePercentage;
  final Value<int> rowid;
  const TaxesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.valuePercentage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaxesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double valuePercentage,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       valuePercentage = Value(valuePercentage);
  static Insertable<Taxe> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? valuePercentage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (valuePercentage != null) 'value_percentage': valuePercentage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaxesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? valuePercentage,
    Value<int>? rowid,
  }) {
    return TaxesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      valuePercentage: valuePercentage ?? this.valuePercentage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (valuePercentage.present) {
      map['value_percentage'] = Variable<double>(valuePercentage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('valuePercentage: $valuePercentage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierCodeMeta = const VerificationMeta(
    'supplierCode',
  );
  @override
  late final GeneratedColumn<String> supplierCode = GeneratedColumn<String>(
    'supplier_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    supplierCode,
    contactName,
    email,
    phone,
    address,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('supplier_code')) {
      context.handle(
        _supplierCodeMeta,
        supplierCode.isAcceptableOrUnknown(
          data['supplier_code']!,
          _supplierCodeMeta,
        ),
      );
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      supplierCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_code'],
      ),
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String id;
  final String name;
  final String? supplierCode;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? address;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Supplier({
    required this.id,
    required this.name,
    this.supplierCode,
    this.contactName,
    this.email,
    this.phone,
    this.address,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || supplierCode != null) {
      map['supplier_code'] = Variable<String>(supplierCode);
    }
    if (!nullToAbsent || contactName != null) {
      map['contact_name'] = Variable<String>(contactName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      supplierCode: supplierCode == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierCode),
      contactName: contactName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      supplierCode: serializer.fromJson<String?>(json['supplierCode']),
      contactName: serializer.fromJson<String?>(json['contactName']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'supplierCode': serializer.toJson<String?>(supplierCode),
      'contactName': serializer.toJson<String?>(contactName),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Supplier copyWith({
    String? id,
    String? name,
    Value<String?> supplierCode = const Value.absent(),
    Value<String?> contactName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Supplier(
    id: id ?? this.id,
    name: name ?? this.name,
    supplierCode: supplierCode.present ? supplierCode.value : this.supplierCode,
    contactName: contactName.present ? contactName.value : this.contactName,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      supplierCode: data.supplierCode.present
          ? data.supplierCode.value
          : this.supplierCode,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    supplierCode,
    contactName,
    email,
    phone,
    address,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.supplierCode == this.supplierCode &&
          other.contactName == this.contactName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> supplierCode;
  final Value<String?> contactName;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<int> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.supplierCode = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.supplierCode = const Value.absent(),
    this.contactName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? supplierCode,
    Expression<String>? contactName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (supplierCode != null) 'supplier_code': supplierCode,
      if (contactName != null) 'contact_name': contactName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? supplierCode,
    Value<String?>? contactName,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<int>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      supplierCode: supplierCode ?? this.supplierCode,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (supplierCode.present) {
      map['supplier_code'] = Variable<String>(supplierCode.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('supplierCode: $supplierCode, ')
          ..write('contactName: $contactName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductBrandsTable extends ProductBrands
    with TableInfo<$ProductBrandsTable, ProductBrand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductBrandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductBrand> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductBrand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductBrand(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductBrandsTable createAlias(String alias) {
    return $ProductBrandsTable(attachedDatabase, alias);
  }
}

class ProductBrand extends DataClass implements Insertable<ProductBrand> {
  final String id;
  final String name;
  final DateTime createdAt;
  const ProductBrand({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductBrandsCompanion toCompanion(bool nullToAbsent) {
    return ProductBrandsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory ProductBrand.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductBrand(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductBrand copyWith({String? id, String? name, DateTime? createdAt}) =>
      ProductBrand(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  ProductBrand copyWithCompanion(ProductBrandsCompanion data) {
    return ProductBrand(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductBrand(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductBrand &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class ProductBrandsCompanion extends UpdateCompanion<ProductBrand> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductBrandsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductBrandsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProductBrand> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductBrandsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductBrandsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductBrandsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoriesTable extends ProductCategories
    with TableInfo<$ProductCategoriesTable, ProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final String id;
  final String name;
  final DateTime createdAt;
  const ProductCategory({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory ProductCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductCategory copyWith({String? id, String? name, DateTime? createdAt}) =>
      ProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  ProductCategory copyWithCompanion(ProductCategoriesCompanion data) {
    return ProductCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProductCategory> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductSubCategoriesTable extends ProductSubCategories
    with TableInfo<$ProductSubCategoriesTable, ProductSubCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductSubCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_sub_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductSubCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductSubCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductSubCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductSubCategoriesTable createAlias(String alias) {
    return $ProductSubCategoriesTable(attachedDatabase, alias);
  }
}

class ProductSubCategory extends DataClass
    implements Insertable<ProductSubCategory> {
  final String id;
  final String categoryId;
  final String name;
  final DateTime createdAt;
  const ProductSubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductSubCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductSubCategoriesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory ProductSubCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductSubCategory(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductSubCategory copyWith({
    String? id,
    String? categoryId,
    String? name,
    DateTime? createdAt,
  }) => ProductSubCategory(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductSubCategory copyWithCompanion(ProductSubCategoriesCompanion data) {
    return ProductSubCategory(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductSubCategory(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductSubCategory &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class ProductSubCategoriesCompanion
    extends UpdateCompanion<ProductSubCategory> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProductSubCategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductSubCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String categoryId,
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name);
  static Insertable<ProductSubCategory> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductSubCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProductSubCategoriesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductSubCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subCategoryMeta = const VerificationMeta(
    'subCategory',
  );
  @override
  late final GeneratedColumn<String> subCategory = GeneratedColumn<String>(
    'sub_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thicknessMeta = const VerificationMeta(
    'thickness',
  );
  @override
  late final GeneratedColumn<String> thickness = GeneratedColumn<String>(
    'thickness',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _materialMeta = const VerificationMeta(
    'material',
  );
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
    'material',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _densityMeta = const VerificationMeta(
    'density',
  );
  @override
  late final GeneratedColumn<String> density = GeneratedColumn<String>(
    'density',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<String> brandId = GeneratedColumn<String>(
    'brand_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _retailPriceMeta = const VerificationMeta(
    'retailPrice',
  );
  @override
  late final GeneratedColumn<double> retailPrice = GeneratedColumn<double>(
    'retail_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPriceMeta = const VerificationMeta(
    'discountPrice',
  );
  @override
  late final GeneratedColumn<double> discountPrice = GeneratedColumn<double>(
    'discount_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<int> isAvailable = GeneratedColumn<int>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sku,
    category,
    categoryId,
    subCategory,
    size,
    thickness,
    material,
    density,
    brand,
    brandId,
    supplier,
    supplierId,
    retailPrice,
    discountPrice,
    discountPercentage,
    quantity,
    unit,
    branchId,
    isAvailable,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('sub_category')) {
      context.handle(
        _subCategoryMeta,
        subCategory.isAcceptableOrUnknown(
          data['sub_category']!,
          _subCategoryMeta,
        ),
      );
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('thickness')) {
      context.handle(
        _thicknessMeta,
        thickness.isAcceptableOrUnknown(data['thickness']!, _thicknessMeta),
      );
    }
    if (data.containsKey('material')) {
      context.handle(
        _materialMeta,
        material.isAcceptableOrUnknown(data['material']!, _materialMeta),
      );
    }
    if (data.containsKey('density')) {
      context.handle(
        _densityMeta,
        density.isAcceptableOrUnknown(data['density']!, _densityMeta),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('retail_price')) {
      context.handle(
        _retailPriceMeta,
        retailPrice.isAcceptableOrUnknown(
          data['retail_price']!,
          _retailPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_retailPriceMeta);
    }
    if (data.containsKey('discount_price')) {
      context.handle(
        _discountPriceMeta,
        discountPrice.isAcceptableOrUnknown(
          data['discount_price']!,
          _discountPriceMeta,
        ),
      );
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discountPercentageMeta,
        discountPercentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discountPercentageMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      subCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_category'],
      ),
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      thickness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thickness'],
      ),
      material: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material'],
      ),
      density: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}density'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand_id'],
      ),
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      ),
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      retailPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}retail_price'],
      )!,
      discountPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_price'],
      ),
      discountPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percentage'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_available'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String id;
  final String name;
  final String sku;
  final String? category;
  final String? categoryId;
  final String? subCategory;
  final String? size;
  final String? thickness;
  final String? material;
  final String? density;
  final String? brand;
  final String? brandId;
  final String? supplier;
  final String? supplierId;
  final double retailPrice;
  final double? discountPrice;
  final double? discountPercentage;
  final int quantity;
  final String? unit;
  final String? branchId;
  final int isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const InventoryItem({
    required this.id,
    required this.name,
    required this.sku,
    this.category,
    this.categoryId,
    this.subCategory,
    this.size,
    this.thickness,
    this.material,
    this.density,
    this.brand,
    this.brandId,
    this.supplier,
    this.supplierId,
    required this.retailPrice,
    this.discountPrice,
    this.discountPercentage,
    required this.quantity,
    this.unit,
    this.branchId,
    required this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sku'] = Variable<String>(sku);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || subCategory != null) {
      map['sub_category'] = Variable<String>(subCategory);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || thickness != null) {
      map['thickness'] = Variable<String>(thickness);
    }
    if (!nullToAbsent || material != null) {
      map['material'] = Variable<String>(material);
    }
    if (!nullToAbsent || density != null) {
      map['density'] = Variable<String>(density);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<String>(brandId);
    }
    if (!nullToAbsent || supplier != null) {
      map['supplier'] = Variable<String>(supplier);
    }
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    map['retail_price'] = Variable<double>(retailPrice);
    if (!nullToAbsent || discountPrice != null) {
      map['discount_price'] = Variable<double>(discountPrice);
    }
    if (!nullToAbsent || discountPercentage != null) {
      map['discount_percentage'] = Variable<double>(discountPercentage);
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    map['is_available'] = Variable<int>(isAvailable);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      id: Value(id),
      name: Value(name),
      sku: Value(sku),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      subCategory: subCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subCategory),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      thickness: thickness == null && nullToAbsent
          ? const Value.absent()
          : Value(thickness),
      material: material == null && nullToAbsent
          ? const Value.absent()
          : Value(material),
      density: density == null && nullToAbsent
          ? const Value.absent()
          : Value(density),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      supplier: supplier == null && nullToAbsent
          ? const Value.absent()
          : Value(supplier),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      retailPrice: Value(retailPrice),
      discountPrice: discountPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPrice),
      discountPercentage: discountPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercentage),
      quantity: Value(quantity),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      isAvailable: Value(isAvailable),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String>(json['sku']),
      category: serializer.fromJson<String?>(json['category']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      subCategory: serializer.fromJson<String?>(json['subCategory']),
      size: serializer.fromJson<String?>(json['size']),
      thickness: serializer.fromJson<String?>(json['thickness']),
      material: serializer.fromJson<String?>(json['material']),
      density: serializer.fromJson<String?>(json['density']),
      brand: serializer.fromJson<String?>(json['brand']),
      brandId: serializer.fromJson<String?>(json['brandId']),
      supplier: serializer.fromJson<String?>(json['supplier']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      retailPrice: serializer.fromJson<double>(json['retailPrice']),
      discountPrice: serializer.fromJson<double?>(json['discountPrice']),
      discountPercentage: serializer.fromJson<double?>(
        json['discountPercentage'],
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
      unit: serializer.fromJson<String?>(json['unit']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      isAvailable: serializer.fromJson<int>(json['isAvailable']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String>(sku),
      'category': serializer.toJson<String?>(category),
      'categoryId': serializer.toJson<String?>(categoryId),
      'subCategory': serializer.toJson<String?>(subCategory),
      'size': serializer.toJson<String?>(size),
      'thickness': serializer.toJson<String?>(thickness),
      'material': serializer.toJson<String?>(material),
      'density': serializer.toJson<String?>(density),
      'brand': serializer.toJson<String?>(brand),
      'brandId': serializer.toJson<String?>(brandId),
      'supplier': serializer.toJson<String?>(supplier),
      'supplierId': serializer.toJson<String?>(supplierId),
      'retailPrice': serializer.toJson<double>(retailPrice),
      'discountPrice': serializer.toJson<double?>(discountPrice),
      'discountPercentage': serializer.toJson<double?>(discountPercentage),
      'quantity': serializer.toJson<int>(quantity),
      'unit': serializer.toJson<String?>(unit),
      'branchId': serializer.toJson<String?>(branchId),
      'isAvailable': serializer.toJson<int>(isAvailable),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  InventoryItem copyWith({
    String? id,
    String? name,
    String? sku,
    Value<String?> category = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> subCategory = const Value.absent(),
    Value<String?> size = const Value.absent(),
    Value<String?> thickness = const Value.absent(),
    Value<String?> material = const Value.absent(),
    Value<String?> density = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    Value<String?> brandId = const Value.absent(),
    Value<String?> supplier = const Value.absent(),
    Value<String?> supplierId = const Value.absent(),
    double? retailPrice,
    Value<double?> discountPrice = const Value.absent(),
    Value<double?> discountPercentage = const Value.absent(),
    int? quantity,
    Value<String?> unit = const Value.absent(),
    Value<String?> branchId = const Value.absent(),
    int? isAvailable,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => InventoryItem(
    id: id ?? this.id,
    name: name ?? this.name,
    sku: sku ?? this.sku,
    category: category.present ? category.value : this.category,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    subCategory: subCategory.present ? subCategory.value : this.subCategory,
    size: size.present ? size.value : this.size,
    thickness: thickness.present ? thickness.value : this.thickness,
    material: material.present ? material.value : this.material,
    density: density.present ? density.value : this.density,
    brand: brand.present ? brand.value : this.brand,
    brandId: brandId.present ? brandId.value : this.brandId,
    supplier: supplier.present ? supplier.value : this.supplier,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    retailPrice: retailPrice ?? this.retailPrice,
    discountPrice: discountPrice.present
        ? discountPrice.value
        : this.discountPrice,
    discountPercentage: discountPercentage.present
        ? discountPercentage.value
        : this.discountPercentage,
    quantity: quantity ?? this.quantity,
    unit: unit.present ? unit.value : this.unit,
    branchId: branchId.present ? branchId.value : this.branchId,
    isAvailable: isAvailable ?? this.isAvailable,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      category: data.category.present ? data.category.value : this.category,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      subCategory: data.subCategory.present
          ? data.subCategory.value
          : this.subCategory,
      size: data.size.present ? data.size.value : this.size,
      thickness: data.thickness.present ? data.thickness.value : this.thickness,
      material: data.material.present ? data.material.value : this.material,
      density: data.density.present ? data.density.value : this.density,
      brand: data.brand.present ? data.brand.value : this.brand,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      retailPrice: data.retailPrice.present
          ? data.retailPrice.value
          : this.retailPrice,
      discountPrice: data.discountPrice.present
          ? data.discountPrice.value
          : this.discountPrice,
      discountPercentage: data.discountPercentage.present
          ? data.discountPercentage.value
          : this.discountPercentage,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('category: $category, ')
          ..write('categoryId: $categoryId, ')
          ..write('subCategory: $subCategory, ')
          ..write('size: $size, ')
          ..write('thickness: $thickness, ')
          ..write('material: $material, ')
          ..write('density: $density, ')
          ..write('brand: $brand, ')
          ..write('brandId: $brandId, ')
          ..write('supplier: $supplier, ')
          ..write('supplierId: $supplierId, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('discountPrice: $discountPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('branchId: $branchId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    sku,
    category,
    categoryId,
    subCategory,
    size,
    thickness,
    material,
    density,
    brand,
    brandId,
    supplier,
    supplierId,
    retailPrice,
    discountPrice,
    discountPercentage,
    quantity,
    unit,
    branchId,
    isAvailable,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.category == this.category &&
          other.categoryId == this.categoryId &&
          other.subCategory == this.subCategory &&
          other.size == this.size &&
          other.thickness == this.thickness &&
          other.material == this.material &&
          other.density == this.density &&
          other.brand == this.brand &&
          other.brandId == this.brandId &&
          other.supplier == this.supplier &&
          other.supplierId == this.supplierId &&
          other.retailPrice == this.retailPrice &&
          other.discountPrice == this.discountPrice &&
          other.discountPercentage == this.discountPercentage &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.branchId == this.branchId &&
          other.isAvailable == this.isAvailable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> sku;
  final Value<String?> category;
  final Value<String?> categoryId;
  final Value<String?> subCategory;
  final Value<String?> size;
  final Value<String?> thickness;
  final Value<String?> material;
  final Value<String?> density;
  final Value<String?> brand;
  final Value<String?> brandId;
  final Value<String?> supplier;
  final Value<String?> supplierId;
  final Value<double> retailPrice;
  final Value<double?> discountPrice;
  final Value<double?> discountPercentage;
  final Value<int> quantity;
  final Value<String?> unit;
  final Value<String?> branchId;
  final Value<int> isAvailable;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.category = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subCategory = const Value.absent(),
    this.size = const Value.absent(),
    this.thickness = const Value.absent(),
    this.material = const Value.absent(),
    this.density = const Value.absent(),
    this.brand = const Value.absent(),
    this.brandId = const Value.absent(),
    this.supplier = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.retailPrice = const Value.absent(),
    this.discountPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.branchId = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String sku,
    this.category = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.subCategory = const Value.absent(),
    this.size = const Value.absent(),
    this.thickness = const Value.absent(),
    this.material = const Value.absent(),
    this.density = const Value.absent(),
    this.brand = const Value.absent(),
    this.brandId = const Value.absent(),
    this.supplier = const Value.absent(),
    this.supplierId = const Value.absent(),
    required double retailPrice,
    this.discountPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    required int quantity,
    this.unit = const Value.absent(),
    this.branchId = const Value.absent(),
    this.isAvailable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       sku = Value(sku),
       retailPrice = Value(retailPrice),
       quantity = Value(quantity);
  static Insertable<InventoryItem> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? category,
    Expression<String>? categoryId,
    Expression<String>? subCategory,
    Expression<String>? size,
    Expression<String>? thickness,
    Expression<String>? material,
    Expression<String>? density,
    Expression<String>? brand,
    Expression<String>? brandId,
    Expression<String>? supplier,
    Expression<String>? supplierId,
    Expression<double>? retailPrice,
    Expression<double>? discountPrice,
    Expression<double>? discountPercentage,
    Expression<int>? quantity,
    Expression<String>? unit,
    Expression<String>? branchId,
    Expression<int>? isAvailable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (category != null) 'category': category,
      if (categoryId != null) 'category_id': categoryId,
      if (subCategory != null) 'sub_category': subCategory,
      if (size != null) 'size': size,
      if (thickness != null) 'thickness': thickness,
      if (material != null) 'material': material,
      if (density != null) 'density': density,
      if (brand != null) 'brand': brand,
      if (brandId != null) 'brand_id': brandId,
      if (supplier != null) 'supplier': supplier,
      if (supplierId != null) 'supplier_id': supplierId,
      if (retailPrice != null) 'retail_price': retailPrice,
      if (discountPrice != null) 'discount_price': discountPrice,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (branchId != null) 'branch_id': branchId,
      if (isAvailable != null) 'is_available': isAvailable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? sku,
    Value<String?>? category,
    Value<String?>? categoryId,
    Value<String?>? subCategory,
    Value<String?>? size,
    Value<String?>? thickness,
    Value<String?>? material,
    Value<String?>? density,
    Value<String?>? brand,
    Value<String?>? brandId,
    Value<String?>? supplier,
    Value<String?>? supplierId,
    Value<double>? retailPrice,
    Value<double?>? discountPrice,
    Value<double?>? discountPercentage,
    Value<int>? quantity,
    Value<String?>? unit,
    Value<String?>? branchId,
    Value<int>? isAvailable,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      subCategory: subCategory ?? this.subCategory,
      size: size ?? this.size,
      thickness: thickness ?? this.thickness,
      material: material ?? this.material,
      density: density ?? this.density,
      brand: brand ?? this.brand,
      brandId: brandId ?? this.brandId,
      supplier: supplier ?? this.supplier,
      supplierId: supplierId ?? this.supplierId,
      retailPrice: retailPrice ?? this.retailPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      branchId: branchId ?? this.branchId,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (subCategory.present) {
      map['sub_category'] = Variable<String>(subCategory.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (thickness.present) {
      map['thickness'] = Variable<String>(thickness.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (density.present) {
      map['density'] = Variable<String>(density.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<String>(brandId.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (retailPrice.present) {
      map['retail_price'] = Variable<double>(retailPrice.value);
    }
    if (discountPrice.present) {
      map['discount_price'] = Variable<double>(discountPrice.value);
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<int>(isAvailable.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('category: $category, ')
          ..write('categoryId: $categoryId, ')
          ..write('subCategory: $subCategory, ')
          ..write('size: $size, ')
          ..write('thickness: $thickness, ')
          ..write('material: $material, ')
          ..write('density: $density, ')
          ..write('brand: $brand, ')
          ..write('brandId: $brandId, ')
          ..write('supplier: $supplier, ')
          ..write('supplierId: $supplierId, ')
          ..write('retailPrice: $retailPrice, ')
          ..write('discountPrice: $discountPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('branchId: $branchId, ')
          ..write('isAvailable: $isAvailable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleOrdersTable extends SaleOrders
    with TableInfo<$SaleOrdersTable, SaleOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalQuantityMeta = const VerificationMeta(
    'totalQuantity',
  );
  @override
  late final GeneratedColumn<int> totalQuantity = GeneratedColumn<int>(
    'total_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderNumber,
    customerName,
    channel,
    branchId,
    branchName,
    totalQuantity,
    totalAmount,
    discountAmount,
    taxAmount,
    status,
    isSynced,
    createdBy,
    createdAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
        _totalQuantityMeta,
        totalQuantity.isAcceptableOrUnknown(
          data['total_quantity']!,
          _totalQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuantityMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      ),
      totalQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_quantity'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SaleOrdersTable createAlias(String alias) {
    return $SaleOrdersTable(attachedDatabase, alias);
  }
}

class SaleOrder extends DataClass implements Insertable<SaleOrder> {
  final String id;
  final String orderNumber;
  final String? customerName;
  final String? channel;
  final String? branchId;
  final String? branchName;
  final int totalQuantity;
  final double totalAmount;
  final double discountAmount;
  final double taxAmount;
  final String status;
  final int isSynced;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? lastSyncedAt;
  const SaleOrder({
    required this.id,
    required this.orderNumber,
    this.customerName,
    this.channel,
    this.branchId,
    this.branchName,
    required this.totalQuantity,
    required this.totalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.status,
    required this.isSynced,
    required this.createdBy,
    this.createdAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_number'] = Variable<String>(orderNumber);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || channel != null) {
      map['channel'] = Variable<String>(channel);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    map['total_quantity'] = Variable<int>(totalQuantity);
    map['total_amount'] = Variable<double>(totalAmount);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['status'] = Variable<String>(status);
    map['is_synced'] = Variable<int>(isSynced);
    map['created_by'] = Variable<String>(createdBy);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SaleOrdersCompanion toCompanion(bool nullToAbsent) {
    return SaleOrdersCompanion(
      id: Value(id),
      orderNumber: Value(orderNumber),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      channel: channel == null && nullToAbsent
          ? const Value.absent()
          : Value(channel),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      totalQuantity: Value(totalQuantity),
      totalAmount: Value(totalAmount),
      discountAmount: Value(discountAmount),
      taxAmount: Value(taxAmount),
      status: Value(status),
      isSynced: Value(isSynced),
      createdBy: Value(createdBy),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SaleOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleOrder(
      id: serializer.fromJson<String>(json['id']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      channel: serializer.fromJson<String?>(json['channel']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      totalQuantity: serializer.fromJson<int>(json['totalQuantity']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      status: serializer.fromJson<String>(json['status']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'customerName': serializer.toJson<String?>(customerName),
      'channel': serializer.toJson<String?>(channel),
      'branchId': serializer.toJson<String?>(branchId),
      'branchName': serializer.toJson<String?>(branchName),
      'totalQuantity': serializer.toJson<int>(totalQuantity),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'status': serializer.toJson<String>(status),
      'isSynced': serializer.toJson<int>(isSynced),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SaleOrder copyWith({
    String? id,
    String? orderNumber,
    Value<String?> customerName = const Value.absent(),
    Value<String?> channel = const Value.absent(),
    Value<String?> branchId = const Value.absent(),
    Value<String?> branchName = const Value.absent(),
    int? totalQuantity,
    double? totalAmount,
    double? discountAmount,
    double? taxAmount,
    String? status,
    int? isSynced,
    String? createdBy,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => SaleOrder(
    id: id ?? this.id,
    orderNumber: orderNumber ?? this.orderNumber,
    customerName: customerName.present ? customerName.value : this.customerName,
    channel: channel.present ? channel.value : this.channel,
    branchId: branchId.present ? branchId.value : this.branchId,
    branchName: branchName.present ? branchName.value : this.branchName,
    totalQuantity: totalQuantity ?? this.totalQuantity,
    totalAmount: totalAmount ?? this.totalAmount,
    discountAmount: discountAmount ?? this.discountAmount,
    taxAmount: taxAmount ?? this.taxAmount,
    status: status ?? this.status,
    isSynced: isSynced ?? this.isSynced,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SaleOrder copyWithCompanion(SaleOrdersCompanion data) {
    return SaleOrder(
      id: data.id.present ? data.id.value : this.id,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      channel: data.channel.present ? data.channel.value : this.channel,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      totalQuantity: data.totalQuantity.present
          ? data.totalQuantity.value
          : this.totalQuantity,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      status: data.status.present ? data.status.value : this.status,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleOrder(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('customerName: $customerName, ')
          ..write('channel: $channel, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderNumber,
    customerName,
    channel,
    branchId,
    branchName,
    totalQuantity,
    totalAmount,
    discountAmount,
    taxAmount,
    status,
    isSynced,
    createdBy,
    createdAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleOrder &&
          other.id == this.id &&
          other.orderNumber == this.orderNumber &&
          other.customerName == this.customerName &&
          other.channel == this.channel &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.totalQuantity == this.totalQuantity &&
          other.totalAmount == this.totalAmount &&
          other.discountAmount == this.discountAmount &&
          other.taxAmount == this.taxAmount &&
          other.status == this.status &&
          other.isSynced == this.isSynced &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SaleOrdersCompanion extends UpdateCompanion<SaleOrder> {
  final Value<String> id;
  final Value<String> orderNumber;
  final Value<String?> customerName;
  final Value<String?> channel;
  final Value<String?> branchId;
  final Value<String?> branchName;
  final Value<int> totalQuantity;
  final Value<double> totalAmount;
  final Value<double> discountAmount;
  final Value<double> taxAmount;
  final Value<String> status;
  final Value<int> isSynced;
  final Value<String> createdBy;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SaleOrdersCompanion({
    this.id = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.customerName = const Value.absent(),
    this.channel = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.totalQuantity = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String orderNumber,
    this.customerName = const Value.absent(),
    this.channel = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    required int totalQuantity,
    required double totalAmount,
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    required String status,
    this.isSynced = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : orderNumber = Value(orderNumber),
       totalQuantity = Value(totalQuantity),
       totalAmount = Value(totalAmount),
       status = Value(status),
       createdBy = Value(createdBy);
  static Insertable<SaleOrder> custom({
    Expression<String>? id,
    Expression<String>? orderNumber,
    Expression<String>? customerName,
    Expression<String>? channel,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<int>? totalQuantity,
    Expression<double>? totalAmount,
    Expression<double>? discountAmount,
    Expression<double>? taxAmount,
    Expression<String>? status,
    Expression<int>? isSynced,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderNumber != null) 'order_number': orderNumber,
      if (customerName != null) 'customer_name': customerName,
      if (channel != null) 'channel': channel,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (totalQuantity != null) 'total_quantity': totalQuantity,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (status != null) 'status': status,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? orderNumber,
    Value<String?>? customerName,
    Value<String?>? channel,
    Value<String?>? branchId,
    Value<String?>? branchName,
    Value<int>? totalQuantity,
    Value<double>? totalAmount,
    Value<double>? discountAmount,
    Value<double>? taxAmount,
    Value<String>? status,
    Value<int>? isSynced,
    Value<String>? createdBy,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SaleOrdersCompanion(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerName: customerName ?? this.customerName,
      channel: channel ?? this.channel,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalAmount: totalAmount ?? this.totalAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (totalQuantity.present) {
      map['total_quantity'] = Variable<int>(totalQuantity.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleOrdersCompanion(')
          ..write('id: $id, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('customerName: $customerName, ')
          ..write('channel: $channel, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleOrderItemsTable extends SaleOrderItems
    with TableInfo<$SaleOrderItemsTable, SaleOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _saleOrderIdMeta = const VerificationMeta(
    'saleOrderId',
  );
  @override
  late final GeneratedColumn<String> saleOrderId = GeneratedColumn<String>(
    'sale_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleOrderId,
    productId,
    productName,
    quantity,
    unitPrice,
    totalPrice,
    discountAmount,
    taxAmount,
    isSynced,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SaleOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_order_id')) {
      context.handle(
        _saleOrderIdMeta,
        saleOrderId.isAcceptableOrUnknown(
          data['sale_order_id']!,
          _saleOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saleOrderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SaleOrderItemsTable createAlias(String alias) {
    return $SaleOrderItemsTable(attachedDatabase, alias);
  }
}

class SaleOrderItem extends DataClass implements Insertable<SaleOrderItem> {
  final String id;
  final String saleOrderId;
  final String? productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double discountAmount;
  final double taxAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;
  const SaleOrderItem({
    required this.id,
    required this.saleOrderId,
    this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.discountAmount,
    required this.taxAmount,
    required this.isSynced,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_order_id'] = Variable<String>(saleOrderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total_price'] = Variable<double>(totalPrice);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['is_synced'] = Variable<int>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  SaleOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleOrderItemsCompanion(
      id: Value(id),
      saleOrderId: Value(saleOrderId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      totalPrice: Value(totalPrice),
      discountAmount: Value(discountAmount),
      taxAmount: Value(taxAmount),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SaleOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleOrderItem(
      id: serializer.fromJson<String>(json['id']),
      saleOrderId: serializer.fromJson<String>(json['saleOrderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleOrderId': serializer.toJson<String>(saleOrderId),
      'productId': serializer.toJson<String?>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'isSynced': serializer.toJson<int>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  SaleOrderItem copyWith({
    String? id,
    String? saleOrderId,
    Value<String?> productId = const Value.absent(),
    String? productName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? discountAmount,
    double? taxAmount,
    int? isSynced,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => SaleOrderItem(
    id: id ?? this.id,
    saleOrderId: saleOrderId ?? this.saleOrderId,
    productId: productId.present ? productId.value : this.productId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    totalPrice: totalPrice ?? this.totalPrice,
    discountAmount: discountAmount ?? this.discountAmount,
    taxAmount: taxAmount ?? this.taxAmount,
    isSynced: isSynced ?? this.isSynced,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SaleOrderItem copyWithCompanion(SaleOrderItemsCompanion data) {
    return SaleOrderItem(
      id: data.id.present ? data.id.value : this.id,
      saleOrderId: data.saleOrderId.present
          ? data.saleOrderId.value
          : this.saleOrderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleOrderItem(')
          ..write('id: $id, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleOrderId,
    productId,
    productName,
    quantity,
    unitPrice,
    totalPrice,
    discountAmount,
    taxAmount,
    isSynced,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleOrderItem &&
          other.id == this.id &&
          other.saleOrderId == this.saleOrderId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalPrice == this.totalPrice &&
          other.discountAmount == this.discountAmount &&
          other.taxAmount == this.taxAmount &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SaleOrderItemsCompanion extends UpdateCompanion<SaleOrderItem> {
  final Value<String> id;
  final Value<String> saleOrderId;
  final Value<String?> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> totalPrice;
  final Value<double> discountAmount;
  final Value<double> taxAmount;
  final Value<int> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const SaleOrderItemsCompanion({
    this.id = const Value.absent(),
    this.saleOrderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required String saleOrderId,
    this.productId = const Value.absent(),
    required String productName,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : saleOrderId = Value(saleOrderId),
       productName = Value(productName),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       totalPrice = Value(totalPrice);
  static Insertable<SaleOrderItem> custom({
    Expression<String>? id,
    Expression<String>? saleOrderId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalPrice,
    Expression<double>? discountAmount,
    Expression<double>? taxAmount,
    Expression<int>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleOrderId != null) 'sale_order_id': saleOrderId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleOrderItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? saleOrderId,
    Value<String?>? productId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? totalPrice,
    Value<double>? discountAmount,
    Value<double>? taxAmount,
    Value<int>? isSynced,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return SaleOrderItemsCompanion(
      id: id ?? this.id,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleOrderId.present) {
      map['sale_order_id'] = Variable<String>(saleOrderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByNameMeta = const VerificationMeta(
    'createdByName',
  );
  @override
  late final GeneratedColumn<String> createdByName = GeneratedColumn<String>(
    'created_by_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    createdBy,
    createdByName,
    branchId,
    branchName,
    totalAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_by_name')) {
      context.handle(
        _createdByNameMeta,
        createdByName.isAcceptableOrUnknown(
          data['created_by_name']!,
          _createdByNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByNameMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      createdByName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_name'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final String createdByName;
  final String branchId;
  final String branchName;
  final double totalAmount;
  const Receipt({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.createdByName,
    required this.branchId,
    required this.branchName,
    required this.totalAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['created_by'] = Variable<String>(createdBy);
    map['created_by_name'] = Variable<String>(createdByName);
    map['branch_id'] = Variable<String>(branchId);
    map['branch_name'] = Variable<String>(branchName);
    map['total_amount'] = Variable<double>(totalAmount);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      createdBy: Value(createdBy),
      createdByName: Value(createdByName),
      branchId: Value(branchId),
      branchName: Value(branchName),
      totalAmount: Value(totalAmount),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdByName: serializer.fromJson<String>(json['createdByName']),
      branchId: serializer.fromJson<String>(json['branchId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdByName': serializer.toJson<String>(createdByName),
      'branchId': serializer.toJson<String>(branchId),
      'branchName': serializer.toJson<String>(branchName),
      'totalAmount': serializer.toJson<double>(totalAmount),
    };
  }

  Receipt copyWith({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? createdByName,
    String? branchId,
    String? branchName,
    double? totalAmount,
  }) => Receipt(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    createdByName: createdByName ?? this.createdByName,
    branchId: branchId ?? this.branchId,
    branchName: branchName ?? this.branchName,
    totalAmount: totalAmount ?? this.totalAmount,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdByName: data.createdByName.present
          ? data.createdByName.value
          : this.createdByName,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdByName: $createdByName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalAmount: $totalAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    createdBy,
    createdByName,
    branchId,
    branchName,
    totalAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.createdByName == this.createdByName &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.totalAmount == this.totalAmount);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> createdBy;
  final Value<String> createdByName;
  final Value<String> branchId;
  final Value<String> branchName;
  final Value<double> totalAmount;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdByName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required String createdBy,
    required String createdByName,
    required String branchId,
    required String branchName,
    required double totalAmount,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       createdBy = Value(createdBy),
       createdByName = Value(createdByName),
       branchId = Value(branchId),
       branchName = Value(branchName),
       totalAmount = Value(totalAmount);
  static Insertable<Receipt> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<String>? createdByName,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<double>? totalAmount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (createdByName != null) 'created_by_name': createdByName,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? createdBy,
    Value<String>? createdByName,
    Value<String>? branchId,
    Value<String>? branchName,
    Value<double>? totalAmount,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalAmount: totalAmount ?? this.totalAmount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdByName.present) {
      map['created_by_name'] = Variable<String>(createdByName.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdByName: $createdByName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProformasTable extends Proformas
    with TableInfo<$ProformasTable, Proforma> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProformasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _partyNameMeta = const VerificationMeta(
    'partyName',
  );
  @override
  late final GeneratedColumn<String> partyName = GeneratedColumn<String>(
    'party_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partyAddressMeta = const VerificationMeta(
    'partyAddress',
  );
  @override
  late final GeneratedColumn<String> partyAddress = GeneratedColumn<String>(
    'party_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<String> tax = GeneratedColumn<String>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalQuantityMeta = const VerificationMeta(
    'totalQuantity',
  );
  @override
  late final GeneratedColumn<int> totalQuantity = GeneratedColumn<int>(
    'total_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _declarationMeta = const VerificationMeta(
    'declaration',
  );
  @override
  late final GeneratedColumn<String> declaration = GeneratedColumn<String>(
    'declaration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<int> isDeleted = GeneratedColumn<int>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    partyName,
    partyAddress,
    tax,
    totalQuantity,
    declaration,
    totalAmount,
    isDeleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proformas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Proforma> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('party_name')) {
      context.handle(
        _partyNameMeta,
        partyName.isAcceptableOrUnknown(data['party_name']!, _partyNameMeta),
      );
    }
    if (data.containsKey('party_address')) {
      context.handle(
        _partyAddressMeta,
        partyAddress.isAcceptableOrUnknown(
          data['party_address']!,
          _partyAddressMeta,
        ),
      );
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    } else if (isInserting) {
      context.missing(_taxMeta);
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
        _totalQuantityMeta,
        totalQuantity.isAcceptableOrUnknown(
          data['total_quantity']!,
          _totalQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuantityMeta);
    }
    if (data.containsKey('declaration')) {
      context.handle(
        _declarationMeta,
        declaration.isAcceptableOrUnknown(
          data['declaration']!,
          _declarationMeta,
        ),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proforma map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Proforma(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      partyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_name'],
      ),
      partyAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_address'],
      ),
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax'],
      )!,
      totalQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_quantity'],
      )!,
      declaration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}declaration'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProformasTable createAlias(String alias) {
    return $ProformasTable(attachedDatabase, alias);
  }
}

class Proforma extends DataClass implements Insertable<Proforma> {
  final String id;
  final String? partyName;
  final String? partyAddress;
  final String tax;
  final int totalQuantity;
  final String? declaration;
  final double totalAmount;
  final int isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Proforma({
    required this.id,
    this.partyName,
    this.partyAddress,
    required this.tax,
    required this.totalQuantity,
    this.declaration,
    required this.totalAmount,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || partyName != null) {
      map['party_name'] = Variable<String>(partyName);
    }
    if (!nullToAbsent || partyAddress != null) {
      map['party_address'] = Variable<String>(partyAddress);
    }
    map['tax'] = Variable<String>(tax);
    map['total_quantity'] = Variable<int>(totalQuantity);
    if (!nullToAbsent || declaration != null) {
      map['declaration'] = Variable<String>(declaration);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['is_deleted'] = Variable<int>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProformasCompanion toCompanion(bool nullToAbsent) {
    return ProformasCompanion(
      id: Value(id),
      partyName: partyName == null && nullToAbsent
          ? const Value.absent()
          : Value(partyName),
      partyAddress: partyAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(partyAddress),
      tax: Value(tax),
      totalQuantity: Value(totalQuantity),
      declaration: declaration == null && nullToAbsent
          ? const Value.absent()
          : Value(declaration),
      totalAmount: Value(totalAmount),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Proforma.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Proforma(
      id: serializer.fromJson<String>(json['id']),
      partyName: serializer.fromJson<String?>(json['partyName']),
      partyAddress: serializer.fromJson<String?>(json['partyAddress']),
      tax: serializer.fromJson<String>(json['tax']),
      totalQuantity: serializer.fromJson<int>(json['totalQuantity']),
      declaration: serializer.fromJson<String?>(json['declaration']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      isDeleted: serializer.fromJson<int>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'partyName': serializer.toJson<String?>(partyName),
      'partyAddress': serializer.toJson<String?>(partyAddress),
      'tax': serializer.toJson<String>(tax),
      'totalQuantity': serializer.toJson<int>(totalQuantity),
      'declaration': serializer.toJson<String?>(declaration),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'isDeleted': serializer.toJson<int>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Proforma copyWith({
    String? id,
    Value<String?> partyName = const Value.absent(),
    Value<String?> partyAddress = const Value.absent(),
    String? tax,
    int? totalQuantity,
    Value<String?> declaration = const Value.absent(),
    double? totalAmount,
    int? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Proforma(
    id: id ?? this.id,
    partyName: partyName.present ? partyName.value : this.partyName,
    partyAddress: partyAddress.present ? partyAddress.value : this.partyAddress,
    tax: tax ?? this.tax,
    totalQuantity: totalQuantity ?? this.totalQuantity,
    declaration: declaration.present ? declaration.value : this.declaration,
    totalAmount: totalAmount ?? this.totalAmount,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Proforma copyWithCompanion(ProformasCompanion data) {
    return Proforma(
      id: data.id.present ? data.id.value : this.id,
      partyName: data.partyName.present ? data.partyName.value : this.partyName,
      partyAddress: data.partyAddress.present
          ? data.partyAddress.value
          : this.partyAddress,
      tax: data.tax.present ? data.tax.value : this.tax,
      totalQuantity: data.totalQuantity.present
          ? data.totalQuantity.value
          : this.totalQuantity,
      declaration: data.declaration.present
          ? data.declaration.value
          : this.declaration,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Proforma(')
          ..write('id: $id, ')
          ..write('partyName: $partyName, ')
          ..write('partyAddress: $partyAddress, ')
          ..write('tax: $tax, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('declaration: $declaration, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    partyName,
    partyAddress,
    tax,
    totalQuantity,
    declaration,
    totalAmount,
    isDeleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Proforma &&
          other.id == this.id &&
          other.partyName == this.partyName &&
          other.partyAddress == this.partyAddress &&
          other.tax == this.tax &&
          other.totalQuantity == this.totalQuantity &&
          other.declaration == this.declaration &&
          other.totalAmount == this.totalAmount &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProformasCompanion extends UpdateCompanion<Proforma> {
  final Value<String> id;
  final Value<String?> partyName;
  final Value<String?> partyAddress;
  final Value<String> tax;
  final Value<int> totalQuantity;
  final Value<String?> declaration;
  final Value<double> totalAmount;
  final Value<int> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProformasCompanion({
    this.id = const Value.absent(),
    this.partyName = const Value.absent(),
    this.partyAddress = const Value.absent(),
    this.tax = const Value.absent(),
    this.totalQuantity = const Value.absent(),
    this.declaration = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProformasCompanion.insert({
    this.id = const Value.absent(),
    this.partyName = const Value.absent(),
    this.partyAddress = const Value.absent(),
    required String tax,
    required int totalQuantity,
    this.declaration = const Value.absent(),
    required double totalAmount,
    this.isDeleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : tax = Value(tax),
       totalQuantity = Value(totalQuantity),
       totalAmount = Value(totalAmount),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Proforma> custom({
    Expression<String>? id,
    Expression<String>? partyName,
    Expression<String>? partyAddress,
    Expression<String>? tax,
    Expression<int>? totalQuantity,
    Expression<String>? declaration,
    Expression<double>? totalAmount,
    Expression<int>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partyName != null) 'party_name': partyName,
      if (partyAddress != null) 'party_address': partyAddress,
      if (tax != null) 'tax': tax,
      if (totalQuantity != null) 'total_quantity': totalQuantity,
      if (declaration != null) 'declaration': declaration,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProformasCompanion copyWith({
    Value<String>? id,
    Value<String?>? partyName,
    Value<String?>? partyAddress,
    Value<String>? tax,
    Value<int>? totalQuantity,
    Value<String?>? declaration,
    Value<double>? totalAmount,
    Value<int>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProformasCompanion(
      id: id ?? this.id,
      partyName: partyName ?? this.partyName,
      partyAddress: partyAddress ?? this.partyAddress,
      tax: tax ?? this.tax,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      declaration: declaration ?? this.declaration,
      totalAmount: totalAmount ?? this.totalAmount,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (partyName.present) {
      map['party_name'] = Variable<String>(partyName.value);
    }
    if (partyAddress.present) {
      map['party_address'] = Variable<String>(partyAddress.value);
    }
    if (tax.present) {
      map['tax'] = Variable<String>(tax.value);
    }
    if (totalQuantity.present) {
      map['total_quantity'] = Variable<int>(totalQuantity.value);
    }
    if (declaration.present) {
      map['declaration'] = Variable<String>(declaration.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<int>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProformasCompanion(')
          ..write('id: $id, ')
          ..write('partyName: $partyName, ')
          ..write('partyAddress: $partyAddress, ')
          ..write('tax: $tax, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('declaration: $declaration, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductDetailsListTable extends ProductDetailsList
    with TableInfo<$ProductDetailsListTable, ProductDetailsListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductDetailsListTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proformaIdMeta = const VerificationMeta(
    'proformaId',
  );
  @override
  late final GeneratedColumn<String> proformaId = GeneratedColumn<String>(
    'proforma_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waybillIdMeta = const VerificationMeta(
    'waybillId',
  );
  @override
  late final GeneratedColumn<String> waybillId = GeneratedColumn<String>(
    'waybill_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    proformaId,
    waybillId,
    productName,
    quantity,
    unitPrice,
    discountPercentage,
    totalAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_details_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductDetailsListData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('proforma_id')) {
      context.handle(
        _proformaIdMeta,
        proformaId.isAcceptableOrUnknown(data['proforma_id']!, _proformaIdMeta),
      );
    }
    if (data.containsKey('waybill_id')) {
      context.handle(
        _waybillIdMeta,
        waybillId.isAcceptableOrUnknown(data['waybill_id']!, _waybillIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discountPercentageMeta,
        discountPercentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discountPercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discountPercentageMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductDetailsListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductDetailsListData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      proformaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proforma_id'],
      ),
      waybillId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}waybill_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      discountPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percentage'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
    );
  }

  @override
  $ProductDetailsListTable createAlias(String alias) {
    return $ProductDetailsListTable(attachedDatabase, alias);
  }
}

class ProductDetailsListData extends DataClass
    implements Insertable<ProductDetailsListData> {
  final String id;
  final String productId;
  final String? proformaId;
  final String? waybillId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double discountPercentage;
  final double totalAmount;
  const ProductDetailsListData({
    required this.id,
    required this.productId,
    this.proformaId,
    this.waybillId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.discountPercentage,
    required this.totalAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    if (!nullToAbsent || proformaId != null) {
      map['proforma_id'] = Variable<String>(proformaId);
    }
    if (!nullToAbsent || waybillId != null) {
      map['waybill_id'] = Variable<String>(waybillId);
    }
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['discount_percentage'] = Variable<double>(discountPercentage);
    map['total_amount'] = Variable<double>(totalAmount);
    return map;
  }

  ProductDetailsListCompanion toCompanion(bool nullToAbsent) {
    return ProductDetailsListCompanion(
      id: Value(id),
      productId: Value(productId),
      proformaId: proformaId == null && nullToAbsent
          ? const Value.absent()
          : Value(proformaId),
      waybillId: waybillId == null && nullToAbsent
          ? const Value.absent()
          : Value(waybillId),
      productName: Value(productName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      discountPercentage: Value(discountPercentage),
      totalAmount: Value(totalAmount),
    );
  }

  factory ProductDetailsListData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductDetailsListData(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      proformaId: serializer.fromJson<String?>(json['proformaId']),
      waybillId: serializer.fromJson<String?>(json['waybillId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      discountPercentage: serializer.fromJson<double>(
        json['discountPercentage'],
      ),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'proformaId': serializer.toJson<String?>(proformaId),
      'waybillId': serializer.toJson<String?>(waybillId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'discountPercentage': serializer.toJson<double>(discountPercentage),
      'totalAmount': serializer.toJson<double>(totalAmount),
    };
  }

  ProductDetailsListData copyWith({
    String? id,
    String? productId,
    Value<String?> proformaId = const Value.absent(),
    Value<String?> waybillId = const Value.absent(),
    String? productName,
    int? quantity,
    double? unitPrice,
    double? discountPercentage,
    double? totalAmount,
  }) => ProductDetailsListData(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    proformaId: proformaId.present ? proformaId.value : this.proformaId,
    waybillId: waybillId.present ? waybillId.value : this.waybillId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    discountPercentage: discountPercentage ?? this.discountPercentage,
    totalAmount: totalAmount ?? this.totalAmount,
  );
  ProductDetailsListData copyWithCompanion(ProductDetailsListCompanion data) {
    return ProductDetailsListData(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      proformaId: data.proformaId.present
          ? data.proformaId.value
          : this.proformaId,
      waybillId: data.waybillId.present ? data.waybillId.value : this.waybillId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      discountPercentage: data.discountPercentage.present
          ? data.discountPercentage.value
          : this.discountPercentage,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductDetailsListData(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('proformaId: $proformaId, ')
          ..write('waybillId: $waybillId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('totalAmount: $totalAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    proformaId,
    waybillId,
    productName,
    quantity,
    unitPrice,
    discountPercentage,
    totalAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductDetailsListData &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.proformaId == this.proformaId &&
          other.waybillId == this.waybillId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.discountPercentage == this.discountPercentage &&
          other.totalAmount == this.totalAmount);
}

class ProductDetailsListCompanion
    extends UpdateCompanion<ProductDetailsListData> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String?> proformaId;
  final Value<String?> waybillId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> discountPercentage;
  final Value<double> totalAmount;
  final Value<int> rowid;
  const ProductDetailsListCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.proformaId = const Value.absent(),
    this.waybillId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductDetailsListCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    this.proformaId = const Value.absent(),
    this.waybillId = const Value.absent(),
    required String productName,
    required int quantity,
    required double unitPrice,
    required double discountPercentage,
    required double totalAmount,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       productName = Value(productName),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       discountPercentage = Value(discountPercentage),
       totalAmount = Value(totalAmount);
  static Insertable<ProductDetailsListData> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? proformaId,
    Expression<String>? waybillId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? discountPercentage,
    Expression<double>? totalAmount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (proformaId != null) 'proforma_id': proformaId,
      if (waybillId != null) 'waybill_id': waybillId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductDetailsListCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String?>? proformaId,
    Value<String?>? waybillId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? discountPercentage,
    Value<double>? totalAmount,
    Value<int>? rowid,
  }) {
    return ProductDetailsListCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      proformaId: proformaId ?? this.proformaId,
      waybillId: waybillId ?? this.waybillId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      totalAmount: totalAmount ?? this.totalAmount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (proformaId.present) {
      map['proforma_id'] = Variable<String>(proformaId.value);
    }
    if (waybillId.present) {
      map['waybill_id'] = Variable<String>(waybillId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductDetailsListCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('proformaId: $proformaId, ')
          ..write('waybillId: $waybillId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WayBillsTable extends WayBills with TableInfo<$WayBillsTable, WayBill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WayBillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _mainContentMeta = const VerificationMeta(
    'mainContent',
  );
  @override
  late final GeneratedColumn<String> mainContent = GeneratedColumn<String>(
    'main_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dispatchDocNumberMeta = const VerificationMeta(
    'dispatchDocNumber',
  );
  @override
  late final GeneratedColumn<String> dispatchDocNumber =
      GeneratedColumn<String>(
        'dispatch_doc_number',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _deliveryNoteMeta = const VerificationMeta(
    'deliveryNote',
  );
  @override
  late final GeneratedColumn<String> deliveryNote = GeneratedColumn<String>(
    'delivery_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationMeta = const VerificationMeta(
    'destination',
  );
  @override
  late final GeneratedColumn<String> destination = GeneratedColumn<String>(
    'destination',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partyNameMeta = const VerificationMeta(
    'partyName',
  );
  @override
  late final GeneratedColumn<String> partyName = GeneratedColumn<String>(
    'party_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<int> isDeleted = GeneratedColumn<int>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dispatchDateMeta = const VerificationMeta(
    'dispatchDate',
  );
  @override
  late final GeneratedColumn<DateTime> dispatchDate = GeneratedColumn<DateTime>(
    'dispatch_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mainContent,
    orderNumber,
    dispatchDocNumber,
    deliveryNote,
    senderName,
    destination,
    partyName,
    createdBy,
    isDeleted,
    dispatchDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'way_bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<WayBill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('main_content')) {
      context.handle(
        _mainContentMeta,
        mainContent.isAcceptableOrUnknown(
          data['main_content']!,
          _mainContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainContentMeta);
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('dispatch_doc_number')) {
      context.handle(
        _dispatchDocNumberMeta,
        dispatchDocNumber.isAcceptableOrUnknown(
          data['dispatch_doc_number']!,
          _dispatchDocNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dispatchDocNumberMeta);
    }
    if (data.containsKey('delivery_note')) {
      context.handle(
        _deliveryNoteMeta,
        deliveryNote.isAcceptableOrUnknown(
          data['delivery_note']!,
          _deliveryNoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryNoteMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('destination')) {
      context.handle(
        _destinationMeta,
        destination.isAcceptableOrUnknown(
          data['destination']!,
          _destinationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationMeta);
    }
    if (data.containsKey('party_name')) {
      context.handle(
        _partyNameMeta,
        partyName.isAcceptableOrUnknown(data['party_name']!, _partyNameMeta),
      );
    } else if (isInserting) {
      context.missing(_partyNameMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('dispatch_date')) {
      context.handle(
        _dispatchDateMeta,
        dispatchDate.isAcceptableOrUnknown(
          data['dispatch_date']!,
          _dispatchDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dispatchDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WayBill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WayBill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mainContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_content'],
      )!,
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      dispatchDocNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dispatch_doc_number'],
      )!,
      deliveryNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delivery_note'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      destination: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination'],
      )!,
      partyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_name'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_deleted'],
      )!,
      dispatchDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dispatch_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WayBillsTable createAlias(String alias) {
    return $WayBillsTable(attachedDatabase, alias);
  }
}

class WayBill extends DataClass implements Insertable<WayBill> {
  final String id;
  final String mainContent;
  final String orderNumber;
  final String dispatchDocNumber;
  final String deliveryNote;
  final String senderName;
  final String destination;
  final String partyName;
  final String createdBy;
  final int isDeleted;
  final DateTime dispatchDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WayBill({
    required this.id,
    required this.mainContent,
    required this.orderNumber,
    required this.dispatchDocNumber,
    required this.deliveryNote,
    required this.senderName,
    required this.destination,
    required this.partyName,
    required this.createdBy,
    required this.isDeleted,
    required this.dispatchDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['main_content'] = Variable<String>(mainContent);
    map['order_number'] = Variable<String>(orderNumber);
    map['dispatch_doc_number'] = Variable<String>(dispatchDocNumber);
    map['delivery_note'] = Variable<String>(deliveryNote);
    map['sender_name'] = Variable<String>(senderName);
    map['destination'] = Variable<String>(destination);
    map['party_name'] = Variable<String>(partyName);
    map['created_by'] = Variable<String>(createdBy);
    map['is_deleted'] = Variable<int>(isDeleted);
    map['dispatch_date'] = Variable<DateTime>(dispatchDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WayBillsCompanion toCompanion(bool nullToAbsent) {
    return WayBillsCompanion(
      id: Value(id),
      mainContent: Value(mainContent),
      orderNumber: Value(orderNumber),
      dispatchDocNumber: Value(dispatchDocNumber),
      deliveryNote: Value(deliveryNote),
      senderName: Value(senderName),
      destination: Value(destination),
      partyName: Value(partyName),
      createdBy: Value(createdBy),
      isDeleted: Value(isDeleted),
      dispatchDate: Value(dispatchDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WayBill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WayBill(
      id: serializer.fromJson<String>(json['id']),
      mainContent: serializer.fromJson<String>(json['mainContent']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      dispatchDocNumber: serializer.fromJson<String>(json['dispatchDocNumber']),
      deliveryNote: serializer.fromJson<String>(json['deliveryNote']),
      senderName: serializer.fromJson<String>(json['senderName']),
      destination: serializer.fromJson<String>(json['destination']),
      partyName: serializer.fromJson<String>(json['partyName']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      isDeleted: serializer.fromJson<int>(json['isDeleted']),
      dispatchDate: serializer.fromJson<DateTime>(json['dispatchDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mainContent': serializer.toJson<String>(mainContent),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'dispatchDocNumber': serializer.toJson<String>(dispatchDocNumber),
      'deliveryNote': serializer.toJson<String>(deliveryNote),
      'senderName': serializer.toJson<String>(senderName),
      'destination': serializer.toJson<String>(destination),
      'partyName': serializer.toJson<String>(partyName),
      'createdBy': serializer.toJson<String>(createdBy),
      'isDeleted': serializer.toJson<int>(isDeleted),
      'dispatchDate': serializer.toJson<DateTime>(dispatchDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WayBill copyWith({
    String? id,
    String? mainContent,
    String? orderNumber,
    String? dispatchDocNumber,
    String? deliveryNote,
    String? senderName,
    String? destination,
    String? partyName,
    String? createdBy,
    int? isDeleted,
    DateTime? dispatchDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WayBill(
    id: id ?? this.id,
    mainContent: mainContent ?? this.mainContent,
    orderNumber: orderNumber ?? this.orderNumber,
    dispatchDocNumber: dispatchDocNumber ?? this.dispatchDocNumber,
    deliveryNote: deliveryNote ?? this.deliveryNote,
    senderName: senderName ?? this.senderName,
    destination: destination ?? this.destination,
    partyName: partyName ?? this.partyName,
    createdBy: createdBy ?? this.createdBy,
    isDeleted: isDeleted ?? this.isDeleted,
    dispatchDate: dispatchDate ?? this.dispatchDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WayBill copyWithCompanion(WayBillsCompanion data) {
    return WayBill(
      id: data.id.present ? data.id.value : this.id,
      mainContent: data.mainContent.present
          ? data.mainContent.value
          : this.mainContent,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      dispatchDocNumber: data.dispatchDocNumber.present
          ? data.dispatchDocNumber.value
          : this.dispatchDocNumber,
      deliveryNote: data.deliveryNote.present
          ? data.deliveryNote.value
          : this.deliveryNote,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      destination: data.destination.present
          ? data.destination.value
          : this.destination,
      partyName: data.partyName.present ? data.partyName.value : this.partyName,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      dispatchDate: data.dispatchDate.present
          ? data.dispatchDate.value
          : this.dispatchDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WayBill(')
          ..write('id: $id, ')
          ..write('mainContent: $mainContent, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('dispatchDocNumber: $dispatchDocNumber, ')
          ..write('deliveryNote: $deliveryNote, ')
          ..write('senderName: $senderName, ')
          ..write('destination: $destination, ')
          ..write('partyName: $partyName, ')
          ..write('createdBy: $createdBy, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dispatchDate: $dispatchDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mainContent,
    orderNumber,
    dispatchDocNumber,
    deliveryNote,
    senderName,
    destination,
    partyName,
    createdBy,
    isDeleted,
    dispatchDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WayBill &&
          other.id == this.id &&
          other.mainContent == this.mainContent &&
          other.orderNumber == this.orderNumber &&
          other.dispatchDocNumber == this.dispatchDocNumber &&
          other.deliveryNote == this.deliveryNote &&
          other.senderName == this.senderName &&
          other.destination == this.destination &&
          other.partyName == this.partyName &&
          other.createdBy == this.createdBy &&
          other.isDeleted == this.isDeleted &&
          other.dispatchDate == this.dispatchDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WayBillsCompanion extends UpdateCompanion<WayBill> {
  final Value<String> id;
  final Value<String> mainContent;
  final Value<String> orderNumber;
  final Value<String> dispatchDocNumber;
  final Value<String> deliveryNote;
  final Value<String> senderName;
  final Value<String> destination;
  final Value<String> partyName;
  final Value<String> createdBy;
  final Value<int> isDeleted;
  final Value<DateTime> dispatchDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WayBillsCompanion({
    this.id = const Value.absent(),
    this.mainContent = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.dispatchDocNumber = const Value.absent(),
    this.deliveryNote = const Value.absent(),
    this.senderName = const Value.absent(),
    this.destination = const Value.absent(),
    this.partyName = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.dispatchDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WayBillsCompanion.insert({
    this.id = const Value.absent(),
    required String mainContent,
    required String orderNumber,
    required String dispatchDocNumber,
    required String deliveryNote,
    required String senderName,
    required String destination,
    required String partyName,
    required String createdBy,
    this.isDeleted = const Value.absent(),
    required DateTime dispatchDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mainContent = Value(mainContent),
       orderNumber = Value(orderNumber),
       dispatchDocNumber = Value(dispatchDocNumber),
       deliveryNote = Value(deliveryNote),
       senderName = Value(senderName),
       destination = Value(destination),
       partyName = Value(partyName),
       createdBy = Value(createdBy),
       dispatchDate = Value(dispatchDate);
  static Insertable<WayBill> custom({
    Expression<String>? id,
    Expression<String>? mainContent,
    Expression<String>? orderNumber,
    Expression<String>? dispatchDocNumber,
    Expression<String>? deliveryNote,
    Expression<String>? senderName,
    Expression<String>? destination,
    Expression<String>? partyName,
    Expression<String>? createdBy,
    Expression<int>? isDeleted,
    Expression<DateTime>? dispatchDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mainContent != null) 'main_content': mainContent,
      if (orderNumber != null) 'order_number': orderNumber,
      if (dispatchDocNumber != null) 'dispatch_doc_number': dispatchDocNumber,
      if (deliveryNote != null) 'delivery_note': deliveryNote,
      if (senderName != null) 'sender_name': senderName,
      if (destination != null) 'destination': destination,
      if (partyName != null) 'party_name': partyName,
      if (createdBy != null) 'created_by': createdBy,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (dispatchDate != null) 'dispatch_date': dispatchDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WayBillsCompanion copyWith({
    Value<String>? id,
    Value<String>? mainContent,
    Value<String>? orderNumber,
    Value<String>? dispatchDocNumber,
    Value<String>? deliveryNote,
    Value<String>? senderName,
    Value<String>? destination,
    Value<String>? partyName,
    Value<String>? createdBy,
    Value<int>? isDeleted,
    Value<DateTime>? dispatchDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WayBillsCompanion(
      id: id ?? this.id,
      mainContent: mainContent ?? this.mainContent,
      orderNumber: orderNumber ?? this.orderNumber,
      dispatchDocNumber: dispatchDocNumber ?? this.dispatchDocNumber,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      senderName: senderName ?? this.senderName,
      destination: destination ?? this.destination,
      partyName: partyName ?? this.partyName,
      createdBy: createdBy ?? this.createdBy,
      isDeleted: isDeleted ?? this.isDeleted,
      dispatchDate: dispatchDate ?? this.dispatchDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mainContent.present) {
      map['main_content'] = Variable<String>(mainContent.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (dispatchDocNumber.present) {
      map['dispatch_doc_number'] = Variable<String>(dispatchDocNumber.value);
    }
    if (deliveryNote.present) {
      map['delivery_note'] = Variable<String>(deliveryNote.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (destination.present) {
      map['destination'] = Variable<String>(destination.value);
    }
    if (partyName.present) {
      map['party_name'] = Variable<String>(partyName.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<int>(isDeleted.value);
    }
    if (dispatchDate.present) {
      map['dispatch_date'] = Variable<DateTime>(dispatchDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WayBillsCompanion(')
          ..write('id: $id, ')
          ..write('mainContent: $mainContent, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('dispatchDocNumber: $dispatchDocNumber, ')
          ..write('deliveryNote: $deliveryNote, ')
          ..write('senderName: $senderName, ')
          ..write('destination: $destination, ')
          ..write('partyName: $partyName, ')
          ..write('createdBy: $createdBy, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('dispatchDate: $dispatchDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saleOrderIdMeta = const VerificationMeta(
    'saleOrderId',
  );
  @override
  late final GeneratedColumn<String> saleOrderId = GeneratedColumn<String>(
    'sale_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dueDate,
    customerName,
    totalAmount,
    paidAmount,
    status,
    note,
    saleOrderId,
    branchName,
    branchId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAmountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sale_order_id')) {
      context.handle(
        _saleOrderIdMeta,
        saleOrderId.isAcceptableOrUnknown(
          data['sale_order_id']!,
          _saleOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saleOrderIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      saleOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_order_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final String id;
  final DateTime dueDate;
  final String? customerName;
  final double totalAmount;
  final double paidAmount;
  final String status;
  final String? note;
  final String saleOrderId;
  final String? branchName;
  final String? branchId;
  const Invoice({
    required this.id,
    required this.dueDate,
    this.customerName,
    required this.totalAmount,
    required this.paidAmount,
    required this.status,
    this.note,
    required this.saleOrderId,
    this.branchName,
    this.branchId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sale_order_id'] = Variable<String>(saleOrderId);
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      dueDate: Value(dueDate),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      totalAmount: Value(totalAmount),
      paidAmount: Value(paidAmount),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      saleOrderId: Value(saleOrderId),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<String>(json['id']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      saleOrderId: serializer.fromJson<String>(json['saleOrderId']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      branchId: serializer.fromJson<String?>(json['branchId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'customerName': serializer.toJson<String?>(customerName),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'saleOrderId': serializer.toJson<String>(saleOrderId),
      'branchName': serializer.toJson<String?>(branchName),
      'branchId': serializer.toJson<String?>(branchId),
    };
  }

  Invoice copyWith({
    String? id,
    DateTime? dueDate,
    Value<String?> customerName = const Value.absent(),
    double? totalAmount,
    double? paidAmount,
    String? status,
    Value<String?> note = const Value.absent(),
    String? saleOrderId,
    Value<String?> branchName = const Value.absent(),
    Value<String?> branchId = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    dueDate: dueDate ?? this.dueDate,
    customerName: customerName.present ? customerName.value : this.customerName,
    totalAmount: totalAmount ?? this.totalAmount,
    paidAmount: paidAmount ?? this.paidAmount,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    saleOrderId: saleOrderId ?? this.saleOrderId,
    branchName: branchName.present ? branchName.value : this.branchName,
    branchId: branchId.present ? branchId.value : this.branchId,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      saleOrderId: data.saleOrderId.present
          ? data.saleOrderId.value
          : this.saleOrderId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('dueDate: $dueDate, ')
          ..write('customerName: $customerName, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('branchName: $branchName, ')
          ..write('branchId: $branchId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dueDate,
    customerName,
    totalAmount,
    paidAmount,
    status,
    note,
    saleOrderId,
    branchName,
    branchId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.dueDate == this.dueDate &&
          other.customerName == this.customerName &&
          other.totalAmount == this.totalAmount &&
          other.paidAmount == this.paidAmount &&
          other.status == this.status &&
          other.note == this.note &&
          other.saleOrderId == this.saleOrderId &&
          other.branchName == this.branchName &&
          other.branchId == this.branchId);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<String> id;
  final Value<DateTime> dueDate;
  final Value<String?> customerName;
  final Value<double> totalAmount;
  final Value<double> paidAmount;
  final Value<String> status;
  final Value<String?> note;
  final Value<String> saleOrderId;
  final Value<String?> branchName;
  final Value<String?> branchId;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.customerName = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.saleOrderId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime dueDate,
    this.customerName = const Value.absent(),
    required double totalAmount,
    required double paidAmount,
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    required String saleOrderId,
    this.branchName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dueDate = Value(dueDate),
       totalAmount = Value(totalAmount),
       paidAmount = Value(paidAmount),
       saleOrderId = Value(saleOrderId);
  static Insertable<Invoice> custom({
    Expression<String>? id,
    Expression<DateTime>? dueDate,
    Expression<String>? customerName,
    Expression<double>? totalAmount,
    Expression<double>? paidAmount,
    Expression<String>? status,
    Expression<String>? note,
    Expression<String>? saleOrderId,
    Expression<String>? branchName,
    Expression<String>? branchId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dueDate != null) 'due_date': dueDate,
      if (customerName != null) 'customer_name': customerName,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (saleOrderId != null) 'sale_order_id': saleOrderId,
      if (branchName != null) 'branch_name': branchName,
      if (branchId != null) 'branch_id': branchId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? dueDate,
    Value<String?>? customerName,
    Value<double>? totalAmount,
    Value<double>? paidAmount,
    Value<String>? status,
    Value<String?>? note,
    Value<String>? saleOrderId,
    Value<String?>? branchName,
    Value<String?>? branchId,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      dueDate: dueDate ?? this.dueDate,
      customerName: customerName ?? this.customerName,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      branchName: branchName ?? this.branchName,
      branchId: branchId ?? this.branchId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (saleOrderId.present) {
      map['sale_order_id'] = Variable<String>(saleOrderId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('dueDate: $dueDate, ')
          ..write('customerName: $customerName, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('branchName: $branchName, ')
          ..write('branchId: $branchId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReturnOrdersTable extends ReturnOrders
    with TableInfo<$ReturnOrdersTable, ReturnOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _returnOrderNumberMeta = const VerificationMeta(
    'returnOrderNumber',
  );
  @override
  late final GeneratedColumn<String> returnOrderNumber =
      GeneratedColumn<String>(
        'return_order_number',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _saleOrderIdMeta = const VerificationMeta(
    'saleOrderId',
  );
  @override
  late final GeneratedColumn<String> saleOrderId = GeneratedColumn<String>(
    'sale_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalItemsMeta = const VerificationMeta(
    'totalItems',
  );
  @override
  late final GeneratedColumn<int> totalItems = GeneratedColumn<int>(
    'total_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalTaxMeta = const VerificationMeta(
    'totalTax',
  );
  @override
  late final GeneratedColumn<double> totalTax = GeneratedColumn<double>(
    'total_tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnDateMeta = const VerificationMeta(
    'returnDate',
  );
  @override
  late final GeneratedColumn<DateTime> returnDate = GeneratedColumn<DateTime>(
    'return_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    returnOrderNumber,
    saleOrderId,
    invoiceId,
    customerName,
    branchId,
    branchName,
    totalItems,
    totalAmount,
    refundAmount,
    totalTax,
    status,
    isSynced,
    createdBy,
    returnDate,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_order_number')) {
      context.handle(
        _returnOrderNumberMeta,
        returnOrderNumber.isAcceptableOrUnknown(
          data['return_order_number']!,
          _returnOrderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_returnOrderNumberMeta);
    }
    if (data.containsKey('sale_order_id')) {
      context.handle(
        _saleOrderIdMeta,
        saleOrderId.isAcceptableOrUnknown(
          data['sale_order_id']!,
          _saleOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saleOrderIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    }
    if (data.containsKey('total_items')) {
      context.handle(
        _totalItemsMeta,
        totalItems.isAcceptableOrUnknown(data['total_items']!, _totalItemsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalItemsMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refundAmountMeta);
    }
    if (data.containsKey('total_tax')) {
      context.handle(
        _totalTaxMeta,
        totalTax.isAcceptableOrUnknown(data['total_tax']!, _totalTaxMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('return_date')) {
      context.handle(
        _returnDateMeta,
        returnDate.isAcceptableOrUnknown(data['return_date']!, _returnDateMeta),
      );
    } else if (isInserting) {
      context.missing(_returnDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      returnOrderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_order_number'],
      )!,
      saleOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_order_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      ),
      totalItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_items'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      )!,
      totalTax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_tax'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      returnDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}return_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $ReturnOrdersTable createAlias(String alias) {
    return $ReturnOrdersTable(attachedDatabase, alias);
  }
}

class ReturnOrder extends DataClass implements Insertable<ReturnOrder> {
  final String id;
  final String returnOrderNumber;
  final String saleOrderId;
  final String? invoiceId;
  final String? customerName;
  final String? branchId;
  final String? branchName;
  final int totalItems;
  final double totalAmount;
  final double refundAmount;
  final double totalTax;
  final String status;
  final int isSynced;
  final String createdBy;
  final DateTime returnDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const ReturnOrder({
    required this.id,
    required this.returnOrderNumber,
    required this.saleOrderId,
    this.invoiceId,
    this.customerName,
    this.branchId,
    this.branchName,
    required this.totalItems,
    required this.totalAmount,
    required this.refundAmount,
    required this.totalTax,
    required this.status,
    required this.isSynced,
    required this.createdBy,
    required this.returnDate,
    required this.createdAt,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['return_order_number'] = Variable<String>(returnOrderNumber);
    map['sale_order_id'] = Variable<String>(saleOrderId);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<String>(invoiceId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    map['total_items'] = Variable<int>(totalItems);
    map['total_amount'] = Variable<double>(totalAmount);
    map['refund_amount'] = Variable<double>(refundAmount);
    map['total_tax'] = Variable<double>(totalTax);
    map['status'] = Variable<String>(status);
    map['is_synced'] = Variable<int>(isSynced);
    map['created_by'] = Variable<String>(createdBy);
    map['return_date'] = Variable<DateTime>(returnDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  ReturnOrdersCompanion toCompanion(bool nullToAbsent) {
    return ReturnOrdersCompanion(
      id: Value(id),
      returnOrderNumber: Value(returnOrderNumber),
      saleOrderId: Value(saleOrderId),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      totalItems: Value(totalItems),
      totalAmount: Value(totalAmount),
      refundAmount: Value(refundAmount),
      totalTax: Value(totalTax),
      status: Value(status),
      isSynced: Value(isSynced),
      createdBy: Value(createdBy),
      returnDate: Value(returnDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory ReturnOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnOrder(
      id: serializer.fromJson<String>(json['id']),
      returnOrderNumber: serializer.fromJson<String>(json['returnOrderNumber']),
      saleOrderId: serializer.fromJson<String>(json['saleOrderId']),
      invoiceId: serializer.fromJson<String?>(json['invoiceId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      totalItems: serializer.fromJson<int>(json['totalItems']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      refundAmount: serializer.fromJson<double>(json['refundAmount']),
      totalTax: serializer.fromJson<double>(json['totalTax']),
      status: serializer.fromJson<String>(json['status']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      returnDate: serializer.fromJson<DateTime>(json['returnDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'returnOrderNumber': serializer.toJson<String>(returnOrderNumber),
      'saleOrderId': serializer.toJson<String>(saleOrderId),
      'invoiceId': serializer.toJson<String?>(invoiceId),
      'customerName': serializer.toJson<String?>(customerName),
      'branchId': serializer.toJson<String?>(branchId),
      'branchName': serializer.toJson<String?>(branchName),
      'totalItems': serializer.toJson<int>(totalItems),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'refundAmount': serializer.toJson<double>(refundAmount),
      'totalTax': serializer.toJson<double>(totalTax),
      'status': serializer.toJson<String>(status),
      'isSynced': serializer.toJson<int>(isSynced),
      'createdBy': serializer.toJson<String>(createdBy),
      'returnDate': serializer.toJson<DateTime>(returnDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  ReturnOrder copyWith({
    String? id,
    String? returnOrderNumber,
    String? saleOrderId,
    Value<String?> invoiceId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    Value<String?> branchId = const Value.absent(),
    Value<String?> branchName = const Value.absent(),
    int? totalItems,
    double? totalAmount,
    double? refundAmount,
    double? totalTax,
    String? status,
    int? isSynced,
    String? createdBy,
    DateTime? returnDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => ReturnOrder(
    id: id ?? this.id,
    returnOrderNumber: returnOrderNumber ?? this.returnOrderNumber,
    saleOrderId: saleOrderId ?? this.saleOrderId,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    customerName: customerName.present ? customerName.value : this.customerName,
    branchId: branchId.present ? branchId.value : this.branchId,
    branchName: branchName.present ? branchName.value : this.branchName,
    totalItems: totalItems ?? this.totalItems,
    totalAmount: totalAmount ?? this.totalAmount,
    refundAmount: refundAmount ?? this.refundAmount,
    totalTax: totalTax ?? this.totalTax,
    status: status ?? this.status,
    isSynced: isSynced ?? this.isSynced,
    createdBy: createdBy ?? this.createdBy,
    returnDate: returnDate ?? this.returnDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  ReturnOrder copyWithCompanion(ReturnOrdersCompanion data) {
    return ReturnOrder(
      id: data.id.present ? data.id.value : this.id,
      returnOrderNumber: data.returnOrderNumber.present
          ? data.returnOrderNumber.value
          : this.returnOrderNumber,
      saleOrderId: data.saleOrderId.present
          ? data.saleOrderId.value
          : this.saleOrderId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      totalItems: data.totalItems.present
          ? data.totalItems.value
          : this.totalItems,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      totalTax: data.totalTax.present ? data.totalTax.value : this.totalTax,
      status: data.status.present ? data.status.value : this.status,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      returnDate: data.returnDate.present
          ? data.returnDate.value
          : this.returnDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnOrder(')
          ..write('id: $id, ')
          ..write('returnOrderNumber: $returnOrderNumber, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerName: $customerName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalItems: $totalItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('totalTax: $totalTax, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('returnDate: $returnDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    returnOrderNumber,
    saleOrderId,
    invoiceId,
    customerName,
    branchId,
    branchName,
    totalItems,
    totalAmount,
    refundAmount,
    totalTax,
    status,
    isSynced,
    createdBy,
    returnDate,
    createdAt,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnOrder &&
          other.id == this.id &&
          other.returnOrderNumber == this.returnOrderNumber &&
          other.saleOrderId == this.saleOrderId &&
          other.invoiceId == this.invoiceId &&
          other.customerName == this.customerName &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.totalItems == this.totalItems &&
          other.totalAmount == this.totalAmount &&
          other.refundAmount == this.refundAmount &&
          other.totalTax == this.totalTax &&
          other.status == this.status &&
          other.isSynced == this.isSynced &&
          other.createdBy == this.createdBy &&
          other.returnDate == this.returnDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class ReturnOrdersCompanion extends UpdateCompanion<ReturnOrder> {
  final Value<String> id;
  final Value<String> returnOrderNumber;
  final Value<String> saleOrderId;
  final Value<String?> invoiceId;
  final Value<String?> customerName;
  final Value<String?> branchId;
  final Value<String?> branchName;
  final Value<int> totalItems;
  final Value<double> totalAmount;
  final Value<double> refundAmount;
  final Value<double> totalTax;
  final Value<String> status;
  final Value<int> isSynced;
  final Value<String> createdBy;
  final Value<DateTime> returnDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const ReturnOrdersCompanion({
    this.id = const Value.absent(),
    this.returnOrderNumber = const Value.absent(),
    this.saleOrderId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.totalItems = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.totalTax = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.returnDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReturnOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String returnOrderNumber,
    required String saleOrderId,
    this.invoiceId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    required int totalItems,
    required double totalAmount,
    required double refundAmount,
    this.totalTax = const Value.absent(),
    this.status = const Value.absent(),
    this.isSynced = const Value.absent(),
    required String createdBy,
    required DateTime returnDate,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : returnOrderNumber = Value(returnOrderNumber),
       saleOrderId = Value(saleOrderId),
       totalItems = Value(totalItems),
       totalAmount = Value(totalAmount),
       refundAmount = Value(refundAmount),
       createdBy = Value(createdBy),
       returnDate = Value(returnDate);
  static Insertable<ReturnOrder> custom({
    Expression<String>? id,
    Expression<String>? returnOrderNumber,
    Expression<String>? saleOrderId,
    Expression<String>? invoiceId,
    Expression<String>? customerName,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<int>? totalItems,
    Expression<double>? totalAmount,
    Expression<double>? refundAmount,
    Expression<double>? totalTax,
    Expression<String>? status,
    Expression<int>? isSynced,
    Expression<String>? createdBy,
    Expression<DateTime>? returnDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (returnOrderNumber != null) 'return_order_number': returnOrderNumber,
      if (saleOrderId != null) 'sale_order_id': saleOrderId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (customerName != null) 'customer_name': customerName,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (totalItems != null) 'total_items': totalItems,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (totalTax != null) 'total_tax': totalTax,
      if (status != null) 'status': status,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdBy != null) 'created_by': createdBy,
      if (returnDate != null) 'return_date': returnDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReturnOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? returnOrderNumber,
    Value<String>? saleOrderId,
    Value<String?>? invoiceId,
    Value<String?>? customerName,
    Value<String?>? branchId,
    Value<String?>? branchName,
    Value<int>? totalItems,
    Value<double>? totalAmount,
    Value<double>? refundAmount,
    Value<double>? totalTax,
    Value<String>? status,
    Value<int>? isSynced,
    Value<String>? createdBy,
    Value<DateTime>? returnDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return ReturnOrdersCompanion(
      id: id ?? this.id,
      returnOrderNumber: returnOrderNumber ?? this.returnOrderNumber,
      saleOrderId: saleOrderId ?? this.saleOrderId,
      invoiceId: invoiceId ?? this.invoiceId,
      customerName: customerName ?? this.customerName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalItems: totalItems ?? this.totalItems,
      totalAmount: totalAmount ?? this.totalAmount,
      refundAmount: refundAmount ?? this.refundAmount,
      totalTax: totalTax ?? this.totalTax,
      status: status ?? this.status,
      isSynced: isSynced ?? this.isSynced,
      createdBy: createdBy ?? this.createdBy,
      returnDate: returnDate ?? this.returnDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (returnOrderNumber.present) {
      map['return_order_number'] = Variable<String>(returnOrderNumber.value);
    }
    if (saleOrderId.present) {
      map['sale_order_id'] = Variable<String>(saleOrderId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (totalItems.present) {
      map['total_items'] = Variable<int>(totalItems.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (totalTax.present) {
      map['total_tax'] = Variable<double>(totalTax.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (returnDate.present) {
      map['return_date'] = Variable<DateTime>(returnDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnOrdersCompanion(')
          ..write('id: $id, ')
          ..write('returnOrderNumber: $returnOrderNumber, ')
          ..write('saleOrderId: $saleOrderId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('customerName: $customerName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalItems: $totalItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('totalTax: $totalTax, ')
          ..write('status: $status, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('returnDate: $returnDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReturnOrderItemsTable extends ReturnOrderItems
    with TableInfo<$ReturnOrderItemsTable, ReturnOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReturnOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _returnOrderIdMeta = const VerificationMeta(
    'returnOrderId',
  );
  @override
  late final GeneratedColumn<String> returnOrderId = GeneratedColumn<String>(
    'return_order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refundAmountMeta = const VerificationMeta(
    'refundAmount',
  );
  @override
  late final GeneratedColumn<double> refundAmount = GeneratedColumn<double>(
    'refund_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    returnOrderId,
    productId,
    productName,
    quantity,
    unitPrice,
    totalPrice,
    taxAmount,
    reason,
    refundAmount,
    isSynced,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'return_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReturnOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_order_id')) {
      context.handle(
        _returnOrderIdMeta,
        returnOrderId.isAcceptableOrUnknown(
          data['return_order_id']!,
          _returnOrderIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_returnOrderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('refund_amount')) {
      context.handle(
        _refundAmountMeta,
        refundAmount.isAcceptableOrUnknown(
          data['refund_amount']!,
          _refundAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_refundAmountMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReturnOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReturnOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      returnOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      refundAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_amount'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $ReturnOrderItemsTable createAlias(String alias) {
    return $ReturnOrderItemsTable(attachedDatabase, alias);
  }
}

class ReturnOrderItem extends DataClass implements Insertable<ReturnOrderItem> {
  final String id;
  final String returnOrderId;
  final String? productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double taxAmount;
  final String? reason;
  final double refundAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;
  const ReturnOrderItem({
    required this.id,
    required this.returnOrderId,
    this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.taxAmount,
    this.reason,
    required this.refundAmount,
    required this.isSynced,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['return_order_id'] = Variable<String>(returnOrderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total_price'] = Variable<double>(totalPrice);
    map['tax_amount'] = Variable<double>(taxAmount);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['refund_amount'] = Variable<double>(refundAmount);
    map['is_synced'] = Variable<int>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  ReturnOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return ReturnOrderItemsCompanion(
      id: Value(id),
      returnOrderId: Value(returnOrderId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      totalPrice: Value(totalPrice),
      taxAmount: Value(taxAmount),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      refundAmount: Value(refundAmount),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory ReturnOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReturnOrderItem(
      id: serializer.fromJson<String>(json['id']),
      returnOrderId: serializer.fromJson<String>(json['returnOrderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      reason: serializer.fromJson<String?>(json['reason']),
      refundAmount: serializer.fromJson<double>(json['refundAmount']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'returnOrderId': serializer.toJson<String>(returnOrderId),
      'productId': serializer.toJson<String?>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'reason': serializer.toJson<String?>(reason),
      'refundAmount': serializer.toJson<double>(refundAmount),
      'isSynced': serializer.toJson<int>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  ReturnOrderItem copyWith({
    String? id,
    String? returnOrderId,
    Value<String?> productId = const Value.absent(),
    String? productName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? taxAmount,
    Value<String?> reason = const Value.absent(),
    double? refundAmount,
    int? isSynced,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => ReturnOrderItem(
    id: id ?? this.id,
    returnOrderId: returnOrderId ?? this.returnOrderId,
    productId: productId.present ? productId.value : this.productId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    totalPrice: totalPrice ?? this.totalPrice,
    taxAmount: taxAmount ?? this.taxAmount,
    reason: reason.present ? reason.value : this.reason,
    refundAmount: refundAmount ?? this.refundAmount,
    isSynced: isSynced ?? this.isSynced,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  ReturnOrderItem copyWithCompanion(ReturnOrderItemsCompanion data) {
    return ReturnOrderItem(
      id: data.id.present ? data.id.value : this.id,
      returnOrderId: data.returnOrderId.present
          ? data.returnOrderId.value
          : this.returnOrderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      reason: data.reason.present ? data.reason.value : this.reason,
      refundAmount: data.refundAmount.present
          ? data.refundAmount.value
          : this.refundAmount,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReturnOrderItem(')
          ..write('id: $id, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('reason: $reason, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    returnOrderId,
    productId,
    productName,
    quantity,
    unitPrice,
    totalPrice,
    taxAmount,
    reason,
    refundAmount,
    isSynced,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReturnOrderItem &&
          other.id == this.id &&
          other.returnOrderId == this.returnOrderId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalPrice == this.totalPrice &&
          other.taxAmount == this.taxAmount &&
          other.reason == this.reason &&
          other.refundAmount == this.refundAmount &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class ReturnOrderItemsCompanion extends UpdateCompanion<ReturnOrderItem> {
  final Value<String> id;
  final Value<String> returnOrderId;
  final Value<String?> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> totalPrice;
  final Value<double> taxAmount;
  final Value<String?> reason;
  final Value<double> refundAmount;
  final Value<int> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const ReturnOrderItemsCompanion({
    this.id = const Value.absent(),
    this.returnOrderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.reason = const Value.absent(),
    this.refundAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReturnOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required String returnOrderId,
    this.productId = const Value.absent(),
    required String productName,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    this.taxAmount = const Value.absent(),
    this.reason = const Value.absent(),
    required double refundAmount,
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : returnOrderId = Value(returnOrderId),
       productName = Value(productName),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       totalPrice = Value(totalPrice),
       refundAmount = Value(refundAmount);
  static Insertable<ReturnOrderItem> custom({
    Expression<String>? id,
    Expression<String>? returnOrderId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalPrice,
    Expression<double>? taxAmount,
    Expression<String>? reason,
    Expression<double>? refundAmount,
    Expression<int>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (returnOrderId != null) 'return_order_id': returnOrderId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (reason != null) 'reason': reason,
      if (refundAmount != null) 'refund_amount': refundAmount,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReturnOrderItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? returnOrderId,
    Value<String?>? productId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? totalPrice,
    Value<double>? taxAmount,
    Value<String?>? reason,
    Value<double>? refundAmount,
    Value<int>? isSynced,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return ReturnOrderItemsCompanion(
      id: id ?? this.id,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      taxAmount: taxAmount ?? this.taxAmount,
      reason: reason ?? this.reason,
      refundAmount: refundAmount ?? this.refundAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (returnOrderId.present) {
      map['return_order_id'] = Variable<String>(returnOrderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (refundAmount.present) {
      map['refund_amount'] = Variable<double>(refundAmount.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReturnOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('reason: $reason, ')
          ..write('refundAmount: $refundAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreditNotesTable extends CreditNotes
    with TableInfo<$CreditNotesTable, CreditNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _creditNoteNumberMeta = const VerificationMeta(
    'creditNoteNumber',
  );
  @override
  late final GeneratedColumn<String> creditNoteNumber = GeneratedColumn<String>(
    'credit_note_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnOrderIdMeta = const VerificationMeta(
    'returnOrderId',
  );
  @override
  late final GeneratedColumn<String> returnOrderId = GeneratedColumn<String>(
    'return_order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalItemsMeta = const VerificationMeta(
    'totalItems',
  );
  @override
  late final GeneratedColumn<int> totalItems = GeneratedColumn<int>(
    'total_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appliedAmountMeta = const VerificationMeta(
    'appliedAmount',
  );
  @override
  late final GeneratedColumn<double> appliedAmount = GeneratedColumn<double>(
    'applied_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creditNoteNumber,
    invoiceId,
    returnOrderId,
    customerName,
    branchId,
    branchName,
    totalItems,
    totalAmount,
    appliedAmount,
    status,
    note,
    isSynced,
    createdBy,
    issuedAt,
    dueDate,
    createdAt,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit_note_number')) {
      context.handle(
        _creditNoteNumberMeta,
        creditNoteNumber.isAcceptableOrUnknown(
          data['credit_note_number']!,
          _creditNoteNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNoteNumberMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('return_order_id')) {
      context.handle(
        _returnOrderIdMeta,
        returnOrderId.isAcceptableOrUnknown(
          data['return_order_id']!,
          _returnOrderIdMeta,
        ),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    }
    if (data.containsKey('total_items')) {
      context.handle(
        _totalItemsMeta,
        totalItems.isAcceptableOrUnknown(data['total_items']!, _totalItemsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalItemsMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('applied_amount')) {
      context.handle(
        _appliedAmountMeta,
        appliedAmount.isAcceptableOrUnknown(
          data['applied_amount']!,
          _appliedAmountMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_issuedAtMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      creditNoteNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_note_number'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      ),
      returnOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_order_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      ),
      totalItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_items'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      appliedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}applied_amount'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $CreditNotesTable createAlias(String alias) {
    return $CreditNotesTable(attachedDatabase, alias);
  }
}

class CreditNote extends DataClass implements Insertable<CreditNote> {
  final String id;
  final String creditNoteNumber;
  final String? invoiceId;
  final String? returnOrderId;
  final String? customerName;
  final String? branchId;
  final String? branchName;
  final int totalItems;
  final double totalAmount;
  final double appliedAmount;
  final String status;
  final String? note;
  final int isSynced;
  final String createdBy;
  final DateTime issuedAt;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const CreditNote({
    required this.id,
    required this.creditNoteNumber,
    this.invoiceId,
    this.returnOrderId,
    this.customerName,
    this.branchId,
    this.branchName,
    required this.totalItems,
    required this.totalAmount,
    required this.appliedAmount,
    required this.status,
    this.note,
    required this.isSynced,
    required this.createdBy,
    required this.issuedAt,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['credit_note_number'] = Variable<String>(creditNoteNumber);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<String>(invoiceId);
    }
    if (!nullToAbsent || returnOrderId != null) {
      map['return_order_id'] = Variable<String>(returnOrderId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || branchName != null) {
      map['branch_name'] = Variable<String>(branchName);
    }
    map['total_items'] = Variable<int>(totalItems);
    map['total_amount'] = Variable<double>(totalAmount);
    map['applied_amount'] = Variable<double>(appliedAmount);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_synced'] = Variable<int>(isSynced);
    map['created_by'] = Variable<String>(createdBy);
    map['issued_at'] = Variable<DateTime>(issuedAt);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  CreditNotesCompanion toCompanion(bool nullToAbsent) {
    return CreditNotesCompanion(
      id: Value(id),
      creditNoteNumber: Value(creditNoteNumber),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      returnOrderId: returnOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(returnOrderId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      branchName: branchName == null && nullToAbsent
          ? const Value.absent()
          : Value(branchName),
      totalItems: Value(totalItems),
      totalAmount: Value(totalAmount),
      appliedAmount: Value(appliedAmount),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isSynced: Value(isSynced),
      createdBy: Value(createdBy),
      issuedAt: Value(issuedAt),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory CreditNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNote(
      id: serializer.fromJson<String>(json['id']),
      creditNoteNumber: serializer.fromJson<String>(json['creditNoteNumber']),
      invoiceId: serializer.fromJson<String?>(json['invoiceId']),
      returnOrderId: serializer.fromJson<String?>(json['returnOrderId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      branchName: serializer.fromJson<String?>(json['branchName']),
      totalItems: serializer.fromJson<int>(json['totalItems']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      appliedAmount: serializer.fromJson<double>(json['appliedAmount']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'creditNoteNumber': serializer.toJson<String>(creditNoteNumber),
      'invoiceId': serializer.toJson<String?>(invoiceId),
      'returnOrderId': serializer.toJson<String?>(returnOrderId),
      'customerName': serializer.toJson<String?>(customerName),
      'branchId': serializer.toJson<String?>(branchId),
      'branchName': serializer.toJson<String?>(branchName),
      'totalItems': serializer.toJson<int>(totalItems),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'appliedAmount': serializer.toJson<double>(appliedAmount),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
      'isSynced': serializer.toJson<int>(isSynced),
      'createdBy': serializer.toJson<String>(createdBy),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  CreditNote copyWith({
    String? id,
    String? creditNoteNumber,
    Value<String?> invoiceId = const Value.absent(),
    Value<String?> returnOrderId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    Value<String?> branchId = const Value.absent(),
    Value<String?> branchName = const Value.absent(),
    int? totalItems,
    double? totalAmount,
    double? appliedAmount,
    String? status,
    Value<String?> note = const Value.absent(),
    int? isSynced,
    String? createdBy,
    DateTime? issuedAt,
    Value<DateTime?> dueDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => CreditNote(
    id: id ?? this.id,
    creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    returnOrderId: returnOrderId.present
        ? returnOrderId.value
        : this.returnOrderId,
    customerName: customerName.present ? customerName.value : this.customerName,
    branchId: branchId.present ? branchId.value : this.branchId,
    branchName: branchName.present ? branchName.value : this.branchName,
    totalItems: totalItems ?? this.totalItems,
    totalAmount: totalAmount ?? this.totalAmount,
    appliedAmount: appliedAmount ?? this.appliedAmount,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
    isSynced: isSynced ?? this.isSynced,
    createdBy: createdBy ?? this.createdBy,
    issuedAt: issuedAt ?? this.issuedAt,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  CreditNote copyWithCompanion(CreditNotesCompanion data) {
    return CreditNote(
      id: data.id.present ? data.id.value : this.id,
      creditNoteNumber: data.creditNoteNumber.present
          ? data.creditNoteNumber.value
          : this.creditNoteNumber,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      returnOrderId: data.returnOrderId.present
          ? data.returnOrderId.value
          : this.returnOrderId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      totalItems: data.totalItems.present
          ? data.totalItems.value
          : this.totalItems,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      appliedAmount: data.appliedAmount.present
          ? data.appliedAmount.value
          : this.appliedAmount,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNote(')
          ..write('id: $id, ')
          ..write('creditNoteNumber: $creditNoteNumber, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('customerName: $customerName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalItems: $totalItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('appliedAmount: $appliedAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditNoteNumber,
    invoiceId,
    returnOrderId,
    customerName,
    branchId,
    branchName,
    totalItems,
    totalAmount,
    appliedAmount,
    status,
    note,
    isSynced,
    createdBy,
    issuedAt,
    dueDate,
    createdAt,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNote &&
          other.id == this.id &&
          other.creditNoteNumber == this.creditNoteNumber &&
          other.invoiceId == this.invoiceId &&
          other.returnOrderId == this.returnOrderId &&
          other.customerName == this.customerName &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.totalItems == this.totalItems &&
          other.totalAmount == this.totalAmount &&
          other.appliedAmount == this.appliedAmount &&
          other.status == this.status &&
          other.note == this.note &&
          other.isSynced == this.isSynced &&
          other.createdBy == this.createdBy &&
          other.issuedAt == this.issuedAt &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CreditNotesCompanion extends UpdateCompanion<CreditNote> {
  final Value<String> id;
  final Value<String> creditNoteNumber;
  final Value<String?> invoiceId;
  final Value<String?> returnOrderId;
  final Value<String?> customerName;
  final Value<String?> branchId;
  final Value<String?> branchName;
  final Value<int> totalItems;
  final Value<double> totalAmount;
  final Value<double> appliedAmount;
  final Value<String> status;
  final Value<String?> note;
  final Value<int> isSynced;
  final Value<String> createdBy;
  final Value<DateTime> issuedAt;
  final Value<DateTime?> dueDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const CreditNotesCompanion({
    this.id = const Value.absent(),
    this.creditNoteNumber = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.returnOrderId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.totalItems = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.appliedAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditNotesCompanion.insert({
    this.id = const Value.absent(),
    required String creditNoteNumber,
    this.invoiceId = const Value.absent(),
    this.returnOrderId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    required int totalItems,
    required double totalAmount,
    this.appliedAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.isSynced = const Value.absent(),
    required String createdBy,
    required DateTime issuedAt,
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : creditNoteNumber = Value(creditNoteNumber),
       totalItems = Value(totalItems),
       totalAmount = Value(totalAmount),
       createdBy = Value(createdBy),
       issuedAt = Value(issuedAt);
  static Insertable<CreditNote> custom({
    Expression<String>? id,
    Expression<String>? creditNoteNumber,
    Expression<String>? invoiceId,
    Expression<String>? returnOrderId,
    Expression<String>? customerName,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<int>? totalItems,
    Expression<double>? totalAmount,
    Expression<double>? appliedAmount,
    Expression<String>? status,
    Expression<String>? note,
    Expression<int>? isSynced,
    Expression<String>? createdBy,
    Expression<DateTime>? issuedAt,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditNoteNumber != null) 'credit_note_number': creditNoteNumber,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (returnOrderId != null) 'return_order_id': returnOrderId,
      if (customerName != null) 'customer_name': customerName,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (totalItems != null) 'total_items': totalItems,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (appliedAmount != null) 'applied_amount': appliedAmount,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdBy != null) 'created_by': createdBy,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? creditNoteNumber,
    Value<String?>? invoiceId,
    Value<String?>? returnOrderId,
    Value<String?>? customerName,
    Value<String?>? branchId,
    Value<String?>? branchName,
    Value<int>? totalItems,
    Value<double>? totalAmount,
    Value<double>? appliedAmount,
    Value<String>? status,
    Value<String?>? note,
    Value<int>? isSynced,
    Value<String>? createdBy,
    Value<DateTime>? issuedAt,
    Value<DateTime?>? dueDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return CreditNotesCompanion(
      id: id ?? this.id,
      creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
      invoiceId: invoiceId ?? this.invoiceId,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      customerName: customerName ?? this.customerName,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      totalItems: totalItems ?? this.totalItems,
      totalAmount: totalAmount ?? this.totalAmount,
      appliedAmount: appliedAmount ?? this.appliedAmount,
      status: status ?? this.status,
      note: note ?? this.note,
      isSynced: isSynced ?? this.isSynced,
      createdBy: createdBy ?? this.createdBy,
      issuedAt: issuedAt ?? this.issuedAt,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creditNoteNumber.present) {
      map['credit_note_number'] = Variable<String>(creditNoteNumber.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (returnOrderId.present) {
      map['return_order_id'] = Variable<String>(returnOrderId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (totalItems.present) {
      map['total_items'] = Variable<int>(totalItems.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (appliedAmount.present) {
      map['applied_amount'] = Variable<double>(appliedAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNotesCompanion(')
          ..write('id: $id, ')
          ..write('creditNoteNumber: $creditNoteNumber, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('customerName: $customerName, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('totalItems: $totalItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('appliedAmount: $appliedAmount, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdBy: $createdBy, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreditNoteItemsTable extends CreditNoteItems
    with TableInfo<$CreditNoteItemsTable, CreditNoteItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNoteItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _creditNoteIdMeta = const VerificationMeta(
    'creditNoteId',
  );
  @override
  late final GeneratedColumn<String> creditNoteId = GeneratedColumn<String>(
    'credit_note_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<int> isSynced = GeneratedColumn<int>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creditNoteId,
    productId,
    description,
    quantity,
    unitPrice,
    totalPrice,
    taxAmount,
    isSynced,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_note_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNoteItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit_note_id')) {
      context.handle(
        _creditNoteIdMeta,
        creditNoteId.isAcceptableOrUnknown(
          data['credit_note_id']!,
          _creditNoteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNoteIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditNoteItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNoteItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      creditNoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_note_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_synced'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $CreditNoteItemsTable createAlias(String alias) {
    return $CreditNoteItemsTable(attachedDatabase, alias);
  }
}

class CreditNoteItem extends DataClass implements Insertable<CreditNoteItem> {
  final String id;
  final String creditNoteId;
  final String? productId;
  final String description;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double taxAmount;
  final int isSynced;
  final DateTime? lastSyncedAt;
  const CreditNoteItem({
    required this.id,
    required this.creditNoteId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.taxAmount,
    required this.isSynced,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['credit_note_id'] = Variable<String>(creditNoteId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total_price'] = Variable<double>(totalPrice);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['is_synced'] = Variable<int>(isSynced);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  CreditNoteItemsCompanion toCompanion(bool nullToAbsent) {
    return CreditNoteItemsCompanion(
      id: Value(id),
      creditNoteId: Value(creditNoteId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      totalPrice: Value(totalPrice),
      taxAmount: Value(taxAmount),
      isSynced: Value(isSynced),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory CreditNoteItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNoteItem(
      id: serializer.fromJson<String>(json['id']),
      creditNoteId: serializer.fromJson<String>(json['creditNoteId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      isSynced: serializer.fromJson<int>(json['isSynced']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'creditNoteId': serializer.toJson<String>(creditNoteId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'isSynced': serializer.toJson<int>(isSynced),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  CreditNoteItem copyWith({
    String? id,
    String? creditNoteId,
    Value<String?> productId = const Value.absent(),
    String? description,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    double? taxAmount,
    int? isSynced,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => CreditNoteItem(
    id: id ?? this.id,
    creditNoteId: creditNoteId ?? this.creditNoteId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    totalPrice: totalPrice ?? this.totalPrice,
    taxAmount: taxAmount ?? this.taxAmount,
    isSynced: isSynced ?? this.isSynced,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  CreditNoteItem copyWithCompanion(CreditNoteItemsCompanion data) {
    return CreditNoteItem(
      id: data.id.present ? data.id.value : this.id,
      creditNoteId: data.creditNoteId.present
          ? data.creditNoteId.value
          : this.creditNoteId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItem(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditNoteId,
    productId,
    description,
    quantity,
    unitPrice,
    totalPrice,
    taxAmount,
    isSynced,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNoteItem &&
          other.id == this.id &&
          other.creditNoteId == this.creditNoteId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalPrice == this.totalPrice &&
          other.taxAmount == this.taxAmount &&
          other.isSynced == this.isSynced &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class CreditNoteItemsCompanion extends UpdateCompanion<CreditNoteItem> {
  final Value<String> id;
  final Value<String> creditNoteId;
  final Value<String?> productId;
  final Value<String> description;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> totalPrice;
  final Value<double> taxAmount;
  final Value<int> isSynced;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const CreditNoteItemsCompanion({
    this.id = const Value.absent(),
    this.creditNoteId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditNoteItemsCompanion.insert({
    this.id = const Value.absent(),
    required String creditNoteId,
    this.productId = const Value.absent(),
    required String description,
    required int quantity,
    required double unitPrice,
    required double totalPrice,
    this.taxAmount = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : creditNoteId = Value(creditNoteId),
       description = Value(description),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       totalPrice = Value(totalPrice);
  static Insertable<CreditNoteItem> custom({
    Expression<String>? id,
    Expression<String>? creditNoteId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalPrice,
    Expression<double>? taxAmount,
    Expression<int>? isSynced,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditNoteId != null) 'credit_note_id': creditNoteId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (isSynced != null) 'is_synced': isSynced,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditNoteItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? creditNoteId,
    Value<String?>? productId,
    Value<String>? description,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? totalPrice,
    Value<double>? taxAmount,
    Value<int>? isSynced,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return CreditNoteItemsCompanion(
      id: id ?? this.id,
      creditNoteId: creditNoteId ?? this.creditNoteId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      taxAmount: taxAmount ?? this.taxAmount,
      isSynced: isSynced ?? this.isSynced,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (creditNoteId.present) {
      map['credit_note_id'] = Variable<String>(creditNoteId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<int>(isSynced.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItemsCompanion(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('isSynced: $isSynced, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockReportsTable extends StockReports
    with TableInfo<$StockReportsTable, StockReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<String> currentStock = GeneratedColumn<String>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryStockMeta = const VerificationMeta(
    'categoryStock',
  );
  @override
  late final GeneratedColumn<String> categoryStock = GeneratedColumn<String>(
    'category_stock',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    branchName,
    currentStock,
    categoryStock,
    createdAt,
    createdBy,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentStockMeta);
    }
    if (data.containsKey('category_stock')) {
      context.handle(
        _categoryStockMeta,
        categoryStock.isAcceptableOrUnknown(
          data['category_stock']!,
          _categoryStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryStockMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_stock'],
      )!,
      categoryStock: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_stock'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StockReportsTable createAlias(String alias) {
    return $StockReportsTable(attachedDatabase, alias);
  }
}

class StockReport extends DataClass implements Insertable<StockReport> {
  final String id;
  final String branchId;
  final String branchName;
  final String currentStock;
  final String categoryStock;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  const StockReport({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.currentStock,
    required this.categoryStock,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['branch_name'] = Variable<String>(branchName);
    map['current_stock'] = Variable<String>(currentStock);
    map['category_stock'] = Variable<String>(categoryStock);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['created_by'] = Variable<String>(createdBy);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StockReportsCompanion toCompanion(bool nullToAbsent) {
    return StockReportsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      branchName: Value(branchName),
      currentStock: Value(currentStock),
      categoryStock: Value(categoryStock),
      createdAt: Value(createdAt),
      createdBy: Value(createdBy),
      updatedAt: Value(updatedAt),
    );
  }

  factory StockReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockReport(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      currentStock: serializer.fromJson<String>(json['currentStock']),
      categoryStock: serializer.fromJson<String>(json['categoryStock']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'branchName': serializer.toJson<String>(branchName),
      'currentStock': serializer.toJson<String>(currentStock),
      'categoryStock': serializer.toJson<String>(categoryStock),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String>(createdBy),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StockReport copyWith({
    String? id,
    String? branchId,
    String? branchName,
    String? currentStock,
    String? categoryStock,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
  }) => StockReport(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    branchName: branchName ?? this.branchName,
    currentStock: currentStock ?? this.currentStock,
    categoryStock: categoryStock ?? this.categoryStock,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StockReport copyWithCompanion(StockReportsCompanion data) {
    return StockReport(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      categoryStock: data.categoryStock.present
          ? data.categoryStock.value
          : this.categoryStock,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockReport(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('currentStock: $currentStock, ')
          ..write('categoryStock: $categoryStock, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    branchName,
    currentStock,
    categoryStock,
    createdAt,
    createdBy,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockReport &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.currentStock == this.currentStock &&
          other.categoryStock == this.categoryStock &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy &&
          other.updatedAt == this.updatedAt);
}

class StockReportsCompanion extends UpdateCompanion<StockReport> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> branchName;
  final Value<String> currentStock;
  final Value<String> categoryStock;
  final Value<DateTime> createdAt;
  final Value<String> createdBy;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StockReportsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.categoryStock = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockReportsCompanion.insert({
    this.id = const Value.absent(),
    required String branchId,
    required String branchName,
    required String currentStock,
    required String categoryStock,
    required DateTime createdAt,
    required String createdBy,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : branchId = Value(branchId),
       branchName = Value(branchName),
       currentStock = Value(currentStock),
       categoryStock = Value(categoryStock),
       createdAt = Value(createdAt),
       createdBy = Value(createdBy),
       updatedAt = Value(updatedAt);
  static Insertable<StockReport> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<String>? currentStock,
    Expression<String>? categoryStock,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (currentStock != null) 'current_stock': currentStock,
      if (categoryStock != null) 'category_stock': categoryStock,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockReportsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? branchName,
    Value<String>? currentStock,
    Value<String>? categoryStock,
    Value<DateTime>? createdAt,
    Value<String>? createdBy,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StockReportsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      currentStock: currentStock ?? this.currentStock,
      categoryStock: categoryStock ?? this.categoryStock,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<String>(currentStock.value);
    }
    if (categoryStock.present) {
      map['category_stock'] = Variable<String>(categoryStock.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockReportsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('currentStock: $currentStock, ')
          ..write('categoryStock: $categoryStock, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _expenseTypeMeta = const VerificationMeta(
    'expenseType',
  );
  @override
  late final GeneratedColumn<String> expenseType = GeneratedColumn<String>(
    'expense_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseType,
    description,
    amount,
    paymentMethod,
    createdAt,
    branchId,
    branchName,
    expenseDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('expense_type')) {
      context.handle(
        _expenseTypeMeta,
        expenseType.isAcceptableOrUnknown(
          data['expense_type']!,
          _expenseTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      expenseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expense_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final String expenseType;
  final String? description;
  final double amount;
  final String paymentMethod;
  final DateTime createdAt;
  final String branchId;
  final String branchName;
  final DateTime expenseDate;
  const Expense({
    required this.id,
    required this.expenseType,
    this.description,
    required this.amount,
    required this.paymentMethod,
    required this.createdAt,
    required this.branchId,
    required this.branchName,
    required this.expenseDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['expense_type'] = Variable<String>(expenseType);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['branch_id'] = Variable<String>(branchId);
    map['branch_name'] = Variable<String>(branchName);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      expenseType: Value(expenseType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      createdAt: Value(createdAt),
      branchId: Value(branchId),
      branchName: Value(branchName),
      expenseDate: Value(expenseDate),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      expenseType: serializer.fromJson<String>(json['expenseType']),
      description: serializer.fromJson<String?>(json['description']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      branchId: serializer.fromJson<String>(json['branchId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'expenseType': serializer.toJson<String>(expenseType),
      'description': serializer.toJson<String?>(description),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'branchId': serializer.toJson<String>(branchId),
      'branchName': serializer.toJson<String>(branchName),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
    };
  }

  Expense copyWith({
    String? id,
    String? expenseType,
    Value<String?> description = const Value.absent(),
    double? amount,
    String? paymentMethod,
    DateTime? createdAt,
    String? branchId,
    String? branchName,
    DateTime? expenseDate,
  }) => Expense(
    id: id ?? this.id,
    expenseType: expenseType ?? this.expenseType,
    description: description.present ? description.value : this.description,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
    branchId: branchId ?? this.branchId,
    branchName: branchName ?? this.branchName,
    expenseDate: expenseDate ?? this.expenseDate,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      expenseType: data.expenseType.present
          ? data.expenseType.value
          : this.expenseType,
      description: data.description.present
          ? data.description.value
          : this.description,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('expenseType: $expenseType, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('expenseDate: $expenseDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    expenseType,
    description,
    amount,
    paymentMethod,
    createdAt,
    branchId,
    branchName,
    expenseDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.expenseType == this.expenseType &&
          other.description == this.description &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.expenseDate == this.expenseDate);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> expenseType;
  final Value<String?> description;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<DateTime> createdAt;
  final Value<String> branchId;
  final Value<String> branchName;
  final Value<DateTime> expenseDate;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.expenseType = const Value.absent(),
    this.description = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String expenseType,
    this.description = const Value.absent(),
    required double amount,
    required String paymentMethod,
    required DateTime createdAt,
    required String branchId,
    required String branchName,
    required DateTime expenseDate,
    this.rowid = const Value.absent(),
  }) : expenseType = Value(expenseType),
       amount = Value(amount),
       paymentMethod = Value(paymentMethod),
       createdAt = Value(createdAt),
       branchId = Value(branchId),
       branchName = Value(branchName),
       expenseDate = Value(expenseDate);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? expenseType,
    Expression<String>? description,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<DateTime>? expenseDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseType != null) 'expense_type': expenseType,
      if (description != null) 'description': description,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? expenseType,
    Value<String?>? description,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<DateTime>? createdAt,
    Value<String>? branchId,
    Value<String>? branchName,
    Value<DateTime>? expenseDate,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      expenseType: expenseType ?? this.expenseType,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      expenseDate: expenseDate ?? this.expenseDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseType.present) {
      map['expense_type'] = Variable<String>(expenseType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('expenseType: $expenseType, ')
          ..write('description: $description, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BranchPaymentsTable extends BranchPayments
    with TableInfo<$BranchPaymentsTable, BranchPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    branchName,
    amount,
    note,
    title,
    createdAt,
    createdBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branch_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<BranchPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BranchPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BranchPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      )!,
    );
  }

  @override
  $BranchPaymentsTable createAlias(String alias) {
    return $BranchPaymentsTable(attachedDatabase, alias);
  }
}

class BranchPayment extends DataClass implements Insertable<BranchPayment> {
  final String id;
  final String branchId;
  final String branchName;
  final double amount;
  final String? note;
  final String title;
  final DateTime createdAt;
  final String createdBy;
  const BranchPayment({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.amount,
    this.note,
    required this.title,
    required this.createdAt,
    required this.createdBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['branch_name'] = Variable<String>(branchName);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['created_by'] = Variable<String>(createdBy);
    return map;
  }

  BranchPaymentsCompanion toCompanion(bool nullToAbsent) {
    return BranchPaymentsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      branchName: Value(branchName),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      title: Value(title),
      createdAt: Value(createdAt),
      createdBy: Value(createdBy),
    );
  }

  factory BranchPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BranchPayment(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'branchName': serializer.toJson<String>(branchName),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String?>(note),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String>(createdBy),
    };
  }

  BranchPayment copyWith({
    String? id,
    String? branchId,
    String? branchName,
    double? amount,
    Value<String?> note = const Value.absent(),
    String? title,
    DateTime? createdAt,
    String? createdBy,
  }) => BranchPayment(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    branchName: branchName ?? this.branchName,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
  );
  BranchPayment copyWithCompanion(BranchPaymentsCompanion data) {
    return BranchPayment(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BranchPayment(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    branchName,
    amount,
    note,
    title,
    createdAt,
    createdBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchPayment &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.branchName == this.branchName &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy);
}

class BranchPaymentsCompanion extends UpdateCompanion<BranchPayment> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> branchName;
  final Value<double> amount;
  final Value<String?> note;
  final Value<String> title;
  final Value<DateTime> createdAt;
  final Value<String> createdBy;
  final Value<int> rowid;
  const BranchPaymentsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required String branchId,
    required String branchName,
    required double amount,
    this.note = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required String createdBy,
    this.rowid = const Value.absent(),
  }) : branchId = Value(branchId),
       branchName = Value(branchName),
       amount = Value(amount),
       title = Value(title),
       createdAt = Value(createdAt),
       createdBy = Value(createdBy);
  static Insertable<BranchPayment> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? branchName,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchPaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? branchName,
    Value<double>? amount,
    Value<String?>? note,
    Value<String>? title,
    Value<DateTime>? createdAt,
    Value<String>? createdBy,
    Value<int>? rowid,
  }) {
    return BranchPaymentsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('branchName: $branchName, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $StoresTable stores = $StoresTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $TaxesTable taxes = $TaxesTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ProductBrandsTable productBrands = $ProductBrandsTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $ProductSubCategoriesTable productSubCategories =
      $ProductSubCategoriesTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $SaleOrdersTable saleOrders = $SaleOrdersTable(this);
  late final $SaleOrderItemsTable saleOrderItems = $SaleOrderItemsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $ProformasTable proformas = $ProformasTable(this);
  late final $ProductDetailsListTable productDetailsList =
      $ProductDetailsListTable(this);
  late final $WayBillsTable wayBills = $WayBillsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $ReturnOrdersTable returnOrders = $ReturnOrdersTable(this);
  late final $ReturnOrderItemsTable returnOrderItems = $ReturnOrderItemsTable(
    this,
  );
  late final $CreditNotesTable creditNotes = $CreditNotesTable(this);
  late final $CreditNoteItemsTable creditNoteItems = $CreditNoteItemsTable(
    this,
  );
  late final $StockReportsTable stockReports = $StockReportsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $BranchPaymentsTable branchPayments = $BranchPaymentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    branches,
    stores,
    employees,
    customers,
    taxes,
    suppliers,
    productBrands,
    productCategories,
    productSubCategories,
    inventoryItems,
    saleOrders,
    saleOrderItems,
    receipts,
    proformas,
    productDetailsList,
    wayBills,
    invoices,
    returnOrders,
    returnOrderItems,
    creditNotes,
    creditNoteItems,
    stockReports,
    expenses,
    branchPayments,
  ];
}

typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      required String storeId,
      required String storeName,
      required String branchName,
      Value<String?> branchAddress,
      Value<String?> contact,
      Value<int> isActive,
      Value<int> isDeleted,
      required String companyDetails,
      Value<String?> branchManagerName,
      Value<String?> branchManagerId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      Value<String> storeId,
      Value<String> storeName,
      Value<String> branchName,
      Value<String?> branchAddress,
      Value<String?> contact,
      Value<int> isActive,
      Value<int> isDeleted,
      Value<String> companyDetails,
      Value<String?> branchManagerName,
      Value<String?> branchManagerId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storeId => $composableBuilder(
    column: $table.storeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storeName => $composableBuilder(
    column: $table.storeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchAddress => $composableBuilder(
    column: $table.branchAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contact => $composableBuilder(
    column: $table.contact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyDetails => $composableBuilder(
    column: $table.companyDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchManagerName => $composableBuilder(
    column: $table.branchManagerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchManagerId => $composableBuilder(
    column: $table.branchManagerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storeId => $composableBuilder(
    column: $table.storeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storeName => $composableBuilder(
    column: $table.storeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchAddress => $composableBuilder(
    column: $table.branchAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contact => $composableBuilder(
    column: $table.contact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyDetails => $composableBuilder(
    column: $table.companyDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchManagerName => $composableBuilder(
    column: $table.branchManagerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchManagerId => $composableBuilder(
    column: $table.branchManagerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get storeId =>
      $composableBuilder(column: $table.storeId, builder: (column) => column);

  GeneratedColumn<String> get storeName =>
      $composableBuilder(column: $table.storeName, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchAddress => $composableBuilder(
    column: $table.branchAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contact =>
      $composableBuilder(column: $table.contact, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get companyDetails => $composableBuilder(
    column: $table.companyDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchManagerName => $composableBuilder(
    column: $table.branchManagerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchManagerId => $composableBuilder(
    column: $table.branchManagerId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branche,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branche, BaseReferences<_$AppDatabase, $BranchesTable, Branche>),
          Branche,
          PrefetchHooks Function()
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> storeId = const Value.absent(),
                Value<String> storeName = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<String?> branchAddress = const Value.absent(),
                Value<String?> contact = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> isDeleted = const Value.absent(),
                Value<String> companyDetails = const Value.absent(),
                Value<String?> branchManagerName = const Value.absent(),
                Value<String?> branchManagerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                storeId: storeId,
                storeName: storeName,
                branchName: branchName,
                branchAddress: branchAddress,
                contact: contact,
                isActive: isActive,
                isDeleted: isDeleted,
                companyDetails: companyDetails,
                branchManagerName: branchManagerName,
                branchManagerId: branchManagerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String storeId,
                required String storeName,
                required String branchName,
                Value<String?> branchAddress = const Value.absent(),
                Value<String?> contact = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<int> isDeleted = const Value.absent(),
                required String companyDetails,
                Value<String?> branchManagerName = const Value.absent(),
                Value<String?> branchManagerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                storeId: storeId,
                storeName: storeName,
                branchName: branchName,
                branchAddress: branchAddress,
                contact: contact,
                isActive: isActive,
                isDeleted: isDeleted,
                companyDetails: companyDetails,
                branchManagerName: branchManagerName,
                branchManagerId: branchManagerId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branche,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branche, BaseReferences<_$AppDatabase, $BranchesTable, Branche>),
      Branche,
      PrefetchHooks Function()
    >;
typedef $$StoresTableCreateCompanionBuilder =
    StoresCompanion Function({
      Value<String> id,
      required String name,
      required String address,
      Value<int> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$StoresTableUpdateCompanionBuilder =
    StoresCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> address,
      Value<int> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$StoresTableFilterComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoresTableOrderingComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoresTable> {
  $$StoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoresTable,
          Store,
          $$StoresTableFilterComposer,
          $$StoresTableOrderingComposer,
          $$StoresTableAnnotationComposer,
          $$StoresTableCreateCompanionBuilder,
          $$StoresTableUpdateCompanionBuilder,
          (Store, BaseReferences<_$AppDatabase, $StoresTable, Store>),
          Store,
          PrefetchHooks Function()
        > {
  $$StoresTableTableManager(_$AppDatabase db, $StoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoresCompanion(
                id: id,
                name: name,
                address: address,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String address,
                Value<int> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoresCompanion.insert(
                id: id,
                name: name,
                address: address,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoresTable,
      Store,
      $$StoresTableFilterComposer,
      $$StoresTableOrderingComposer,
      $$StoresTableAnnotationComposer,
      $$StoresTableCreateCompanionBuilder,
      $$StoresTableUpdateCompanionBuilder,
      (Store, BaseReferences<_$AppDatabase, $StoresTable, Store>),
      Store,
      PrefetchHooks Function()
    >;
typedef $$EmployeesTableCreateCompanionBuilder =
    EmployeesCompanion Function({
      Value<String> id,
      required String firstName,
      required String lastName,
      Value<String?> middleName,
      required String email,
      required String phone,
      required String role,
      required String department,
      Value<String?> branchId,
      Value<String?> branchName,
      Value<String?> managerId,
      Value<String?> managerName,
      Value<String?> designation,
      Value<String> status,
      Value<int> isActive,
      required DateTime hireDate,
      Value<DateTime?> endDate,
      Value<String?> address,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$EmployeesTableUpdateCompanionBuilder =
    EmployeesCompanion Function({
      Value<String> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String?> middleName,
      Value<String> email,
      Value<String> phone,
      Value<String> role,
      Value<String> department,
      Value<String?> branchId,
      Value<String?> branchName,
      Value<String?> managerId,
      Value<String?> managerName,
      Value<String?> designation,
      Value<String> status,
      Value<int> isActive,
      Value<DateTime> hireDate,
      Value<DateTime?> endDate,
      Value<String?> address,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get managerId => $composableBuilder(
    column: $table.managerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managerId => $composableBuilder(
    column: $table.managerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get managerId =>
      $composableBuilder(column: $table.managerId, builder: (column) => column);

  GeneratedColumn<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get hireDate =>
      $composableBuilder(column: $table.hireDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
          Employee,
          PrefetchHooks Function()
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> middleName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<String?> managerId = const Value.absent(),
                Value<String?> managerName = const Value.absent(),
                Value<String?> designation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<DateTime> hireDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                middleName: middleName,
                email: email,
                phone: phone,
                role: role,
                department: department,
                branchId: branchId,
                branchName: branchName,
                managerId: managerId,
                managerName: managerName,
                designation: designation,
                status: status,
                isActive: isActive,
                hireDate: hireDate,
                endDate: endDate,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String firstName,
                required String lastName,
                Value<String?> middleName = const Value.absent(),
                required String email,
                required String phone,
                required String role,
                required String department,
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<String?> managerId = const Value.absent(),
                Value<String?> managerName = const Value.absent(),
                Value<String?> designation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                required DateTime hireDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeesCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                middleName: middleName,
                email: email,
                phone: phone,
                role: role,
                department: department,
                branchId: branchId,
                branchName: branchName,
                managerId: managerId,
                managerName: managerName,
                designation: designation,
                status: status,
                isActive: isActive,
                hireDate: hireDate,
                endDate: endDate,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
      Employee,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      required String phone,
      required String segment,
      Value<int> ordersCount,
      Value<double> lifetimeValue,
      required DateTime lastOrderDate,
      required String status,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> phone,
      Value<String> segment,
      Value<int> ordersCount,
      Value<double> lifetimeValue,
      Value<DateTime> lastOrderDate,
      Value<String> status,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segment => $composableBuilder(
    column: $table.segment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordersCount => $composableBuilder(
    column: $table.ordersCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lifetimeValue => $composableBuilder(
    column: $table.lifetimeValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOrderDate => $composableBuilder(
    column: $table.lastOrderDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segment => $composableBuilder(
    column: $table.segment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordersCount => $composableBuilder(
    column: $table.ordersCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lifetimeValue => $composableBuilder(
    column: $table.lifetimeValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOrderDate => $composableBuilder(
    column: $table.lastOrderDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get segment =>
      $composableBuilder(column: $table.segment, builder: (column) => column);

  GeneratedColumn<int> get ordersCount => $composableBuilder(
    column: $table.ordersCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lifetimeValue => $composableBuilder(
    column: $table.lifetimeValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastOrderDate => $composableBuilder(
    column: $table.lastOrderDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> segment = const Value.absent(),
                Value<int> ordersCount = const Value.absent(),
                Value<double> lifetimeValue = const Value.absent(),
                Value<DateTime> lastOrderDate = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                email: email,
                phone: phone,
                segment: segment,
                ordersCount: ordersCount,
                lifetimeValue: lifetimeValue,
                lastOrderDate: lastOrderDate,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String phone,
                required String segment,
                Value<int> ordersCount = const Value.absent(),
                Value<double> lifetimeValue = const Value.absent(),
                required DateTime lastOrderDate,
                required String status,
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                email: email,
                phone: phone,
                segment: segment,
                ordersCount: ordersCount,
                lifetimeValue: lifetimeValue,
                lastOrderDate: lastOrderDate,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$TaxesTableCreateCompanionBuilder =
    TaxesCompanion Function({
      Value<String> id,
      required String name,
      required double valuePercentage,
      Value<int> rowid,
    });
typedef $$TaxesTableUpdateCompanionBuilder =
    TaxesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> valuePercentage,
      Value<int> rowid,
    });

class $$TaxesTableFilterComposer extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valuePercentage => $composableBuilder(
    column: $table.valuePercentage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaxesTableOrderingComposer
    extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valuePercentage => $composableBuilder(
    column: $table.valuePercentage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaxesTable> {
  $$TaxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get valuePercentage => $composableBuilder(
    column: $table.valuePercentage,
    builder: (column) => column,
  );
}

class $$TaxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaxesTable,
          Taxe,
          $$TaxesTableFilterComposer,
          $$TaxesTableOrderingComposer,
          $$TaxesTableAnnotationComposer,
          $$TaxesTableCreateCompanionBuilder,
          $$TaxesTableUpdateCompanionBuilder,
          (Taxe, BaseReferences<_$AppDatabase, $TaxesTable, Taxe>),
          Taxe,
          PrefetchHooks Function()
        > {
  $$TaxesTableTableManager(_$AppDatabase db, $TaxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> valuePercentage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TaxesCompanion(
                id: id,
                name: name,
                valuePercentage: valuePercentage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required double valuePercentage,
                Value<int> rowid = const Value.absent(),
              }) => TaxesCompanion.insert(
                id: id,
                name: name,
                valuePercentage: valuePercentage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaxesTable,
      Taxe,
      $$TaxesTableFilterComposer,
      $$TaxesTableOrderingComposer,
      $$TaxesTableAnnotationComposer,
      $$TaxesTableCreateCompanionBuilder,
      $$TaxesTableUpdateCompanionBuilder,
      (Taxe, BaseReferences<_$AppDatabase, $TaxesTable, Taxe>),
      Taxe,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      required String name,
      Value<String?> supplierCode,
      Value<String?> contactName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<int> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> supplierCode,
      Value<String?> contactName,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<int> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get supplierCode => $composableBuilder(
    column: $table.supplierCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
          Supplier,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> supplierCode = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                supplierCode: supplierCode,
                contactName: contactName,
                email: email,
                phone: phone,
                address: address,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<String?> supplierCode = const Value.absent(),
                Value<String?> contactName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                supplierCode: supplierCode,
                contactName: contactName,
                email: email,
                phone: phone,
                address: address,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
      Supplier,
      PrefetchHooks Function()
    >;
typedef $$ProductBrandsTableCreateCompanionBuilder =
    ProductBrandsCompanion Function({
      Value<String> id,
      required String name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductBrandsTableUpdateCompanionBuilder =
    ProductBrandsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ProductBrandsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductBrandsTable> {
  $$ProductBrandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductBrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductBrandsTable> {
  $$ProductBrandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductBrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductBrandsTable> {
  $$ProductBrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProductBrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductBrandsTable,
          ProductBrand,
          $$ProductBrandsTableFilterComposer,
          $$ProductBrandsTableOrderingComposer,
          $$ProductBrandsTableAnnotationComposer,
          $$ProductBrandsTableCreateCompanionBuilder,
          $$ProductBrandsTableUpdateCompanionBuilder,
          (
            ProductBrand,
            BaseReferences<_$AppDatabase, $ProductBrandsTable, ProductBrand>,
          ),
          ProductBrand,
          PrefetchHooks Function()
        > {
  $$ProductBrandsTableTableManager(_$AppDatabase db, $ProductBrandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductBrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductBrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductBrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductBrandsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductBrandsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductBrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductBrandsTable,
      ProductBrand,
      $$ProductBrandsTableFilterComposer,
      $$ProductBrandsTableOrderingComposer,
      $$ProductBrandsTableAnnotationComposer,
      $$ProductBrandsTableCreateCompanionBuilder,
      $$ProductBrandsTableUpdateCompanionBuilder,
      (
        ProductBrand,
        BaseReferences<_$AppDatabase, $ProductBrandsTable, ProductBrand>,
      ),
      ProductBrand,
      PrefetchHooks Function()
    >;
typedef $$ProductCategoriesTableCreateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<String> id,
      required String name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductCategoriesTableUpdateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ProductCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProductCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductCategoriesTable,
          ProductCategory,
          $$ProductCategoriesTableFilterComposer,
          $$ProductCategoriesTableOrderingComposer,
          $$ProductCategoriesTableAnnotationComposer,
          $$ProductCategoriesTableCreateCompanionBuilder,
          $$ProductCategoriesTableUpdateCompanionBuilder,
          (
            ProductCategory,
            BaseReferences<
              _$AppDatabase,
              $ProductCategoriesTable,
              ProductCategory
            >,
          ),
          ProductCategory,
          PrefetchHooks Function()
        > {
  $$ProductCategoriesTableTableManager(
    _$AppDatabase db,
    $ProductCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductCategoriesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductCategoriesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductCategoriesTable,
      ProductCategory,
      $$ProductCategoriesTableFilterComposer,
      $$ProductCategoriesTableOrderingComposer,
      $$ProductCategoriesTableAnnotationComposer,
      $$ProductCategoriesTableCreateCompanionBuilder,
      $$ProductCategoriesTableUpdateCompanionBuilder,
      (
        ProductCategory,
        BaseReferences<_$AppDatabase, $ProductCategoriesTable, ProductCategory>,
      ),
      ProductCategory,
      PrefetchHooks Function()
    >;
typedef $$ProductSubCategoriesTableCreateCompanionBuilder =
    ProductSubCategoriesCompanion Function({
      Value<String> id,
      required String categoryId,
      required String name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ProductSubCategoriesTableUpdateCompanionBuilder =
    ProductSubCategoriesCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ProductSubCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductSubCategoriesTable> {
  $$ProductSubCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductSubCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductSubCategoriesTable> {
  $$ProductSubCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductSubCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductSubCategoriesTable> {
  $$ProductSubCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProductSubCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductSubCategoriesTable,
          ProductSubCategory,
          $$ProductSubCategoriesTableFilterComposer,
          $$ProductSubCategoriesTableOrderingComposer,
          $$ProductSubCategoriesTableAnnotationComposer,
          $$ProductSubCategoriesTableCreateCompanionBuilder,
          $$ProductSubCategoriesTableUpdateCompanionBuilder,
          (
            ProductSubCategory,
            BaseReferences<
              _$AppDatabase,
              $ProductSubCategoriesTable,
              ProductSubCategory
            >,
          ),
          ProductSubCategory,
          PrefetchHooks Function()
        > {
  $$ProductSubCategoriesTableTableManager(
    _$AppDatabase db,
    $ProductSubCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductSubCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductSubCategoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductSubCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductSubCategoriesCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String categoryId,
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductSubCategoriesCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductSubCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductSubCategoriesTable,
      ProductSubCategory,
      $$ProductSubCategoriesTableFilterComposer,
      $$ProductSubCategoriesTableOrderingComposer,
      $$ProductSubCategoriesTableAnnotationComposer,
      $$ProductSubCategoriesTableCreateCompanionBuilder,
      $$ProductSubCategoriesTableUpdateCompanionBuilder,
      (
        ProductSubCategory,
        BaseReferences<
          _$AppDatabase,
          $ProductSubCategoriesTable,
          ProductSubCategory
        >,
      ),
      ProductSubCategory,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      required String name,
      required String sku,
      Value<String?> category,
      Value<String?> categoryId,
      Value<String?> subCategory,
      Value<String?> size,
      Value<String?> thickness,
      Value<String?> material,
      Value<String?> density,
      Value<String?> brand,
      Value<String?> brandId,
      Value<String?> supplier,
      Value<String?> supplierId,
      required double retailPrice,
      Value<double?> discountPrice,
      Value<double?> discountPercentage,
      required int quantity,
      Value<String?> unit,
      Value<String?> branchId,
      Value<int> isAvailable,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> sku,
      Value<String?> category,
      Value<String?> categoryId,
      Value<String?> subCategory,
      Value<String?> size,
      Value<String?> thickness,
      Value<String?> material,
      Value<String?> density,
      Value<String?> brand,
      Value<String?> brandId,
      Value<String?> supplier,
      Value<String?> supplierId,
      Value<double> retailPrice,
      Value<double?> discountPrice,
      Value<double?> discountPercentage,
      Value<int> quantity,
      Value<String?> unit,
      Value<String?> branchId,
      Value<int> isAvailable,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subCategory => $composableBuilder(
    column: $table.subCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thickness => $composableBuilder(
    column: $table.thickness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPrice => $composableBuilder(
    column: $table.discountPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subCategory => $composableBuilder(
    column: $table.subCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thickness => $composableBuilder(
    column: $table.thickness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPrice => $composableBuilder(
    column: $table.discountPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subCategory => $composableBuilder(
    column: $table.subCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get thickness =>
      $composableBuilder(column: $table.thickness, builder: (column) => column);

  GeneratedColumn<String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumn<String> get density =>
      $composableBuilder(column: $table.density, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get brandId =>
      $composableBuilder(column: $table.brandId, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get retailPrice => $composableBuilder(
    column: $table.retailPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountPrice => $composableBuilder(
    column: $table.discountPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<int> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> subCategory = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<String?> thickness = const Value.absent(),
                Value<String?> material = const Value.absent(),
                Value<String?> density = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> brandId = const Value.absent(),
                Value<String?> supplier = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<double> retailPrice = const Value.absent(),
                Value<double?> discountPrice = const Value.absent(),
                Value<double?> discountPercentage = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<int> isAvailable = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                id: id,
                name: name,
                sku: sku,
                category: category,
                categoryId: categoryId,
                subCategory: subCategory,
                size: size,
                thickness: thickness,
                material: material,
                density: density,
                brand: brand,
                brandId: brandId,
                supplier: supplier,
                supplierId: supplierId,
                retailPrice: retailPrice,
                discountPrice: discountPrice,
                discountPercentage: discountPercentage,
                quantity: quantity,
                unit: unit,
                branchId: branchId,
                isAvailable: isAvailable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String sku,
                Value<String?> category = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> subCategory = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<String?> thickness = const Value.absent(),
                Value<String?> material = const Value.absent(),
                Value<String?> density = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> brandId = const Value.absent(),
                Value<String?> supplier = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                required double retailPrice,
                Value<double?> discountPrice = const Value.absent(),
                Value<double?> discountPercentage = const Value.absent(),
                required int quantity,
                Value<String?> unit = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<int> isAvailable = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                id: id,
                name: name,
                sku: sku,
                category: category,
                categoryId: categoryId,
                subCategory: subCategory,
                size: size,
                thickness: thickness,
                material: material,
                density: density,
                brand: brand,
                brandId: brandId,
                supplier: supplier,
                supplierId: supplierId,
                retailPrice: retailPrice,
                discountPrice: discountPrice,
                discountPercentage: discountPercentage,
                quantity: quantity,
                unit: unit,
                branchId: branchId,
                isAvailable: isAvailable,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$SaleOrdersTableCreateCompanionBuilder =
    SaleOrdersCompanion Function({
      Value<String> id,
      required String orderNumber,
      Value<String?> customerName,
      Value<String?> channel,
      Value<String?> branchId,
      Value<String?> branchName,
      required int totalQuantity,
      required double totalAmount,
      Value<double> discountAmount,
      Value<double> taxAmount,
      required String status,
      Value<int> isSynced,
      required String createdBy,
      Value<DateTime?> createdAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SaleOrdersTableUpdateCompanionBuilder =
    SaleOrdersCompanion Function({
      Value<String> id,
      Value<String> orderNumber,
      Value<String?> customerName,
      Value<String?> channel,
      Value<String?> branchId,
      Value<String?> branchName,
      Value<int> totalQuantity,
      Value<double> totalAmount,
      Value<double> discountAmount,
      Value<double> taxAmount,
      Value<String> status,
      Value<int> isSynced,
      Value<String> createdBy,
      Value<DateTime?> createdAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SaleOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $SaleOrdersTable> {
  $$SaleOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SaleOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleOrdersTable> {
  $$SaleOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SaleOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleOrdersTable> {
  $$SaleOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SaleOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleOrdersTable,
          SaleOrder,
          $$SaleOrdersTableFilterComposer,
          $$SaleOrdersTableOrderingComposer,
          $$SaleOrdersTableAnnotationComposer,
          $$SaleOrdersTableCreateCompanionBuilder,
          $$SaleOrdersTableUpdateCompanionBuilder,
          (
            SaleOrder,
            BaseReferences<_$AppDatabase, $SaleOrdersTable, SaleOrder>,
          ),
          SaleOrder,
          PrefetchHooks Function()
        > {
  $$SaleOrdersTableTableManager(_$AppDatabase db, $SaleOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> channel = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<int> totalQuantity = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleOrdersCompanion(
                id: id,
                orderNumber: orderNumber,
                customerName: customerName,
                channel: channel,
                branchId: branchId,
                branchName: branchName,
                totalQuantity: totalQuantity,
                totalAmount: totalAmount,
                discountAmount: discountAmount,
                taxAmount: taxAmount,
                status: status,
                isSynced: isSynced,
                createdBy: createdBy,
                createdAt: createdAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String orderNumber,
                Value<String?> customerName = const Value.absent(),
                Value<String?> channel = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                required int totalQuantity,
                required double totalAmount,
                Value<double> discountAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                required String status,
                Value<int> isSynced = const Value.absent(),
                required String createdBy,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleOrdersCompanion.insert(
                id: id,
                orderNumber: orderNumber,
                customerName: customerName,
                channel: channel,
                branchId: branchId,
                branchName: branchName,
                totalQuantity: totalQuantity,
                totalAmount: totalAmount,
                discountAmount: discountAmount,
                taxAmount: taxAmount,
                status: status,
                isSynced: isSynced,
                createdBy: createdBy,
                createdAt: createdAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SaleOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleOrdersTable,
      SaleOrder,
      $$SaleOrdersTableFilterComposer,
      $$SaleOrdersTableOrderingComposer,
      $$SaleOrdersTableAnnotationComposer,
      $$SaleOrdersTableCreateCompanionBuilder,
      $$SaleOrdersTableUpdateCompanionBuilder,
      (SaleOrder, BaseReferences<_$AppDatabase, $SaleOrdersTable, SaleOrder>),
      SaleOrder,
      PrefetchHooks Function()
    >;
typedef $$SaleOrderItemsTableCreateCompanionBuilder =
    SaleOrderItemsCompanion Function({
      Value<String> id,
      required String saleOrderId,
      Value<String?> productId,
      required String productName,
      required int quantity,
      required double unitPrice,
      required double totalPrice,
      Value<double> discountAmount,
      Value<double> taxAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$SaleOrderItemsTableUpdateCompanionBuilder =
    SaleOrderItemsCompanion Function({
      Value<String> id,
      Value<String> saleOrderId,
      Value<String?> productId,
      Value<String> productName,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> totalPrice,
      Value<double> discountAmount,
      Value<double> taxAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$SaleOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SaleOrderItemsTable> {
  $$SaleOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SaleOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SaleOrderItemsTable> {
  $$SaleOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SaleOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SaleOrderItemsTable> {
  $$SaleOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SaleOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleOrderItemsTable,
          SaleOrderItem,
          $$SaleOrderItemsTableFilterComposer,
          $$SaleOrderItemsTableOrderingComposer,
          $$SaleOrderItemsTableAnnotationComposer,
          $$SaleOrderItemsTableCreateCompanionBuilder,
          $$SaleOrderItemsTableUpdateCompanionBuilder,
          (
            SaleOrderItem,
            BaseReferences<_$AppDatabase, $SaleOrderItemsTable, SaleOrderItem>,
          ),
          SaleOrderItem,
          PrefetchHooks Function()
        > {
  $$SaleOrderItemsTableTableManager(
    _$AppDatabase db,
    $SaleOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SaleOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SaleOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SaleOrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleOrderId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleOrderItemsCompanion(
                id: id,
                saleOrderId: saleOrderId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                discountAmount: discountAmount,
                taxAmount: taxAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String saleOrderId,
                Value<String?> productId = const Value.absent(),
                required String productName,
                required int quantity,
                required double unitPrice,
                required double totalPrice,
                Value<double> discountAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SaleOrderItemsCompanion.insert(
                id: id,
                saleOrderId: saleOrderId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                discountAmount: discountAmount,
                taxAmount: taxAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SaleOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleOrderItemsTable,
      SaleOrderItem,
      $$SaleOrderItemsTableFilterComposer,
      $$SaleOrderItemsTableOrderingComposer,
      $$SaleOrderItemsTableAnnotationComposer,
      $$SaleOrderItemsTableCreateCompanionBuilder,
      $$SaleOrderItemsTableUpdateCompanionBuilder,
      (
        SaleOrderItem,
        BaseReferences<_$AppDatabase, $SaleOrderItemsTable, SaleOrderItem>,
      ),
      SaleOrderItem,
      PrefetchHooks Function()
    >;
typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      required DateTime createdAt,
      required String createdBy,
      required String createdByName,
      required String branchId,
      required String branchName,
      required double totalAmount,
      Value<int> rowid,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> createdBy,
      Value<String> createdByName,
      Value<String> branchId,
      Value<String> branchName,
      Value<double> totalAmount,
      Value<int> rowid,
    });

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get createdByName => $composableBuilder(
    column: $table.createdByName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
          Receipt,
          PrefetchHooks Function()
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<String> createdByName = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                createdAt: createdAt,
                createdBy: createdBy,
                createdByName: createdByName,
                branchId: branchId,
                branchName: branchName,
                totalAmount: totalAmount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime createdAt,
                required String createdBy,
                required String createdByName,
                required String branchId,
                required String branchName,
                required double totalAmount,
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                createdAt: createdAt,
                createdBy: createdBy,
                createdByName: createdByName,
                branchId: branchId,
                branchName: branchName,
                totalAmount: totalAmount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
      Receipt,
      PrefetchHooks Function()
    >;
typedef $$ProformasTableCreateCompanionBuilder =
    ProformasCompanion Function({
      Value<String> id,
      Value<String?> partyName,
      Value<String?> partyAddress,
      required String tax,
      required int totalQuantity,
      Value<String?> declaration,
      required double totalAmount,
      Value<int> isDeleted,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProformasTableUpdateCompanionBuilder =
    ProformasCompanion Function({
      Value<String> id,
      Value<String?> partyName,
      Value<String?> partyAddress,
      Value<String> tax,
      Value<int> totalQuantity,
      Value<String?> declaration,
      Value<double> totalAmount,
      Value<int> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProformasTableFilterComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partyAddress => $composableBuilder(
    column: $table.partyAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get declaration => $composableBuilder(
    column: $table.declaration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProformasTableOrderingComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyAddress => $composableBuilder(
    column: $table.partyAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get declaration => $composableBuilder(
    column: $table.declaration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProformasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProformasTable> {
  $$ProformasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partyName =>
      $composableBuilder(column: $table.partyName, builder: (column) => column);

  GeneratedColumn<String> get partyAddress => $composableBuilder(
    column: $table.partyAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<int> get totalQuantity => $composableBuilder(
    column: $table.totalQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get declaration => $composableBuilder(
    column: $table.declaration,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProformasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProformasTable,
          Proforma,
          $$ProformasTableFilterComposer,
          $$ProformasTableOrderingComposer,
          $$ProformasTableAnnotationComposer,
          $$ProformasTableCreateCompanionBuilder,
          $$ProformasTableUpdateCompanionBuilder,
          (Proforma, BaseReferences<_$AppDatabase, $ProformasTable, Proforma>),
          Proforma,
          PrefetchHooks Function()
        > {
  $$ProformasTableTableManager(_$AppDatabase db, $ProformasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProformasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProformasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProformasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> partyName = const Value.absent(),
                Value<String?> partyAddress = const Value.absent(),
                Value<String> tax = const Value.absent(),
                Value<int> totalQuantity = const Value.absent(),
                Value<String?> declaration = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProformasCompanion(
                id: id,
                partyName: partyName,
                partyAddress: partyAddress,
                tax: tax,
                totalQuantity: totalQuantity,
                declaration: declaration,
                totalAmount: totalAmount,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> partyName = const Value.absent(),
                Value<String?> partyAddress = const Value.absent(),
                required String tax,
                required int totalQuantity,
                Value<String?> declaration = const Value.absent(),
                required double totalAmount,
                Value<int> isDeleted = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProformasCompanion.insert(
                id: id,
                partyName: partyName,
                partyAddress: partyAddress,
                tax: tax,
                totalQuantity: totalQuantity,
                declaration: declaration,
                totalAmount: totalAmount,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProformasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProformasTable,
      Proforma,
      $$ProformasTableFilterComposer,
      $$ProformasTableOrderingComposer,
      $$ProformasTableAnnotationComposer,
      $$ProformasTableCreateCompanionBuilder,
      $$ProformasTableUpdateCompanionBuilder,
      (Proforma, BaseReferences<_$AppDatabase, $ProformasTable, Proforma>),
      Proforma,
      PrefetchHooks Function()
    >;
typedef $$ProductDetailsListTableCreateCompanionBuilder =
    ProductDetailsListCompanion Function({
      Value<String> id,
      required String productId,
      Value<String?> proformaId,
      Value<String?> waybillId,
      required String productName,
      required int quantity,
      required double unitPrice,
      required double discountPercentage,
      required double totalAmount,
      Value<int> rowid,
    });
typedef $$ProductDetailsListTableUpdateCompanionBuilder =
    ProductDetailsListCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String?> proformaId,
      Value<String?> waybillId,
      Value<String> productName,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> discountPercentage,
      Value<double> totalAmount,
      Value<int> rowid,
    });

class $$ProductDetailsListTableFilterComposer
    extends Composer<_$AppDatabase, $ProductDetailsListTable> {
  $$ProductDetailsListTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proformaId => $composableBuilder(
    column: $table.proformaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get waybillId => $composableBuilder(
    column: $table.waybillId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductDetailsListTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductDetailsListTable> {
  $$ProductDetailsListTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proformaId => $composableBuilder(
    column: $table.proformaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get waybillId => $composableBuilder(
    column: $table.waybillId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductDetailsListTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductDetailsListTable> {
  $$ProductDetailsListTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get proformaId => $composableBuilder(
    column: $table.proformaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get waybillId =>
      $composableBuilder(column: $table.waybillId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );
}

class $$ProductDetailsListTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductDetailsListTable,
          ProductDetailsListData,
          $$ProductDetailsListTableFilterComposer,
          $$ProductDetailsListTableOrderingComposer,
          $$ProductDetailsListTableAnnotationComposer,
          $$ProductDetailsListTableCreateCompanionBuilder,
          $$ProductDetailsListTableUpdateCompanionBuilder,
          (
            ProductDetailsListData,
            BaseReferences<
              _$AppDatabase,
              $ProductDetailsListTable,
              ProductDetailsListData
            >,
          ),
          ProductDetailsListData,
          PrefetchHooks Function()
        > {
  $$ProductDetailsListTableTableManager(
    _$AppDatabase db,
    $ProductDetailsListTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductDetailsListTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductDetailsListTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductDetailsListTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String?> proformaId = const Value.absent(),
                Value<String?> waybillId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> discountPercentage = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductDetailsListCompanion(
                id: id,
                productId: productId,
                proformaId: proformaId,
                waybillId: waybillId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                discountPercentage: discountPercentage,
                totalAmount: totalAmount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String productId,
                Value<String?> proformaId = const Value.absent(),
                Value<String?> waybillId = const Value.absent(),
                required String productName,
                required int quantity,
                required double unitPrice,
                required double discountPercentage,
                required double totalAmount,
                Value<int> rowid = const Value.absent(),
              }) => ProductDetailsListCompanion.insert(
                id: id,
                productId: productId,
                proformaId: proformaId,
                waybillId: waybillId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                discountPercentage: discountPercentage,
                totalAmount: totalAmount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductDetailsListTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductDetailsListTable,
      ProductDetailsListData,
      $$ProductDetailsListTableFilterComposer,
      $$ProductDetailsListTableOrderingComposer,
      $$ProductDetailsListTableAnnotationComposer,
      $$ProductDetailsListTableCreateCompanionBuilder,
      $$ProductDetailsListTableUpdateCompanionBuilder,
      (
        ProductDetailsListData,
        BaseReferences<
          _$AppDatabase,
          $ProductDetailsListTable,
          ProductDetailsListData
        >,
      ),
      ProductDetailsListData,
      PrefetchHooks Function()
    >;
typedef $$WayBillsTableCreateCompanionBuilder =
    WayBillsCompanion Function({
      Value<String> id,
      required String mainContent,
      required String orderNumber,
      required String dispatchDocNumber,
      required String deliveryNote,
      required String senderName,
      required String destination,
      required String partyName,
      required String createdBy,
      Value<int> isDeleted,
      required DateTime dispatchDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$WayBillsTableUpdateCompanionBuilder =
    WayBillsCompanion Function({
      Value<String> id,
      Value<String> mainContent,
      Value<String> orderNumber,
      Value<String> dispatchDocNumber,
      Value<String> deliveryNote,
      Value<String> senderName,
      Value<String> destination,
      Value<String> partyName,
      Value<String> createdBy,
      Value<int> isDeleted,
      Value<DateTime> dispatchDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$WayBillsTableFilterComposer
    extends Composer<_$AppDatabase, $WayBillsTable> {
  $$WayBillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainContent => $composableBuilder(
    column: $table.mainContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dispatchDocNumber => $composableBuilder(
    column: $table.dispatchDocNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deliveryNote => $composableBuilder(
    column: $table.deliveryNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dispatchDate => $composableBuilder(
    column: $table.dispatchDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WayBillsTableOrderingComposer
    extends Composer<_$AppDatabase, $WayBillsTable> {
  $$WayBillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainContent => $composableBuilder(
    column: $table.mainContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dispatchDocNumber => $composableBuilder(
    column: $table.dispatchDocNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryNote => $composableBuilder(
    column: $table.deliveryNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyName => $composableBuilder(
    column: $table.partyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dispatchDate => $composableBuilder(
    column: $table.dispatchDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WayBillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WayBillsTable> {
  $$WayBillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mainContent => $composableBuilder(
    column: $table.mainContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dispatchDocNumber => $composableBuilder(
    column: $table.dispatchDocNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deliveryNote => $composableBuilder(
    column: $table.deliveryNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destination => $composableBuilder(
    column: $table.destination,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partyName =>
      $composableBuilder(column: $table.partyName, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<int> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get dispatchDate => $composableBuilder(
    column: $table.dispatchDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WayBillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WayBillsTable,
          WayBill,
          $$WayBillsTableFilterComposer,
          $$WayBillsTableOrderingComposer,
          $$WayBillsTableAnnotationComposer,
          $$WayBillsTableCreateCompanionBuilder,
          $$WayBillsTableUpdateCompanionBuilder,
          (WayBill, BaseReferences<_$AppDatabase, $WayBillsTable, WayBill>),
          WayBill,
          PrefetchHooks Function()
        > {
  $$WayBillsTableTableManager(_$AppDatabase db, $WayBillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WayBillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WayBillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WayBillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mainContent = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String> dispatchDocNumber = const Value.absent(),
                Value<String> deliveryNote = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String> destination = const Value.absent(),
                Value<String> partyName = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<int> isDeleted = const Value.absent(),
                Value<DateTime> dispatchDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WayBillsCompanion(
                id: id,
                mainContent: mainContent,
                orderNumber: orderNumber,
                dispatchDocNumber: dispatchDocNumber,
                deliveryNote: deliveryNote,
                senderName: senderName,
                destination: destination,
                partyName: partyName,
                createdBy: createdBy,
                isDeleted: isDeleted,
                dispatchDate: dispatchDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String mainContent,
                required String orderNumber,
                required String dispatchDocNumber,
                required String deliveryNote,
                required String senderName,
                required String destination,
                required String partyName,
                required String createdBy,
                Value<int> isDeleted = const Value.absent(),
                required DateTime dispatchDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WayBillsCompanion.insert(
                id: id,
                mainContent: mainContent,
                orderNumber: orderNumber,
                dispatchDocNumber: dispatchDocNumber,
                deliveryNote: deliveryNote,
                senderName: senderName,
                destination: destination,
                partyName: partyName,
                createdBy: createdBy,
                isDeleted: isDeleted,
                dispatchDate: dispatchDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WayBillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WayBillsTable,
      WayBill,
      $$WayBillsTableFilterComposer,
      $$WayBillsTableOrderingComposer,
      $$WayBillsTableAnnotationComposer,
      $$WayBillsTableCreateCompanionBuilder,
      $$WayBillsTableUpdateCompanionBuilder,
      (WayBill, BaseReferences<_$AppDatabase, $WayBillsTable, WayBill>),
      WayBill,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      required DateTime dueDate,
      Value<String?> customerName,
      required double totalAmount,
      required double paidAmount,
      Value<String> status,
      Value<String?> note,
      required String saleOrderId,
      Value<String?> branchName,
      Value<String?> branchId,
      Value<int> rowid,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      Value<DateTime> dueDate,
      Value<String?> customerName,
      Value<double> totalAmount,
      Value<double> paidAmount,
      Value<String> status,
      Value<String?> note,
      Value<String> saleOrderId,
      Value<String?> branchName,
      Value<String?> branchId,
      Value<int> rowid,
    });

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
          Invoice,
          PrefetchHooks Function()
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> saleOrderId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                dueDate: dueDate,
                customerName: customerName,
                totalAmount: totalAmount,
                paidAmount: paidAmount,
                status: status,
                note: note,
                saleOrderId: saleOrderId,
                branchName: branchName,
                branchId: branchId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime dueDate,
                Value<String?> customerName = const Value.absent(),
                required double totalAmount,
                required double paidAmount,
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required String saleOrderId,
                Value<String?> branchName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                dueDate: dueDate,
                customerName: customerName,
                totalAmount: totalAmount,
                paidAmount: paidAmount,
                status: status,
                note: note,
                saleOrderId: saleOrderId,
                branchName: branchName,
                branchId: branchId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, BaseReferences<_$AppDatabase, $InvoicesTable, Invoice>),
      Invoice,
      PrefetchHooks Function()
    >;
typedef $$ReturnOrdersTableCreateCompanionBuilder =
    ReturnOrdersCompanion Function({
      Value<String> id,
      required String returnOrderNumber,
      required String saleOrderId,
      Value<String?> invoiceId,
      Value<String?> customerName,
      Value<String?> branchId,
      Value<String?> branchName,
      required int totalItems,
      required double totalAmount,
      required double refundAmount,
      Value<double> totalTax,
      Value<String> status,
      Value<int> isSynced,
      required String createdBy,
      required DateTime returnDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$ReturnOrdersTableUpdateCompanionBuilder =
    ReturnOrdersCompanion Function({
      Value<String> id,
      Value<String> returnOrderNumber,
      Value<String> saleOrderId,
      Value<String?> invoiceId,
      Value<String?> customerName,
      Value<String?> branchId,
      Value<String?> branchName,
      Value<int> totalItems,
      Value<double> totalAmount,
      Value<double> refundAmount,
      Value<double> totalTax,
      Value<String> status,
      Value<int> isSynced,
      Value<String> createdBy,
      Value<DateTime> returnDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$ReturnOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnOrdersTable> {
  $$ReturnOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnOrderNumber => $composableBuilder(
    column: $table.returnOrderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalTax => $composableBuilder(
    column: $table.totalTax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnOrdersTable> {
  $$ReturnOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnOrderNumber => $composableBuilder(
    column: $table.returnOrderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalTax => $composableBuilder(
    column: $table.totalTax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnOrdersTable> {
  $$ReturnOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get returnOrderNumber => $composableBuilder(
    column: $table.returnOrderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get saleOrderId => $composableBuilder(
    column: $table.saleOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalTax =>
      $composableBuilder(column: $table.totalTax, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get returnDate => $composableBuilder(
    column: $table.returnDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$ReturnOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnOrdersTable,
          ReturnOrder,
          $$ReturnOrdersTableFilterComposer,
          $$ReturnOrdersTableOrderingComposer,
          $$ReturnOrdersTableAnnotationComposer,
          $$ReturnOrdersTableCreateCompanionBuilder,
          $$ReturnOrdersTableUpdateCompanionBuilder,
          (
            ReturnOrder,
            BaseReferences<_$AppDatabase, $ReturnOrdersTable, ReturnOrder>,
          ),
          ReturnOrder,
          PrefetchHooks Function()
        > {
  $$ReturnOrdersTableTableManager(_$AppDatabase db, $ReturnOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> returnOrderNumber = const Value.absent(),
                Value<String> saleOrderId = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<int> totalItems = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<double> totalTax = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime> returnDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnOrdersCompanion(
                id: id,
                returnOrderNumber: returnOrderNumber,
                saleOrderId: saleOrderId,
                invoiceId: invoiceId,
                customerName: customerName,
                branchId: branchId,
                branchName: branchName,
                totalItems: totalItems,
                totalAmount: totalAmount,
                refundAmount: refundAmount,
                totalTax: totalTax,
                status: status,
                isSynced: isSynced,
                createdBy: createdBy,
                returnDate: returnDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String returnOrderNumber,
                required String saleOrderId,
                Value<String?> invoiceId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                required int totalItems,
                required double totalAmount,
                required double refundAmount,
                Value<double> totalTax = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                required String createdBy,
                required DateTime returnDate,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnOrdersCompanion.insert(
                id: id,
                returnOrderNumber: returnOrderNumber,
                saleOrderId: saleOrderId,
                invoiceId: invoiceId,
                customerName: customerName,
                branchId: branchId,
                branchName: branchName,
                totalItems: totalItems,
                totalAmount: totalAmount,
                refundAmount: refundAmount,
                totalTax: totalTax,
                status: status,
                isSynced: isSynced,
                createdBy: createdBy,
                returnDate: returnDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReturnOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnOrdersTable,
      ReturnOrder,
      $$ReturnOrdersTableFilterComposer,
      $$ReturnOrdersTableOrderingComposer,
      $$ReturnOrdersTableAnnotationComposer,
      $$ReturnOrdersTableCreateCompanionBuilder,
      $$ReturnOrdersTableUpdateCompanionBuilder,
      (
        ReturnOrder,
        BaseReferences<_$AppDatabase, $ReturnOrdersTable, ReturnOrder>,
      ),
      ReturnOrder,
      PrefetchHooks Function()
    >;
typedef $$ReturnOrderItemsTableCreateCompanionBuilder =
    ReturnOrderItemsCompanion Function({
      Value<String> id,
      required String returnOrderId,
      Value<String?> productId,
      required String productName,
      required int quantity,
      required double unitPrice,
      required double totalPrice,
      Value<double> taxAmount,
      Value<String?> reason,
      required double refundAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$ReturnOrderItemsTableUpdateCompanionBuilder =
    ReturnOrderItemsCompanion Function({
      Value<String> id,
      Value<String> returnOrderId,
      Value<String?> productId,
      Value<String> productName,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> totalPrice,
      Value<double> taxAmount,
      Value<String?> reason,
      Value<double> refundAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$ReturnOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReturnOrderItemsTable> {
  $$ReturnOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReturnOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReturnOrderItemsTable> {
  $$ReturnOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReturnOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReturnOrderItemsTable> {
  $$ReturnOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<double> get refundAmount => $composableBuilder(
    column: $table.refundAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$ReturnOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReturnOrderItemsTable,
          ReturnOrderItem,
          $$ReturnOrderItemsTableFilterComposer,
          $$ReturnOrderItemsTableOrderingComposer,
          $$ReturnOrderItemsTableAnnotationComposer,
          $$ReturnOrderItemsTableCreateCompanionBuilder,
          $$ReturnOrderItemsTableUpdateCompanionBuilder,
          (
            ReturnOrderItem,
            BaseReferences<
              _$AppDatabase,
              $ReturnOrderItemsTable,
              ReturnOrderItem
            >,
          ),
          ReturnOrderItem,
          PrefetchHooks Function()
        > {
  $$ReturnOrderItemsTableTableManager(
    _$AppDatabase db,
    $ReturnOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReturnOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReturnOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReturnOrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> returnOrderId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<double> refundAmount = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnOrderItemsCompanion(
                id: id,
                returnOrderId: returnOrderId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                taxAmount: taxAmount,
                reason: reason,
                refundAmount: refundAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String returnOrderId,
                Value<String?> productId = const Value.absent(),
                required String productName,
                required int quantity,
                required double unitPrice,
                required double totalPrice,
                Value<double> taxAmount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required double refundAmount,
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReturnOrderItemsCompanion.insert(
                id: id,
                returnOrderId: returnOrderId,
                productId: productId,
                productName: productName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                taxAmount: taxAmount,
                reason: reason,
                refundAmount: refundAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReturnOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReturnOrderItemsTable,
      ReturnOrderItem,
      $$ReturnOrderItemsTableFilterComposer,
      $$ReturnOrderItemsTableOrderingComposer,
      $$ReturnOrderItemsTableAnnotationComposer,
      $$ReturnOrderItemsTableCreateCompanionBuilder,
      $$ReturnOrderItemsTableUpdateCompanionBuilder,
      (
        ReturnOrderItem,
        BaseReferences<_$AppDatabase, $ReturnOrderItemsTable, ReturnOrderItem>,
      ),
      ReturnOrderItem,
      PrefetchHooks Function()
    >;
typedef $$CreditNotesTableCreateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<String> id,
      required String creditNoteNumber,
      Value<String?> invoiceId,
      Value<String?> returnOrderId,
      Value<String?> customerName,
      Value<String?> branchId,
      Value<String?> branchName,
      required int totalItems,
      required double totalAmount,
      Value<double> appliedAmount,
      Value<String> status,
      Value<String?> note,
      Value<int> isSynced,
      required String createdBy,
      required DateTime issuedAt,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$CreditNotesTableUpdateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<String> id,
      Value<String> creditNoteNumber,
      Value<String?> invoiceId,
      Value<String?> returnOrderId,
      Value<String?> customerName,
      Value<String?> branchId,
      Value<String?> branchName,
      Value<int> totalItems,
      Value<double> totalAmount,
      Value<double> appliedAmount,
      Value<String> status,
      Value<String?> note,
      Value<int> isSynced,
      Value<String> createdBy,
      Value<DateTime> issuedAt,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$CreditNotesTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get appliedAmount => $composableBuilder(
    column: $table.appliedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CreditNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get appliedAmount => $composableBuilder(
    column: $table.appliedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get returnOrderId => $composableBuilder(
    column: $table.returnOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get appliedAmount => $composableBuilder(
    column: $table.appliedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$CreditNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNotesTable,
          CreditNote,
          $$CreditNotesTableFilterComposer,
          $$CreditNotesTableOrderingComposer,
          $$CreditNotesTableAnnotationComposer,
          $$CreditNotesTableCreateCompanionBuilder,
          $$CreditNotesTableUpdateCompanionBuilder,
          (
            CreditNote,
            BaseReferences<_$AppDatabase, $CreditNotesTable, CreditNote>,
          ),
          CreditNote,
          PrefetchHooks Function()
        > {
  $$CreditNotesTableTableManager(_$AppDatabase db, $CreditNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> creditNoteNumber = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<String?> returnOrderId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                Value<int> totalItems = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> appliedAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime> issuedAt = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditNotesCompanion(
                id: id,
                creditNoteNumber: creditNoteNumber,
                invoiceId: invoiceId,
                returnOrderId: returnOrderId,
                customerName: customerName,
                branchId: branchId,
                branchName: branchName,
                totalItems: totalItems,
                totalAmount: totalAmount,
                appliedAmount: appliedAmount,
                status: status,
                note: note,
                isSynced: isSynced,
                createdBy: createdBy,
                issuedAt: issuedAt,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String creditNoteNumber,
                Value<String?> invoiceId = const Value.absent(),
                Value<String?> returnOrderId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> branchName = const Value.absent(),
                required int totalItems,
                required double totalAmount,
                Value<double> appliedAmount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                required String createdBy,
                required DateTime issuedAt,
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditNotesCompanion.insert(
                id: id,
                creditNoteNumber: creditNoteNumber,
                invoiceId: invoiceId,
                returnOrderId: returnOrderId,
                customerName: customerName,
                branchId: branchId,
                branchName: branchName,
                totalItems: totalItems,
                totalAmount: totalAmount,
                appliedAmount: appliedAmount,
                status: status,
                note: note,
                isSynced: isSynced,
                createdBy: createdBy,
                issuedAt: issuedAt,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CreditNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNotesTable,
      CreditNote,
      $$CreditNotesTableFilterComposer,
      $$CreditNotesTableOrderingComposer,
      $$CreditNotesTableAnnotationComposer,
      $$CreditNotesTableCreateCompanionBuilder,
      $$CreditNotesTableUpdateCompanionBuilder,
      (
        CreditNote,
        BaseReferences<_$AppDatabase, $CreditNotesTable, CreditNote>,
      ),
      CreditNote,
      PrefetchHooks Function()
    >;
typedef $$CreditNoteItemsTableCreateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<String> id,
      required String creditNoteId,
      Value<String?> productId,
      required String description,
      required int quantity,
      required double unitPrice,
      required double totalPrice,
      Value<double> taxAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$CreditNoteItemsTableUpdateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<String> id,
      Value<String> creditNoteId,
      Value<String?> productId,
      Value<String> description,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> totalPrice,
      Value<double> taxAmount,
      Value<int> isSynced,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$CreditNoteItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditNoteId => $composableBuilder(
    column: $table.creditNoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CreditNoteItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditNoteId => $composableBuilder(
    column: $table.creditNoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditNoteItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get creditNoteId => $composableBuilder(
    column: $table.creditNoteId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<int> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$CreditNoteItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNoteItemsTable,
          CreditNoteItem,
          $$CreditNoteItemsTableFilterComposer,
          $$CreditNoteItemsTableOrderingComposer,
          $$CreditNoteItemsTableAnnotationComposer,
          $$CreditNoteItemsTableCreateCompanionBuilder,
          $$CreditNoteItemsTableUpdateCompanionBuilder,
          (
            CreditNoteItem,
            BaseReferences<
              _$AppDatabase,
              $CreditNoteItemsTable,
              CreditNoteItem
            >,
          ),
          CreditNoteItem,
          PrefetchHooks Function()
        > {
  $$CreditNoteItemsTableTableManager(
    _$AppDatabase db,
    $CreditNoteItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNoteItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNoteItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNoteItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> creditNoteId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditNoteItemsCompanion(
                id: id,
                creditNoteId: creditNoteId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                taxAmount: taxAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String creditNoteId,
                Value<String?> productId = const Value.absent(),
                required String description,
                required int quantity,
                required double unitPrice,
                required double totalPrice,
                Value<double> taxAmount = const Value.absent(),
                Value<int> isSynced = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditNoteItemsCompanion.insert(
                id: id,
                creditNoteId: creditNoteId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                taxAmount: taxAmount,
                isSynced: isSynced,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CreditNoteItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNoteItemsTable,
      CreditNoteItem,
      $$CreditNoteItemsTableFilterComposer,
      $$CreditNoteItemsTableOrderingComposer,
      $$CreditNoteItemsTableAnnotationComposer,
      $$CreditNoteItemsTableCreateCompanionBuilder,
      $$CreditNoteItemsTableUpdateCompanionBuilder,
      (
        CreditNoteItem,
        BaseReferences<_$AppDatabase, $CreditNoteItemsTable, CreditNoteItem>,
      ),
      CreditNoteItem,
      PrefetchHooks Function()
    >;
typedef $$StockReportsTableCreateCompanionBuilder =
    StockReportsCompanion Function({
      Value<String> id,
      required String branchId,
      required String branchName,
      required String currentStock,
      required String categoryStock,
      required DateTime createdAt,
      required String createdBy,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$StockReportsTableUpdateCompanionBuilder =
    StockReportsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> branchName,
      Value<String> currentStock,
      Value<String> categoryStock,
      Value<DateTime> createdAt,
      Value<String> createdBy,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$StockReportsTableFilterComposer
    extends Composer<_$AppDatabase, $StockReportsTable> {
  $$StockReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryStock => $composableBuilder(
    column: $table.categoryStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockReportsTable> {
  $$StockReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryStock => $composableBuilder(
    column: $table.categoryStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockReportsTable> {
  $$StockReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryStock => $composableBuilder(
    column: $table.categoryStock,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StockReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockReportsTable,
          StockReport,
          $$StockReportsTableFilterComposer,
          $$StockReportsTableOrderingComposer,
          $$StockReportsTableAnnotationComposer,
          $$StockReportsTableCreateCompanionBuilder,
          $$StockReportsTableUpdateCompanionBuilder,
          (
            StockReport,
            BaseReferences<_$AppDatabase, $StockReportsTable, StockReport>,
          ),
          StockReport,
          PrefetchHooks Function()
        > {
  $$StockReportsTableTableManager(_$AppDatabase db, $StockReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<String> currentStock = const Value.absent(),
                Value<String> categoryStock = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockReportsCompanion(
                id: id,
                branchId: branchId,
                branchName: branchName,
                currentStock: currentStock,
                categoryStock: categoryStock,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String branchId,
                required String branchName,
                required String currentStock,
                required String categoryStock,
                required DateTime createdAt,
                required String createdBy,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StockReportsCompanion.insert(
                id: id,
                branchId: branchId,
                branchName: branchName,
                currentStock: currentStock,
                categoryStock: categoryStock,
                createdAt: createdAt,
                createdBy: createdBy,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockReportsTable,
      StockReport,
      $$StockReportsTableFilterComposer,
      $$StockReportsTableOrderingComposer,
      $$StockReportsTableAnnotationComposer,
      $$StockReportsTableCreateCompanionBuilder,
      $$StockReportsTableUpdateCompanionBuilder,
      (
        StockReport,
        BaseReferences<_$AppDatabase, $StockReportsTable, StockReport>,
      ),
      StockReport,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      required String expenseType,
      Value<String?> description,
      required double amount,
      required String paymentMethod,
      required DateTime createdAt,
      required String branchId,
      required String branchName,
      required DateTime expenseDate,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<String> expenseType,
      Value<String?> description,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
      Value<String> branchId,
      Value<String> branchName,
      Value<DateTime> expenseDate,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expenseType => $composableBuilder(
    column: $table.expenseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expenseType => $composableBuilder(
    column: $table.expenseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get expenseType => $composableBuilder(
    column: $table.expenseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> expenseType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                expenseType: expenseType,
                description: description,
                amount: amount,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                branchId: branchId,
                branchName: branchName,
                expenseDate: expenseDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String expenseType,
                Value<String?> description = const Value.absent(),
                required double amount,
                required String paymentMethod,
                required DateTime createdAt,
                required String branchId,
                required String branchName,
                required DateTime expenseDate,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                expenseType: expenseType,
                description: description,
                amount: amount,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                branchId: branchId,
                branchName: branchName,
                expenseDate: expenseDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$BranchPaymentsTableCreateCompanionBuilder =
    BranchPaymentsCompanion Function({
      Value<String> id,
      required String branchId,
      required String branchName,
      required double amount,
      Value<String?> note,
      required String title,
      required DateTime createdAt,
      required String createdBy,
      Value<int> rowid,
    });
typedef $$BranchPaymentsTableUpdateCompanionBuilder =
    BranchPaymentsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> branchName,
      Value<double> amount,
      Value<String?> note,
      Value<String> title,
      Value<DateTime> createdAt,
      Value<String> createdBy,
      Value<int> rowid,
    });

class $$BranchPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $BranchPaymentsTable> {
  $$BranchPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BranchPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchPaymentsTable> {
  $$BranchPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchPaymentsTable> {
  $$BranchPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);
}

class $$BranchPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchPaymentsTable,
          BranchPayment,
          $$BranchPaymentsTableFilterComposer,
          $$BranchPaymentsTableOrderingComposer,
          $$BranchPaymentsTableAnnotationComposer,
          $$BranchPaymentsTableCreateCompanionBuilder,
          $$BranchPaymentsTableUpdateCompanionBuilder,
          (
            BranchPayment,
            BaseReferences<_$AppDatabase, $BranchPaymentsTable, BranchPayment>,
          ),
          BranchPayment,
          PrefetchHooks Function()
        > {
  $$BranchPaymentsTableTableManager(
    _$AppDatabase db,
    $BranchPaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> createdBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchPaymentsCompanion(
                id: id,
                branchId: branchId,
                branchName: branchName,
                amount: amount,
                note: note,
                title: title,
                createdAt: createdAt,
                createdBy: createdBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String branchId,
                required String branchName,
                required double amount,
                Value<String?> note = const Value.absent(),
                required String title,
                required DateTime createdAt,
                required String createdBy,
                Value<int> rowid = const Value.absent(),
              }) => BranchPaymentsCompanion.insert(
                id: id,
                branchId: branchId,
                branchName: branchName,
                amount: amount,
                note: note,
                title: title,
                createdAt: createdAt,
                createdBy: createdBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BranchPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchPaymentsTable,
      BranchPayment,
      $$BranchPaymentsTableFilterComposer,
      $$BranchPaymentsTableOrderingComposer,
      $$BranchPaymentsTableAnnotationComposer,
      $$BranchPaymentsTableCreateCompanionBuilder,
      $$BranchPaymentsTableUpdateCompanionBuilder,
      (
        BranchPayment,
        BaseReferences<_$AppDatabase, $BranchPaymentsTable, BranchPayment>,
      ),
      BranchPayment,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$StoresTableTableManager get stores =>
      $$StoresTableTableManager(_db, _db.stores);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$TaxesTableTableManager get taxes =>
      $$TaxesTableTableManager(_db, _db.taxes);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$ProductBrandsTableTableManager get productBrands =>
      $$ProductBrandsTableTableManager(_db, _db.productBrands);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(_db, _db.productCategories);
  $$ProductSubCategoriesTableTableManager get productSubCategories =>
      $$ProductSubCategoriesTableTableManager(_db, _db.productSubCategories);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$SaleOrdersTableTableManager get saleOrders =>
      $$SaleOrdersTableTableManager(_db, _db.saleOrders);
  $$SaleOrderItemsTableTableManager get saleOrderItems =>
      $$SaleOrderItemsTableTableManager(_db, _db.saleOrderItems);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$ProformasTableTableManager get proformas =>
      $$ProformasTableTableManager(_db, _db.proformas);
  $$ProductDetailsListTableTableManager get productDetailsList =>
      $$ProductDetailsListTableTableManager(_db, _db.productDetailsList);
  $$WayBillsTableTableManager get wayBills =>
      $$WayBillsTableTableManager(_db, _db.wayBills);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$ReturnOrdersTableTableManager get returnOrders =>
      $$ReturnOrdersTableTableManager(_db, _db.returnOrders);
  $$ReturnOrderItemsTableTableManager get returnOrderItems =>
      $$ReturnOrderItemsTableTableManager(_db, _db.returnOrderItems);
  $$CreditNotesTableTableManager get creditNotes =>
      $$CreditNotesTableTableManager(_db, _db.creditNotes);
  $$CreditNoteItemsTableTableManager get creditNoteItems =>
      $$CreditNoteItemsTableTableManager(_db, _db.creditNoteItems);
  $$StockReportsTableTableManager get stockReports =>
      $$StockReportsTableTableManager(_db, _db.stockReports);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$BranchPaymentsTableTableManager get branchPayments =>
      $$BranchPaymentsTableTableManager(_db, _db.branchPayments);
}
