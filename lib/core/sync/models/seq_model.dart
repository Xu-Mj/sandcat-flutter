import 'package:freezed_annotation/freezed_annotation.dart';

part 'seq_model.g.dart';
part 'seq_model.freezed.dart';

/// 序列号模型
@freezed
class SeqModel with _$SeqModel {
  const factory SeqModel({
    /// 接收消息的序列号
    required int seq,

    /// 发送消息的序列号
    required int sendSeq,
  }) = _SeqModel;

  /// 从JSON创建
  factory SeqModel.fromJson(Map<String, dynamic> json) =>
      _$SeqModelFromJson(json);
}

/// 自定义JSON序列化帮助函数
extension SeqModelX on SeqModel {
  /// 将数据库模型转换为API模型
  static SeqModel? fromMap(Map<String, dynamic>? json) {
    if (json == null) return null;

    return SeqModel(
      seq: json['seq'] as int? ?? 0,
      sendSeq: json['send_seq'] as int? ?? 0,
    );
  }
}
