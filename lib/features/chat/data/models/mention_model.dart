/// 消息中的@提及模型
class MentionModel {
  /// 被提及用户的ID
  final String userId;

  /// 被提及用户的名称
  final String name;

  /// 提及在文本中的位置
  final int offset;

  /// 提及的长度
  final int length;

  /// 是否提及所有人（@all）
  final bool isAll;

  /// 构造函数
  MentionModel({
    required this.userId,
    required this.name,
    required this.offset,
    required this.length,
    this.isAll = false,
  });

  /// 从JSON创建模型
  factory MentionModel.fromJson(Map<String, dynamic> json) {
    return MentionModel(
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      offset: json['offset'] ?? 0,
      length: json['length'] ?? 0,
      isAll: json['is_all'] ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'offset': offset,
      'length': length,
      'is_all': isAll,
    };
  }

  /// 创建@所有人的提及
  factory MentionModel.all(int offset) {
    return MentionModel(
      userId: 'all',
      name: '所有人',
      offset: offset,
      length: 3, // "@all" 的长度
      isAll: true,
    );
  }

  /// 创建消息提及的副本
  MentionModel copyWith({
    String? userId,
    String? name,
    int? offset,
    int? length,
    bool? isAll,
  }) {
    return MentionModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      offset: offset ?? this.offset,
      length: length ?? this.length,
      isAll: isAll ?? this.isAll,
    );
  }
}
