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
  late final GeneratedColumn<int> lastLoginTime = GeneratedColumn<int>(
      'last_login_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
        timezone
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
          .read(DriftSqlType.int, data['${effectivePrefix}last_login_time']),
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
  final int? lastLoginTime;
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
      required this.timezone});
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
      map['last_login_time'] = Variable<int>(lastLoginTime);
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
      lastLoginTime: serializer.fromJson<int?>(json['lastLoginTime']),
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
    );
  }
  factory User.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      User.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
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
      'lastLoginTime': serializer.toJson<int?>(lastLoginTime),
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
          Value<int?> lastLoginTime = const Value.absent(),
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
          String? timezone}) =>
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
          ..write('timezone: $timezone')
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
        timezone
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
          other.timezone == this.timezone);
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
  final Value<int?> lastLoginTime;
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
    Expression<int>? lastLoginTime,
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
      Value<int?>? lastLoginTime,
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
      map['last_login_time'] = Variable<int>(lastLoginTime.value);
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendsTable extends Friends with TableInfo<$FriendsTable, Friend> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _fsIdMeta = const VerificationMeta('fsId');
  @override
  late final GeneratedColumn<String> fsId = GeneratedColumn<String>(
      'fs_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(FriendRequestStatus.accepted));
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _deletedTimeMeta =
      const VerificationMeta('deletedTime');
  @override
  late final GeneratedColumn<int> deletedTime = GeneratedColumn<int>(
      'deleted_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isStarredMeta =
      const VerificationMeta('isStarred');
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
      'is_starred', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_starred" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        fsId,
        userId,
        friendId,
        name,
        avatar,
        gender,
        age,
        region,
        email,
        status,
        remark,
        source,
        createTime,
        updateTime,
        deletedTime,
        isStarred,
        groupId,
        priority
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friends';
  @override
  VerificationContext validateIntegrity(Insertable<Friend> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('fs_id')) {
      context.handle(
          _fsIdMeta, fsId.isAcceptableOrUnknown(data['fs_id']!, _fsIdMeta));
    } else if (isInserting) {
      context.missing(_fsIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
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
    if (data.containsKey('deleted_time')) {
      context.handle(
          _deletedTimeMeta,
          deletedTime.isAcceptableOrUnknown(
              data['deleted_time']!, _deletedTimeMeta));
    }
    if (data.containsKey('is_starred')) {
      context.handle(_isStarredMeta,
          isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fsId};
  @override
  Friend map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Friend(
      fsId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fs_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_time'])!,
      deletedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_time']),
      isStarred: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_starred'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
    );
  }

  @override
  $FriendsTable createAlias(String alias) {
    return $FriendsTable(attachedDatabase, alias);
  }
}

class Friend extends DataClass implements Insertable<Friend> {
  final String fsId;
  final String userId;
  final String friendId;
  final String name;
  final String avatar;
  final String gender;
  final int age;
  final String? region;
  final String email;
  final String status;
  final String? remark;
  final String? source;
  final int createTime;
  final int updateTime;
  final int? deletedTime;
  final bool isStarred;
  final int? groupId;
  final int priority;
  const Friend(
      {required this.fsId,
      required this.userId,
      required this.friendId,
      required this.name,
      required this.avatar,
      required this.gender,
      required this.age,
      this.region,
      required this.email,
      required this.status,
      this.remark,
      this.source,
      required this.createTime,
      required this.updateTime,
      this.deletedTime,
      required this.isStarred,
      this.groupId,
      required this.priority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['fs_id'] = Variable<String>(fsId);
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['name'] = Variable<String>(name);
    map['avatar'] = Variable<String>(avatar);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['email'] = Variable<String>(email);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    if (!nullToAbsent || deletedTime != null) {
      map['deleted_time'] = Variable<int>(deletedTime);
    }
    map['is_starred'] = Variable<bool>(isStarred);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<int>(groupId);
    }
    map['priority'] = Variable<int>(priority);
    return map;
  }

  FriendsCompanion toCompanion(bool nullToAbsent) {
    return FriendsCompanion(
      fsId: Value(fsId),
      userId: Value(userId),
      friendId: Value(friendId),
      name: Value(name),
      avatar: Value(avatar),
      gender: Value(gender),
      age: Value(age),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      email: Value(email),
      status: Value(status),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      deletedTime: deletedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedTime),
      isStarred: Value(isStarred),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      priority: Value(priority),
    );
  }

  factory Friend.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Friend(
      fsId: serializer.fromJson<String>(json['fsId']),
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String>(json['avatar']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      region: serializer.fromJson<String?>(json['region']),
      email: serializer.fromJson<String>(json['email']),
      status: serializer.fromJson<String>(json['status']),
      remark: serializer.fromJson<String?>(json['remark']),
      source: serializer.fromJson<String?>(json['source']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
      deletedTime: serializer.fromJson<int?>(json['deletedTime']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      groupId: serializer.fromJson<int?>(json['groupId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  factory Friend.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Friend.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fsId': serializer.toJson<String>(fsId),
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String>(avatar),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'region': serializer.toJson<String?>(region),
      'email': serializer.toJson<String>(email),
      'status': serializer.toJson<String>(status),
      'remark': serializer.toJson<String?>(remark),
      'source': serializer.toJson<String?>(source),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
      'deletedTime': serializer.toJson<int?>(deletedTime),
      'isStarred': serializer.toJson<bool>(isStarred),
      'groupId': serializer.toJson<int?>(groupId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Friend copyWith(
          {String? fsId,
          String? userId,
          String? friendId,
          String? name,
          String? avatar,
          String? gender,
          int? age,
          Value<String?> region = const Value.absent(),
          String? email,
          String? status,
          Value<String?> remark = const Value.absent(),
          Value<String?> source = const Value.absent(),
          int? createTime,
          int? updateTime,
          Value<int?> deletedTime = const Value.absent(),
          bool? isStarred,
          Value<int?> groupId = const Value.absent(),
          int? priority}) =>
      Friend(
        fsId: fsId ?? this.fsId,
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        region: region.present ? region.value : this.region,
        email: email ?? this.email,
        status: status ?? this.status,
        remark: remark.present ? remark.value : this.remark,
        source: source.present ? source.value : this.source,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        deletedTime: deletedTime.present ? deletedTime.value : this.deletedTime,
        isStarred: isStarred ?? this.isStarred,
        groupId: groupId.present ? groupId.value : this.groupId,
        priority: priority ?? this.priority,
      );
  Friend copyWithCompanion(FriendsCompanion data) {
    return Friend(
      fsId: data.fsId.present ? data.fsId.value : this.fsId,
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      region: data.region.present ? data.region.value : this.region,
      email: data.email.present ? data.email.value : this.email,
      status: data.status.present ? data.status.value : this.status,
      remark: data.remark.present ? data.remark.value : this.remark,
      source: data.source.present ? data.source.value : this.source,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      deletedTime:
          data.deletedTime.present ? data.deletedTime.value : this.deletedTime,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      priority: data.priority.present ? data.priority.value : this.priority,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Friend(')
          ..write('fsId: $fsId, ')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('region: $region, ')
          ..write('email: $email, ')
          ..write('status: $status, ')
          ..write('remark: $remark, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('deletedTime: $deletedTime, ')
          ..write('isStarred: $isStarred, ')
          ..write('groupId: $groupId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      fsId,
      userId,
      friendId,
      name,
      avatar,
      gender,
      age,
      region,
      email,
      status,
      remark,
      source,
      createTime,
      updateTime,
      deletedTime,
      isStarred,
      groupId,
      priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Friend &&
          other.fsId == this.fsId &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.region == this.region &&
          other.email == this.email &&
          other.status == this.status &&
          other.remark == this.remark &&
          other.source == this.source &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.deletedTime == this.deletedTime &&
          other.isStarred == this.isStarred &&
          other.groupId == this.groupId &&
          other.priority == this.priority);
}

class FriendsCompanion extends UpdateCompanion<Friend> {
  final Value<String> fsId;
  final Value<String> userId;
  final Value<String> friendId;
  final Value<String> name;
  final Value<String> avatar;
  final Value<String> gender;
  final Value<int> age;
  final Value<String?> region;
  final Value<String> email;
  final Value<String> status;
  final Value<String?> remark;
  final Value<String?> source;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<int?> deletedTime;
  final Value<bool> isStarred;
  final Value<int?> groupId;
  final Value<int> priority;
  final Value<int> rowid;
  const FriendsCompanion({
    this.fsId = const Value.absent(),
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.region = const Value.absent(),
    this.email = const Value.absent(),
    this.status = const Value.absent(),
    this.remark = const Value.absent(),
    this.source = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.deletedTime = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.groupId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendsCompanion.insert({
    required String fsId,
    required String userId,
    required String friendId,
    required String name,
    required String avatar,
    required String gender,
    required int age,
    this.region = const Value.absent(),
    required String email,
    this.status = const Value.absent(),
    this.remark = const Value.absent(),
    this.source = const Value.absent(),
    required int createTime,
    required int updateTime,
    this.deletedTime = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.groupId = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : fsId = Value(fsId),
        userId = Value(userId),
        friendId = Value(friendId),
        name = Value(name),
        avatar = Value(avatar),
        gender = Value(gender),
        age = Value(age),
        email = Value(email),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<Friend> custom({
    Expression<String>? fsId,
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<String>? region,
    Expression<String>? email,
    Expression<String>? status,
    Expression<String>? remark,
    Expression<String>? source,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<int>? deletedTime,
    Expression<bool>? isStarred,
    Expression<int>? groupId,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (fsId != null) 'fs_id': fsId,
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (region != null) 'region': region,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
      if (remark != null) 'remark': remark,
      if (source != null) 'source': source,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (deletedTime != null) 'deleted_time': deletedTime,
      if (isStarred != null) 'is_starred': isStarred,
      if (groupId != null) 'group_id': groupId,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendsCompanion copyWith(
      {Value<String>? fsId,
      Value<String>? userId,
      Value<String>? friendId,
      Value<String>? name,
      Value<String>? avatar,
      Value<String>? gender,
      Value<int>? age,
      Value<String?>? region,
      Value<String>? email,
      Value<String>? status,
      Value<String?>? remark,
      Value<String?>? source,
      Value<int>? createTime,
      Value<int>? updateTime,
      Value<int?>? deletedTime,
      Value<bool>? isStarred,
      Value<int?>? groupId,
      Value<int>? priority,
      Value<int>? rowid}) {
    return FriendsCompanion(
      fsId: fsId ?? this.fsId,
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      region: region ?? this.region,
      email: email ?? this.email,
      status: status ?? this.status,
      remark: remark ?? this.remark,
      source: source ?? this.source,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      deletedTime: deletedTime ?? this.deletedTime,
      isStarred: isStarred ?? this.isStarred,
      groupId: groupId ?? this.groupId,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fsId.present) {
      map['fs_id'] = Variable<String>(fsId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (deletedTime.present) {
      map['deleted_time'] = Variable<int>(deletedTime.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendsCompanion(')
          ..write('fsId: $fsId, ')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('region: $region, ')
          ..write('email: $email, ')
          ..write('status: $status, ')
          ..write('remark: $remark, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('deletedTime: $deletedTime, ')
          ..write('isStarred: $isStarred, ')
          ..write('groupId: $groupId, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendRequestsTable extends FriendRequests
    with TableInfo<$FriendRequestsTable, FriendRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(FriendRequestStatus.pending));
  static const VerificationMeta _applyMsgMeta =
      const VerificationMeta('applyMsg');
  @override
  late final GeneratedColumn<String> applyMsg = GeneratedColumn<String>(
      'apply_msg', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reqRemarkMeta =
      const VerificationMeta('reqRemark');
  @override
  late final GeneratedColumn<String> reqRemark = GeneratedColumn<String>(
      'req_remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _respMsgMeta =
      const VerificationMeta('respMsg');
  @override
  late final GeneratedColumn<String> respMsg = GeneratedColumn<String>(
      'resp_msg', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _respRemarkMeta =
      const VerificationMeta('respRemark');
  @override
  late final GeneratedColumn<String> respRemark = GeneratedColumn<String>(
      'resp_remark', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
      'update_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _operatorIdMeta =
      const VerificationMeta('operatorId');
  @override
  late final GeneratedColumn<String> operatorId = GeneratedColumn<String>(
      'operator_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastOperationMeta =
      const VerificationMeta('lastOperation');
  @override
  late final GeneratedColumn<String> lastOperation = GeneratedColumn<String>(
      'last_operation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deletedTimeMeta =
      const VerificationMeta('deletedTime');
  @override
  late final GeneratedColumn<int> deletedTime = GeneratedColumn<int>(
      'deleted_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        friendId,
        name,
        avatar,
        gender,
        age,
        region,
        status,
        applyMsg,
        reqRemark,
        respMsg,
        respRemark,
        source,
        createTime,
        updateTime,
        operatorId,
        lastOperation,
        deletedTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_requests';
  @override
  VerificationContext validateIntegrity(Insertable<FriendRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('apply_msg')) {
      context.handle(_applyMsgMeta,
          applyMsg.isAcceptableOrUnknown(data['apply_msg']!, _applyMsgMeta));
    }
    if (data.containsKey('req_remark')) {
      context.handle(_reqRemarkMeta,
          reqRemark.isAcceptableOrUnknown(data['req_remark']!, _reqRemarkMeta));
    }
    if (data.containsKey('resp_msg')) {
      context.handle(_respMsgMeta,
          respMsg.isAcceptableOrUnknown(data['resp_msg']!, _respMsgMeta));
    }
    if (data.containsKey('resp_remark')) {
      context.handle(
          _respRemarkMeta,
          respRemark.isAcceptableOrUnknown(
              data['resp_remark']!, _respRemarkMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
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
    }
    if (data.containsKey('operator_id')) {
      context.handle(
          _operatorIdMeta,
          operatorId.isAcceptableOrUnknown(
              data['operator_id']!, _operatorIdMeta));
    }
    if (data.containsKey('last_operation')) {
      context.handle(
          _lastOperationMeta,
          lastOperation.isAcceptableOrUnknown(
              data['last_operation']!, _lastOperationMeta));
    }
    if (data.containsKey('deleted_time')) {
      context.handle(
          _deletedTimeMeta,
          deletedTime.isAcceptableOrUnknown(
              data['deleted_time']!, _deletedTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      applyMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apply_msg']),
      reqRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}req_remark']),
      respMsg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resp_msg']),
      respRemark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resp_remark']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_time']),
      operatorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operator_id']),
      lastOperation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_operation']),
      deletedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_time']),
    );
  }

  @override
  $FriendRequestsTable createAlias(String alias) {
    return $FriendRequestsTable(attachedDatabase, alias);
  }
}

class FriendRequest extends DataClass implements Insertable<FriendRequest> {
  final String id;
  final String userId;
  final String friendId;
  final String name;
  final String avatar;
  final String gender;
  final int age;
  final String? region;
  final String status;
  final String? applyMsg;
  final String? reqRemark;
  final String? respMsg;
  final String? respRemark;
  final String? source;
  final int createTime;
  final int? updateTime;
  final String? operatorId;
  final String? lastOperation;
  final int? deletedTime;
  const FriendRequest(
      {required this.id,
      required this.userId,
      required this.friendId,
      required this.name,
      required this.avatar,
      required this.gender,
      required this.age,
      this.region,
      required this.status,
      this.applyMsg,
      this.reqRemark,
      this.respMsg,
      this.respRemark,
      this.source,
      required this.createTime,
      this.updateTime,
      this.operatorId,
      this.lastOperation,
      this.deletedTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['name'] = Variable<String>(name);
    map['avatar'] = Variable<String>(avatar);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || applyMsg != null) {
      map['apply_msg'] = Variable<String>(applyMsg);
    }
    if (!nullToAbsent || reqRemark != null) {
      map['req_remark'] = Variable<String>(reqRemark);
    }
    if (!nullToAbsent || respMsg != null) {
      map['resp_msg'] = Variable<String>(respMsg);
    }
    if (!nullToAbsent || respRemark != null) {
      map['resp_remark'] = Variable<String>(respRemark);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['create_time'] = Variable<int>(createTime);
    if (!nullToAbsent || updateTime != null) {
      map['update_time'] = Variable<int>(updateTime);
    }
    if (!nullToAbsent || operatorId != null) {
      map['operator_id'] = Variable<String>(operatorId);
    }
    if (!nullToAbsent || lastOperation != null) {
      map['last_operation'] = Variable<String>(lastOperation);
    }
    if (!nullToAbsent || deletedTime != null) {
      map['deleted_time'] = Variable<int>(deletedTime);
    }
    return map;
  }

  FriendRequestsCompanion toCompanion(bool nullToAbsent) {
    return FriendRequestsCompanion(
      id: Value(id),
      userId: Value(userId),
      friendId: Value(friendId),
      name: Value(name),
      avatar: Value(avatar),
      gender: Value(gender),
      age: Value(age),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      status: Value(status),
      applyMsg: applyMsg == null && nullToAbsent
          ? const Value.absent()
          : Value(applyMsg),
      reqRemark: reqRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(reqRemark),
      respMsg: respMsg == null && nullToAbsent
          ? const Value.absent()
          : Value(respMsg),
      respRemark: respRemark == null && nullToAbsent
          ? const Value.absent()
          : Value(respRemark),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      createTime: Value(createTime),
      updateTime: updateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(updateTime),
      operatorId: operatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(operatorId),
      lastOperation: lastOperation == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOperation),
      deletedTime: deletedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedTime),
    );
  }

  factory FriendRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendRequest(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String>(json['avatar']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      region: serializer.fromJson<String?>(json['region']),
      status: serializer.fromJson<String>(json['status']),
      applyMsg: serializer.fromJson<String?>(json['applyMsg']),
      reqRemark: serializer.fromJson<String?>(json['reqRemark']),
      respMsg: serializer.fromJson<String?>(json['respMsg']),
      respRemark: serializer.fromJson<String?>(json['respRemark']),
      source: serializer.fromJson<String?>(json['source']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int?>(json['updateTime']),
      operatorId: serializer.fromJson<String?>(json['operatorId']),
      lastOperation: serializer.fromJson<String?>(json['lastOperation']),
      deletedTime: serializer.fromJson<int?>(json['deletedTime']),
    );
  }
  factory FriendRequest.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendRequest.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String>(avatar),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'region': serializer.toJson<String?>(region),
      'status': serializer.toJson<String>(status),
      'applyMsg': serializer.toJson<String?>(applyMsg),
      'reqRemark': serializer.toJson<String?>(reqRemark),
      'respMsg': serializer.toJson<String?>(respMsg),
      'respRemark': serializer.toJson<String?>(respRemark),
      'source': serializer.toJson<String?>(source),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int?>(updateTime),
      'operatorId': serializer.toJson<String?>(operatorId),
      'lastOperation': serializer.toJson<String?>(lastOperation),
      'deletedTime': serializer.toJson<int?>(deletedTime),
    };
  }

  FriendRequest copyWith(
          {String? id,
          String? userId,
          String? friendId,
          String? name,
          String? avatar,
          String? gender,
          int? age,
          Value<String?> region = const Value.absent(),
          String? status,
          Value<String?> applyMsg = const Value.absent(),
          Value<String?> reqRemark = const Value.absent(),
          Value<String?> respMsg = const Value.absent(),
          Value<String?> respRemark = const Value.absent(),
          Value<String?> source = const Value.absent(),
          int? createTime,
          Value<int?> updateTime = const Value.absent(),
          Value<String?> operatorId = const Value.absent(),
          Value<String?> lastOperation = const Value.absent(),
          Value<int?> deletedTime = const Value.absent()}) =>
      FriendRequest(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        region: region.present ? region.value : this.region,
        status: status ?? this.status,
        applyMsg: applyMsg.present ? applyMsg.value : this.applyMsg,
        reqRemark: reqRemark.present ? reqRemark.value : this.reqRemark,
        respMsg: respMsg.present ? respMsg.value : this.respMsg,
        respRemark: respRemark.present ? respRemark.value : this.respRemark,
        source: source.present ? source.value : this.source,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime.present ? updateTime.value : this.updateTime,
        operatorId: operatorId.present ? operatorId.value : this.operatorId,
        lastOperation:
            lastOperation.present ? lastOperation.value : this.lastOperation,
        deletedTime: deletedTime.present ? deletedTime.value : this.deletedTime,
      );
  FriendRequest copyWithCompanion(FriendRequestsCompanion data) {
    return FriendRequest(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      region: data.region.present ? data.region.value : this.region,
      status: data.status.present ? data.status.value : this.status,
      applyMsg: data.applyMsg.present ? data.applyMsg.value : this.applyMsg,
      reqRemark: data.reqRemark.present ? data.reqRemark.value : this.reqRemark,
      respMsg: data.respMsg.present ? data.respMsg.value : this.respMsg,
      respRemark:
          data.respRemark.present ? data.respRemark.value : this.respRemark,
      source: data.source.present ? data.source.value : this.source,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      operatorId:
          data.operatorId.present ? data.operatorId.value : this.operatorId,
      lastOperation: data.lastOperation.present
          ? data.lastOperation.value
          : this.lastOperation,
      deletedTime:
          data.deletedTime.present ? data.deletedTime.value : this.deletedTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequest(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('region: $region, ')
          ..write('status: $status, ')
          ..write('applyMsg: $applyMsg, ')
          ..write('reqRemark: $reqRemark, ')
          ..write('respMsg: $respMsg, ')
          ..write('respRemark: $respRemark, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('operatorId: $operatorId, ')
          ..write('lastOperation: $lastOperation, ')
          ..write('deletedTime: $deletedTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      friendId,
      name,
      avatar,
      gender,
      age,
      region,
      status,
      applyMsg,
      reqRemark,
      respMsg,
      respRemark,
      source,
      createTime,
      updateTime,
      operatorId,
      lastOperation,
      deletedTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendRequest &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.region == this.region &&
          other.status == this.status &&
          other.applyMsg == this.applyMsg &&
          other.reqRemark == this.reqRemark &&
          other.respMsg == this.respMsg &&
          other.respRemark == this.respRemark &&
          other.source == this.source &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.operatorId == this.operatorId &&
          other.lastOperation == this.lastOperation &&
          other.deletedTime == this.deletedTime);
}

class FriendRequestsCompanion extends UpdateCompanion<FriendRequest> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> friendId;
  final Value<String> name;
  final Value<String> avatar;
  final Value<String> gender;
  final Value<int> age;
  final Value<String?> region;
  final Value<String> status;
  final Value<String?> applyMsg;
  final Value<String?> reqRemark;
  final Value<String?> respMsg;
  final Value<String?> respRemark;
  final Value<String?> source;
  final Value<int> createTime;
  final Value<int?> updateTime;
  final Value<String?> operatorId;
  final Value<String?> lastOperation;
  final Value<int?> deletedTime;
  final Value<int> rowid;
  const FriendRequestsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.region = const Value.absent(),
    this.status = const Value.absent(),
    this.applyMsg = const Value.absent(),
    this.reqRemark = const Value.absent(),
    this.respMsg = const Value.absent(),
    this.respRemark = const Value.absent(),
    this.source = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.operatorId = const Value.absent(),
    this.lastOperation = const Value.absent(),
    this.deletedTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendRequestsCompanion.insert({
    required String id,
    required String userId,
    required String friendId,
    required String name,
    required String avatar,
    required String gender,
    required int age,
    this.region = const Value.absent(),
    this.status = const Value.absent(),
    this.applyMsg = const Value.absent(),
    this.reqRemark = const Value.absent(),
    this.respMsg = const Value.absent(),
    this.respRemark = const Value.absent(),
    this.source = const Value.absent(),
    required int createTime,
    this.updateTime = const Value.absent(),
    this.operatorId = const Value.absent(),
    this.lastOperation = const Value.absent(),
    this.deletedTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        friendId = Value(friendId),
        name = Value(name),
        avatar = Value(avatar),
        gender = Value(gender),
        age = Value(age),
        createTime = Value(createTime);
  static Insertable<FriendRequest> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<String>? region,
    Expression<String>? status,
    Expression<String>? applyMsg,
    Expression<String>? reqRemark,
    Expression<String>? respMsg,
    Expression<String>? respRemark,
    Expression<String>? source,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<String>? operatorId,
    Expression<String>? lastOperation,
    Expression<int>? deletedTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (region != null) 'region': region,
      if (status != null) 'status': status,
      if (applyMsg != null) 'apply_msg': applyMsg,
      if (reqRemark != null) 'req_remark': reqRemark,
      if (respMsg != null) 'resp_msg': respMsg,
      if (respRemark != null) 'resp_remark': respRemark,
      if (source != null) 'source': source,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (operatorId != null) 'operator_id': operatorId,
      if (lastOperation != null) 'last_operation': lastOperation,
      if (deletedTime != null) 'deleted_time': deletedTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendRequestsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? friendId,
      Value<String>? name,
      Value<String>? avatar,
      Value<String>? gender,
      Value<int>? age,
      Value<String?>? region,
      Value<String>? status,
      Value<String?>? applyMsg,
      Value<String?>? reqRemark,
      Value<String?>? respMsg,
      Value<String?>? respRemark,
      Value<String?>? source,
      Value<int>? createTime,
      Value<int?>? updateTime,
      Value<String?>? operatorId,
      Value<String?>? lastOperation,
      Value<int?>? deletedTime,
      Value<int>? rowid}) {
    return FriendRequestsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      region: region ?? this.region,
      status: status ?? this.status,
      applyMsg: applyMsg ?? this.applyMsg,
      reqRemark: reqRemark ?? this.reqRemark,
      respMsg: respMsg ?? this.respMsg,
      respRemark: respRemark ?? this.respRemark,
      source: source ?? this.source,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      operatorId: operatorId ?? this.operatorId,
      lastOperation: lastOperation ?? this.lastOperation,
      deletedTime: deletedTime ?? this.deletedTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (applyMsg.present) {
      map['apply_msg'] = Variable<String>(applyMsg.value);
    }
    if (reqRemark.present) {
      map['req_remark'] = Variable<String>(reqRemark.value);
    }
    if (respMsg.present) {
      map['resp_msg'] = Variable<String>(respMsg.value);
    }
    if (respRemark.present) {
      map['resp_remark'] = Variable<String>(respRemark.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (operatorId.present) {
      map['operator_id'] = Variable<String>(operatorId.value);
    }
    if (lastOperation.present) {
      map['last_operation'] = Variable<String>(lastOperation.value);
    }
    if (deletedTime.present) {
      map['deleted_time'] = Variable<int>(deletedTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendRequestsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('region: $region, ')
          ..write('status: $status, ')
          ..write('applyMsg: $applyMsg, ')
          ..write('reqRemark: $reqRemark, ')
          ..write('respMsg: $respMsg, ')
          ..write('respRemark: $respRemark, ')
          ..write('source: $source, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('operatorId: $operatorId, ')
          ..write('lastOperation: $lastOperation, ')
          ..write('deletedTime: $deletedTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendGroupsTable extends FriendGroups
    with TableInfo<$FriendGroupsTable, FriendGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, name, createTime, updateTime, sortOrder, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_groups';
  @override
  VerificationContext validateIntegrity(Insertable<FriendGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_time'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
    );
  }

  @override
  $FriendGroupsTable createAlias(String alias) {
    return $FriendGroupsTable(attachedDatabase, alias);
  }
}

class FriendGroup extends DataClass implements Insertable<FriendGroup> {
  final int id;
  final String userId;
  final String name;
  final int createTime;
  final int updateTime;
  final int sortOrder;
  final String? icon;
  const FriendGroup(
      {required this.id,
      required this.userId,
      required this.name,
      required this.createTime,
      required this.updateTime,
      required this.sortOrder,
      this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  FriendGroupsCompanion toCompanion(bool nullToAbsent) {
    return FriendGroupsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      sortOrder: Value(sortOrder),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory FriendGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendGroup(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  factory FriendGroup.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendGroup.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  FriendGroup copyWith(
          {int? id,
          String? userId,
          String? name,
          int? createTime,
          int? updateTime,
          int? sortOrder,
          Value<String?> icon = const Value.absent()}) =>
      FriendGroup(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        sortOrder: sortOrder ?? this.sortOrder,
        icon: icon.present ? icon.value : this.icon,
      );
  FriendGroup copyWithCompanion(FriendGroupsCompanion data) {
    return FriendGroup(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendGroup(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, createTime, updateTime, sortOrder, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendGroup &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.sortOrder == this.sortOrder &&
          other.icon == this.icon);
}

class FriendGroupsCompanion extends UpdateCompanion<FriendGroup> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<int> sortOrder;
  final Value<String?> icon;
  const FriendGroupsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.icon = const Value.absent(),
  });
  FriendGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    required int createTime,
    required int updateTime,
    this.sortOrder = const Value.absent(),
    this.icon = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<FriendGroup> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<int>? sortOrder,
    Expression<String>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (icon != null) 'icon': icon,
    });
  }

  FriendGroupsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<int>? createTime,
      Value<int>? updateTime,
      Value<int>? sortOrder,
      Value<String?>? icon}) {
    return FriendGroupsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      sortOrder: sortOrder ?? this.sortOrder,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendGroupsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $FriendTagsTable extends FriendTags
    with TableInfo<$FriendTagsTable, FriendTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#000000'));
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, name, color, createTime, icon, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_tags';
  @override
  VerificationContext validateIntegrity(Insertable<FriendTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FriendTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendTag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $FriendTagsTable createAlias(String alias) {
    return $FriendTagsTable(attachedDatabase, alias);
  }
}

class FriendTag extends DataClass implements Insertable<FriendTag> {
  final int id;
  final String userId;
  final String name;
  final String color;
  final int createTime;
  final String? icon;
  final int sortOrder;
  const FriendTag(
      {required this.id,
      required this.userId,
      required this.name,
      required this.color,
      required this.createTime,
      this.icon,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    map['create_time'] = Variable<int>(createTime);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  FriendTagsCompanion toCompanion(bool nullToAbsent) {
    return FriendTagsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      color: Value(color),
      createTime: Value(createTime),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      sortOrder: Value(sortOrder),
    );
  }

  factory FriendTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendTag(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      createTime: serializer.fromJson<int>(json['createTime']),
      icon: serializer.fromJson<String?>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  factory FriendTag.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendTag.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'createTime': serializer.toJson<int>(createTime),
      'icon': serializer.toJson<String?>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  FriendTag copyWith(
          {int? id,
          String? userId,
          String? name,
          String? color,
          int? createTime,
          Value<String?> icon = const Value.absent(),
          int? sortOrder}) =>
      FriendTag(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        color: color ?? this.color,
        createTime: createTime ?? this.createTime,
        icon: icon.present ? icon.value : this.icon,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  FriendTag copyWithCompanion(FriendTagsCompanion data) {
    return FriendTag(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendTag(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createTime: $createTime, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, color, createTime, icon, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendTag &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.color == this.color &&
          other.createTime == this.createTime &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder);
}

class FriendTagsCompanion extends UpdateCompanion<FriendTag> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> color;
  final Value<int> createTime;
  final Value<String?> icon;
  final Value<int> sortOrder;
  const FriendTagsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createTime = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  FriendTagsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.color = const Value.absent(),
    required int createTime,
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name),
        createTime = Value(createTime);
  static Insertable<FriendTag> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<int>? createTime,
    Expression<String>? icon,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createTime != null) 'create_time': createTime,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  FriendTagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? color,
      Value<int>? createTime,
      Value<String?>? icon,
      Value<int>? sortOrder}) {
    return FriendTagsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      color: color ?? this.color,
      createTime: createTime ?? this.createTime,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendTagsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createTime: $createTime, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $FriendTagRelationsTable extends FriendTagRelations
    with TableInfo<$FriendTagRelationsTable, FriendTagRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendTagRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [userId, friendId, tagId, createTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_tag_relations';
  @override
  VerificationContext validateIntegrity(Insertable<FriendTagRelation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, friendId, tagId};
  @override
  FriendTagRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendTagRelation(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
    );
  }

  @override
  $FriendTagRelationsTable createAlias(String alias) {
    return $FriendTagRelationsTable(attachedDatabase, alias);
  }
}

class FriendTagRelation extends DataClass
    implements Insertable<FriendTagRelation> {
  final String userId;
  final String friendId;
  final int tagId;
  final int createTime;
  const FriendTagRelation(
      {required this.userId,
      required this.friendId,
      required this.tagId,
      required this.createTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['tag_id'] = Variable<int>(tagId);
    map['create_time'] = Variable<int>(createTime);
    return map;
  }

  FriendTagRelationsCompanion toCompanion(bool nullToAbsent) {
    return FriendTagRelationsCompanion(
      userId: Value(userId),
      friendId: Value(friendId),
      tagId: Value(tagId),
      createTime: Value(createTime),
    );
  }

  factory FriendTagRelation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendTagRelation(
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      tagId: serializer.fromJson<int>(json['tagId']),
      createTime: serializer.fromJson<int>(json['createTime']),
    );
  }
  factory FriendTagRelation.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendTagRelation.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'tagId': serializer.toJson<int>(tagId),
      'createTime': serializer.toJson<int>(createTime),
    };
  }

  FriendTagRelation copyWith(
          {String? userId, String? friendId, int? tagId, int? createTime}) =>
      FriendTagRelation(
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        tagId: tagId ?? this.tagId,
        createTime: createTime ?? this.createTime,
      );
  FriendTagRelation copyWithCompanion(FriendTagRelationsCompanion data) {
    return FriendTagRelation(
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendTagRelation(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('tagId: $tagId, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, friendId, tagId, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendTagRelation &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.tagId == this.tagId &&
          other.createTime == this.createTime);
}

class FriendTagRelationsCompanion extends UpdateCompanion<FriendTagRelation> {
  final Value<String> userId;
  final Value<String> friendId;
  final Value<int> tagId;
  final Value<int> createTime;
  final Value<int> rowid;
  const FriendTagRelationsCompanion({
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendTagRelationsCompanion.insert({
    required String userId,
    required String friendId,
    required int tagId,
    required int createTime,
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        friendId = Value(friendId),
        tagId = Value(tagId),
        createTime = Value(createTime);
  static Insertable<FriendTagRelation> custom({
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<int>? tagId,
    Expression<int>? createTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (tagId != null) 'tag_id': tagId,
      if (createTime != null) 'create_time': createTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendTagRelationsCompanion copyWith(
      {Value<String>? userId,
      Value<String>? friendId,
      Value<int>? tagId,
      Value<int>? createTime,
      Value<int>? rowid}) {
    return FriendTagRelationsCompanion(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      tagId: tagId ?? this.tagId,
      createTime: createTime ?? this.createTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendTagRelationsCompanion(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('tagId: $tagId, ')
          ..write('createTime: $createTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendInteractionsTable extends FriendInteractions
    with TableInfo<$FriendInteractionsTable, FriendInteraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendInteractionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageCountMeta =
      const VerificationMeta('messageCount');
  @override
  late final GeneratedColumn<int> messageCount = GeneratedColumn<int>(
      'message_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastInteractTimeMeta =
      const VerificationMeta('lastInteractTime');
  @override
  late final GeneratedColumn<int> lastInteractTime = GeneratedColumn<int>(
      'last_interact_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalDurationMeta =
      const VerificationMeta('totalDuration');
  @override
  late final GeneratedColumn<int> totalDuration = GeneratedColumn<int>(
      'total_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _callCountMeta =
      const VerificationMeta('callCount');
  @override
  late final GeneratedColumn<int> callCount = GeneratedColumn<int>(
      'call_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _interactionScoreMeta =
      const VerificationMeta('interactionScore');
  @override
  late final GeneratedColumn<double> interactionScore = GeneratedColumn<double>(
      'interaction_score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _lastWeekCountMeta =
      const VerificationMeta('lastWeekCount');
  @override
  late final GeneratedColumn<int> lastWeekCount = GeneratedColumn<int>(
      'last_week_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastMonthCountMeta =
      const VerificationMeta('lastMonthCount');
  @override
  late final GeneratedColumn<int> lastMonthCount = GeneratedColumn<int>(
      'last_month_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        friendId,
        messageCount,
        lastInteractTime,
        totalDuration,
        callCount,
        interactionScore,
        lastWeekCount,
        lastMonthCount
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_interactions';
  @override
  VerificationContext validateIntegrity(Insertable<FriendInteraction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('message_count')) {
      context.handle(
          _messageCountMeta,
          messageCount.isAcceptableOrUnknown(
              data['message_count']!, _messageCountMeta));
    }
    if (data.containsKey('last_interact_time')) {
      context.handle(
          _lastInteractTimeMeta,
          lastInteractTime.isAcceptableOrUnknown(
              data['last_interact_time']!, _lastInteractTimeMeta));
    }
    if (data.containsKey('total_duration')) {
      context.handle(
          _totalDurationMeta,
          totalDuration.isAcceptableOrUnknown(
              data['total_duration']!, _totalDurationMeta));
    }
    if (data.containsKey('call_count')) {
      context.handle(_callCountMeta,
          callCount.isAcceptableOrUnknown(data['call_count']!, _callCountMeta));
    }
    if (data.containsKey('interaction_score')) {
      context.handle(
          _interactionScoreMeta,
          interactionScore.isAcceptableOrUnknown(
              data['interaction_score']!, _interactionScoreMeta));
    }
    if (data.containsKey('last_week_count')) {
      context.handle(
          _lastWeekCountMeta,
          lastWeekCount.isAcceptableOrUnknown(
              data['last_week_count']!, _lastWeekCountMeta));
    }
    if (data.containsKey('last_month_count')) {
      context.handle(
          _lastMonthCountMeta,
          lastMonthCount.isAcceptableOrUnknown(
              data['last_month_count']!, _lastMonthCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, friendId};
  @override
  FriendInteraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendInteraction(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      messageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_count'])!,
      lastInteractTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_interact_time']),
      totalDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_duration'])!,
      callCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}call_count'])!,
      interactionScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}interaction_score'])!,
      lastWeekCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_week_count'])!,
      lastMonthCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_month_count'])!,
    );
  }

  @override
  $FriendInteractionsTable createAlias(String alias) {
    return $FriendInteractionsTable(attachedDatabase, alias);
  }
}

class FriendInteraction extends DataClass
    implements Insertable<FriendInteraction> {
  final String userId;
  final String friendId;
  final int messageCount;
  final int? lastInteractTime;
  final int totalDuration;
  final int callCount;
  final double interactionScore;
  final int lastWeekCount;
  final int lastMonthCount;
  const FriendInteraction(
      {required this.userId,
      required this.friendId,
      required this.messageCount,
      this.lastInteractTime,
      required this.totalDuration,
      required this.callCount,
      required this.interactionScore,
      required this.lastWeekCount,
      required this.lastMonthCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['message_count'] = Variable<int>(messageCount);
    if (!nullToAbsent || lastInteractTime != null) {
      map['last_interact_time'] = Variable<int>(lastInteractTime);
    }
    map['total_duration'] = Variable<int>(totalDuration);
    map['call_count'] = Variable<int>(callCount);
    map['interaction_score'] = Variable<double>(interactionScore);
    map['last_week_count'] = Variable<int>(lastWeekCount);
    map['last_month_count'] = Variable<int>(lastMonthCount);
    return map;
  }

  FriendInteractionsCompanion toCompanion(bool nullToAbsent) {
    return FriendInteractionsCompanion(
      userId: Value(userId),
      friendId: Value(friendId),
      messageCount: Value(messageCount),
      lastInteractTime: lastInteractTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastInteractTime),
      totalDuration: Value(totalDuration),
      callCount: Value(callCount),
      interactionScore: Value(interactionScore),
      lastWeekCount: Value(lastWeekCount),
      lastMonthCount: Value(lastMonthCount),
    );
  }

  factory FriendInteraction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendInteraction(
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      messageCount: serializer.fromJson<int>(json['messageCount']),
      lastInteractTime: serializer.fromJson<int?>(json['lastInteractTime']),
      totalDuration: serializer.fromJson<int>(json['totalDuration']),
      callCount: serializer.fromJson<int>(json['callCount']),
      interactionScore: serializer.fromJson<double>(json['interactionScore']),
      lastWeekCount: serializer.fromJson<int>(json['lastWeekCount']),
      lastMonthCount: serializer.fromJson<int>(json['lastMonthCount']),
    );
  }
  factory FriendInteraction.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendInteraction.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'messageCount': serializer.toJson<int>(messageCount),
      'lastInteractTime': serializer.toJson<int?>(lastInteractTime),
      'totalDuration': serializer.toJson<int>(totalDuration),
      'callCount': serializer.toJson<int>(callCount),
      'interactionScore': serializer.toJson<double>(interactionScore),
      'lastWeekCount': serializer.toJson<int>(lastWeekCount),
      'lastMonthCount': serializer.toJson<int>(lastMonthCount),
    };
  }

  FriendInteraction copyWith(
          {String? userId,
          String? friendId,
          int? messageCount,
          Value<int?> lastInteractTime = const Value.absent(),
          int? totalDuration,
          int? callCount,
          double? interactionScore,
          int? lastWeekCount,
          int? lastMonthCount}) =>
      FriendInteraction(
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        messageCount: messageCount ?? this.messageCount,
        lastInteractTime: lastInteractTime.present
            ? lastInteractTime.value
            : this.lastInteractTime,
        totalDuration: totalDuration ?? this.totalDuration,
        callCount: callCount ?? this.callCount,
        interactionScore: interactionScore ?? this.interactionScore,
        lastWeekCount: lastWeekCount ?? this.lastWeekCount,
        lastMonthCount: lastMonthCount ?? this.lastMonthCount,
      );
  FriendInteraction copyWithCompanion(FriendInteractionsCompanion data) {
    return FriendInteraction(
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      messageCount: data.messageCount.present
          ? data.messageCount.value
          : this.messageCount,
      lastInteractTime: data.lastInteractTime.present
          ? data.lastInteractTime.value
          : this.lastInteractTime,
      totalDuration: data.totalDuration.present
          ? data.totalDuration.value
          : this.totalDuration,
      callCount: data.callCount.present ? data.callCount.value : this.callCount,
      interactionScore: data.interactionScore.present
          ? data.interactionScore.value
          : this.interactionScore,
      lastWeekCount: data.lastWeekCount.present
          ? data.lastWeekCount.value
          : this.lastWeekCount,
      lastMonthCount: data.lastMonthCount.present
          ? data.lastMonthCount.value
          : this.lastMonthCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendInteraction(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('messageCount: $messageCount, ')
          ..write('lastInteractTime: $lastInteractTime, ')
          ..write('totalDuration: $totalDuration, ')
          ..write('callCount: $callCount, ')
          ..write('interactionScore: $interactionScore, ')
          ..write('lastWeekCount: $lastWeekCount, ')
          ..write('lastMonthCount: $lastMonthCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      friendId,
      messageCount,
      lastInteractTime,
      totalDuration,
      callCount,
      interactionScore,
      lastWeekCount,
      lastMonthCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendInteraction &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.messageCount == this.messageCount &&
          other.lastInteractTime == this.lastInteractTime &&
          other.totalDuration == this.totalDuration &&
          other.callCount == this.callCount &&
          other.interactionScore == this.interactionScore &&
          other.lastWeekCount == this.lastWeekCount &&
          other.lastMonthCount == this.lastMonthCount);
}

class FriendInteractionsCompanion extends UpdateCompanion<FriendInteraction> {
  final Value<String> userId;
  final Value<String> friendId;
  final Value<int> messageCount;
  final Value<int?> lastInteractTime;
  final Value<int> totalDuration;
  final Value<int> callCount;
  final Value<double> interactionScore;
  final Value<int> lastWeekCount;
  final Value<int> lastMonthCount;
  final Value<int> rowid;
  const FriendInteractionsCompanion({
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.lastInteractTime = const Value.absent(),
    this.totalDuration = const Value.absent(),
    this.callCount = const Value.absent(),
    this.interactionScore = const Value.absent(),
    this.lastWeekCount = const Value.absent(),
    this.lastMonthCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendInteractionsCompanion.insert({
    required String userId,
    required String friendId,
    this.messageCount = const Value.absent(),
    this.lastInteractTime = const Value.absent(),
    this.totalDuration = const Value.absent(),
    this.callCount = const Value.absent(),
    this.interactionScore = const Value.absent(),
    this.lastWeekCount = const Value.absent(),
    this.lastMonthCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        friendId = Value(friendId);
  static Insertable<FriendInteraction> custom({
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<int>? messageCount,
    Expression<int>? lastInteractTime,
    Expression<int>? totalDuration,
    Expression<int>? callCount,
    Expression<double>? interactionScore,
    Expression<int>? lastWeekCount,
    Expression<int>? lastMonthCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (messageCount != null) 'message_count': messageCount,
      if (lastInteractTime != null) 'last_interact_time': lastInteractTime,
      if (totalDuration != null) 'total_duration': totalDuration,
      if (callCount != null) 'call_count': callCount,
      if (interactionScore != null) 'interaction_score': interactionScore,
      if (lastWeekCount != null) 'last_week_count': lastWeekCount,
      if (lastMonthCount != null) 'last_month_count': lastMonthCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendInteractionsCompanion copyWith(
      {Value<String>? userId,
      Value<String>? friendId,
      Value<int>? messageCount,
      Value<int?>? lastInteractTime,
      Value<int>? totalDuration,
      Value<int>? callCount,
      Value<double>? interactionScore,
      Value<int>? lastWeekCount,
      Value<int>? lastMonthCount,
      Value<int>? rowid}) {
    return FriendInteractionsCompanion(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      messageCount: messageCount ?? this.messageCount,
      lastInteractTime: lastInteractTime ?? this.lastInteractTime,
      totalDuration: totalDuration ?? this.totalDuration,
      callCount: callCount ?? this.callCount,
      interactionScore: interactionScore ?? this.interactionScore,
      lastWeekCount: lastWeekCount ?? this.lastWeekCount,
      lastMonthCount: lastMonthCount ?? this.lastMonthCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (messageCount.present) {
      map['message_count'] = Variable<int>(messageCount.value);
    }
    if (lastInteractTime.present) {
      map['last_interact_time'] = Variable<int>(lastInteractTime.value);
    }
    if (totalDuration.present) {
      map['total_duration'] = Variable<int>(totalDuration.value);
    }
    if (callCount.present) {
      map['call_count'] = Variable<int>(callCount.value);
    }
    if (interactionScore.present) {
      map['interaction_score'] = Variable<double>(interactionScore.value);
    }
    if (lastWeekCount.present) {
      map['last_week_count'] = Variable<int>(lastWeekCount.value);
    }
    if (lastMonthCount.present) {
      map['last_month_count'] = Variable<int>(lastMonthCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendInteractionsCompanion(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('messageCount: $messageCount, ')
          ..write('lastInteractTime: $lastInteractTime, ')
          ..write('totalDuration: $totalDuration, ')
          ..write('callCount: $callCount, ')
          ..write('interactionScore: $interactionScore, ')
          ..write('lastWeekCount: $lastWeekCount, ')
          ..write('lastMonthCount: $lastMonthCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendPrivacySettingsTable extends FriendPrivacySettings
    with TableInfo<$FriendPrivacySettingsTable, FriendPrivacySetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendPrivacySettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _canSeeMomentsMeta =
      const VerificationMeta('canSeeMoments');
  @override
  late final GeneratedColumn<bool> canSeeMoments = GeneratedColumn<bool>(
      'can_see_moments', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_see_moments" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _canSeeOnlineStatusMeta =
      const VerificationMeta('canSeeOnlineStatus');
  @override
  late final GeneratedColumn<bool> canSeeOnlineStatus = GeneratedColumn<bool>(
      'can_see_online_status', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_see_online_status" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _canSeeLocationMeta =
      const VerificationMeta('canSeeLocation');
  @override
  late final GeneratedColumn<bool> canSeeLocation = GeneratedColumn<bool>(
      'can_see_location', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_see_location" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _canSeeMutualFriendsMeta =
      const VerificationMeta('canSeeMutualFriends');
  @override
  late final GeneratedColumn<bool> canSeeMutualFriends = GeneratedColumn<bool>(
      'can_see_mutual_friends', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_see_mutual_friends" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _permissionLevelMeta =
      const VerificationMeta('permissionLevel');
  @override
  late final GeneratedColumn<String> permissionLevel = GeneratedColumn<String>(
      'permission_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('full_access'));
  static const VerificationMeta _customSettingsMeta =
      const VerificationMeta('customSettings');
  @override
  late final GeneratedColumn<String> customSettings = GeneratedColumn<String>(
      'custom_settings', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns => [
        userId,
        friendId,
        canSeeMoments,
        canSeeOnlineStatus,
        canSeeLocation,
        canSeeMutualFriends,
        permissionLevel,
        customSettings
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_privacy_settings';
  @override
  VerificationContext validateIntegrity(
      Insertable<FriendPrivacySetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('can_see_moments')) {
      context.handle(
          _canSeeMomentsMeta,
          canSeeMoments.isAcceptableOrUnknown(
              data['can_see_moments']!, _canSeeMomentsMeta));
    }
    if (data.containsKey('can_see_online_status')) {
      context.handle(
          _canSeeOnlineStatusMeta,
          canSeeOnlineStatus.isAcceptableOrUnknown(
              data['can_see_online_status']!, _canSeeOnlineStatusMeta));
    }
    if (data.containsKey('can_see_location')) {
      context.handle(
          _canSeeLocationMeta,
          canSeeLocation.isAcceptableOrUnknown(
              data['can_see_location']!, _canSeeLocationMeta));
    }
    if (data.containsKey('can_see_mutual_friends')) {
      context.handle(
          _canSeeMutualFriendsMeta,
          canSeeMutualFriends.isAcceptableOrUnknown(
              data['can_see_mutual_friends']!, _canSeeMutualFriendsMeta));
    }
    if (data.containsKey('permission_level')) {
      context.handle(
          _permissionLevelMeta,
          permissionLevel.isAcceptableOrUnknown(
              data['permission_level']!, _permissionLevelMeta));
    }
    if (data.containsKey('custom_settings')) {
      context.handle(
          _customSettingsMeta,
          customSettings.isAcceptableOrUnknown(
              data['custom_settings']!, _customSettingsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, friendId};
  @override
  FriendPrivacySetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendPrivacySetting(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      canSeeMoments: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_see_moments'])!,
      canSeeOnlineStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_see_online_status'])!,
      canSeeLocation: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_see_location'])!,
      canSeeMutualFriends: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_see_mutual_friends'])!,
      permissionLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}permission_level'])!,
      customSettings: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}custom_settings'])!,
    );
  }

  @override
  $FriendPrivacySettingsTable createAlias(String alias) {
    return $FriendPrivacySettingsTable(attachedDatabase, alias);
  }
}

class FriendPrivacySetting extends DataClass
    implements Insertable<FriendPrivacySetting> {
  final String userId;
  final String friendId;
  final bool canSeeMoments;
  final bool canSeeOnlineStatus;
  final bool canSeeLocation;
  final bool canSeeMutualFriends;
  final String permissionLevel;
  final String customSettings;
  const FriendPrivacySetting(
      {required this.userId,
      required this.friendId,
      required this.canSeeMoments,
      required this.canSeeOnlineStatus,
      required this.canSeeLocation,
      required this.canSeeMutualFriends,
      required this.permissionLevel,
      required this.customSettings});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['can_see_moments'] = Variable<bool>(canSeeMoments);
    map['can_see_online_status'] = Variable<bool>(canSeeOnlineStatus);
    map['can_see_location'] = Variable<bool>(canSeeLocation);
    map['can_see_mutual_friends'] = Variable<bool>(canSeeMutualFriends);
    map['permission_level'] = Variable<String>(permissionLevel);
    map['custom_settings'] = Variable<String>(customSettings);
    return map;
  }

  FriendPrivacySettingsCompanion toCompanion(bool nullToAbsent) {
    return FriendPrivacySettingsCompanion(
      userId: Value(userId),
      friendId: Value(friendId),
      canSeeMoments: Value(canSeeMoments),
      canSeeOnlineStatus: Value(canSeeOnlineStatus),
      canSeeLocation: Value(canSeeLocation),
      canSeeMutualFriends: Value(canSeeMutualFriends),
      permissionLevel: Value(permissionLevel),
      customSettings: Value(customSettings),
    );
  }

  factory FriendPrivacySetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendPrivacySetting(
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      canSeeMoments: serializer.fromJson<bool>(json['canSeeMoments']),
      canSeeOnlineStatus: serializer.fromJson<bool>(json['canSeeOnlineStatus']),
      canSeeLocation: serializer.fromJson<bool>(json['canSeeLocation']),
      canSeeMutualFriends:
          serializer.fromJson<bool>(json['canSeeMutualFriends']),
      permissionLevel: serializer.fromJson<String>(json['permissionLevel']),
      customSettings: serializer.fromJson<String>(json['customSettings']),
    );
  }
  factory FriendPrivacySetting.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendPrivacySetting.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'canSeeMoments': serializer.toJson<bool>(canSeeMoments),
      'canSeeOnlineStatus': serializer.toJson<bool>(canSeeOnlineStatus),
      'canSeeLocation': serializer.toJson<bool>(canSeeLocation),
      'canSeeMutualFriends': serializer.toJson<bool>(canSeeMutualFriends),
      'permissionLevel': serializer.toJson<String>(permissionLevel),
      'customSettings': serializer.toJson<String>(customSettings),
    };
  }

  FriendPrivacySetting copyWith(
          {String? userId,
          String? friendId,
          bool? canSeeMoments,
          bool? canSeeOnlineStatus,
          bool? canSeeLocation,
          bool? canSeeMutualFriends,
          String? permissionLevel,
          String? customSettings}) =>
      FriendPrivacySetting(
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        canSeeMoments: canSeeMoments ?? this.canSeeMoments,
        canSeeOnlineStatus: canSeeOnlineStatus ?? this.canSeeOnlineStatus,
        canSeeLocation: canSeeLocation ?? this.canSeeLocation,
        canSeeMutualFriends: canSeeMutualFriends ?? this.canSeeMutualFriends,
        permissionLevel: permissionLevel ?? this.permissionLevel,
        customSettings: customSettings ?? this.customSettings,
      );
  FriendPrivacySetting copyWithCompanion(FriendPrivacySettingsCompanion data) {
    return FriendPrivacySetting(
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      canSeeMoments: data.canSeeMoments.present
          ? data.canSeeMoments.value
          : this.canSeeMoments,
      canSeeOnlineStatus: data.canSeeOnlineStatus.present
          ? data.canSeeOnlineStatus.value
          : this.canSeeOnlineStatus,
      canSeeLocation: data.canSeeLocation.present
          ? data.canSeeLocation.value
          : this.canSeeLocation,
      canSeeMutualFriends: data.canSeeMutualFriends.present
          ? data.canSeeMutualFriends.value
          : this.canSeeMutualFriends,
      permissionLevel: data.permissionLevel.present
          ? data.permissionLevel.value
          : this.permissionLevel,
      customSettings: data.customSettings.present
          ? data.customSettings.value
          : this.customSettings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendPrivacySetting(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('canSeeMoments: $canSeeMoments, ')
          ..write('canSeeOnlineStatus: $canSeeOnlineStatus, ')
          ..write('canSeeLocation: $canSeeLocation, ')
          ..write('canSeeMutualFriends: $canSeeMutualFriends, ')
          ..write('permissionLevel: $permissionLevel, ')
          ..write('customSettings: $customSettings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      userId,
      friendId,
      canSeeMoments,
      canSeeOnlineStatus,
      canSeeLocation,
      canSeeMutualFriends,
      permissionLevel,
      customSettings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendPrivacySetting &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.canSeeMoments == this.canSeeMoments &&
          other.canSeeOnlineStatus == this.canSeeOnlineStatus &&
          other.canSeeLocation == this.canSeeLocation &&
          other.canSeeMutualFriends == this.canSeeMutualFriends &&
          other.permissionLevel == this.permissionLevel &&
          other.customSettings == this.customSettings);
}

class FriendPrivacySettingsCompanion
    extends UpdateCompanion<FriendPrivacySetting> {
  final Value<String> userId;
  final Value<String> friendId;
  final Value<bool> canSeeMoments;
  final Value<bool> canSeeOnlineStatus;
  final Value<bool> canSeeLocation;
  final Value<bool> canSeeMutualFriends;
  final Value<String> permissionLevel;
  final Value<String> customSettings;
  final Value<int> rowid;
  const FriendPrivacySettingsCompanion({
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.canSeeMoments = const Value.absent(),
    this.canSeeOnlineStatus = const Value.absent(),
    this.canSeeLocation = const Value.absent(),
    this.canSeeMutualFriends = const Value.absent(),
    this.permissionLevel = const Value.absent(),
    this.customSettings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendPrivacySettingsCompanion.insert({
    required String userId,
    required String friendId,
    this.canSeeMoments = const Value.absent(),
    this.canSeeOnlineStatus = const Value.absent(),
    this.canSeeLocation = const Value.absent(),
    this.canSeeMutualFriends = const Value.absent(),
    this.permissionLevel = const Value.absent(),
    this.customSettings = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        friendId = Value(friendId);
  static Insertable<FriendPrivacySetting> custom({
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<bool>? canSeeMoments,
    Expression<bool>? canSeeOnlineStatus,
    Expression<bool>? canSeeLocation,
    Expression<bool>? canSeeMutualFriends,
    Expression<String>? permissionLevel,
    Expression<String>? customSettings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (canSeeMoments != null) 'can_see_moments': canSeeMoments,
      if (canSeeOnlineStatus != null)
        'can_see_online_status': canSeeOnlineStatus,
      if (canSeeLocation != null) 'can_see_location': canSeeLocation,
      if (canSeeMutualFriends != null)
        'can_see_mutual_friends': canSeeMutualFriends,
      if (permissionLevel != null) 'permission_level': permissionLevel,
      if (customSettings != null) 'custom_settings': customSettings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendPrivacySettingsCompanion copyWith(
      {Value<String>? userId,
      Value<String>? friendId,
      Value<bool>? canSeeMoments,
      Value<bool>? canSeeOnlineStatus,
      Value<bool>? canSeeLocation,
      Value<bool>? canSeeMutualFriends,
      Value<String>? permissionLevel,
      Value<String>? customSettings,
      Value<int>? rowid}) {
    return FriendPrivacySettingsCompanion(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      canSeeMoments: canSeeMoments ?? this.canSeeMoments,
      canSeeOnlineStatus: canSeeOnlineStatus ?? this.canSeeOnlineStatus,
      canSeeLocation: canSeeLocation ?? this.canSeeLocation,
      canSeeMutualFriends: canSeeMutualFriends ?? this.canSeeMutualFriends,
      permissionLevel: permissionLevel ?? this.permissionLevel,
      customSettings: customSettings ?? this.customSettings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (canSeeMoments.present) {
      map['can_see_moments'] = Variable<bool>(canSeeMoments.value);
    }
    if (canSeeOnlineStatus.present) {
      map['can_see_online_status'] = Variable<bool>(canSeeOnlineStatus.value);
    }
    if (canSeeLocation.present) {
      map['can_see_location'] = Variable<bool>(canSeeLocation.value);
    }
    if (canSeeMutualFriends.present) {
      map['can_see_mutual_friends'] = Variable<bool>(canSeeMutualFriends.value);
    }
    if (permissionLevel.present) {
      map['permission_level'] = Variable<String>(permissionLevel.value);
    }
    if (customSettings.present) {
      map['custom_settings'] = Variable<String>(customSettings.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendPrivacySettingsCompanion(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('canSeeMoments: $canSeeMoments, ')
          ..write('canSeeOnlineStatus: $canSeeOnlineStatus, ')
          ..write('canSeeLocation: $canSeeLocation, ')
          ..write('canSeeMutualFriends: $canSeeMutualFriends, ')
          ..write('permissionLevel: $permissionLevel, ')
          ..write('customSettings: $customSettings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FriendNotesTable extends FriendNotes
    with TableInfo<$FriendNotesTable, FriendNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FriendNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _friendIdMeta =
      const VerificationMeta('friendId');
  @override
  late final GeneratedColumn<String> friendId = GeneratedColumn<String>(
      'friend_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [userId, friendId, content, createTime, updateTime, isPinned];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'friend_notes';
  @override
  VerificationContext validateIntegrity(Insertable<FriendNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('friend_id')) {
      context.handle(_friendIdMeta,
          friendId.isAcceptableOrUnknown(data['friend_id']!, _friendIdMeta));
    } else if (isInserting) {
      context.missing(_friendIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
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
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, friendId};
  @override
  FriendNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FriendNote(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      friendId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}friend_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      updateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}update_time'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
    );
  }

  @override
  $FriendNotesTable createAlias(String alias) {
    return $FriendNotesTable(attachedDatabase, alias);
  }
}

class FriendNote extends DataClass implements Insertable<FriendNote> {
  final String userId;
  final String friendId;
  final String content;
  final int createTime;
  final int updateTime;
  final bool isPinned;
  const FriendNote(
      {required this.userId,
      required this.friendId,
      required this.content,
      required this.createTime,
      required this.updateTime,
      required this.isPinned});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['friend_id'] = Variable<String>(friendId);
    map['content'] = Variable<String>(content);
    map['create_time'] = Variable<int>(createTime);
    map['update_time'] = Variable<int>(updateTime);
    map['is_pinned'] = Variable<bool>(isPinned);
    return map;
  }

  FriendNotesCompanion toCompanion(bool nullToAbsent) {
    return FriendNotesCompanion(
      userId: Value(userId),
      friendId: Value(friendId),
      content: Value(content),
      createTime: Value(createTime),
      updateTime: Value(updateTime),
      isPinned: Value(isPinned),
    );
  }

  factory FriendNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FriendNote(
      userId: serializer.fromJson<String>(json['userId']),
      friendId: serializer.fromJson<String>(json['friendId']),
      content: serializer.fromJson<String>(json['content']),
      createTime: serializer.fromJson<int>(json['createTime']),
      updateTime: serializer.fromJson<int>(json['updateTime']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
    );
  }
  factory FriendNote.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      FriendNote.fromJson(
          DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'friendId': serializer.toJson<String>(friendId),
      'content': serializer.toJson<String>(content),
      'createTime': serializer.toJson<int>(createTime),
      'updateTime': serializer.toJson<int>(updateTime),
      'isPinned': serializer.toJson<bool>(isPinned),
    };
  }

  FriendNote copyWith(
          {String? userId,
          String? friendId,
          String? content,
          int? createTime,
          int? updateTime,
          bool? isPinned}) =>
      FriendNote(
        userId: userId ?? this.userId,
        friendId: friendId ?? this.friendId,
        content: content ?? this.content,
        createTime: createTime ?? this.createTime,
        updateTime: updateTime ?? this.updateTime,
        isPinned: isPinned ?? this.isPinned,
      );
  FriendNote copyWithCompanion(FriendNotesCompanion data) {
    return FriendNote(
      userId: data.userId.present ? data.userId.value : this.userId,
      friendId: data.friendId.present ? data.friendId.value : this.friendId,
      content: data.content.present ? data.content.value : this.content,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      updateTime:
          data.updateTime.present ? data.updateTime.value : this.updateTime,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FriendNote(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('content: $content, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('isPinned: $isPinned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, friendId, content, createTime, updateTime, isPinned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FriendNote &&
          other.userId == this.userId &&
          other.friendId == this.friendId &&
          other.content == this.content &&
          other.createTime == this.createTime &&
          other.updateTime == this.updateTime &&
          other.isPinned == this.isPinned);
}

class FriendNotesCompanion extends UpdateCompanion<FriendNote> {
  final Value<String> userId;
  final Value<String> friendId;
  final Value<String> content;
  final Value<int> createTime;
  final Value<int> updateTime;
  final Value<bool> isPinned;
  final Value<int> rowid;
  const FriendNotesCompanion({
    this.userId = const Value.absent(),
    this.friendId = const Value.absent(),
    this.content = const Value.absent(),
    this.createTime = const Value.absent(),
    this.updateTime = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FriendNotesCompanion.insert({
    required String userId,
    required String friendId,
    required String content,
    required int createTime,
    required int updateTime,
    this.isPinned = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        friendId = Value(friendId),
        content = Value(content),
        createTime = Value(createTime),
        updateTime = Value(updateTime);
  static Insertable<FriendNote> custom({
    Expression<String>? userId,
    Expression<String>? friendId,
    Expression<String>? content,
    Expression<int>? createTime,
    Expression<int>? updateTime,
    Expression<bool>? isPinned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (friendId != null) 'friend_id': friendId,
      if (content != null) 'content': content,
      if (createTime != null) 'create_time': createTime,
      if (updateTime != null) 'update_time': updateTime,
      if (isPinned != null) 'is_pinned': isPinned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FriendNotesCompanion copyWith(
      {Value<String>? userId,
      Value<String>? friendId,
      Value<String>? content,
      Value<int>? createTime,
      Value<int>? updateTime,
      Value<bool>? isPinned,
      Value<int>? rowid}) {
    return FriendNotesCompanion(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isPinned: isPinned ?? this.isPinned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (friendId.present) {
      map['friend_id'] = Variable<String>(friendId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<int>(updateTime.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FriendNotesCompanion(')
          ..write('userId: $userId, ')
          ..write('friendId: $friendId, ')
          ..write('content: $content, ')
          ..write('createTime: $createTime, ')
          ..write('updateTime: $updateTime, ')
          ..write('isPinned: $isPinned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<ChatType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ChatType>($ChatsTable.$convertertype);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastMessagePreviewMeta =
      const VerificationMeta('lastMessagePreview');
  @override
  late final GeneratedColumn<String> lastMessagePreview =
      GeneratedColumn<String>('last_message_preview', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastMessageTypeMeta =
      const VerificationMeta('lastMessageType');
  @override
  late final GeneratedColumn<String> lastMessageType = GeneratedColumn<String>(
      'last_message_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastMessageTimeMeta =
      const VerificationMeta('lastMessageTime');
  @override
  late final GeneratedColumn<DateTime> lastMessageTime =
      GeneratedColumn<DateTime>('last_message_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _unreadCountMeta =
      const VerificationMeta('unreadCount');
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
      'unread_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isMutedMeta =
      const VerificationMeta('isMuted');
  @override
  late final GeneratedColumn<bool> isMuted = GeneratedColumn<bool>(
      'is_muted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_muted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _mentionsMeMeta =
      const VerificationMeta('mentionsMe');
  @override
  late final GeneratedColumn<bool> mentionsMe = GeneratedColumn<bool>(
      'mentions_me', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("mentions_me" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _draftMeta = const VerificationMeta('draft');
  @override
  late final GeneratedColumn<String> draft = GeneratedColumn<String>(
      'draft', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _memberCountMeta =
      const VerificationMeta('memberCount');
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
      'member_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        avatarUrl,
        lastMessagePreview,
        lastMessageType,
        lastMessageTime,
        unreadCount,
        isPinned,
        isMuted,
        mentionsMe,
        draft,
        memberCount,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
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
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    if (data.containsKey('last_message_preview')) {
      context.handle(
          _lastMessagePreviewMeta,
          lastMessagePreview.isAcceptableOrUnknown(
              data['last_message_preview']!, _lastMessagePreviewMeta));
    }
    if (data.containsKey('last_message_type')) {
      context.handle(
          _lastMessageTypeMeta,
          lastMessageType.isAcceptableOrUnknown(
              data['last_message_type']!, _lastMessageTypeMeta));
    }
    if (data.containsKey('last_message_time')) {
      context.handle(
          _lastMessageTimeMeta,
          lastMessageTime.isAcceptableOrUnknown(
              data['last_message_time']!, _lastMessageTimeMeta));
    }
    if (data.containsKey('unread_count')) {
      context.handle(
          _unreadCountMeta,
          unreadCount.isAcceptableOrUnknown(
              data['unread_count']!, _unreadCountMeta));
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    if (data.containsKey('is_muted')) {
      context.handle(_isMutedMeta,
          isMuted.isAcceptableOrUnknown(data['is_muted']!, _isMutedMeta));
    }
    if (data.containsKey('mentions_me')) {
      context.handle(
          _mentionsMeMeta,
          mentionsMe.isAcceptableOrUnknown(
              data['mentions_me']!, _mentionsMeMeta));
    }
    if (data.containsKey('draft')) {
      context.handle(
          _draftMeta, draft.isAcceptableOrUnknown(data['draft']!, _draftMeta));
    }
    if (data.containsKey('member_count')) {
      context.handle(
          _memberCountMeta,
          memberCount.isAcceptableOrUnknown(
              data['member_count']!, _memberCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      type: $ChatsTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
      lastMessagePreview: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_message_preview']),
      lastMessageType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_message_type']),
      lastMessageTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_message_time']),
      unreadCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread_count'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      isMuted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_muted'])!,
      mentionsMe: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mentions_me'])!,
      draft: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}draft']),
      memberCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}member_count']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ChatType, String, String> $convertertype =
      const EnumNameConverter<ChatType>(ChatType.values);
}

class Chat extends DataClass implements Insertable<Chat> {
  /// 唯一会话ID
  final String id;

  /// 会话名称
  final String? name;

  /// 会话类型
  final ChatType type;

  /// 头像URL（单聊为用户头像，群聊可以是多头像JSON字符串）
  final String? avatarUrl;

  /// 最后一条消息预览
  final String? lastMessagePreview;

  /// 最后一条消息类型
  final String? lastMessageType;

  /// 最后一条消息时间
  final DateTime? lastMessageTime;

  /// 未读消息数量
  final int unreadCount;

  /// 是否置顶
  final bool isPinned;

  /// 是否静音
  final bool isMuted;

  /// 是否有@我
  final bool mentionsMe;

  /// 草稿内容
  final String? draft;

  /// 成员数量（群聊）
  final int? memberCount;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime updatedAt;
  const Chat(
      {required this.id,
      this.name,
      required this.type,
      this.avatarUrl,
      this.lastMessagePreview,
      this.lastMessageType,
      this.lastMessageTime,
      required this.unreadCount,
      required this.isPinned,
      required this.isMuted,
      required this.mentionsMe,
      this.draft,
      this.memberCount,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    {
      map['type'] = Variable<String>($ChatsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || lastMessagePreview != null) {
      map['last_message_preview'] = Variable<String>(lastMessagePreview);
    }
    if (!nullToAbsent || lastMessageType != null) {
      map['last_message_type'] = Variable<String>(lastMessageType);
    }
    if (!nullToAbsent || lastMessageTime != null) {
      map['last_message_time'] = Variable<DateTime>(lastMessageTime);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_muted'] = Variable<bool>(isMuted);
    map['mentions_me'] = Variable<bool>(mentionsMe);
    if (!nullToAbsent || draft != null) {
      map['draft'] = Variable<String>(draft);
    }
    if (!nullToAbsent || memberCount != null) {
      map['member_count'] = Variable<int>(memberCount);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      type: Value(type),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      lastMessagePreview: lastMessagePreview == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessagePreview),
      lastMessageType: lastMessageType == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageType),
      lastMessageTime: lastMessageTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageTime),
      unreadCount: Value(unreadCount),
      isPinned: Value(isPinned),
      isMuted: Value(isMuted),
      mentionsMe: Value(mentionsMe),
      draft:
          draft == null && nullToAbsent ? const Value.absent() : Value(draft),
      memberCount: memberCount == null && nullToAbsent
          ? const Value.absent()
          : Value(memberCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      type: $ChatsTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      lastMessagePreview:
          serializer.fromJson<String?>(json['lastMessagePreview']),
      lastMessageType: serializer.fromJson<String?>(json['lastMessageType']),
      lastMessageTime: serializer.fromJson<DateTime?>(json['lastMessageTime']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isMuted: serializer.fromJson<bool>(json['isMuted']),
      mentionsMe: serializer.fromJson<bool>(json['mentionsMe']),
      draft: serializer.fromJson<String?>(json['draft']),
      memberCount: serializer.fromJson<int?>(json['memberCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  factory Chat.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Chat.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'type':
          serializer.toJson<String>($ChatsTable.$convertertype.toJson(type)),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'lastMessagePreview': serializer.toJson<String?>(lastMessagePreview),
      'lastMessageType': serializer.toJson<String?>(lastMessageType),
      'lastMessageTime': serializer.toJson<DateTime?>(lastMessageTime),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isMuted': serializer.toJson<bool>(isMuted),
      'mentionsMe': serializer.toJson<bool>(mentionsMe),
      'draft': serializer.toJson<String?>(draft),
      'memberCount': serializer.toJson<int?>(memberCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Chat copyWith(
          {String? id,
          Value<String?> name = const Value.absent(),
          ChatType? type,
          Value<String?> avatarUrl = const Value.absent(),
          Value<String?> lastMessagePreview = const Value.absent(),
          Value<String?> lastMessageType = const Value.absent(),
          Value<DateTime?> lastMessageTime = const Value.absent(),
          int? unreadCount,
          bool? isPinned,
          bool? isMuted,
          bool? mentionsMe,
          Value<String?> draft = const Value.absent(),
          Value<int?> memberCount = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Chat(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        type: type ?? this.type,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
        lastMessagePreview: lastMessagePreview.present
            ? lastMessagePreview.value
            : this.lastMessagePreview,
        lastMessageType: lastMessageType.present
            ? lastMessageType.value
            : this.lastMessageType,
        lastMessageTime: lastMessageTime.present
            ? lastMessageTime.value
            : this.lastMessageTime,
        unreadCount: unreadCount ?? this.unreadCount,
        isPinned: isPinned ?? this.isPinned,
        isMuted: isMuted ?? this.isMuted,
        mentionsMe: mentionsMe ?? this.mentionsMe,
        draft: draft.present ? draft.value : this.draft,
        memberCount: memberCount.present ? memberCount.value : this.memberCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      lastMessagePreview: data.lastMessagePreview.present
          ? data.lastMessagePreview.value
          : this.lastMessagePreview,
      lastMessageType: data.lastMessageType.present
          ? data.lastMessageType.value
          : this.lastMessageType,
      lastMessageTime: data.lastMessageTime.present
          ? data.lastMessageTime.value
          : this.lastMessageTime,
      unreadCount:
          data.unreadCount.present ? data.unreadCount.value : this.unreadCount,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isMuted: data.isMuted.present ? data.isMuted.value : this.isMuted,
      mentionsMe:
          data.mentionsMe.present ? data.mentionsMe.value : this.mentionsMe,
      draft: data.draft.present ? data.draft.value : this.draft,
      memberCount:
          data.memberCount.present ? data.memberCount.value : this.memberCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastMessagePreview: $lastMessagePreview, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageTime: $lastMessageTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isPinned: $isPinned, ')
          ..write('isMuted: $isMuted, ')
          ..write('mentionsMe: $mentionsMe, ')
          ..write('draft: $draft, ')
          ..write('memberCount: $memberCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      type,
      avatarUrl,
      lastMessagePreview,
      lastMessageType,
      lastMessageTime,
      unreadCount,
      isPinned,
      isMuted,
      mentionsMe,
      draft,
      memberCount,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.avatarUrl == this.avatarUrl &&
          other.lastMessagePreview == this.lastMessagePreview &&
          other.lastMessageType == this.lastMessageType &&
          other.lastMessageTime == this.lastMessageTime &&
          other.unreadCount == this.unreadCount &&
          other.isPinned == this.isPinned &&
          other.isMuted == this.isMuted &&
          other.mentionsMe == this.mentionsMe &&
          other.draft == this.draft &&
          other.memberCount == this.memberCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> id;
  final Value<String?> name;
  final Value<ChatType> type;
  final Value<String?> avatarUrl;
  final Value<String?> lastMessagePreview;
  final Value<String?> lastMessageType;
  final Value<DateTime?> lastMessageTime;
  final Value<int> unreadCount;
  final Value<bool> isPinned;
  final Value<bool> isMuted;
  final Value<bool> mentionsMe;
  final Value<String?> draft;
  final Value<int?> memberCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.lastMessagePreview = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.mentionsMe = const Value.absent(),
    this.draft = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    required ChatType type,
    this.avatarUrl = const Value.absent(),
    this.lastMessagePreview = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.mentionsMe = const Value.absent(),
    this.draft = const Value.absent(),
    this.memberCount = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Chat> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? avatarUrl,
    Expression<String>? lastMessagePreview,
    Expression<String>? lastMessageType,
    Expression<DateTime>? lastMessageTime,
    Expression<int>? unreadCount,
    Expression<bool>? isPinned,
    Expression<bool>? isMuted,
    Expression<bool>? mentionsMe,
    Expression<String>? draft,
    Expression<int>? memberCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (lastMessagePreview != null)
        'last_message_preview': lastMessagePreview,
      if (lastMessageType != null) 'last_message_type': lastMessageType,
      if (lastMessageTime != null) 'last_message_time': lastMessageTime,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isMuted != null) 'is_muted': isMuted,
      if (mentionsMe != null) 'mentions_me': mentionsMe,
      if (draft != null) 'draft': draft,
      if (memberCount != null) 'member_count': memberCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<ChatType>? type,
      Value<String?>? avatarUrl,
      Value<String?>? lastMessagePreview,
      Value<String?>? lastMessageType,
      Value<DateTime?>? lastMessageTime,
      Value<int>? unreadCount,
      Value<bool>? isPinned,
      Value<bool>? isMuted,
      Value<bool>? mentionsMe,
      Value<String?>? draft,
      Value<int?>? memberCount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ChatsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      mentionsMe: mentionsMe ?? this.mentionsMe,
      draft: draft ?? this.draft,
      memberCount: memberCount ?? this.memberCount,
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
    if (type.present) {
      map['type'] =
          Variable<String>($ChatsTable.$convertertype.toSql(type.value));
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (lastMessagePreview.present) {
      map['last_message_preview'] = Variable<String>(lastMessagePreview.value);
    }
    if (lastMessageType.present) {
      map['last_message_type'] = Variable<String>(lastMessageType.value);
    }
    if (lastMessageTime.present) {
      map['last_message_time'] = Variable<DateTime>(lastMessageTime.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isMuted.present) {
      map['is_muted'] = Variable<bool>(isMuted.value);
    }
    if (mentionsMe.present) {
      map['mentions_me'] = Variable<bool>(mentionsMe.value);
    }
    if (draft.present) {
      map['draft'] = Variable<String>(draft.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
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
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastMessagePreview: $lastMessagePreview, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageTime: $lastMessageTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isPinned: $isPinned, ')
          ..write('isMuted: $isMuted, ')
          ..write('mentionsMe: $mentionsMe, ')
          ..write('draft: $draft, ')
          ..write('memberCount: $memberCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _senderIdMeta =
      const VerificationMeta('senderId');
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
      'sender_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receiverIdMeta =
      const VerificationMeta('receiverId');
  @override
  late final GeneratedColumn<String> receiverId = GeneratedColumn<String>(
      'receiver_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serverIdMeta =
      const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
      'server_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sendTimeMeta =
      const VerificationMeta('sendTime');
  @override
  late final GeneratedColumn<int> sendTime = GeneratedColumn<int>(
      'send_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
      'seq', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _msgTypeMeta =
      const VerificationMeta('msgType');
  @override
  late final GeneratedColumn<int> msgType = GeneratedColumn<int>(
      'msg_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentTypeMeta =
      const VerificationMeta('contentType');
  @override
  late final GeneratedColumn<int> contentType = GeneratedColumn<int>(
      'content_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<int> platform = GeneratedColumn<int>(
      'platform', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _relatedMsgIdMeta =
      const VerificationMeta('relatedMsgId');
  @override
  late final GeneratedColumn<String> relatedMsgId = GeneratedColumn<String>(
      'related_msg_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sendSeqMeta =
      const VerificationMeta('sendSeq');
  @override
  late final GeneratedColumn<int> sendSeq = GeneratedColumn<int>(
      'send_seq', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSelfMeta = const VerificationMeta('isSelf');
  @override
  late final GeneratedColumn<bool> isSelf = GeneratedColumn<bool>(
      'is_self', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_self" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _remoteUrlMeta =
      const VerificationMeta('remoteUrl');
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
      'remote_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
      'extra', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deletedTimeMeta =
      const VerificationMeta('deletedTime');
  @override
  late final GeneratedColumn<int> deletedTime = GeneratedColumn<int>(
      'deleted_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedTimeMeta =
      const VerificationMeta('updatedTime');
  @override
  late final GeneratedColumn<int> updatedTime = GeneratedColumn<int>(
      'updated_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        clientId,
        senderId,
        receiverId,
        serverId,
        createTime,
        sendTime,
        seq,
        msgType,
        contentType,
        content,
        isRead,
        groupId,
        platform,
        relatedMsgId,
        sendSeq,
        conversationId,
        isSelf,
        status,
        localPath,
        remoteUrl,
        extra,
        deletedTime,
        isDeleted,
        updatedTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(_senderIdMeta,
          senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta));
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('receiver_id')) {
      context.handle(
          _receiverIdMeta,
          receiverId.isAcceptableOrUnknown(
              data['receiver_id']!, _receiverIdMeta));
    } else if (isInserting) {
      context.missing(_receiverIdMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('send_time')) {
      context.handle(_sendTimeMeta,
          sendTime.isAcceptableOrUnknown(data['send_time']!, _sendTimeMeta));
    } else if (isInserting) {
      context.missing(_sendTimeMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
          _seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('msg_type')) {
      context.handle(_msgTypeMeta,
          msgType.isAcceptableOrUnknown(data['msg_type']!, _msgTypeMeta));
    } else if (isInserting) {
      context.missing(_msgTypeMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
          _contentTypeMeta,
          contentType.isAcceptableOrUnknown(
              data['content_type']!, _contentTypeMeta));
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('related_msg_id')) {
      context.handle(
          _relatedMsgIdMeta,
          relatedMsgId.isAcceptableOrUnknown(
              data['related_msg_id']!, _relatedMsgIdMeta));
    }
    if (data.containsKey('send_seq')) {
      context.handle(_sendSeqMeta,
          sendSeq.isAcceptableOrUnknown(data['send_seq']!, _sendSeqMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('is_self')) {
      context.handle(_isSelfMeta,
          isSelf.isAcceptableOrUnknown(data['is_self']!, _isSelfMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('remote_url')) {
      context.handle(_remoteUrlMeta,
          remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta));
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    if (data.containsKey('deleted_time')) {
      context.handle(
          _deletedTimeMeta,
          deletedTime.isAcceptableOrUnknown(
              data['deleted_time']!, _deletedTimeMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('updated_time')) {
      context.handle(
          _updatedTimeMeta,
          updatedTime.isAcceptableOrUnknown(
              data['updated_time']!, _updatedTimeMeta));
    } else if (isInserting) {
      context.missing(_updatedTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      senderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_id'])!,
      receiverId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receiver_id'])!,
      serverId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_id']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      sendTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_time'])!,
      seq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seq'])!,
      msgType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}msg_type'])!,
      contentType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}content_type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id']),
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}platform'])!,
      relatedMsgId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}related_msg_id']),
      sendSeq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_seq']),
      conversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conversation_id'])!,
      isSelf: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_self'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      remoteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_url']),
      extra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra']),
      deletedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_time']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      updatedTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_time'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  /// The client ID (local ID). primary key
  final String clientId;

  /// The sender ID.
  final String senderId;

  /// The receiver ID.
  final String receiverId;

  /// The server ID.
  final String? serverId;

  /// The create time.
  final int createTime;

  /// The send time.
  final int sendTime;

  /// The sequence number.
  final int seq;

  /// The message type.
  final int msgType;

  /// The content type.
  final int contentType;

  /// The content.
  final String content;

  /// Whether the message is read.
  final bool isRead;

  /// The group ID.
  final String? groupId;

  /// The platform.
  final int platform;

  /// The related message ID.
  final String? relatedMsgId;

  /// The send sequence number.
  final int? sendSeq;

  /// The conversation ID.
  final String conversationId;

  /// Whether the message is sent by the current user.
  final bool isSelf;

  /// The message status (0: sending, 1: sent, 2: delivered, 3: read, 4: failed).
  final int status;

  /// The local path of the attachment.
  final String? localPath;

  /// The remote URL of the attachment.
  final String? remoteUrl;

  /// The message extra data.
  final String? extra;

  /// The deleted time.
  final int? deletedTime;

  /// Whether the message is deleted.
  final bool isDeleted;

  /// The last update time.
  final int updatedTime;
  const Message(
      {required this.clientId,
      required this.senderId,
      required this.receiverId,
      this.serverId,
      required this.createTime,
      required this.sendTime,
      required this.seq,
      required this.msgType,
      required this.contentType,
      required this.content,
      required this.isRead,
      this.groupId,
      required this.platform,
      this.relatedMsgId,
      this.sendSeq,
      required this.conversationId,
      required this.isSelf,
      required this.status,
      this.localPath,
      this.remoteUrl,
      this.extra,
      this.deletedTime,
      required this.isDeleted,
      required this.updatedTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<String>(clientId);
    map['sender_id'] = Variable<String>(senderId);
    map['receiver_id'] = Variable<String>(receiverId);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['create_time'] = Variable<int>(createTime);
    map['send_time'] = Variable<int>(sendTime);
    map['seq'] = Variable<int>(seq);
    map['msg_type'] = Variable<int>(msgType);
    map['content_type'] = Variable<int>(contentType);
    map['content'] = Variable<String>(content);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    map['platform'] = Variable<int>(platform);
    if (!nullToAbsent || relatedMsgId != null) {
      map['related_msg_id'] = Variable<String>(relatedMsgId);
    }
    if (!nullToAbsent || sendSeq != null) {
      map['send_seq'] = Variable<int>(sendSeq);
    }
    map['conversation_id'] = Variable<String>(conversationId);
    map['is_self'] = Variable<bool>(isSelf);
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String>(extra);
    }
    if (!nullToAbsent || deletedTime != null) {
      map['deleted_time'] = Variable<int>(deletedTime);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['updated_time'] = Variable<int>(updatedTime);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      clientId: Value(clientId),
      senderId: Value(senderId),
      receiverId: Value(receiverId),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      createTime: Value(createTime),
      sendTime: Value(sendTime),
      seq: Value(seq),
      msgType: Value(msgType),
      contentType: Value(contentType),
      content: Value(content),
      isRead: Value(isRead),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      platform: Value(platform),
      relatedMsgId: relatedMsgId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedMsgId),
      sendSeq: sendSeq == null && nullToAbsent
          ? const Value.absent()
          : Value(sendSeq),
      conversationId: Value(conversationId),
      isSelf: Value(isSelf),
      status: Value(status),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      extra:
          extra == null && nullToAbsent ? const Value.absent() : Value(extra),
      deletedTime: deletedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedTime),
      isDeleted: Value(isDeleted),
      updatedTime: Value(updatedTime),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      clientId: serializer.fromJson<String>(json['clientId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      receiverId: serializer.fromJson<String>(json['receiverId']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      createTime: serializer.fromJson<int>(json['createTime']),
      sendTime: serializer.fromJson<int>(json['sendTime']),
      seq: serializer.fromJson<int>(json['seq']),
      msgType: serializer.fromJson<int>(json['msgType']),
      contentType: serializer.fromJson<int>(json['contentType']),
      content: serializer.fromJson<String>(json['content']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      platform: serializer.fromJson<int>(json['platform']),
      relatedMsgId: serializer.fromJson<String?>(json['relatedMsgId']),
      sendSeq: serializer.fromJson<int?>(json['sendSeq']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      isSelf: serializer.fromJson<bool>(json['isSelf']),
      status: serializer.fromJson<int>(json['status']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      extra: serializer.fromJson<String?>(json['extra']),
      deletedTime: serializer.fromJson<int?>(json['deletedTime']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      updatedTime: serializer.fromJson<int>(json['updatedTime']),
    );
  }
  factory Message.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Message.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<String>(clientId),
      'senderId': serializer.toJson<String>(senderId),
      'receiverId': serializer.toJson<String>(receiverId),
      'serverId': serializer.toJson<String?>(serverId),
      'createTime': serializer.toJson<int>(createTime),
      'sendTime': serializer.toJson<int>(sendTime),
      'seq': serializer.toJson<int>(seq),
      'msgType': serializer.toJson<int>(msgType),
      'contentType': serializer.toJson<int>(contentType),
      'content': serializer.toJson<String>(content),
      'isRead': serializer.toJson<bool>(isRead),
      'groupId': serializer.toJson<String?>(groupId),
      'platform': serializer.toJson<int>(platform),
      'relatedMsgId': serializer.toJson<String?>(relatedMsgId),
      'sendSeq': serializer.toJson<int?>(sendSeq),
      'conversationId': serializer.toJson<String>(conversationId),
      'isSelf': serializer.toJson<bool>(isSelf),
      'status': serializer.toJson<int>(status),
      'localPath': serializer.toJson<String?>(localPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'extra': serializer.toJson<String?>(extra),
      'deletedTime': serializer.toJson<int?>(deletedTime),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'updatedTime': serializer.toJson<int>(updatedTime),
    };
  }

  Message copyWith(
          {String? clientId,
          String? senderId,
          String? receiverId,
          Value<String?> serverId = const Value.absent(),
          int? createTime,
          int? sendTime,
          int? seq,
          int? msgType,
          int? contentType,
          String? content,
          bool? isRead,
          Value<String?> groupId = const Value.absent(),
          int? platform,
          Value<String?> relatedMsgId = const Value.absent(),
          Value<int?> sendSeq = const Value.absent(),
          String? conversationId,
          bool? isSelf,
          int? status,
          Value<String?> localPath = const Value.absent(),
          Value<String?> remoteUrl = const Value.absent(),
          Value<String?> extra = const Value.absent(),
          Value<int?> deletedTime = const Value.absent(),
          bool? isDeleted,
          int? updatedTime}) =>
      Message(
        clientId: clientId ?? this.clientId,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        serverId: serverId.present ? serverId.value : this.serverId,
        createTime: createTime ?? this.createTime,
        sendTime: sendTime ?? this.sendTime,
        seq: seq ?? this.seq,
        msgType: msgType ?? this.msgType,
        contentType: contentType ?? this.contentType,
        content: content ?? this.content,
        isRead: isRead ?? this.isRead,
        groupId: groupId.present ? groupId.value : this.groupId,
        platform: platform ?? this.platform,
        relatedMsgId:
            relatedMsgId.present ? relatedMsgId.value : this.relatedMsgId,
        sendSeq: sendSeq.present ? sendSeq.value : this.sendSeq,
        conversationId: conversationId ?? this.conversationId,
        isSelf: isSelf ?? this.isSelf,
        status: status ?? this.status,
        localPath: localPath.present ? localPath.value : this.localPath,
        remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
        extra: extra.present ? extra.value : this.extra,
        deletedTime: deletedTime.present ? deletedTime.value : this.deletedTime,
        isDeleted: isDeleted ?? this.isDeleted,
        updatedTime: updatedTime ?? this.updatedTime,
      );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      receiverId:
          data.receiverId.present ? data.receiverId.value : this.receiverId,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      sendTime: data.sendTime.present ? data.sendTime.value : this.sendTime,
      seq: data.seq.present ? data.seq.value : this.seq,
      msgType: data.msgType.present ? data.msgType.value : this.msgType,
      contentType:
          data.contentType.present ? data.contentType.value : this.contentType,
      content: data.content.present ? data.content.value : this.content,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      platform: data.platform.present ? data.platform.value : this.platform,
      relatedMsgId: data.relatedMsgId.present
          ? data.relatedMsgId.value
          : this.relatedMsgId,
      sendSeq: data.sendSeq.present ? data.sendSeq.value : this.sendSeq,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      isSelf: data.isSelf.present ? data.isSelf.value : this.isSelf,
      status: data.status.present ? data.status.value : this.status,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      extra: data.extra.present ? data.extra.value : this.extra,
      deletedTime:
          data.deletedTime.present ? data.deletedTime.value : this.deletedTime,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      updatedTime:
          data.updatedTime.present ? data.updatedTime.value : this.updatedTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('clientId: $clientId, ')
          ..write('senderId: $senderId, ')
          ..write('receiverId: $receiverId, ')
          ..write('serverId: $serverId, ')
          ..write('createTime: $createTime, ')
          ..write('sendTime: $sendTime, ')
          ..write('seq: $seq, ')
          ..write('msgType: $msgType, ')
          ..write('contentType: $contentType, ')
          ..write('content: $content, ')
          ..write('isRead: $isRead, ')
          ..write('groupId: $groupId, ')
          ..write('platform: $platform, ')
          ..write('relatedMsgId: $relatedMsgId, ')
          ..write('sendSeq: $sendSeq, ')
          ..write('conversationId: $conversationId, ')
          ..write('isSelf: $isSelf, ')
          ..write('status: $status, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('extra: $extra, ')
          ..write('deletedTime: $deletedTime, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedTime: $updatedTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        clientId,
        senderId,
        receiverId,
        serverId,
        createTime,
        sendTime,
        seq,
        msgType,
        contentType,
        content,
        isRead,
        groupId,
        platform,
        relatedMsgId,
        sendSeq,
        conversationId,
        isSelf,
        status,
        localPath,
        remoteUrl,
        extra,
        deletedTime,
        isDeleted,
        updatedTime
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.clientId == this.clientId &&
          other.senderId == this.senderId &&
          other.receiverId == this.receiverId &&
          other.serverId == this.serverId &&
          other.createTime == this.createTime &&
          other.sendTime == this.sendTime &&
          other.seq == this.seq &&
          other.msgType == this.msgType &&
          other.contentType == this.contentType &&
          other.content == this.content &&
          other.isRead == this.isRead &&
          other.groupId == this.groupId &&
          other.platform == this.platform &&
          other.relatedMsgId == this.relatedMsgId &&
          other.sendSeq == this.sendSeq &&
          other.conversationId == this.conversationId &&
          other.isSelf == this.isSelf &&
          other.status == this.status &&
          other.localPath == this.localPath &&
          other.remoteUrl == this.remoteUrl &&
          other.extra == this.extra &&
          other.deletedTime == this.deletedTime &&
          other.isDeleted == this.isDeleted &&
          other.updatedTime == this.updatedTime);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> clientId;
  final Value<String> senderId;
  final Value<String> receiverId;
  final Value<String?> serverId;
  final Value<int> createTime;
  final Value<int> sendTime;
  final Value<int> seq;
  final Value<int> msgType;
  final Value<int> contentType;
  final Value<String> content;
  final Value<bool> isRead;
  final Value<String?> groupId;
  final Value<int> platform;
  final Value<String?> relatedMsgId;
  final Value<int?> sendSeq;
  final Value<String> conversationId;
  final Value<bool> isSelf;
  final Value<int> status;
  final Value<String?> localPath;
  final Value<String?> remoteUrl;
  final Value<String?> extra;
  final Value<int?> deletedTime;
  final Value<bool> isDeleted;
  final Value<int> updatedTime;
  final Value<int> rowid;
  const MessagesCompanion({
    this.clientId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.serverId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.sendTime = const Value.absent(),
    this.seq = const Value.absent(),
    this.msgType = const Value.absent(),
    this.contentType = const Value.absent(),
    this.content = const Value.absent(),
    this.isRead = const Value.absent(),
    this.groupId = const Value.absent(),
    this.platform = const Value.absent(),
    this.relatedMsgId = const Value.absent(),
    this.sendSeq = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.isSelf = const Value.absent(),
    this.status = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.extra = const Value.absent(),
    this.deletedTime = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.updatedTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String clientId,
    required String senderId,
    required String receiverId,
    this.serverId = const Value.absent(),
    required int createTime,
    required int sendTime,
    required int seq,
    required int msgType,
    required int contentType,
    required String content,
    this.isRead = const Value.absent(),
    this.groupId = const Value.absent(),
    required int platform,
    this.relatedMsgId = const Value.absent(),
    this.sendSeq = const Value.absent(),
    required String conversationId,
    this.isSelf = const Value.absent(),
    this.status = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.extra = const Value.absent(),
    this.deletedTime = const Value.absent(),
    this.isDeleted = const Value.absent(),
    required int updatedTime,
    this.rowid = const Value.absent(),
  })  : clientId = Value(clientId),
        senderId = Value(senderId),
        receiverId = Value(receiverId),
        createTime = Value(createTime),
        sendTime = Value(sendTime),
        seq = Value(seq),
        msgType = Value(msgType),
        contentType = Value(contentType),
        content = Value(content),
        platform = Value(platform),
        conversationId = Value(conversationId),
        updatedTime = Value(updatedTime);
  static Insertable<Message> custom({
    Expression<String>? clientId,
    Expression<String>? senderId,
    Expression<String>? receiverId,
    Expression<String>? serverId,
    Expression<int>? createTime,
    Expression<int>? sendTime,
    Expression<int>? seq,
    Expression<int>? msgType,
    Expression<int>? contentType,
    Expression<String>? content,
    Expression<bool>? isRead,
    Expression<String>? groupId,
    Expression<int>? platform,
    Expression<String>? relatedMsgId,
    Expression<int>? sendSeq,
    Expression<String>? conversationId,
    Expression<bool>? isSelf,
    Expression<int>? status,
    Expression<String>? localPath,
    Expression<String>? remoteUrl,
    Expression<String>? extra,
    Expression<int>? deletedTime,
    Expression<bool>? isDeleted,
    Expression<int>? updatedTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (senderId != null) 'sender_id': senderId,
      if (receiverId != null) 'receiver_id': receiverId,
      if (serverId != null) 'server_id': serverId,
      if (createTime != null) 'create_time': createTime,
      if (sendTime != null) 'send_time': sendTime,
      if (seq != null) 'seq': seq,
      if (msgType != null) 'msg_type': msgType,
      if (contentType != null) 'content_type': contentType,
      if (content != null) 'content': content,
      if (isRead != null) 'is_read': isRead,
      if (groupId != null) 'group_id': groupId,
      if (platform != null) 'platform': platform,
      if (relatedMsgId != null) 'related_msg_id': relatedMsgId,
      if (sendSeq != null) 'send_seq': sendSeq,
      if (conversationId != null) 'conversation_id': conversationId,
      if (isSelf != null) 'is_self': isSelf,
      if (status != null) 'status': status,
      if (localPath != null) 'local_path': localPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (extra != null) 'extra': extra,
      if (deletedTime != null) 'deleted_time': deletedTime,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (updatedTime != null) 'updated_time': updatedTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith(
      {Value<String>? clientId,
      Value<String>? senderId,
      Value<String>? receiverId,
      Value<String?>? serverId,
      Value<int>? createTime,
      Value<int>? sendTime,
      Value<int>? seq,
      Value<int>? msgType,
      Value<int>? contentType,
      Value<String>? content,
      Value<bool>? isRead,
      Value<String?>? groupId,
      Value<int>? platform,
      Value<String?>? relatedMsgId,
      Value<int?>? sendSeq,
      Value<String>? conversationId,
      Value<bool>? isSelf,
      Value<int>? status,
      Value<String?>? localPath,
      Value<String?>? remoteUrl,
      Value<String?>? extra,
      Value<int?>? deletedTime,
      Value<bool>? isDeleted,
      Value<int>? updatedTime,
      Value<int>? rowid}) {
    return MessagesCompanion(
      clientId: clientId ?? this.clientId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      serverId: serverId ?? this.serverId,
      createTime: createTime ?? this.createTime,
      sendTime: sendTime ?? this.sendTime,
      seq: seq ?? this.seq,
      msgType: msgType ?? this.msgType,
      contentType: contentType ?? this.contentType,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      groupId: groupId ?? this.groupId,
      platform: platform ?? this.platform,
      relatedMsgId: relatedMsgId ?? this.relatedMsgId,
      sendSeq: sendSeq ?? this.sendSeq,
      conversationId: conversationId ?? this.conversationId,
      isSelf: isSelf ?? this.isSelf,
      status: status ?? this.status,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      extra: extra ?? this.extra,
      deletedTime: deletedTime ?? this.deletedTime,
      isDeleted: isDeleted ?? this.isDeleted,
      updatedTime: updatedTime ?? this.updatedTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (receiverId.present) {
      map['receiver_id'] = Variable<String>(receiverId.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (sendTime.present) {
      map['send_time'] = Variable<int>(sendTime.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (msgType.present) {
      map['msg_type'] = Variable<int>(msgType.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<int>(contentType.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<int>(platform.value);
    }
    if (relatedMsgId.present) {
      map['related_msg_id'] = Variable<String>(relatedMsgId.value);
    }
    if (sendSeq.present) {
      map['send_seq'] = Variable<int>(sendSeq.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (isSelf.present) {
      map['is_self'] = Variable<bool>(isSelf.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (deletedTime.present) {
      map['deleted_time'] = Variable<int>(deletedTime.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (updatedTime.present) {
      map['updated_time'] = Variable<int>(updatedTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('clientId: $clientId, ')
          ..write('senderId: $senderId, ')
          ..write('receiverId: $receiverId, ')
          ..write('serverId: $serverId, ')
          ..write('createTime: $createTime, ')
          ..write('sendTime: $sendTime, ')
          ..write('seq: $seq, ')
          ..write('msgType: $msgType, ')
          ..write('contentType: $contentType, ')
          ..write('content: $content, ')
          ..write('isRead: $isRead, ')
          ..write('groupId: $groupId, ')
          ..write('platform: $platform, ')
          ..write('relatedMsgId: $relatedMsgId, ')
          ..write('sendSeq: $sendSeq, ')
          ..write('conversationId: $conversationId, ')
          ..write('isSelf: $isSelf, ')
          ..write('status: $status, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('extra: $extra, ')
          ..write('deletedTime: $deletedTime, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('updatedTime: $updatedTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeqsTable extends Seqs with TableInfo<$SeqsTable, Seq> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeqsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localSeqMeta =
      const VerificationMeta('localSeq');
  @override
  late final GeneratedColumn<int> localSeq = GeneratedColumn<int>(
      'local_seq', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sendSeqMeta =
      const VerificationMeta('sendSeq');
  @override
  late final GeneratedColumn<int> sendSeq = GeneratedColumn<int>(
      'send_seq', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastSyncTimeMeta =
      const VerificationMeta('lastSyncTime');
  @override
  late final GeneratedColumn<int> lastSyncTime = GeneratedColumn<int>(
      'last_sync_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [userId, localSeq, sendSeq, lastSyncTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seqs';
  @override
  VerificationContext validateIntegrity(Insertable<Seq> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('local_seq')) {
      context.handle(_localSeqMeta,
          localSeq.isAcceptableOrUnknown(data['local_seq']!, _localSeqMeta));
    }
    if (data.containsKey('send_seq')) {
      context.handle(_sendSeqMeta,
          sendSeq.isAcceptableOrUnknown(data['send_seq']!, _sendSeqMeta));
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
          _lastSyncTimeMeta,
          lastSyncTime.isAcceptableOrUnknown(
              data['last_sync_time']!, _lastSyncTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  Seq map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Seq(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      localSeq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}local_seq'])!,
      sendSeq: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}send_seq'])!,
      lastSyncTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_sync_time'])!,
    );
  }

  @override
  $SeqsTable createAlias(String alias) {
    return $SeqsTable(attachedDatabase, alias);
  }
}

class Seq extends DataClass implements Insertable<Seq> {
  /// 用户ID，作为主键
  final String userId;

  /// 接收消息的序列号
  final int localSeq;

  /// 发送消息的序列号
  final int sendSeq;

  /// 最后同步时间
  final int lastSyncTime;
  const Seq(
      {required this.userId,
      required this.localSeq,
      required this.sendSeq,
      required this.lastSyncTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['local_seq'] = Variable<int>(localSeq);
    map['send_seq'] = Variable<int>(sendSeq);
    map['last_sync_time'] = Variable<int>(lastSyncTime);
    return map;
  }

  SeqsCompanion toCompanion(bool nullToAbsent) {
    return SeqsCompanion(
      userId: Value(userId),
      localSeq: Value(localSeq),
      sendSeq: Value(sendSeq),
      lastSyncTime: Value(lastSyncTime),
    );
  }

  factory Seq.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Seq(
      userId: serializer.fromJson<String>(json['userId']),
      localSeq: serializer.fromJson<int>(json['localSeq']),
      sendSeq: serializer.fromJson<int>(json['sendSeq']),
      lastSyncTime: serializer.fromJson<int>(json['lastSyncTime']),
    );
  }
  factory Seq.fromJsonString(String encodedJson,
          {ValueSerializer? serializer}) =>
      Seq.fromJson(DataClass.parseJson(encodedJson) as Map<String, dynamic>,
          serializer: serializer);
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'localSeq': serializer.toJson<int>(localSeq),
      'sendSeq': serializer.toJson<int>(sendSeq),
      'lastSyncTime': serializer.toJson<int>(lastSyncTime),
    };
  }

  Seq copyWith(
          {String? userId, int? localSeq, int? sendSeq, int? lastSyncTime}) =>
      Seq(
        userId: userId ?? this.userId,
        localSeq: localSeq ?? this.localSeq,
        sendSeq: sendSeq ?? this.sendSeq,
        lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      );
  Seq copyWithCompanion(SeqsCompanion data) {
    return Seq(
      userId: data.userId.present ? data.userId.value : this.userId,
      localSeq: data.localSeq.present ? data.localSeq.value : this.localSeq,
      sendSeq: data.sendSeq.present ? data.sendSeq.value : this.sendSeq,
      lastSyncTime: data.lastSyncTime.present
          ? data.lastSyncTime.value
          : this.lastSyncTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Seq(')
          ..write('userId: $userId, ')
          ..write('localSeq: $localSeq, ')
          ..write('sendSeq: $sendSeq, ')
          ..write('lastSyncTime: $lastSyncTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, localSeq, sendSeq, lastSyncTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Seq &&
          other.userId == this.userId &&
          other.localSeq == this.localSeq &&
          other.sendSeq == this.sendSeq &&
          other.lastSyncTime == this.lastSyncTime);
}

class SeqsCompanion extends UpdateCompanion<Seq> {
  final Value<String> userId;
  final Value<int> localSeq;
  final Value<int> sendSeq;
  final Value<int> lastSyncTime;
  final Value<int> rowid;
  const SeqsCompanion({
    this.userId = const Value.absent(),
    this.localSeq = const Value.absent(),
    this.sendSeq = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeqsCompanion.insert({
    required String userId,
    this.localSeq = const Value.absent(),
    this.sendSeq = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<Seq> custom({
    Expression<String>? userId,
    Expression<int>? localSeq,
    Expression<int>? sendSeq,
    Expression<int>? lastSyncTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (localSeq != null) 'local_seq': localSeq,
      if (sendSeq != null) 'send_seq': sendSeq,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeqsCompanion copyWith(
      {Value<String>? userId,
      Value<int>? localSeq,
      Value<int>? sendSeq,
      Value<int>? lastSyncTime,
      Value<int>? rowid}) {
    return SeqsCompanion(
      userId: userId ?? this.userId,
      localSeq: localSeq ?? this.localSeq,
      sendSeq: sendSeq ?? this.sendSeq,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (localSeq.present) {
      map['local_seq'] = Variable<int>(localSeq.value);
    }
    if (sendSeq.present) {
      map['send_seq'] = Variable<int>(sendSeq.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<int>(lastSyncTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeqsCompanion(')
          ..write('userId: $userId, ')
          ..write('localSeq: $localSeq, ')
          ..write('sendSeq: $sendSeq, ')
          ..write('lastSyncTime: $lastSyncTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $FriendsTable friends = $FriendsTable(this);
  late final $FriendRequestsTable friendRequests = $FriendRequestsTable(this);
  late final $FriendGroupsTable friendGroups = $FriendGroupsTable(this);
  late final $FriendTagsTable friendTags = $FriendTagsTable(this);
  late final $FriendTagRelationsTable friendTagRelations =
      $FriendTagRelationsTable(this);
  late final $FriendInteractionsTable friendInteractions =
      $FriendInteractionsTable(this);
  late final $FriendPrivacySettingsTable friendPrivacySettings =
      $FriendPrivacySettingsTable(this);
  late final $FriendNotesTable friendNotes = $FriendNotesTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SeqsTable seqs = $SeqsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        friends,
        friendRequests,
        friendGroups,
        friendTags,
        friendTagRelations,
        friendInteractions,
        friendPrivacySettings,
        friendNotes,
        chats,
        messages,
        seqs
      ];
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
  Value<int?> lastLoginTime,
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
  Value<int?> lastLoginTime,
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
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get account => $composableBuilder(
      column: $table.account, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get signature => $composableBuilder(
      column: $table.signature, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get twoFactorEnabled => $composableBuilder(
      column: $table.twoFactorEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountStatus => $composableBuilder(
      column: $table.accountStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastActiveTime => $composableBuilder(
      column: $table.lastActiveTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statusMessage => $composableBuilder(
      column: $table.statusMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get privacySettings => $composableBuilder(
      column: $table.privacySettings,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendRequestsPrivacy => $composableBuilder(
      column: $table.friendRequestsPrivacy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileVisibility => $composableBuilder(
      column: $table.profileVisibility,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get account => $composableBuilder(
      column: $table.account, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get signature => $composableBuilder(
      column: $table.signature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get twoFactorEnabled => $composableBuilder(
      column: $table.twoFactorEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountStatus => $composableBuilder(
      column: $table.accountStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastActiveTime => $composableBuilder(
      column: $table.lastActiveTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statusMessage => $composableBuilder(
      column: $table.statusMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get privacySettings => $composableBuilder(
      column: $table.privacySettings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendRequestsPrivacy => $composableBuilder(
      column: $table.friendRequestsPrivacy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileVisibility => $composableBuilder(
      column: $table.profileVisibility,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
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

  GeneratedColumn<String> get account =>
      $composableBuilder(column: $table.account, builder: (column) => column);

  GeneratedColumn<String> get signature =>
      $composableBuilder(column: $table.signature, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<int> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => column);

  GeneratedColumn<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => column);

  GeneratedColumn<bool> get twoFactorEnabled => $composableBuilder(
      column: $table.twoFactorEnabled, builder: (column) => column);

  GeneratedColumn<String> get accountStatus => $composableBuilder(
      column: $table.accountStatus, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get lastActiveTime => $composableBuilder(
      column: $table.lastActiveTime, builder: (column) => column);

  GeneratedColumn<String> get statusMessage => $composableBuilder(
      column: $table.statusMessage, builder: (column) => column);

  GeneratedColumn<String> get privacySettings => $composableBuilder(
      column: $table.privacySettings, builder: (column) => column);

  GeneratedColumn<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get friendRequestsPrivacy => $composableBuilder(
      column: $table.friendRequestsPrivacy, builder: (column) => column);

  GeneratedColumn<String> get profileVisibility => $composableBuilder(
      column: $table.profileVisibility, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
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
            Value<int?> lastLoginTime = const Value.absent(),
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
            Value<int?> lastLoginTime = const Value.absent(),
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
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$FriendsTableCreateCompanionBuilder = FriendsCompanion Function({
  required String fsId,
  required String userId,
  required String friendId,
  required String name,
  required String avatar,
  required String gender,
  required int age,
  Value<String?> region,
  required String email,
  Value<String> status,
  Value<String?> remark,
  Value<String?> source,
  required int createTime,
  required int updateTime,
  Value<int?> deletedTime,
  Value<bool> isStarred,
  Value<int?> groupId,
  Value<int> priority,
  Value<int> rowid,
});
typedef $$FriendsTableUpdateCompanionBuilder = FriendsCompanion Function({
  Value<String> fsId,
  Value<String> userId,
  Value<String> friendId,
  Value<String> name,
  Value<String> avatar,
  Value<String> gender,
  Value<int> age,
  Value<String?> region,
  Value<String> email,
  Value<String> status,
  Value<String?> remark,
  Value<String?> source,
  Value<int> createTime,
  Value<int> updateTime,
  Value<int?> deletedTime,
  Value<bool> isStarred,
  Value<int?> groupId,
  Value<int> priority,
  Value<int> rowid,
});

class $$FriendsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get fsId => $composableBuilder(
      column: $table.fsId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isStarred => $composableBuilder(
      column: $table.isStarred, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));
}

class $$FriendsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get fsId => $composableBuilder(
      column: $table.fsId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isStarred => $composableBuilder(
      column: $table.isStarred, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));
}

class $$FriendsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendsTable> {
  $$FriendsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get fsId =>
      $composableBuilder(column: $table.fsId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => column);

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<int> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);
}

class $$FriendsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendsTable,
    Friend,
    $$FriendsTableFilterComposer,
    $$FriendsTableOrderingComposer,
    $$FriendsTableAnnotationComposer,
    $$FriendsTableCreateCompanionBuilder,
    $$FriendsTableUpdateCompanionBuilder,
    (Friend, BaseReferences<_$AppDatabase, $FriendsTable, Friend>),
    Friend,
    PrefetchHooks Function()> {
  $$FriendsTableTableManager(_$AppDatabase db, $FriendsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> fsId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> updateTime = const Value.absent(),
            Value<int?> deletedTime = const Value.absent(),
            Value<bool> isStarred = const Value.absent(),
            Value<int?> groupId = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendsCompanion(
            fsId: fsId,
            userId: userId,
            friendId: friendId,
            name: name,
            avatar: avatar,
            gender: gender,
            age: age,
            region: region,
            email: email,
            status: status,
            remark: remark,
            source: source,
            createTime: createTime,
            updateTime: updateTime,
            deletedTime: deletedTime,
            isStarred: isStarred,
            groupId: groupId,
            priority: priority,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String fsId,
            required String userId,
            required String friendId,
            required String name,
            required String avatar,
            required String gender,
            required int age,
            Value<String?> region = const Value.absent(),
            required String email,
            Value<String> status = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<String?> source = const Value.absent(),
            required int createTime,
            required int updateTime,
            Value<int?> deletedTime = const Value.absent(),
            Value<bool> isStarred = const Value.absent(),
            Value<int?> groupId = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendsCompanion.insert(
            fsId: fsId,
            userId: userId,
            friendId: friendId,
            name: name,
            avatar: avatar,
            gender: gender,
            age: age,
            region: region,
            email: email,
            status: status,
            remark: remark,
            source: source,
            createTime: createTime,
            updateTime: updateTime,
            deletedTime: deletedTime,
            isStarred: isStarred,
            groupId: groupId,
            priority: priority,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendsTable,
    Friend,
    $$FriendsTableFilterComposer,
    $$FriendsTableOrderingComposer,
    $$FriendsTableAnnotationComposer,
    $$FriendsTableCreateCompanionBuilder,
    $$FriendsTableUpdateCompanionBuilder,
    (Friend, BaseReferences<_$AppDatabase, $FriendsTable, Friend>),
    Friend,
    PrefetchHooks Function()>;
typedef $$FriendRequestsTableCreateCompanionBuilder = FriendRequestsCompanion
    Function({
  required String id,
  required String userId,
  required String friendId,
  required String name,
  required String avatar,
  required String gender,
  required int age,
  Value<String?> region,
  Value<String> status,
  Value<String?> applyMsg,
  Value<String?> reqRemark,
  Value<String?> respMsg,
  Value<String?> respRemark,
  Value<String?> source,
  required int createTime,
  Value<int?> updateTime,
  Value<String?> operatorId,
  Value<String?> lastOperation,
  Value<int?> deletedTime,
  Value<int> rowid,
});
typedef $$FriendRequestsTableUpdateCompanionBuilder = FriendRequestsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> friendId,
  Value<String> name,
  Value<String> avatar,
  Value<String> gender,
  Value<int> age,
  Value<String?> region,
  Value<String> status,
  Value<String?> applyMsg,
  Value<String?> reqRemark,
  Value<String?> respMsg,
  Value<String?> respRemark,
  Value<String?> source,
  Value<int> createTime,
  Value<int?> updateTime,
  Value<String?> operatorId,
  Value<String?> lastOperation,
  Value<int?> deletedTime,
  Value<int> rowid,
});

class $$FriendRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get applyMsg => $composableBuilder(
      column: $table.applyMsg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reqRemark => $composableBuilder(
      column: $table.reqRemark, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get respMsg => $composableBuilder(
      column: $table.respMsg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get respRemark => $composableBuilder(
      column: $table.respRemark, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operatorId => $composableBuilder(
      column: $table.operatorId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastOperation => $composableBuilder(
      column: $table.lastOperation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnFilters(column));
}

class $$FriendRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get applyMsg => $composableBuilder(
      column: $table.applyMsg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reqRemark => $composableBuilder(
      column: $table.reqRemark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get respMsg => $composableBuilder(
      column: $table.respMsg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get respRemark => $composableBuilder(
      column: $table.respRemark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operatorId => $composableBuilder(
      column: $table.operatorId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastOperation => $composableBuilder(
      column: $table.lastOperation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnOrderings(column));
}

class $$FriendRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendRequestsTable> {
  $$FriendRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get applyMsg =>
      $composableBuilder(column: $table.applyMsg, builder: (column) => column);

  GeneratedColumn<String> get reqRemark =>
      $composableBuilder(column: $table.reqRemark, builder: (column) => column);

  GeneratedColumn<String> get respMsg =>
      $composableBuilder(column: $table.respMsg, builder: (column) => column);

  GeneratedColumn<String> get respRemark => $composableBuilder(
      column: $table.respRemark, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<String> get operatorId => $composableBuilder(
      column: $table.operatorId, builder: (column) => column);

  GeneratedColumn<String> get lastOperation => $composableBuilder(
      column: $table.lastOperation, builder: (column) => column);

  GeneratedColumn<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => column);
}

class $$FriendRequestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendRequestsTable,
    FriendRequest,
    $$FriendRequestsTableFilterComposer,
    $$FriendRequestsTableOrderingComposer,
    $$FriendRequestsTableAnnotationComposer,
    $$FriendRequestsTableCreateCompanionBuilder,
    $$FriendRequestsTableUpdateCompanionBuilder,
    (
      FriendRequest,
      BaseReferences<_$AppDatabase, $FriendRequestsTable, FriendRequest>
    ),
    FriendRequest,
    PrefetchHooks Function()> {
  $$FriendRequestsTableTableManager(
      _$AppDatabase db, $FriendRequestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> applyMsg = const Value.absent(),
            Value<String?> reqRemark = const Value.absent(),
            Value<String?> respMsg = const Value.absent(),
            Value<String?> respRemark = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int?> updateTime = const Value.absent(),
            Value<String?> operatorId = const Value.absent(),
            Value<String?> lastOperation = const Value.absent(),
            Value<int?> deletedTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendRequestsCompanion(
            id: id,
            userId: userId,
            friendId: friendId,
            name: name,
            avatar: avatar,
            gender: gender,
            age: age,
            region: region,
            status: status,
            applyMsg: applyMsg,
            reqRemark: reqRemark,
            respMsg: respMsg,
            respRemark: respRemark,
            source: source,
            createTime: createTime,
            updateTime: updateTime,
            operatorId: operatorId,
            lastOperation: lastOperation,
            deletedTime: deletedTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String friendId,
            required String name,
            required String avatar,
            required String gender,
            required int age,
            Value<String?> region = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> applyMsg = const Value.absent(),
            Value<String?> reqRemark = const Value.absent(),
            Value<String?> respMsg = const Value.absent(),
            Value<String?> respRemark = const Value.absent(),
            Value<String?> source = const Value.absent(),
            required int createTime,
            Value<int?> updateTime = const Value.absent(),
            Value<String?> operatorId = const Value.absent(),
            Value<String?> lastOperation = const Value.absent(),
            Value<int?> deletedTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendRequestsCompanion.insert(
            id: id,
            userId: userId,
            friendId: friendId,
            name: name,
            avatar: avatar,
            gender: gender,
            age: age,
            region: region,
            status: status,
            applyMsg: applyMsg,
            reqRemark: reqRemark,
            respMsg: respMsg,
            respRemark: respRemark,
            source: source,
            createTime: createTime,
            updateTime: updateTime,
            operatorId: operatorId,
            lastOperation: lastOperation,
            deletedTime: deletedTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendRequestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendRequestsTable,
    FriendRequest,
    $$FriendRequestsTableFilterComposer,
    $$FriendRequestsTableOrderingComposer,
    $$FriendRequestsTableAnnotationComposer,
    $$FriendRequestsTableCreateCompanionBuilder,
    $$FriendRequestsTableUpdateCompanionBuilder,
    (
      FriendRequest,
      BaseReferences<_$AppDatabase, $FriendRequestsTable, FriendRequest>
    ),
    FriendRequest,
    PrefetchHooks Function()>;
typedef $$FriendGroupsTableCreateCompanionBuilder = FriendGroupsCompanion
    Function({
  Value<int> id,
  required String userId,
  required String name,
  required int createTime,
  required int updateTime,
  Value<int> sortOrder,
  Value<String?> icon,
});
typedef $$FriendGroupsTableUpdateCompanionBuilder = FriendGroupsCompanion
    Function({
  Value<int> id,
  Value<String> userId,
  Value<String> name,
  Value<int> createTime,
  Value<int> updateTime,
  Value<int> sortOrder,
  Value<String?> icon,
});

class $$FriendGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendGroupsTable> {
  $$FriendGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));
}

class $$FriendGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendGroupsTable> {
  $$FriendGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));
}

class $$FriendGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendGroupsTable> {
  $$FriendGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$FriendGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendGroupsTable,
    FriendGroup,
    $$FriendGroupsTableFilterComposer,
    $$FriendGroupsTableOrderingComposer,
    $$FriendGroupsTableAnnotationComposer,
    $$FriendGroupsTableCreateCompanionBuilder,
    $$FriendGroupsTableUpdateCompanionBuilder,
    (
      FriendGroup,
      BaseReferences<_$AppDatabase, $FriendGroupsTable, FriendGroup>
    ),
    FriendGroup,
    PrefetchHooks Function()> {
  $$FriendGroupsTableTableManager(_$AppDatabase db, $FriendGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> updateTime = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String?> icon = const Value.absent(),
          }) =>
              FriendGroupsCompanion(
            id: id,
            userId: userId,
            name: name,
            createTime: createTime,
            updateTime: updateTime,
            sortOrder: sortOrder,
            icon: icon,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String name,
            required int createTime,
            required int updateTime,
            Value<int> sortOrder = const Value.absent(),
            Value<String?> icon = const Value.absent(),
          }) =>
              FriendGroupsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            createTime: createTime,
            updateTime: updateTime,
            sortOrder: sortOrder,
            icon: icon,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendGroupsTable,
    FriendGroup,
    $$FriendGroupsTableFilterComposer,
    $$FriendGroupsTableOrderingComposer,
    $$FriendGroupsTableAnnotationComposer,
    $$FriendGroupsTableCreateCompanionBuilder,
    $$FriendGroupsTableUpdateCompanionBuilder,
    (
      FriendGroup,
      BaseReferences<_$AppDatabase, $FriendGroupsTable, FriendGroup>
    ),
    FriendGroup,
    PrefetchHooks Function()>;
typedef $$FriendTagsTableCreateCompanionBuilder = FriendTagsCompanion Function({
  Value<int> id,
  required String userId,
  required String name,
  Value<String> color,
  required int createTime,
  Value<String?> icon,
  Value<int> sortOrder,
});
typedef $$FriendTagsTableUpdateCompanionBuilder = FriendTagsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> name,
  Value<String> color,
  Value<int> createTime,
  Value<String?> icon,
  Value<int> sortOrder,
});

class $$FriendTagsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendTagsTable> {
  $$FriendTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$FriendTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendTagsTable> {
  $$FriendTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$FriendTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendTagsTable> {
  $$FriendTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$FriendTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendTagsTable,
    FriendTag,
    $$FriendTagsTableFilterComposer,
    $$FriendTagsTableOrderingComposer,
    $$FriendTagsTableAnnotationComposer,
    $$FriendTagsTableCreateCompanionBuilder,
    $$FriendTagsTableUpdateCompanionBuilder,
    (FriendTag, BaseReferences<_$AppDatabase, $FriendTagsTable, FriendTag>),
    FriendTag,
    PrefetchHooks Function()> {
  $$FriendTagsTableTableManager(_$AppDatabase db, $FriendTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              FriendTagsCompanion(
            id: id,
            userId: userId,
            name: name,
            color: color,
            createTime: createTime,
            icon: icon,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String name,
            Value<String> color = const Value.absent(),
            required int createTime,
            Value<String?> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              FriendTagsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            color: color,
            createTime: createTime,
            icon: icon,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendTagsTable,
    FriendTag,
    $$FriendTagsTableFilterComposer,
    $$FriendTagsTableOrderingComposer,
    $$FriendTagsTableAnnotationComposer,
    $$FriendTagsTableCreateCompanionBuilder,
    $$FriendTagsTableUpdateCompanionBuilder,
    (FriendTag, BaseReferences<_$AppDatabase, $FriendTagsTable, FriendTag>),
    FriendTag,
    PrefetchHooks Function()>;
typedef $$FriendTagRelationsTableCreateCompanionBuilder
    = FriendTagRelationsCompanion Function({
  required String userId,
  required String friendId,
  required int tagId,
  required int createTime,
  Value<int> rowid,
});
typedef $$FriendTagRelationsTableUpdateCompanionBuilder
    = FriendTagRelationsCompanion Function({
  Value<String> userId,
  Value<String> friendId,
  Value<int> tagId,
  Value<int> createTime,
  Value<int> rowid,
});

class $$FriendTagRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendTagRelationsTable> {
  $$FriendTagRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));
}

class $$FriendTagRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendTagRelationsTable> {
  $$FriendTagRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tagId => $composableBuilder(
      column: $table.tagId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));
}

class $$FriendTagRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendTagRelationsTable> {
  $$FriendTagRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<int> get tagId =>
      $composableBuilder(column: $table.tagId, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);
}

class $$FriendTagRelationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendTagRelationsTable,
    FriendTagRelation,
    $$FriendTagRelationsTableFilterComposer,
    $$FriendTagRelationsTableOrderingComposer,
    $$FriendTagRelationsTableAnnotationComposer,
    $$FriendTagRelationsTableCreateCompanionBuilder,
    $$FriendTagRelationsTableUpdateCompanionBuilder,
    (
      FriendTagRelation,
      BaseReferences<_$AppDatabase, $FriendTagRelationsTable, FriendTagRelation>
    ),
    FriendTagRelation,
    PrefetchHooks Function()> {
  $$FriendTagRelationsTableTableManager(
      _$AppDatabase db, $FriendTagRelationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendTagRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendTagRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendTagRelationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendTagRelationsCompanion(
            userId: userId,
            friendId: friendId,
            tagId: tagId,
            createTime: createTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required String friendId,
            required int tagId,
            required int createTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendTagRelationsCompanion.insert(
            userId: userId,
            friendId: friendId,
            tagId: tagId,
            createTime: createTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendTagRelationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendTagRelationsTable,
    FriendTagRelation,
    $$FriendTagRelationsTableFilterComposer,
    $$FriendTagRelationsTableOrderingComposer,
    $$FriendTagRelationsTableAnnotationComposer,
    $$FriendTagRelationsTableCreateCompanionBuilder,
    $$FriendTagRelationsTableUpdateCompanionBuilder,
    (
      FriendTagRelation,
      BaseReferences<_$AppDatabase, $FriendTagRelationsTable, FriendTagRelation>
    ),
    FriendTagRelation,
    PrefetchHooks Function()>;
typedef $$FriendInteractionsTableCreateCompanionBuilder
    = FriendInteractionsCompanion Function({
  required String userId,
  required String friendId,
  Value<int> messageCount,
  Value<int?> lastInteractTime,
  Value<int> totalDuration,
  Value<int> callCount,
  Value<double> interactionScore,
  Value<int> lastWeekCount,
  Value<int> lastMonthCount,
  Value<int> rowid,
});
typedef $$FriendInteractionsTableUpdateCompanionBuilder
    = FriendInteractionsCompanion Function({
  Value<String> userId,
  Value<String> friendId,
  Value<int> messageCount,
  Value<int?> lastInteractTime,
  Value<int> totalDuration,
  Value<int> callCount,
  Value<double> interactionScore,
  Value<int> lastWeekCount,
  Value<int> lastMonthCount,
  Value<int> rowid,
});

class $$FriendInteractionsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendInteractionsTable> {
  $$FriendInteractionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get messageCount => $composableBuilder(
      column: $table.messageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastInteractTime => $composableBuilder(
      column: $table.lastInteractTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get callCount => $composableBuilder(
      column: $table.callCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get interactionScore => $composableBuilder(
      column: $table.interactionScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastWeekCount => $composableBuilder(
      column: $table.lastWeekCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastMonthCount => $composableBuilder(
      column: $table.lastMonthCount,
      builder: (column) => ColumnFilters(column));
}

class $$FriendInteractionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendInteractionsTable> {
  $$FriendInteractionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get messageCount => $composableBuilder(
      column: $table.messageCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastInteractTime => $composableBuilder(
      column: $table.lastInteractTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get callCount => $composableBuilder(
      column: $table.callCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get interactionScore => $composableBuilder(
      column: $table.interactionScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastWeekCount => $composableBuilder(
      column: $table.lastWeekCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastMonthCount => $composableBuilder(
      column: $table.lastMonthCount,
      builder: (column) => ColumnOrderings(column));
}

class $$FriendInteractionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendInteractionsTable> {
  $$FriendInteractionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<int> get messageCount => $composableBuilder(
      column: $table.messageCount, builder: (column) => column);

  GeneratedColumn<int> get lastInteractTime => $composableBuilder(
      column: $table.lastInteractTime, builder: (column) => column);

  GeneratedColumn<int> get totalDuration => $composableBuilder(
      column: $table.totalDuration, builder: (column) => column);

  GeneratedColumn<int> get callCount =>
      $composableBuilder(column: $table.callCount, builder: (column) => column);

  GeneratedColumn<double> get interactionScore => $composableBuilder(
      column: $table.interactionScore, builder: (column) => column);

  GeneratedColumn<int> get lastWeekCount => $composableBuilder(
      column: $table.lastWeekCount, builder: (column) => column);

  GeneratedColumn<int> get lastMonthCount => $composableBuilder(
      column: $table.lastMonthCount, builder: (column) => column);
}

class $$FriendInteractionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendInteractionsTable,
    FriendInteraction,
    $$FriendInteractionsTableFilterComposer,
    $$FriendInteractionsTableOrderingComposer,
    $$FriendInteractionsTableAnnotationComposer,
    $$FriendInteractionsTableCreateCompanionBuilder,
    $$FriendInteractionsTableUpdateCompanionBuilder,
    (
      FriendInteraction,
      BaseReferences<_$AppDatabase, $FriendInteractionsTable, FriendInteraction>
    ),
    FriendInteraction,
    PrefetchHooks Function()> {
  $$FriendInteractionsTableTableManager(
      _$AppDatabase db, $FriendInteractionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendInteractionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendInteractionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendInteractionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<int> messageCount = const Value.absent(),
            Value<int?> lastInteractTime = const Value.absent(),
            Value<int> totalDuration = const Value.absent(),
            Value<int> callCount = const Value.absent(),
            Value<double> interactionScore = const Value.absent(),
            Value<int> lastWeekCount = const Value.absent(),
            Value<int> lastMonthCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendInteractionsCompanion(
            userId: userId,
            friendId: friendId,
            messageCount: messageCount,
            lastInteractTime: lastInteractTime,
            totalDuration: totalDuration,
            callCount: callCount,
            interactionScore: interactionScore,
            lastWeekCount: lastWeekCount,
            lastMonthCount: lastMonthCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required String friendId,
            Value<int> messageCount = const Value.absent(),
            Value<int?> lastInteractTime = const Value.absent(),
            Value<int> totalDuration = const Value.absent(),
            Value<int> callCount = const Value.absent(),
            Value<double> interactionScore = const Value.absent(),
            Value<int> lastWeekCount = const Value.absent(),
            Value<int> lastMonthCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendInteractionsCompanion.insert(
            userId: userId,
            friendId: friendId,
            messageCount: messageCount,
            lastInteractTime: lastInteractTime,
            totalDuration: totalDuration,
            callCount: callCount,
            interactionScore: interactionScore,
            lastWeekCount: lastWeekCount,
            lastMonthCount: lastMonthCount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendInteractionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendInteractionsTable,
    FriendInteraction,
    $$FriendInteractionsTableFilterComposer,
    $$FriendInteractionsTableOrderingComposer,
    $$FriendInteractionsTableAnnotationComposer,
    $$FriendInteractionsTableCreateCompanionBuilder,
    $$FriendInteractionsTableUpdateCompanionBuilder,
    (
      FriendInteraction,
      BaseReferences<_$AppDatabase, $FriendInteractionsTable, FriendInteraction>
    ),
    FriendInteraction,
    PrefetchHooks Function()>;
typedef $$FriendPrivacySettingsTableCreateCompanionBuilder
    = FriendPrivacySettingsCompanion Function({
  required String userId,
  required String friendId,
  Value<bool> canSeeMoments,
  Value<bool> canSeeOnlineStatus,
  Value<bool> canSeeLocation,
  Value<bool> canSeeMutualFriends,
  Value<String> permissionLevel,
  Value<String> customSettings,
  Value<int> rowid,
});
typedef $$FriendPrivacySettingsTableUpdateCompanionBuilder
    = FriendPrivacySettingsCompanion Function({
  Value<String> userId,
  Value<String> friendId,
  Value<bool> canSeeMoments,
  Value<bool> canSeeOnlineStatus,
  Value<bool> canSeeLocation,
  Value<bool> canSeeMutualFriends,
  Value<String> permissionLevel,
  Value<String> customSettings,
  Value<int> rowid,
});

class $$FriendPrivacySettingsTableFilterComposer
    extends Composer<_$AppDatabase, $FriendPrivacySettingsTable> {
  $$FriendPrivacySettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canSeeMoments => $composableBuilder(
      column: $table.canSeeMoments, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canSeeOnlineStatus => $composableBuilder(
      column: $table.canSeeOnlineStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canSeeLocation => $composableBuilder(
      column: $table.canSeeLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canSeeMutualFriends => $composableBuilder(
      column: $table.canSeeMutualFriends,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissionLevel => $composableBuilder(
      column: $table.permissionLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customSettings => $composableBuilder(
      column: $table.customSettings,
      builder: (column) => ColumnFilters(column));
}

class $$FriendPrivacySettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendPrivacySettingsTable> {
  $$FriendPrivacySettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canSeeMoments => $composableBuilder(
      column: $table.canSeeMoments,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canSeeOnlineStatus => $composableBuilder(
      column: $table.canSeeOnlineStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canSeeLocation => $composableBuilder(
      column: $table.canSeeLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canSeeMutualFriends => $composableBuilder(
      column: $table.canSeeMutualFriends,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissionLevel => $composableBuilder(
      column: $table.permissionLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customSettings => $composableBuilder(
      column: $table.customSettings,
      builder: (column) => ColumnOrderings(column));
}

class $$FriendPrivacySettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendPrivacySettingsTable> {
  $$FriendPrivacySettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<bool> get canSeeMoments => $composableBuilder(
      column: $table.canSeeMoments, builder: (column) => column);

  GeneratedColumn<bool> get canSeeOnlineStatus => $composableBuilder(
      column: $table.canSeeOnlineStatus, builder: (column) => column);

  GeneratedColumn<bool> get canSeeLocation => $composableBuilder(
      column: $table.canSeeLocation, builder: (column) => column);

  GeneratedColumn<bool> get canSeeMutualFriends => $composableBuilder(
      column: $table.canSeeMutualFriends, builder: (column) => column);

  GeneratedColumn<String> get permissionLevel => $composableBuilder(
      column: $table.permissionLevel, builder: (column) => column);

  GeneratedColumn<String> get customSettings => $composableBuilder(
      column: $table.customSettings, builder: (column) => column);
}

class $$FriendPrivacySettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendPrivacySettingsTable,
    FriendPrivacySetting,
    $$FriendPrivacySettingsTableFilterComposer,
    $$FriendPrivacySettingsTableOrderingComposer,
    $$FriendPrivacySettingsTableAnnotationComposer,
    $$FriendPrivacySettingsTableCreateCompanionBuilder,
    $$FriendPrivacySettingsTableUpdateCompanionBuilder,
    (
      FriendPrivacySetting,
      BaseReferences<_$AppDatabase, $FriendPrivacySettingsTable,
          FriendPrivacySetting>
    ),
    FriendPrivacySetting,
    PrefetchHooks Function()> {
  $$FriendPrivacySettingsTableTableManager(
      _$AppDatabase db, $FriendPrivacySettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendPrivacySettingsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendPrivacySettingsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendPrivacySettingsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<bool> canSeeMoments = const Value.absent(),
            Value<bool> canSeeOnlineStatus = const Value.absent(),
            Value<bool> canSeeLocation = const Value.absent(),
            Value<bool> canSeeMutualFriends = const Value.absent(),
            Value<String> permissionLevel = const Value.absent(),
            Value<String> customSettings = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendPrivacySettingsCompanion(
            userId: userId,
            friendId: friendId,
            canSeeMoments: canSeeMoments,
            canSeeOnlineStatus: canSeeOnlineStatus,
            canSeeLocation: canSeeLocation,
            canSeeMutualFriends: canSeeMutualFriends,
            permissionLevel: permissionLevel,
            customSettings: customSettings,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required String friendId,
            Value<bool> canSeeMoments = const Value.absent(),
            Value<bool> canSeeOnlineStatus = const Value.absent(),
            Value<bool> canSeeLocation = const Value.absent(),
            Value<bool> canSeeMutualFriends = const Value.absent(),
            Value<String> permissionLevel = const Value.absent(),
            Value<String> customSettings = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendPrivacySettingsCompanion.insert(
            userId: userId,
            friendId: friendId,
            canSeeMoments: canSeeMoments,
            canSeeOnlineStatus: canSeeOnlineStatus,
            canSeeLocation: canSeeLocation,
            canSeeMutualFriends: canSeeMutualFriends,
            permissionLevel: permissionLevel,
            customSettings: customSettings,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendPrivacySettingsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $FriendPrivacySettingsTable,
        FriendPrivacySetting,
        $$FriendPrivacySettingsTableFilterComposer,
        $$FriendPrivacySettingsTableOrderingComposer,
        $$FriendPrivacySettingsTableAnnotationComposer,
        $$FriendPrivacySettingsTableCreateCompanionBuilder,
        $$FriendPrivacySettingsTableUpdateCompanionBuilder,
        (
          FriendPrivacySetting,
          BaseReferences<_$AppDatabase, $FriendPrivacySettingsTable,
              FriendPrivacySetting>
        ),
        FriendPrivacySetting,
        PrefetchHooks Function()>;
typedef $$FriendNotesTableCreateCompanionBuilder = FriendNotesCompanion
    Function({
  required String userId,
  required String friendId,
  required String content,
  required int createTime,
  required int updateTime,
  Value<bool> isPinned,
  Value<int> rowid,
});
typedef $$FriendNotesTableUpdateCompanionBuilder = FriendNotesCompanion
    Function({
  Value<String> userId,
  Value<String> friendId,
  Value<String> content,
  Value<int> createTime,
  Value<int> updateTime,
  Value<bool> isPinned,
  Value<int> rowid,
});

class $$FriendNotesTableFilterComposer
    extends Composer<_$AppDatabase, $FriendNotesTable> {
  $$FriendNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));
}

class $$FriendNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $FriendNotesTable> {
  $$FriendNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get friendId => $composableBuilder(
      column: $table.friendId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));
}

class $$FriendNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FriendNotesTable> {
  $$FriendNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get friendId =>
      $composableBuilder(column: $table.friendId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get updateTime => $composableBuilder(
      column: $table.updateTime, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);
}

class $$FriendNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FriendNotesTable,
    FriendNote,
    $$FriendNotesTableFilterComposer,
    $$FriendNotesTableOrderingComposer,
    $$FriendNotesTableAnnotationComposer,
    $$FriendNotesTableCreateCompanionBuilder,
    $$FriendNotesTableUpdateCompanionBuilder,
    (FriendNote, BaseReferences<_$AppDatabase, $FriendNotesTable, FriendNote>),
    FriendNote,
    PrefetchHooks Function()> {
  $$FriendNotesTableTableManager(_$AppDatabase db, $FriendNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FriendNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FriendNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FriendNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<String> friendId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> updateTime = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendNotesCompanion(
            userId: userId,
            friendId: friendId,
            content: content,
            createTime: createTime,
            updateTime: updateTime,
            isPinned: isPinned,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            required String friendId,
            required String content,
            required int createTime,
            required int updateTime,
            Value<bool> isPinned = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FriendNotesCompanion.insert(
            userId: userId,
            friendId: friendId,
            content: content,
            createTime: createTime,
            updateTime: updateTime,
            isPinned: isPinned,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FriendNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FriendNotesTable,
    FriendNote,
    $$FriendNotesTableFilterComposer,
    $$FriendNotesTableOrderingComposer,
    $$FriendNotesTableAnnotationComposer,
    $$FriendNotesTableCreateCompanionBuilder,
    $$FriendNotesTableUpdateCompanionBuilder,
    (FriendNote, BaseReferences<_$AppDatabase, $FriendNotesTable, FriendNote>),
    FriendNote,
    PrefetchHooks Function()>;
typedef $$ChatsTableCreateCompanionBuilder = ChatsCompanion Function({
  required String id,
  Value<String?> name,
  required ChatType type,
  Value<String?> avatarUrl,
  Value<String?> lastMessagePreview,
  Value<String?> lastMessageType,
  Value<DateTime?> lastMessageTime,
  Value<int> unreadCount,
  Value<bool> isPinned,
  Value<bool> isMuted,
  Value<bool> mentionsMe,
  Value<String?> draft,
  Value<int?> memberCount,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ChatsTableUpdateCompanionBuilder = ChatsCompanion Function({
  Value<String> id,
  Value<String?> name,
  Value<ChatType> type,
  Value<String?> avatarUrl,
  Value<String?> lastMessagePreview,
  Value<String?> lastMessageType,
  Value<DateTime?> lastMessageTime,
  Value<int> unreadCount,
  Value<bool> isPinned,
  Value<bool> isMuted,
  Value<bool> mentionsMe,
  Value<String?> draft,
  Value<int?> memberCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ChatsTableFilterComposer extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ChatType, ChatType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMessagePreview => $composableBuilder(
      column: $table.lastMessagePreview,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMessageType => $composableBuilder(
      column: $table.lastMessageType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMuted => $composableBuilder(
      column: $table.isMuted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mentionsMe => $composableBuilder(
      column: $table.mentionsMe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get draft => $composableBuilder(
      column: $table.draft, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ChatsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMessagePreview => $composableBuilder(
      column: $table.lastMessagePreview,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMessageType => $composableBuilder(
      column: $table.lastMessageType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMuted => $composableBuilder(
      column: $table.isMuted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mentionsMe => $composableBuilder(
      column: $table.mentionsMe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get draft => $composableBuilder(
      column: $table.draft, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ChatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<ChatType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get lastMessagePreview => $composableBuilder(
      column: $table.lastMessagePreview, builder: (column) => column);

  GeneratedColumn<String> get lastMessageType => $composableBuilder(
      column: $table.lastMessageType, builder: (column) => column);

  GeneratedColumn<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<bool> get isMuted =>
      $composableBuilder(column: $table.isMuted, builder: (column) => column);

  GeneratedColumn<bool> get mentionsMe => $composableBuilder(
      column: $table.mentionsMe, builder: (column) => column);

  GeneratedColumn<String> get draft =>
      $composableBuilder(column: $table.draft, builder: (column) => column);

  GeneratedColumn<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ChatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatsTable,
    Chat,
    $$ChatsTableFilterComposer,
    $$ChatsTableOrderingComposer,
    $$ChatsTableAnnotationComposer,
    $$ChatsTableCreateCompanionBuilder,
    $$ChatsTableUpdateCompanionBuilder,
    (Chat, BaseReferences<_$AppDatabase, $ChatsTable, Chat>),
    Chat,
    PrefetchHooks Function()> {
  $$ChatsTableTableManager(_$AppDatabase db, $ChatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<ChatType> type = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<String?> lastMessagePreview = const Value.absent(),
            Value<String?> lastMessageType = const Value.absent(),
            Value<DateTime?> lastMessageTime = const Value.absent(),
            Value<int> unreadCount = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isMuted = const Value.absent(),
            Value<bool> mentionsMe = const Value.absent(),
            Value<String?> draft = const Value.absent(),
            Value<int?> memberCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatsCompanion(
            id: id,
            name: name,
            type: type,
            avatarUrl: avatarUrl,
            lastMessagePreview: lastMessagePreview,
            lastMessageType: lastMessageType,
            lastMessageTime: lastMessageTime,
            unreadCount: unreadCount,
            isPinned: isPinned,
            isMuted: isMuted,
            mentionsMe: mentionsMe,
            draft: draft,
            memberCount: memberCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> name = const Value.absent(),
            required ChatType type,
            Value<String?> avatarUrl = const Value.absent(),
            Value<String?> lastMessagePreview = const Value.absent(),
            Value<String?> lastMessageType = const Value.absent(),
            Value<DateTime?> lastMessageTime = const Value.absent(),
            Value<int> unreadCount = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isMuted = const Value.absent(),
            Value<bool> mentionsMe = const Value.absent(),
            Value<String?> draft = const Value.absent(),
            Value<int?> memberCount = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ChatsCompanion.insert(
            id: id,
            name: name,
            type: type,
            avatarUrl: avatarUrl,
            lastMessagePreview: lastMessagePreview,
            lastMessageType: lastMessageType,
            lastMessageTime: lastMessageTime,
            unreadCount: unreadCount,
            isPinned: isPinned,
            isMuted: isMuted,
            mentionsMe: mentionsMe,
            draft: draft,
            memberCount: memberCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatsTable,
    Chat,
    $$ChatsTableFilterComposer,
    $$ChatsTableOrderingComposer,
    $$ChatsTableAnnotationComposer,
    $$ChatsTableCreateCompanionBuilder,
    $$ChatsTableUpdateCompanionBuilder,
    (Chat, BaseReferences<_$AppDatabase, $ChatsTable, Chat>),
    Chat,
    PrefetchHooks Function()>;
typedef $$MessagesTableCreateCompanionBuilder = MessagesCompanion Function({
  required String clientId,
  required String senderId,
  required String receiverId,
  Value<String?> serverId,
  required int createTime,
  required int sendTime,
  required int seq,
  required int msgType,
  required int contentType,
  required String content,
  Value<bool> isRead,
  Value<String?> groupId,
  required int platform,
  Value<String?> relatedMsgId,
  Value<int?> sendSeq,
  required String conversationId,
  Value<bool> isSelf,
  Value<int> status,
  Value<String?> localPath,
  Value<String?> remoteUrl,
  Value<String?> extra,
  Value<int?> deletedTime,
  Value<bool> isDeleted,
  required int updatedTime,
  Value<int> rowid,
});
typedef $$MessagesTableUpdateCompanionBuilder = MessagesCompanion Function({
  Value<String> clientId,
  Value<String> senderId,
  Value<String> receiverId,
  Value<String?> serverId,
  Value<int> createTime,
  Value<int> sendTime,
  Value<int> seq,
  Value<int> msgType,
  Value<int> contentType,
  Value<String> content,
  Value<bool> isRead,
  Value<String?> groupId,
  Value<int> platform,
  Value<String?> relatedMsgId,
  Value<int?> sendSeq,
  Value<String> conversationId,
  Value<bool> isSelf,
  Value<int> status,
  Value<String?> localPath,
  Value<String?> remoteUrl,
  Value<String?> extra,
  Value<int?> deletedTime,
  Value<bool> isDeleted,
  Value<int> updatedTime,
  Value<int> rowid,
});

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senderId => $composableBuilder(
      column: $table.senderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiverId => $composableBuilder(
      column: $table.receiverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sendTime => $composableBuilder(
      column: $table.sendTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get seq => $composableBuilder(
      column: $table.seq, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get msgType => $composableBuilder(
      column: $table.msgType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedMsgId => $composableBuilder(
      column: $table.relatedMsgId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sendSeq => $composableBuilder(
      column: $table.sendSeq, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conversationId => $composableBuilder(
      column: $table.conversationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelf => $composableBuilder(
      column: $table.isSelf, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedTime => $composableBuilder(
      column: $table.updatedTime, builder: (column) => ColumnFilters(column));
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senderId => $composableBuilder(
      column: $table.senderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiverId => $composableBuilder(
      column: $table.receiverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sendTime => $composableBuilder(
      column: $table.sendTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get seq => $composableBuilder(
      column: $table.seq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get msgType => $composableBuilder(
      column: $table.msgType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedMsgId => $composableBuilder(
      column: $table.relatedMsgId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sendSeq => $composableBuilder(
      column: $table.sendSeq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conversationId => $composableBuilder(
      column: $table.conversationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelf => $composableBuilder(
      column: $table.isSelf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedTime => $composableBuilder(
      column: $table.updatedTime, builder: (column) => ColumnOrderings(column));
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get receiverId => $composableBuilder(
      column: $table.receiverId, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<int> get sendTime =>
      $composableBuilder(column: $table.sendTime, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<int> get msgType =>
      $composableBuilder(column: $table.msgType, builder: (column) => column);

  GeneratedColumn<int> get contentType => $composableBuilder(
      column: $table.contentType, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<int> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get relatedMsgId => $composableBuilder(
      column: $table.relatedMsgId, builder: (column) => column);

  GeneratedColumn<int> get sendSeq =>
      $composableBuilder(column: $table.sendSeq, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
      column: $table.conversationId, builder: (column) => column);

  GeneratedColumn<bool> get isSelf =>
      $composableBuilder(column: $table.isSelf, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get extra =>
      $composableBuilder(column: $table.extra, builder: (column) => column);

  GeneratedColumn<int> get deletedTime => $composableBuilder(
      column: $table.deletedTime, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<int> get updatedTime => $composableBuilder(
      column: $table.updatedTime, builder: (column) => column);
}

class $$MessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
    Message,
    PrefetchHooks Function()> {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientId = const Value.absent(),
            Value<String> senderId = const Value.absent(),
            Value<String> receiverId = const Value.absent(),
            Value<String?> serverId = const Value.absent(),
            Value<int> createTime = const Value.absent(),
            Value<int> sendTime = const Value.absent(),
            Value<int> seq = const Value.absent(),
            Value<int> msgType = const Value.absent(),
            Value<int> contentType = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<int> platform = const Value.absent(),
            Value<String?> relatedMsgId = const Value.absent(),
            Value<int?> sendSeq = const Value.absent(),
            Value<String> conversationId = const Value.absent(),
            Value<bool> isSelf = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            Value<int?> deletedTime = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<int> updatedTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MessagesCompanion(
            clientId: clientId,
            senderId: senderId,
            receiverId: receiverId,
            serverId: serverId,
            createTime: createTime,
            sendTime: sendTime,
            seq: seq,
            msgType: msgType,
            contentType: contentType,
            content: content,
            isRead: isRead,
            groupId: groupId,
            platform: platform,
            relatedMsgId: relatedMsgId,
            sendSeq: sendSeq,
            conversationId: conversationId,
            isSelf: isSelf,
            status: status,
            localPath: localPath,
            remoteUrl: remoteUrl,
            extra: extra,
            deletedTime: deletedTime,
            isDeleted: isDeleted,
            updatedTime: updatedTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientId,
            required String senderId,
            required String receiverId,
            Value<String?> serverId = const Value.absent(),
            required int createTime,
            required int sendTime,
            required int seq,
            required int msgType,
            required int contentType,
            required String content,
            Value<bool> isRead = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            required int platform,
            Value<String?> relatedMsgId = const Value.absent(),
            Value<int?> sendSeq = const Value.absent(),
            required String conversationId,
            Value<bool> isSelf = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            Value<int?> deletedTime = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            required int updatedTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              MessagesCompanion.insert(
            clientId: clientId,
            senderId: senderId,
            receiverId: receiverId,
            serverId: serverId,
            createTime: createTime,
            sendTime: sendTime,
            seq: seq,
            msgType: msgType,
            contentType: contentType,
            content: content,
            isRead: isRead,
            groupId: groupId,
            platform: platform,
            relatedMsgId: relatedMsgId,
            sendSeq: sendSeq,
            conversationId: conversationId,
            isSelf: isSelf,
            status: status,
            localPath: localPath,
            remoteUrl: remoteUrl,
            extra: extra,
            deletedTime: deletedTime,
            isDeleted: isDeleted,
            updatedTime: updatedTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
    Message,
    PrefetchHooks Function()>;
typedef $$SeqsTableCreateCompanionBuilder = SeqsCompanion Function({
  required String userId,
  Value<int> localSeq,
  Value<int> sendSeq,
  Value<int> lastSyncTime,
  Value<int> rowid,
});
typedef $$SeqsTableUpdateCompanionBuilder = SeqsCompanion Function({
  Value<String> userId,
  Value<int> localSeq,
  Value<int> sendSeq,
  Value<int> lastSyncTime,
  Value<int> rowid,
});

class $$SeqsTableFilterComposer extends Composer<_$AppDatabase, $SeqsTable> {
  $$SeqsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get localSeq => $composableBuilder(
      column: $table.localSeq, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sendSeq => $composableBuilder(
      column: $table.sendSeq, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastSyncTime => $composableBuilder(
      column: $table.lastSyncTime, builder: (column) => ColumnFilters(column));
}

class $$SeqsTableOrderingComposer extends Composer<_$AppDatabase, $SeqsTable> {
  $$SeqsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get localSeq => $composableBuilder(
      column: $table.localSeq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sendSeq => $composableBuilder(
      column: $table.sendSeq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastSyncTime => $composableBuilder(
      column: $table.lastSyncTime,
      builder: (column) => ColumnOrderings(column));
}

class $$SeqsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeqsTable> {
  $$SeqsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get localSeq =>
      $composableBuilder(column: $table.localSeq, builder: (column) => column);

  GeneratedColumn<int> get sendSeq =>
      $composableBuilder(column: $table.sendSeq, builder: (column) => column);

  GeneratedColumn<int> get lastSyncTime => $composableBuilder(
      column: $table.lastSyncTime, builder: (column) => column);
}

class $$SeqsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SeqsTable,
    Seq,
    $$SeqsTableFilterComposer,
    $$SeqsTableOrderingComposer,
    $$SeqsTableAnnotationComposer,
    $$SeqsTableCreateCompanionBuilder,
    $$SeqsTableUpdateCompanionBuilder,
    (Seq, BaseReferences<_$AppDatabase, $SeqsTable, Seq>),
    Seq,
    PrefetchHooks Function()> {
  $$SeqsTableTableManager(_$AppDatabase db, $SeqsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeqsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeqsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeqsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> userId = const Value.absent(),
            Value<int> localSeq = const Value.absent(),
            Value<int> sendSeq = const Value.absent(),
            Value<int> lastSyncTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SeqsCompanion(
            userId: userId,
            localSeq: localSeq,
            sendSeq: sendSeq,
            lastSyncTime: lastSyncTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String userId,
            Value<int> localSeq = const Value.absent(),
            Value<int> sendSeq = const Value.absent(),
            Value<int> lastSyncTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SeqsCompanion.insert(
            userId: userId,
            localSeq: localSeq,
            sendSeq: sendSeq,
            lastSyncTime: lastSyncTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SeqsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SeqsTable,
    Seq,
    $$SeqsTableFilterComposer,
    $$SeqsTableOrderingComposer,
    $$SeqsTableAnnotationComposer,
    $$SeqsTableCreateCompanionBuilder,
    $$SeqsTableUpdateCompanionBuilder,
    (Seq, BaseReferences<_$AppDatabase, $SeqsTable, Seq>),
    Seq,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$FriendsTableTableManager get friends =>
      $$FriendsTableTableManager(_db, _db.friends);
  $$FriendRequestsTableTableManager get friendRequests =>
      $$FriendRequestsTableTableManager(_db, _db.friendRequests);
  $$FriendGroupsTableTableManager get friendGroups =>
      $$FriendGroupsTableTableManager(_db, _db.friendGroups);
  $$FriendTagsTableTableManager get friendTags =>
      $$FriendTagsTableTableManager(_db, _db.friendTags);
  $$FriendTagRelationsTableTableManager get friendTagRelations =>
      $$FriendTagRelationsTableTableManager(_db, _db.friendTagRelations);
  $$FriendInteractionsTableTableManager get friendInteractions =>
      $$FriendInteractionsTableTableManager(_db, _db.friendInteractions);
  $$FriendPrivacySettingsTableTableManager get friendPrivacySettings =>
      $$FriendPrivacySettingsTableTableManager(_db, _db.friendPrivacySettings);
  $$FriendNotesTableTableManager get friendNotes =>
      $$FriendNotesTableTableManager(_db, _db.friendNotes);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SeqsTableTableManager get seqs => $$SeqsTableTableManager(_db, _db.seqs);
}
