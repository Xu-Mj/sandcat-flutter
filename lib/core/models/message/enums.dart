// 枚举类型 - 对应服务端的Proto定义

/// 平台类型枚举
enum PlatformType {
  /// 未知平台
  unknown(-1),

  /// 移动端
  mobile(0),

  /// 桌面端
  desktop(1),

  /// iOS端（扩展值，兼容数据库）
  ios(2),

  /// 安卓端（扩展值，兼容数据库）
  android(3),

  /// Web端（扩展值，兼容数据库）
  web(4);

  /// 平台类型值
  final int value;

  /// 构造函数
  const PlatformType(this.value);

  /// 从值创建平台类型
  static PlatformType fromValue(int value) {
    return PlatformType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => PlatformType.unknown,
    );
  }
}

/// 内容类型枚举
enum ContentType {
  /// 未知类型
  unknown(-1),

  /// 文本
  text(0),

  /// 图片
  image(1),

  /// 视频
  video(2),

  /// 音频
  audio(3),

  /// 文件
  file(4),

  /// 位置
  location(5),

  /// 联系人
  contact(6),

  /// 表情
  emoji(7),

  /// 贴纸（扩展值，兼容数据库）
  sticker(8),

  /// 通话（扩展值，兼容数据库）
  call(9),

  /// 信令（扩展值，兼容数据库）
  rtcSignal(10),

  /// 自定义
  custom(100);

  /// 内容类型值
  final int value;

  /// 构造函数
  const ContentType(this.value);

  /// 从值创建内容类型
  static ContentType fromValue(int value) {
    return ContentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ContentType.unknown,
    );
  }
}

/// 好友关系状态
enum FriendshipStatus {
  pending(0),
  accepted(1),
  rejected(2),
  blacked(3),
  deleted(4);

  final int value;
  const FriendshipStatus(this.value);

  factory FriendshipStatus.fromValue(int value) {
    return FriendshipStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FriendshipStatus.pending,
    );
  }
}

/// 消息类型枚举
enum MsgType {
  /// 未知消息
  unknown(-1),

  /// 单聊消息
  singleMsg(0),

  /// 群聊消息
  groupMsg(1),

  /// 群组邀请
  groupInvitation(2),

  /// 群组邀请新成员
  groupInviteNew(3),

  /// 群组成员退出
  groupMemberExit(4),

  /// 群组移除成员
  groupRemoveMember(5),

  /// 群组解散
  groupDismiss(6),

  /// 群组解散或退出接收
  groupDismissOrExitReceived(7),

  /// 群组邀请接收
  groupInvitationReceived(8),

  /// 群组更新
  groupUpdate(9),

  /// 群组文件
  groupFile(10),

  /// 群组投票
  groupPoll(11),

  /// 群组禁言
  groupMute(12),

  /// 群组公告
  groupAnnouncement(13),

  /// 好友申请请求
  friendApplyReq(14),

  /// 好友申请响应
  friendApplyResp(15),

  /// 拉黑好友
  friendBlack(16),

  /// 删除好友
  friendDelete(17),

  /// 单聊邀请
  singleCallInvite(18),

  /// 拒绝单聊
  rejectSingleCall(19),

  /// 同意单聊
  agreeSingleCall(20),

  /// 单聊邀请未应答
  singleCallInviteNotAnswer(21),

  /// 单聊邀请取消
  singleCallInviteCancel(22),

  /// 单聊Offer
  singleCallOffer(23),

  /// 挂断
  hangup(24),

  /// 连接单聊
  connectSingleCall(25),

  /// ICE候选者
  candidate(26),

  /// 已读回执
  read(27),

  /// 消息接收响应
  msgRecResp(28),

  /// 通知消息
  notification(29),

  /// 服务消息
  service(30),

  /// 好友关系变更接收
  friendshipReceived(31);

  /// 消息类型值
  final int value;

  /// 构造函数
  const MsgType(this.value);

  /// 从值创建消息类型
  static MsgType fromValue(int value) {
    return MsgType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MsgType.unknown,
    );
  }
}

/// 单聊通话邀请类型
enum SingleCallInviteType {
  singleAudio(0),
  singleVideo(1);

  final int value;
  const SingleCallInviteType(this.value);

  factory SingleCallInviteType.fromValue(int value) {
    return SingleCallInviteType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SingleCallInviteType.singleAudio,
    );
  }
}

/// 群成员角色
enum GroupMemberRole {
  owner(0),
  admin(1),
  member(2);

  final int value;
  const GroupMemberRole(this.value);

  factory GroupMemberRole.fromValue(int value) {
    return GroupMemberRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GroupMemberRole.member,
    );
  }
}
