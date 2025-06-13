import 'package:drift/drift.dart';

// 好友请求状态枚举
class FriendRequestStatus {
  static const String pending = 'Pending';
  static const String accepted = 'Accepted';
  static const String rejected = 'Rejected';
  static const String blacked = 'Blacked';
  static const String deleted = 'Deleted';
  static const String muted = 'Muted';
  static const String hidden = 'Hidden';
}

// 好友表定义 - 对应服务端的friends表
class Friends extends Table {
  // 关联的好友关系ID
  TextColumn get fsId => text()();

  // 用户ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();
  TextColumn get name => text()();
  TextColumn get avatar => text()();
  TextColumn get gender => text()();
  IntColumn get age => integer()();
  TextColumn get region => text().nullable()();
  // 好友邮箱
  TextColumn get email => text()();

  // 好友状态
  TextColumn get status =>
      text().withDefault(const Constant(FriendRequestStatus.accepted))();

  // 备注
  TextColumn get remark => text().nullable()();

  // 来源
  TextColumn get source => text().nullable()();

  // 创建时间
  IntColumn get createTime => integer()();

  // 更新时间
  IntColumn get updateTime => integer()();

  // 删除时间
  IntColumn get deletedTime => integer().nullable()();

  // 是否星标好友
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();

  // 所属分组ID
  IntColumn get groupId => integer().nullable()();

  // 优先级
  IntColumn get priority => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {fsId};
}

// 好友申请表 - 对应服务端的friendships表
class FriendRequests extends Table {
  // 主键
  TextColumn get id => text()();

  // 发起人ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();
  TextColumn get name => text()();
  TextColumn get avatar => text()();
  TextColumn get gender => text()();
  IntColumn get age => integer()();
  TextColumn get region => text().nullable()();

  // 请求状态
  TextColumn get status =>
      text().withDefault(const Constant(FriendRequestStatus.pending))();

  // 申请消息
  TextColumn get applyMsg => text().nullable()();

  // 请求者备注
  TextColumn get reqRemark => text().nullable()();

  // 响应消息
  TextColumn get respMsg => text().nullable()();

  // 响应者备注
  TextColumn get respRemark => text().nullable()();

  // 来源
  TextColumn get source => text().nullable()();

  // 创建时间
  IntColumn get createTime => integer()();

  // 更新时间
  IntColumn get updateTime => integer().nullable()();

  // 操作者ID
  TextColumn get operatorId => text().nullable()();

  // 最后一次操作类型
  TextColumn get lastOperation => text().nullable()();

  // 删除时间
  IntColumn get deletedTime => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 好友分组表 - 对应服务端的friend_groups表
class FriendGroups extends Table {
  // 主键
  IntColumn get id => integer().autoIncrement()();

  // 用户ID
  TextColumn get userId => text()();

  // 分组名称
  TextColumn get name => text()();

  // 创建时间
  IntColumn get createTime => integer()();

  // 更新时间
  IntColumn get updateTime => integer()();

  // 排序顺序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  // 分组图标
  TextColumn get icon => text().nullable()();
}

// 好友标签表 - 对应服务端的friend_tags表
class FriendTags extends Table {
  // 主键
  IntColumn get id => integer().autoIncrement()();

  // 用户ID
  TextColumn get userId => text()();

  // 标签名称
  TextColumn get name => text()();

  // 标签颜色
  TextColumn get color => text().withDefault(const Constant('#000000'))();

  // 创建时间
  IntColumn get createTime => integer()();

  // 标签图标
  TextColumn get icon => text().nullable()();

  // 排序顺序
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

// 好友-标签关联表 - 对应服务端的friend_tag_relations表
class FriendTagRelations extends Table {
  // 用户ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();

  // 标签ID
  IntColumn get tagId => integer()();

  // 创建时间
  IntColumn get createTime => integer()();

  @override
  Set<Column> get primaryKey => {userId, friendId, tagId};
}

// 好友互动统计表 - 对应服务端的friend_interactions表
class FriendInteractions extends Table {
  // 用户ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();

  // 消息数量
  IntColumn get messageCount => integer().withDefault(const Constant(0))();

  // 最后互动时间
  IntColumn get lastInteractTime => integer().nullable()();

  // 通话总时长(秒)
  IntColumn get totalDuration => integer().withDefault(const Constant(0))();

  // 通话次数
  IntColumn get callCount => integer().withDefault(const Constant(0))();

  // 互动亲密度评分
  RealColumn get interactionScore => real().withDefault(const Constant(0.0))();

  // 最近一周互动次数
  IntColumn get lastWeekCount => integer().withDefault(const Constant(0))();

  // 最近一月互动次数
  IntColumn get lastMonthCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId, friendId};
}

// 好友隐私设置表 - 对应服务端的friend_privacy_settings表
class FriendPrivacySettings extends Table {
  // 用户ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();

  // 是否可见朋友圈
  BoolColumn get canSeeMoments => boolean().withDefault(const Constant(true))();

  // 是否可见在线状态
  BoolColumn get canSeeOnlineStatus =>
      boolean().withDefault(const Constant(true))();

  // 是否可见位置
  BoolColumn get canSeeLocation =>
      boolean().withDefault(const Constant(true))();

  // 是否可见共同好友
  BoolColumn get canSeeMutualFriends =>
      boolean().withDefault(const Constant(true))();

  // 权限级别
  TextColumn get permissionLevel =>
      text().withDefault(const Constant('full_access'))();

  // 自定义设置JSON
  TextColumn get customSettings => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {userId, friendId};
}

// 好友备忘录表 - 对应服务端的friend_notes表
class FriendNotes extends Table {
  // 用户ID
  TextColumn get userId => text()();

  // 好友ID
  TextColumn get friendId => text()();

  // 内容
  TextColumn get content => text()();

  // 创建时间
  IntColumn get createTime => integer()();

  // 更新时间
  IntColumn get updateTime => integer()();

  // 是否置顶
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {userId, friendId};
}
