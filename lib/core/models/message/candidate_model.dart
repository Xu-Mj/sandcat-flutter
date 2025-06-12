/// WebRTC候选人模型 - 对应服务端的ICE候选结构
class CandidateModel {
  /// 候选人SDP信息
  final String sdpMid;

  /// 候选人SDP行索引
  final int sdpMLineIndex;

  /// 候选人SDP
  final String sdp;

  /// 构造函数
  CandidateModel({
    required this.sdpMid,
    required this.sdpMLineIndex,
    required this.sdp,
  });

  /// 从JSON创建模型
  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return CandidateModel(
      sdpMid: json['sdp_mid'] as String? ?? '',
      sdpMLineIndex: json['sdp_m_line_index'] as int? ?? 0,
      sdp: json['sdp'] as String? ?? '',
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'sdp_mid': sdpMid,
      'sdp_m_line_index': sdpMLineIndex,
      'sdp': sdp,
    };
  }
}
