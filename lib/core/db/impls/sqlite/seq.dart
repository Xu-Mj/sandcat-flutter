import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/services/logger_service.dart';

/// 序列号数据访问对象
@injectable
class SeqDao {
  final DatabaseFactory _databaseFactory;
  AppDatabase get _database => _databaseFactory();

  SeqDao(this._databaseFactory);

  /// 获取用户序列号
  /// 如果不存在则创建一个默认值
  Future<Seq?> getSeqForUser(String userId) async {
    try {
      // 使用生成的表访问对象
      final query = _database.select(_database.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      final result = await query.getSingleOrNull();

      if (result != null) {
        // 将Drift生成的数据对象转换为Map
        return result;
      } else {
        // 不存在则创建一个新的序列号记录
        final lastSyncTime = DateTime.now().millisecondsSinceEpoch;

        final seq = Seq(
          userId: userId,
          localSeq: 0,
          sendSeq: 0,
          lastSyncTime: lastSyncTime,
        );

        await _database.into(_database.seqs).insert(seq);

        // 返回新创建的对象
        return seq;
      }
    } catch (e) {
      log.e('获取用户序列号失败', error: e, tag: 'SeqDao');
      // 出错时返回null
      return null;
    }
  }

  /// 更新序列号
  Future<bool> updateSeq(String userId, int localSeq, int sendSeq) async {
    try {
      final updateStatement = _database.update(_database.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      await updateStatement.write(
        SeqsCompanion(
          localSeq: Value(localSeq),
          sendSeq: Value(sendSeq),
          lastSyncTime: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
      return true;
    } catch (e) {
      log.e('更新序列号失败', error: e, tag: 'SeqDao');
      return false;
    }
  }

  /// 更新最后同步时间
  Future<bool> updateLastSyncTime(String userId) async {
    try {
      final updateStatement = _database.update(_database.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      await updateStatement.write(
        SeqsCompanion(
          lastSyncTime: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );
      return true;
    } catch (e) {
      log.e('更新最后同步时间失败', error: e, tag: 'SeqDao');
      return false;
    }
  }

  /// 获取最后同步时间
  Future<int> getLastSyncTime(String userId) async {
    try {
      final query = _database.select(_database.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      final seqData = await query.getSingleOrNull();
      return seqData?.lastSyncTime ?? 0;
    } catch (e) {
      log.e('获取最后同步时间失败', error: e, tag: 'SeqDao');
      return 0;
    }
  }
}
