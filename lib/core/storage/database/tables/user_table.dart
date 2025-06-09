// lib/core/storage/database/tables/user_table.dart

import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get name => text().withLength(min: 1)();
  TextColumn get account => text()();
  TextColumn get signature => text().nullable()();
  TextColumn get avatar => text()();
  TextColumn get gender => text()();
  IntColumn get age => integer().withDefault(const Constant(0))();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get region => text().nullable()();
  Column<int> get birthday => integer().nullable()();
  Column<int> get createTime => integer()();
  Column<int> get updateTime => integer()();

  // 账号与安全
  Column<BigInt> get lastLoginTime => int64().nullable()();
  TextColumn get lastLoginIp => text().nullable()();
  BoolColumn get twoFactorEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get accountStatus =>
      text().withDefault(const Constant('active'))();

  // 在线状态管理
  TextColumn get status => text().withDefault(const Constant('offline'))();
  Column<int> get lastActiveTime => integer().nullable()();
  TextColumn get statusMessage => text().nullable()();

  // 隐私与设置
  TextColumn get privacySettings => text().withDefault(const Constant('{}'))();
  TextColumn get notificationSettings =>
      text().withDefault(const Constant('{}'))();
  TextColumn get language => text().withDefault(const Constant('zh_CN'))();

  // 社交与关系
  TextColumn get friendRequestsPrivacy =>
      text().withDefault(const Constant('all'))();
  TextColumn get profileVisibility =>
      text().withDefault(const Constant('public'))();

  // 用户体验
  TextColumn get theme => text().withDefault(const Constant('system'))();
  TextColumn get timezone =>
      text().withDefault(const Constant('Asia/Shanghai'))();

  BoolColumn get isDelete => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
