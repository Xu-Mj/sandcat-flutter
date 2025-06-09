// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id =
      GeneratedColumn<String>('id', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<String> account = GeneratedColumn<String>(
      'account', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _signatureMeta =
      const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String> signature = GeneratedColumn<String>(
      'signature', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<int> birthday = GeneratedColumn<int>(
      'birthday', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updateTimeMeta =
      const VerificationMeta('updateTime');
  @override
  late final GeneratedColumn<int> updateTime = GeneratedColumn<int>(
      'update_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastLoginTimeMeta =
      const VerificationMeta('lastLoginTime');
  @override
  late final GeneratedColumn<BigInt> lastLoginTime = GeneratedColumn<BigInt>(
      'last_login_time', aliasedName, true,
      type: DriftSqlType.bigInt, requiredDuringInsert: false);
  static const VerificationMeta _lastLoginIpMeta =
      const VerificationMeta('lastLoginIp');
  @override
  late final GeneratedColumn<String> lastLoginIp = GeneratedColumn<String>(
      'last_login_ip', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _twoFactorEnabledMeta =
      const VerificationMeta('twoFactorEnabled');
  @override
  late final GeneratedColumn<bool> twoFactorEnabled = GeneratedColumn<bool>(
      'two_factor_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("two_factor_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _accountStatusMeta =
      const VerificationMeta('accountStatus');
  @override
  late final GeneratedColumn<String> accountStatus = GeneratedColumn<String>(
      'account_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('offline'));
  static const VerificationMeta _lastActiveTimeMeta =
      const VerificationMeta('lastActiveTime');
  @override
  late final GeneratedColumn<int> lastActiveTime = GeneratedColumn<int>(
      'last_active_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMessageMeta =
      const VerificationMeta('statusMessage');
  @override
  late final GeneratedColumn<String> statusMessage = GeneratedColumn<String>(
      'status_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _privacySettingsMeta =
      const VerificationMeta('privacySettings');
  @override
  late final GeneratedColumn<String> privacySettings = GeneratedColumn<String>(
      'privacy_settings', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _notificationSettingsMeta =
      const VerificationMeta('notificationSettings');
  @override
  late final GeneratedColumn<String> notificationSettings =
      GeneratedColumn<String>('notification_settings', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('{}'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('zh_CN'));
  static const VerificationMeta _friendRequestsPrivacyMeta =
      const VerificationMeta('friendRequestsPrivacy');
  @override
  late final GeneratedColumn<String> friendRequestsPrivacy =
      GeneratedColumn<String>('friend_requests_privacy', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('all'));
  static const VerificationMeta _profileVisibilityMeta =
      const VerificationMeta('profileVisibility');
  @override
  late final GeneratedColumn<String> profileVisibility =
      GeneratedColumn<String>('profile_visibility', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('public'));
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
      'theme', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('system'));
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Asia/Shanghai'));
  static const VerificationMeta _isDeleteMeta =
      const VerificationMeta('isDelete');
  @override
  late final GeneratedColumn<bool> isDelete = GeneratedColumn<bool>(
      'is_delete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_delete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        account,
        signature,
        avatar,
        gender,
        age,
        phone,
        email,
        address,
        region,
        birthday,
        createTime,
        updateTime,
        lastLoginTime,
        lastLoginIp,
        twoFactorEnabled,
        accountStatus,
        status,
        lastActiveTime,
        statusMessage,
        privacySettings,
        notificationSettings,
        language,
        friendRequestsPrivacy,
        profileVisibility,
        theme,
        timezone,
        isDelete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('update_time')) {
      context.handle(
          _updateTimeMeta,
          updateTime.isAcceptableOrUnknown(
              data['update_time']!, _updateTimeMeta));
    } else if (isInserting) {
      context.missing(_updateTimeMeta);
    }
    if (data.containsKey('last_login_time')) {
      context.handle(
          _lastLoginTimeMeta,
          lastLoginTime.isAcceptableOrUnknown(
              data['last_login_time']!, _lastLoginTimeMeta));
    }
    if (data.containsKey('last_login_ip')) {
      context.handle(
          _lastLoginIpMeta,
          lastLoginIp.isAcceptableOrUnknown(
              data['last_login_ip']!, _lastLoginIpMeta));
    }
    if (data.containsKey('two_factor_enabled')) {
      context.handle(
          _twoFactorEnabledMeta,
          twoFactorEnabled.isAcceptableOrUnknown(
              data['two_factor_enabled']!, _twoFactorEnabledMeta));
    }
    if (data.containsKey('account_status')) {
      context.handle(
          _accountStatusMeta,
          accountStatus.isAcceptableOrUnknown(
              data['account_status']!, _accountStatusMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('last_active_time')) {
      context.handle(
          _lastActiveTimeMeta,
          lastActiveTime.isAcceptableOrUnknown(
              data['last_active_time']!, _lastActiveTimeMeta));
    }
    if (data.containsKey('status_message')) {
      context.handle(
          _statusMessageMeta,
          statusMessage.isAcceptableOrUnknown(
              data['status_message']!, _statusMessageMeta));
    }
    if (data.containsKey('privacy_settings')) {
      context.handle(
          _privacySettingsMeta,
          privacySettings.isAcceptableOrUnknown(
              data['privacy_settings']!, _privacySettingsMeta));
    }
    if (data.containsKey('notification_settings')) {
      context.handle(
          _notificationSettingsMeta,
          notificationSettings.isAcceptableOrUnknown(
              data['notification_settings']!, _notificationSettingsMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('friend_requests_privacy')) {
      context.handle(
          _friendRequestsPrivacyMeta,
          friendRequestsPrivacy.isAcceptableOrUnknown(
              data['friend_requests_privacy']!, _friendRequestsPrivacyMeta));
    }
    if (data.containsKey('profile_visibility')) {
      context.handle(
          _profileVisibilityMeta,
          profileVisibility.isAcceptableOrUnknown(
              data['profile_visibility']!, _profileVisibilityMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
          _themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('is_delete')) {
      context.handle(_isDeleteMeta,
          isDelete.isAcceptableOrUnknown(data['is_delete']!, _isDeleteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account'])!,
      signature: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}signature']),
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}birthday']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_time'])!,
      lastLoginTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}last_login_time']),
      lastLoginIp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_login_ip']),
      twoFactorEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}two_factor_enabled'])!,
      accountStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_status'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastActiveTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_active_time']),
      statusMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_message']),
      privacySettings: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}privacy_settings'])!,
      notificationSettings: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}notification_settings'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      friendRequestsPrivacy: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}friend_requests_privacy'])!,
      profileVisibility: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_visibility'])!,
      theme: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      isDelete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_delete'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String name;
  final String account;
  final String? signature;
  final String avatar;
  final String gender;
  final int age;
  final String? phone;
  final String? email;
  final String? address;
  final String? region;
  final int? birthday;
  final int createTime;
  final int updateTime;
  final BigInt? lastLoginTime;
  final String? lastLoginIp;
  final bool twoFactorEnabled;
  final String accountStatus;
  final String status;
  final int? lastActiveTime;
  final String? statusMessage;
  final String privacySettings;
  final String notificationSettings;
  final String language;
  final String friendRequestsPrivacy;
  final String profileVisibility;
  final String theme;
  final String timezone;
  final bool isDelete;
  const User(
      {required this.id,
      required this.name,
      required this.account,
      this.signature,
      required this.avatar,
      required this.gender,
      required this.age,
      this.phone,
      this.email,
      this.address,
      this.region,
      this.birthday,
      required this.createTime,
      required this.updateTime,
      this.lastLoginTime,
      this.lastLoginIp,
      required this.twoFactorEnabled,
      required this.accountStatus,
      required this.status,
      this.lastActiveTime,
      this.statusMessage,
      required this.privacySettings,
      required this.notificationSettings,
      required this.language,
      required this.friendRequestsPrivacy,
      required this.profileVisibility,
      required this.theme,
      required this.timezone,
      required this.isDelete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['account'] = Variable<String>(account);
    if (!nullToAbsent || signature != null) {
      map['signature'] = Variable<String>(signature);
    }
    map['avatar'] = Variable<String>(avatar);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<int>(birthday);
    }
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    if (!nullToAbsent || lastLoginTime != null) {
      map['last_login_time'] = Variable<BigInt>(lastLoginTime);
    }
    if (!nullToAbsent || lastLoginIp != null) {
      map['last_login_ip'] = Variable<String>(lastLoginIp);
    }
    map['two_factor_enabled'] = Variable<bool>(twoFactorEnabled);
    map['account_status'] = Variable<String>(accountStatus);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastActiveTime != null) {
      map['last_active_time'] = Variable<int>(lastActiveTime);
    }
    if (!nullToAbsent || statusMessage != null) {
      map['status_message'] = Variable<String>(statusMessage);
    }
    map['privacy_settings'] = Variable<String>(privacySettings);
    map['notification_settings'] = Variable<String>(notificationSettings);
    map['language'] = Variable<String>(language);
    map['friend_requests_privacy'] = Variable<String>(friendRequestsPrivacy);
    map['profile_visibility'] = Variable<String>(profileVisibility);
    map['theme'] = Variable<String>(theme);
    map['timezone'] = Variable<String>(timezone);
    map['is_delete'] = Variable<bool>(isDelete);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      account: Value(account),
      signature: signature == null && nullToAbsent
          ? const Value.absent()
          : Value(signature),
      avatar: Value(avatar),
      gender: Value(gender),
      age: Value(age),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      lastLoginTime: lastLoginTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginTime),
      lastLoginIp: lastLoginIp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginIp),
      twoFactorEnabled: Value(twoFactorEnabled),
      accountStatus: Value(accountStatus),
      status: Value(status),
      lastActiveTime: lastActiveTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveTime),
      statusMessage: statusMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(statusMessage),
      privacySettings: Value(privacySettings),
      notificationSettings: Value(notificationSettings),
      language: Value(language),
      friendRequestsPrivacy: Value(friendRequestsPrivacy),
      profileVisibility: Value(profileVisibility),
      theme: Value(theme),
      timezone: Value(timezone),
      isDelete: Value(isDelete),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      account: serializer.fromJson<String>(json['account']),
      signature: serializer.fromJson<String?>(json['signature']),
      avatar: serializer.fromJson<String>(json['avatar']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      region: serializer.fromJson<String?>(json['region']),
      birthday: serializer.fromJson<int?>(json['birthday']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
      lastLoginTime: serializer.fromJson<BigInt?>(json['lastLoginTime']),
      lastLoginIp: serializer.fromJson<String?>(json['lastLoginIp']),
      twoFactorEnabled: serializer.fromJson<bool>(json['twoFactorEnabled']),
      accountStatus: serializer.fromJson<String>(json['accountStatus']),
      status: serializer.fromJson<String>(json['status']),
      lastActiveTime: serializer.fromJson<int?>(json['lastActiveTime']),
      statusMessage: serializer.fromJson<String?>(json['statusMessage']),
      privacySettings: serializer.fromJson<String>(json['privacySettings']),
      notificationSettings:
          serializer.fromJson<String>(json['notificationSettings']),
      language: serializer.fromJson<String>(json['language']),
      friendRequestsPrivacy:
          serializer.fromJson<String>(json['friendRequestsPrivacy']),
      profileVisibility: serializer.fromJson<String>(json['profileVisibility']),
      theme: serializer.fromJson<String>(json['theme']),
      timezone: serializer.fromJson<String>(json['timezone']),
      isDelete: serializer.fromJson<bool>(json['isDelete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'account': serializer.toJson<String>(account),
      'signature': serializer.toJson<String?>(signature),
      'avatar': serializer.toJson<String>(avatar),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'region': serializer.toJson<String?>(region),
      'birthday': serializer.toJson<int?>(birthday),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
      'lastLoginTime': serializer.toJson<BigInt?>(lastLoginTime),
      'lastLoginIp': serializer.toJson<String?>(lastLoginIp),
      'twoFactorEnabled': serializer.toJson<bool>(twoFactorEnabled),
      'accountStatus': serializer.toJson<String>(accountStatus),
      'status': serializer.toJson<String>(status),
      'lastActiveTime': serializer.toJson<int?>(lastActiveTime),
      'statusMessage': serializer.toJson<String?>(statusMessage),
      'privacySettings': serializer.toJson<String>(privacySettings),
      'notificationSettings': serializer.toJson<String>(notificationSettings),
      'language': serializer.toJson<String>(language),
      'friendRequestsPrivacy': serializer.toJson<String>(friendRequestsPrivacy),
      'profileVisibility': serializer.toJson<String>(profileVisibility),
      'theme': serializer.toJson<String>(theme),
      'timezone': serializer.toJson<String>(timezone),
      'isDelete': serializer.toJson<bool>(isDelete),
    };
  }

  User copyWith(
          {String? id,
          String? name,
          String? account,
          Value<String?> signature = const Value.absent(),
          String? avatar,
          String? gender,
          int? age,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> region = const Value.absent(),
          Value<int?> birthday = const Value.absent(),
          int? createTime,
          int? updateTime,
          Value<BigInt?> lastLoginTime = const Value.absent(),
          Value<String?> lastLoginIp = const Value.absent(),
          bool? twoFactorEnabled,
          String? accountStatus,
          String? status,
          Value<int?> lastActiveTime = const Value.absent(),
          Value<String?> statusMessage = const Value.absent(),
          String? privacySettings,
          String? notificationSettings,
          String? language,
          String? friendRequestsPrivacy,
          String? profileVisibility,
          String? theme,
          String? timezone,
          bool? isDelete}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        account: account ?? this.account,
        signature: signature.present ? signature.value : this.signature,
        avatar: avatar ?? this.avatar,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        region: region.present ? region.value : this.region,
        birthday: birthday.present ? birthday.value : this.birthday,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        lastLoginTime:
            lastLoginTime.present ? lastLoginTime.value : this.lastLoginTime,
        lastLoginIp: lastLoginIp.present ? lastLoginIp.value : this.lastLoginIp,
        twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
        accountStatus: accountStatus ?? this.accountStatus,
        status: status ?? this.status,
        lastActiveTime:
            lastActiveTime.present ? lastActiveTime.value : this.lastActiveTime,
        statusMessage:
            statusMessage.present ? statusMessage.value : this.statusMessage,
        privacySettings: privacySettings ?? this.privacySettings,
        notificationSettings: notificationSettings ?? this.notificationSettings,
        language: language ?? this.language,
        friendRequestsPrivacy:
            friendRequestsPrivacy ?? this.friendRequestsPrivacy,
        profileVisibility: profileVisibility ?? this.profileVisibility,
        theme: theme ?? this.theme,
        timezone: timezone ?? this.timezone,
        isDelete: isDelete ?? this.isDelete,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      account: data.account.present ? data.account.value : this.account,
      signature: data.signature.present ? data.signature.value : this.signature,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      region: data.region.present ? data.region.value : this.region,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      lastLoginTime: data.lastLoginTime.present
          ? data.lastLoginTime.value
          : this.lastLoginTime,
      lastLoginIp:
          data.lastLoginIp.present ? data.lastLoginIp.value : this.lastLoginIp,
      twoFactorEnabled: data.twoFactorEnabled.present
          ? data.twoFactorEnabled.value
          : this.twoFactorEnabled,
      accountStatus: data.accountStatus.present
          ? data.accountStatus.value
          : this.accountStatus,
      status: data.status.present ? data.status.value : this.status,
      lastActiveTime: data.lastActiveTime.present
          ? data.lastActiveTime.value
          : this.lastActiveTime,
      statusMessage: data.statusMessage.present
          ? data.statusMessage.value
          : this.statusMessage,
      privacySettings: data.privacySettings.present
          ? data.privacySettings.value
          : this.privacySettings,
      notificationSettings: data.notificationSettings.present
          ? data.notificationSettings.value
          : this.notificationSettings,
      language: data.language.present ? data.language.value : this.language,
      friendRequestsPrivacy: data.friendRequestsPrivacy.present
          ? data.friendRequestsPrivacy.value
          : this.friendRequestsPrivacy,
      profileVisibility: data.profileVisibility.present
          ? data.profileVisibility.value
          : this.profileVisibility,
      theme: data.theme.present ? data.theme.value : this.theme,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      isDelete: data.isDelete.present ? data.isDelete.value : this.isDelete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('account: $account, ')
          ..write('signature: $signature, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('region: $region, ')
          ..write('birthday: $birthday, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('lastLoginIp: $lastLoginIp, ')
          ..write('twoFactorEnabled: $twoFactorEnabled, ')
          ..write('accountStatus: $accountStatus, ')
          ..write('status: $status, ')
          ..write('lastActiveTime: $lastActiveTime, ')
          ..write('statusMessage: $statusMessage, ')
          ..write('privacySettings: $privacySettings, ')
          ..write('notificationSettings: $notificationSettings, ')
          ..write('language: $language, ')
          ..write('friendRequestsPrivacy: $friendRequestsPrivacy, ')
          ..write('profileVisibility: $profileVisibility, ')
          ..write('theme: $theme, ')
          ..write('timezone: $timezone, ')
          ..write('isDelete: $isDelete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        account,
        signature,
        avatar,
        gender,
        age,
        phone,
        email,
        address,
        region,
        birthday,
        createTime,
        updateTime,
        lastLoginTime,
        lastLoginIp,
        twoFactorEnabled,
        accountStatus,
        status,
        lastActiveTime,
        statusMessage,
        privacySettings,
        notificationSettings,
        language,
        friendRequestsPrivacy,
        profileVisibility,
        theme,
        timezone,
        isDelete
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.account == this.account &&
          other.signature == this.signature &&
          other.avatar == this.avatar &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.region == this.region &&
          other.birthday == this.birthday &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.lastLoginTime == this.lastLoginTime &&
          other.lastLoginIp == this.lastLoginIp &&
          other.twoFactorEnabled == this.twoFactorEnabled &&
          other.accountStatus == this.accountStatus &&
          other.status == this.status &&
          other.lastActiveTime == this.lastActiveTime &&
          other.statusMessage == this.statusMessage &&
          other.privacySettings == this.privacySettings &&
          other.notificationSettings == this.notificationSettings &&
          other.language == this.language &&
          other.friendRequestsPrivacy == this.friendRequestsPrivacy &&
          other.profileVisibility == this.profileVisibility &&
          other.theme == this.theme &&
          other.timezone == this.timezone &&
          other.isDelete == this.isDelete);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> account;
  final Value<String?> signature;
  final Value<String> avatar;
  final Value<String> gender;
  final Value<int> age;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> region;
  final Value<int?> birthday;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<BigInt?> lastLoginTime;
  final Value<String?> lastLoginIp;
  final Value<bool> twoFactorEnabled;
  final Value<String> accountStatus;
  final Value<String> status;
  final Value<int?> lastActiveTime;
  final Value<String?> statusMessage;
  final Value<String> privacySettings;
  final Value<String> notificationSettings;
  final Value<String> language;
  final Value<String> friendRequestsPrivacy;
  final Value<String> profileVisibility;
  final Value<String> theme;
  final Value<String> timezone;
  final Value<bool> isDelete;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.account = const Value.absent(),
    this.signature = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.region = const Value.absent(),
    this.birthday = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.lastLoginTime = const Value.absent(),
    this.lastLoginIp = const Value.absent(),
    this.twoFactorEnabled = const Value.absent(),
    this.accountStatus = const Value.absent(),
    this.status = const Value.absent(),
    this.lastActiveTime = const Value.absent(),
    this.statusMessage = const Value.absent(),
    this.privacySettings = const Value.absent(),
    this.notificationSettings = const Value.absent(),
    this.language = const Value.absent(),
    this.friendRequestsPrivacy = const Value.absent(),
    this.profileVisibility = const Value.absent(),
    this.theme = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isDelete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String account,
    this.signature = const Value.absent(),
    required String avatar,
    required String gender,
    this.age = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.region = const Value.absent(),
    this.birthday = const Value.absent(),
    required int createTime,
    required int updateTime,
    this.lastLoginTime = const Value.absent(),
    this.lastLoginIp = const Value.absent(),
    this.twoFactorEnabled = const Value.absent(),
    this.accountStatus = const Value.absent(),
    this.status = const Value.absent(),
    this.lastActiveTime = const Value.absent(),
    this.statusMessage = const Value.absent(),
    this.privacySettings = const Value.absent(),
    this.notificationSettings = const Value.absent(),
    this.language = const Value.absent(),
    this.friendRequestsPrivacy = const Value.absent(),
    this.profileVisibility = const Value.absent(),
    this.theme = const Value.absent(),
    this.timezone = const Value.absent(),
    this.isDelete = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        account = Value(account),
        avatar = Value(avatar),
        gender = Value(gender),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? account,
    Expression<String>? signature,
    Expression<String>? avatar,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? region,
    Expression<int>? birthday,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<BigInt>? lastLoginTime,
    Expression<String>? lastLoginIp,
    Expression<bool>? twoFactorEnabled,
    Expression<String>? accountStatus,
    Expression<String>? status,
    Expression<int>? lastActiveTime,
    Expression<String>? statusMessage,
    Expression<String>? privacySettings,
    Expression<String>? notificationSettings,
    Expression<String>? language,
    Expression<String>? friendRequestsPrivacy,
    Expression<String>? profileVisibility,
    Expression<String>? theme,
    Expression<String>? timezone,
    Expression<bool>? isDelete,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (account != null) 'account': account,
      if (signature != null) 'signature': signature,
      if (avatar != null) 'avatar': avatar,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (region != null) 'region': region,
      if (birthday != null) 'birthday': birthday,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (lastLoginTime != null) 'last_login_time': lastLoginTime,
      if (lastLoginIp != null) 'last_login_ip': lastLoginIp,
      if (twoFactorEnabled != null) 'two_factor_enabled': twoFactorEnabled,
      if (accountStatus != null) 'account_status': accountStatus,
      if (status != null) 'status': status,
      if (lastActiveTime != null) 'last_active_time': lastActiveTime,
      if (statusMessage != null) 'status_message': statusMessage,
      if (privacySettings != null) 'privacy_settings': privacySettings,
      if (notificationSettings != null)
        'notification_settings': notificationSettings,
      if (language != null) 'language': language,
      if (friendRequestsPrivacy != null)
        'friend_requests_privacy': friendRequestsPrivacy,
      if (profileVisibility != null) 'profile_visibility': profileVisibility,
      if (theme != null) 'theme': theme,
      if (timezone != null) 'timezone': timezone,
      if (isDelete != null) 'is_delete': isDelete,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? account,
      Value<String?>? signature,
      Value<String>? avatar,
      Value<String>? gender,
      Value<int>? age,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<String?>? region,
      Value<int?>? birthday,
      Value<int>? createTime,
      Value<int>? updateTime,
      Value<BigInt?>? lastLoginTime,
      Value<String?>? lastLoginIp,
      Value<bool>? twoFactorEnabled,
      Value<String>? accountStatus,
      Value<String>? status,
      Value<int?>? lastActiveTime,
      Value<String?>? statusMessage,
      Value<String>? privacySettings,
      Value<String>? notificationSettings,
      Value<String>? language,
      Value<String>? friendRequestsPrivacy,
      Value<String>? profileVisibility,
      Value<String>? theme,
      Value<String>? timezone,
      Value<bool>? isDelete,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      account: account ?? this.account,
      signature: signature ?? this.signature,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      region: region ?? this.region,
      birthday: birthday ?? this.birthday,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      accountStatus: accountStatus ?? this.accountStatus,
      status: status ?? this.status,
      lastActiveTime: lastActiveTime ?? this.lastActiveTime,
      statusMessage: statusMessage ?? this.statusMessage,
      privacySettings: privacySettings ?? this.privacySettings,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      language: language ?? this.language,
      friendRequestsPrivacy:
          friendRequestsPrivacy ?? this.friendRequestsPrivacy,
      profileVisibility: profileVisibility ?? this.profileVisibility,
      theme: theme ?? this.theme,
      timezone: timezone ?? this.timezone,
      isDelete: isDelete ?? this.isDelete,
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
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<int>(birthday.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (lastLoginTime.present) {
      map['last_login_time'] = Variable<BigInt>(lastLoginTime.value);
    }
    if (lastLoginIp.present) {
      map['last_login_ip'] = Variable<String>(lastLoginIp.value);
    }
    if (twoFactorEnabled.present) {
      map['two_factor_enabled'] = Variable<bool>(twoFactorEnabled.value);
    }
    if (accountStatus.present) {
      map['account_status'] = Variable<String>(accountStatus.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastActiveTime.present) {
      map['last_active_time'] = Variable<int>(lastActiveTime.value);
    }
    if (statusMessage.present) {
      map['status_message'] = Variable<String>(statusMessage.value);
    }
    if (privacySettings.present) {
      map['privacy_settings'] = Variable<String>(privacySettings.value);
    }
    if (notificationSettings.present) {
      map['notification_settings'] =
          Variable<String>(notificationSettings.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (friendRequestsPrivacy.present) {
      map['friend_requests_privacy'] =
          Variable<String>(friendRequestsPrivacy.value);
    }
    if (profileVisibility.present) {
      map['profile_visibility'] = Variable<String>(profileVisibility.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (isDelete.present) {
      map['is_delete'] = Variable<bool>(isDelete.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('account: $account, ')
          ..write('signature: $signature, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('region: $region, ')
          ..write('birthday: $birthday, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('lastLoginIp: $lastLoginIp, ')
          ..write('twoFactorEnabled: $twoFactorEnabled, ')
          ..write('accountStatus: $accountStatus, ')
          ..write('status: $status, ')
          ..write('lastActiveTime: $lastActiveTime, ')
          ..write('statusMessage: $statusMessage, ')
          ..write('privacySettings: $privacySettings, ')
          ..write('notificationSettings: $notificationSettings, ')
          ..write('language: $language, ')
          ..write('friendRequestsPrivacy: $friendRequestsPrivacy, ')
          ..write('profileVisibility: $profileVisibility, ')
          ..write('theme: $theme, ')
          ..write('timezone: $timezone, ')
          ..write('isDelete: $isDelete, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  required String account,
  Value<String?> signature,
  required String avatar,
  required String gender,
  Value<int> age,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> region,
  Value<int?> birthday,
  required int createTime,
  required int updateTime,
  Value<BigInt?> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<bool> twoFactorEnabled,
  Value<String> accountStatus,
  Value<String> status,
  Value<int?> lastActiveTime,
  Value<String?> statusMessage,
  Value<String> privacySettings,
  Value<String> notificationSettings,
  Value<String> language,
  Value<String> friendRequestsPrivacy,
  Value<String> profileVisibility,
  Value<String> theme,
  Value<String> timezone,
  Value<bool> isDelete,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> account,
  Value<String?> signature,
  Value<String> avatar,
  Value<String> gender,
  Value<int> age,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> region,
  Value<int?> birthday,
  Value<int> createTime,
  Value<int> updateTime,
  Value<BigInt?> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<bool> twoFactorEnabled,
  Value<String> accountStatus,
  Value<String> status,
  Value<int?> lastActiveTime,
  Value<String?> statusMessage,
  Value<String> privacySettings,
  Value<String> notificationSettings,
  Value<String> language,
  Value<String> friendRequestsPrivacy,
  Value<String> profileVisibility,
  Value<String> theme,
  Value<String> timezone,
  Value<bool> isDelete,
  Value<int> rowid,
});

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> account = const Value.absent(),
            Value<String?> signature = const Value.absent(),
            Value<String> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int?> birthday = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> updateTime = const Value.absent(),
            Value<BigInt?> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<bool> twoFactorEnabled = const Value.absent(),
            Value<String> accountStatus = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> lastActiveTime = const Value.absent(),
            Value<String?> statusMessage = const Value.absent(),
            Value<String> privacySettings = const Value.absent(),
            Value<String> notificationSettings = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> friendRequestsPrivacy = const Value.absent(),
            Value<String> profileVisibility = const Value.absent(),
            Value<String> theme = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<bool> isDelete = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            account: account,
            signature: signature,
            avatar: avatar,
            gender: gender,
            age: age,
            phone: phone,
            email: email,
            address: address,
            region: region,
            birthday: birthday,
            createTime: createTime,
            updateTime: updateTime,
            lastLoginTime: lastLoginTime,
            lastLoginIp: lastLoginIp,
            twoFactorEnabled: twoFactorEnabled,
            accountStatus: accountStatus,
            status: status,
            lastActiveTime: lastActiveTime,
            statusMessage: statusMessage,
            privacySettings: privacySettings,
            notificationSettings: notificationSettings,
            language: language,
            friendRequestsPrivacy: friendRequestsPrivacy,
            profileVisibility: profileVisibility,
            theme: theme,
            timezone: timezone,
            isDelete: isDelete,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String account,
            Value<String?> signature = const Value.absent(),
            required String avatar,
            required String gender,
            Value<int> age = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int?> birthday = const Value.absent(),
            required int createTime,
            required int updateTime,
            Value<BigInt?> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<bool> twoFactorEnabled = const Value.absent(),
            Value<String> accountStatus = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> lastActiveTime = const Value.absent(),
            Value<String?> statusMessage = const Value.absent(),
            Value<String> privacySettings = const Value.absent(),
            Value<String> notificationSettings = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> friendRequestsPrivacy = const Value.absent(),
            Value<String> profileVisibility = const Value.absent(),
            Value<String> theme = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<bool> isDelete = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            account: account,
            signature: signature,
            avatar: avatar,
            gender: gender,
            age: age,
            phone: phone,
            email: email,
            address: address,
            region: region,
            birthday: birthday,
            createTime: createTime,
            updateTime: updateTime,
            lastLoginTime: lastLoginTime,
            lastLoginIp: lastLoginIp,
            twoFactorEnabled: twoFactorEnabled,
            accountStatus: accountStatus,
            status: status,
            lastActiveTime: lastActiveTime,
            statusMessage: statusMessage,
            privacySettings: privacySettings,
            notificationSettings: notificationSettings,
            language: language,
            friendRequestsPrivacy: friendRequestsPrivacy,
            profileVisibility: profileVisibility,
            theme: theme,
            timezone: timezone,
            isDelete: isDelete,
            rowid: rowid,
          ),
        ));
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get account => $state.composableBuilder(
      column: $state.table.account,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get signature => $state.composableBuilder(
      column: $state.table.signature,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get avatar => $state.composableBuilder(
      column: $state.table.avatar,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get age => $state.composableBuilder(
      column: $state.table.age,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get region => $state.composableBuilder(
      column: $state.table.region,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get birthday => $state.composableBuilder(
      column: $state.table.birthday,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createTime => $state.composableBuilder(
      column: $state.table.createTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get updateTime => $state.composableBuilder(
      column: $state.table.updateTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<BigInt> get lastLoginTime => $state.composableBuilder(
      column: $state.table.lastLoginTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastLoginIp => $state.composableBuilder(
      column: $state.table.lastLoginIp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get twoFactorEnabled => $state.composableBuilder(
      column: $state.table.twoFactorEnabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get accountStatus => $state.composableBuilder(
      column: $state.table.accountStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lastActiveTime => $state.composableBuilder(
      column: $state.table.lastActiveTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusMessage => $state.composableBuilder(
      column: $state.table.statusMessage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get privacySettings => $state.composableBuilder(
      column: $state.table.privacySettings,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notificationSettings => $state.composableBuilder(
      column: $state.table.notificationSettings,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get friendRequestsPrivacy => $state.composableBuilder(
      column: $state.table.friendRequestsPrivacy,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get profileVisibility => $state.composableBuilder(
      column: $state.table.profileVisibility,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get theme => $state.composableBuilder(
      column: $state.table.theme,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get timezone => $state.composableBuilder(
      column: $state.table.timezone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDelete => $state.composableBuilder(
      column: $state.table.isDelete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get account => $state.composableBuilder(
      column: $state.table.account,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get signature => $state.composableBuilder(
      column: $state.table.signature,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get avatar => $state.composableBuilder(
      column: $state.table.avatar,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gender => $state.composableBuilder(
      column: $state.table.gender,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get age => $state.composableBuilder(
      column: $state.table.age,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get region => $state.composableBuilder(
      column: $state.table.region,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get birthday => $state.composableBuilder(
      column: $state.table.birthday,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createTime => $state.composableBuilder(
      column: $state.table.createTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get updateTime => $state.composableBuilder(
      column: $state.table.updateTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<BigInt> get lastLoginTime => $state.composableBuilder(
      column: $state.table.lastLoginTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastLoginIp => $state.composableBuilder(
      column: $state.table.lastLoginIp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get twoFactorEnabled => $state.composableBuilder(
      column: $state.table.twoFactorEnabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get accountStatus => $state.composableBuilder(
      column: $state.table.accountStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lastActiveTime => $state.composableBuilder(
      column: $state.table.lastActiveTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusMessage => $state.composableBuilder(
      column: $state.table.statusMessage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get privacySettings => $state.composableBuilder(
      column: $state.table.privacySettings,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notificationSettings => $state.composableBuilder(
      column: $state.table.notificationSettings,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get friendRequestsPrivacy => $state.composableBuilder(
      column: $state.table.friendRequestsPrivacy,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get profileVisibility => $state.composableBuilder(
      column: $state.table.profileVisibility,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get theme => $state.composableBuilder(
      column: $state.table.theme,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get timezone => $state.composableBuilder(
      column: $state.table.timezone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDelete => $state.composableBuilder(
      column: $state.table.isDelete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
