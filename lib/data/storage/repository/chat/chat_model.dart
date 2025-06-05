import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// 聊天类型
enum ChatType {
  /// 私聊
  private,

  /// 群聊
  group,

  /// 系统
  system,
}

/// 聊天状态
enum ChatStatus {
  /// 活跃
  active,

  /// 归档
  archived,

  /// 已删除
  deleted,

  /// 已屏蔽
  blocked,
}

/// 聊天实体
class Chat extends Equatable {
  /// UUID生成器
  static final _uuid = Uuid();

  /// 聊天ID
  final String id;

  /// 聊天类型
  final ChatType type;

  /// 聊天名称
  final String name;

  /// 聊天头像
  final String? avatar;

  /// 参与者ID列表
  final List<String> participantIds;

  /// 创建者ID
  final String createdBy;

  /// 创建时间
  final DateTime createdAt;

  /// 更新时间
  final DateTime? updatedAt;

  /// 最后一条消息
  final String? lastMessageText;

  /// 最后一条消息时间
  final DateTime? lastMessageTime;

  /// 最后一条消息发送者ID
  final String? lastMessageSenderId;

  /// 未读消息数
  final int unreadCount;

  /// 是否置顶
  final bool isPinned;

  /// 是否静音
  final bool isMuted;

  /// 聊天状态
  final ChatStatus status;

  /// 自定义数据
  final Map<String, dynamic>? metadata;

  /// 创建聊天
  const Chat({
    required this.id,
    required this.type,
    required this.name,
    this.avatar,
    required this.participantIds,
    required this.createdBy,
    required this.createdAt,
    this.updatedAt,
    this.lastMessageText,
    this.lastMessageTime,
    this.lastMessageSenderId,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isMuted = false,
    this.status = ChatStatus.active,
    this.metadata,
  });

  /// 创建一个空的聊天对象，用于orElse返回值
  factory Chat.empty() {
    return Chat(
      id: '',
      type: ChatType.private,
      name: '',
      participantIds: [],
      createdBy: '',
      createdAt: DateTime.now(),
    );
  }

  /// 创建私聊
  factory Chat.privateChat({
    required String currentUserId,
    required String peerId,
    required String peerName,
    String? peerAvatar,
    String? id,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? _uuid.v4(),
      type: ChatType.private,
      name: peerName,
      avatar: peerAvatar,
      participantIds: [currentUserId, peerId],
      createdBy: currentUserId,
      createdAt: createdAt ?? DateTime.now(),
      metadata: metadata,
    );
  }

  /// 创建群聊
  factory Chat.groupChat({
    required String name,
    required List<String> participantIds,
    required String createdBy,
    String? avatar,
    String? id,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? _uuid.v4(),
      type: ChatType.group,
      name: name,
      avatar: avatar,
      participantIds: List<String>.from(participantIds),
      createdBy: createdBy,
      createdAt: createdAt ?? DateTime.now(),
      metadata: metadata,
    );
  }

  /// 创建系统聊天
  factory Chat.systemChat({
    required String name,
    required String userId,
    String? avatar,
    String? id,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? _uuid.v4(),
      type: ChatType.system,
      name: name,
      avatar: avatar,
      participantIds: [userId],
      createdBy: 'system',
      createdAt: createdAt ?? DateTime.now(),
      metadata: metadata,
    );
  }

  /// 将聊天转换为地图
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'name': name,
      'avatar': avatar,
      'participantIds': participantIds,
      'createdBy': createdBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'lastMessageText': lastMessageText,
      'lastMessageTime': lastMessageTime?.millisecondsSinceEpoch,
      'lastMessageSenderId': lastMessageSenderId,
      'unreadCount': unreadCount,
      'isPinned': isPinned ? 1 : 0,
      'isMuted': isMuted ? 1 : 0,
      'status': status.index,
      'metadata': metadata,
    };
  }

  /// 从地图创建聊天
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      type: ChatType.values[map['type']],
      name: map['name'],
      avatar: map['avatar'],
      participantIds: List<String>.from(map['participantIds']),
      createdBy: map['createdBy'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      lastMessageText: map['lastMessageText'],
      lastMessageTime: map['lastMessageTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'])
          : null,
      lastMessageSenderId: map['lastMessageSenderId'],
      unreadCount: map['unreadCount'] ?? 0,
      isPinned: map['isPinned'] == 1,
      isMuted: map['isMuted'] == 1,
      status: ChatStatus.values[map['status'] ?? ChatStatus.active.index],
      metadata: map['metadata'],
    );
  }

  /// 将聊天转换为JSON
  Map<String, dynamic> toJson() => toMap();

  /// 从JSON创建聊天
  factory Chat.fromJson(Map<String, dynamic> json) => Chat.fromMap(json);

  /// 更新最后一条消息
  Chat updateLastMessage({
    required String text,
    required DateTime time,
    required String senderId,
    int? unreadIncrement,
  }) {
    return copyWith(
      lastMessageText: text,
      lastMessageTime: time,
      lastMessageSenderId: senderId,
      updatedAt: DateTime.now(),
      unreadCount:
          unreadIncrement != null ? unreadCount + unreadIncrement : unreadCount,
    );
  }

  /// 重置未读消息数
  Chat resetUnreadCount() {
    return copyWith(unreadCount: 0);
  }

  /// 标记为已删除
  Chat markDeleted() {
    return copyWith(status: ChatStatus.deleted);
  }

  /// 标记为已归档
  Chat markArchived() {
    return copyWith(status: ChatStatus.archived);
  }

  /// 标记为已屏蔽
  Chat markBlocked() {
    return copyWith(status: ChatStatus.blocked);
  }

  /// 标记为活跃
  Chat markActive() {
    return copyWith(status: ChatStatus.active);
  }

  /// 切换置顶状态
  Chat togglePinned() {
    return copyWith(isPinned: !isPinned);
  }

  /// 切换静音状态
  Chat toggleMuted() {
    return copyWith(isMuted: !isMuted);
  }

  /// 添加参与者
  Chat addParticipant(String userId) {
    if (participantIds.contains(userId)) {
      return this;
    }

    final newParticipantIds = List<String>.from(participantIds)..add(userId);

    return copyWith(
      participantIds: newParticipantIds,
      updatedAt: DateTime.now(),
    );
  }

  /// 移除参与者
  Chat removeParticipant(String userId) {
    if (!participantIds.contains(userId)) {
      return this;
    }

    final newParticipantIds = List<String>.from(participantIds)..remove(userId);

    return copyWith(
      participantIds: newParticipantIds,
      updatedAt: DateTime.now(),
    );
  }

  /// 复制聊天，并应用修改
  Chat copyWith({
    String? id,
    ChatType? type,
    String? name,
    String? avatar,
    List<String>? participantIds,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? lastMessageText,
    DateTime? lastMessageTime,
    String? lastMessageSenderId,
    int? unreadCount,
    bool? isPinned,
    bool? isMuted,
    ChatStatus? status,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      participantIds: participantIds ?? this.participantIds,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        avatar,
        participantIds,
        createdBy,
        createdAt,
        updatedAt,
        lastMessageText,
        lastMessageTime,
        lastMessageSenderId,
        unreadCount,
        isPinned,
        isMuted,
        status,
        metadata,
      ];

  @override
  String toString() {
    return 'Chat(id: $id, type: $type, name: $name, '
        'participantIds: $participantIds, status: $status)';
  }
}
