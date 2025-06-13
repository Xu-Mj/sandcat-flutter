import 'package:sandcat/core/models/seq/seq_model.dart';
import 'package:sandcat/core/protos/generated/common.pb.dart';

/// 消息API接口
abstract class MsgApi {
  /// 拉取离线消息
  ///
  /// [userId] 用户ID
  /// [sendStart] 发送开始序列号
  /// [sendEnd] 发送结束序列号
  /// [start] 接收开始序列号
  /// [end] 接收结束序列号
  Future<List<Msg>> pullOfflineMessages({
    required String userId,
    int? sendStart,
    int? sendEnd,
    int? start,
    int? end,
  });

  /// 获取用户当前序列号
  ///
  /// [userId] 用户ID
  Future<SeqModel> getSequence(String userId);

  /// 删除消息
  ///
  /// [userId] 用户ID
  /// [messageIds] 消息ID列表
  Future<void> deleteMessages({
    required String userId,
    required List<String> messageIds,
  });
}
