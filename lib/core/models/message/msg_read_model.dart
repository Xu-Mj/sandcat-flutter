/// 消息已读模型 - 对应服务端的MsgRead结构
class MsgReadModel {
  /// 消息ID列表
  final List<String> msgIds;

  /// 最后读取的消息ID
  final String lastMsgId;

  /// 最后读取的消息序号
  final int lastSeq;

  /// 构造函数
  MsgReadModel({
    required this.msgIds,
    this.lastMsgId = '',
    this.lastSeq = 0,
  });

  /// 从JSON创建模型
  factory MsgReadModel.fromJson(Map<String, dynamic> json) {
    final msgIdsJson = json['msg_ids'] as List<dynamic>?;
    return MsgReadModel(
      msgIds: msgIdsJson != null ? msgIdsJson.cast<String>() : [],
      lastMsgId: json['last_msg_id'] as String? ?? '',
      lastSeq: json['last_seq'] as int? ?? 0,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'msg_ids': msgIds,
      'last_msg_id': lastMsgId,
      'last_seq': lastSeq,
    };
  }

  /// 创建消息已读模型的副本
  MsgReadModel copyWith(
      {List<String>? msgIds, String? lastMsgId, int? lastSeq}) {
    return MsgReadModel(
      msgIds: msgIds ?? this.msgIds,
      lastMsgId: lastMsgId ?? this.lastMsgId,
      lastSeq: lastSeq ?? this.lastSeq,
    );
  }
}
