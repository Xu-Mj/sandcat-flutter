import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/services/logger_service.dart';

/// 序列号数据访问对象
@injectable
class SeqDao {
  final AppDatabase _db;

  SeqDao(this._db);

  /// 获取用户序列号
  /// 如果不存在则创建一个默认值
  Future<Map<String, dynamic>?> getSeqForUser(String userId) async {
    try {
      // 使用生成的表访问对象
      final query = _db.select(_db.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      final result = await query.getSingleOrNull();

      if (result != null) {
        // 将Drift生成的数据对象转换为Map
        return {
          'userId': result.userId,
          'localSeq': result.localSeq,
          'sendSeq': result.sendSeq,
          'lastSyncTime': result.lastSyncTime,
        };
      } else {
        // 不存在则创建一个新的序列号记录
        final lastSyncTime = DateTime.now().millisecondsSinceEpoch;

        await _db.into(_db.seqs).insert(
              SeqsCompanion.insert(
                userId: userId,
                localSeq: const Value(0),
                sendSeq: const Value(0),
                lastSyncTime: Value(lastSyncTime),
              ),
            );

        // 返回新创建的对象
        return {
          'userId': userId,
          'localSeq': 0,
          'sendSeq': 0,
          'lastSyncTime': lastSyncTime,
        };
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
      final updateStatement = _db.update(_db.seqs)
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
      final updateStatement = _db.update(_db.seqs)
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
      final query = _db.select(_db.seqs)
        ..where((tbl) => tbl.userId.equals(userId));

      final seqData = await query.getSingleOrNull();
      return seqData?.lastSyncTime ?? 0;
    } catch (e) {
      log.e('获取最后同步时间失败', error: e, tag: 'SeqDao');
      return 0;
    }
  }
}
