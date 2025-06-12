import 'package:drift/drift.dart';

/// 序列号表，用于消息同步
class Seqs extends Table {
  /// 用户ID，作为主键
  TextColumn get userId => text()();

  /// 接收消息的序列号
  IntColumn get localSeq => integer().withDefault(const Constant(0))();

  /// 发送消息的序列号
  IntColumn get sendSeq => integer().withDefault(const Constant(0))();

  /// 最后同步时间
  IntColumn get lastSyncTime => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId};
}
