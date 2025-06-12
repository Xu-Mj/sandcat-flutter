// lib/features/chat/data/dao/test_data.dart
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/db/tables/chat_table.dart';
import 'package:drift/drift.dart';
import 'package:im_flutter/ui/chat/data/dao/chat_dao.dart';

class TestDataHelper {
  final ChatDao _chatDao;

  TestDataHelper(this._chatDao);

  /// 添加测试数据到数据库
  Future<void> insertTestData() async {
    // 删除现有数据（可选）
    // await _chatDao.deleteAllChats();

    // 创建测试会话数据
    final testChats = [
      // 单聊 - 有未读消息，置顶
      ChatsCompanion.insert(
        id: '1',
        name: Value('张三'),
        type: ChatType.direct,
        avatarUrl: Value('https://randomuser.me/api/portraits/men/32.jpg'),
        lastMessagePreview: Value('你好，周末有空一起打球吗？'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(minutes: 5))),
        unreadCount: Value(2),
        isPinned: Value(true),
        isMuted: Value(false),
        mentionsMe: Value(false),
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),

      // 单聊 - 已读，静音
      ChatsCompanion.insert(
        id: '2',
        name: Value('李四'),
        type: ChatType.direct,
        avatarUrl: Value('https://randomuser.me/api/portraits/women/44.jpg'),
        lastMessagePreview: Value('项目进度如何了？'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(hours: 2))),
        unreadCount: Value(0),
        isPinned: Value(false),
        isMuted: Value(true),
        mentionsMe: Value(false),
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),

      // 单聊 - 有草稿
      ChatsCompanion.insert(
        id: '3',
        name: Value('王五'),
        type: ChatType.direct,
        avatarUrl: Value('https://randomuser.me/api/portraits/men/46.jpg'),
        lastMessagePreview: Value('明天下午开会记得带上材料'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(days: 1))),
        unreadCount: Value(0),
        isPinned: Value(false),
        isMuted: Value(false),
        draft: Value('关于那个项目的事情，我想说'),
        mentionsMe: Value(false),
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),

      // 群聊 - 有@我，未读消息多
      ChatsCompanion.insert(
        id: '4',
        name: Value('项目讨论组'),
        type: ChatType.group,
        avatarUrl: Value(
            '[{"url":"https://randomuser.me/api/portraits/men/32.jpg"},{"url":"https://randomuser.me/api/portraits/women/44.jpg"},{"url":"https://randomuser.me/api/portraits/men/46.jpg"}]'),
        lastMessagePreview: Value('@我 请查看最新的设计文档'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(minutes: 30))),
        unreadCount: Value(15),
        isPinned: Value(true),
        isMuted: Value(false),
        mentionsMe: Value(true),
        memberCount: Value(8),
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),

      // 群聊 - 已读，置顶
      ChatsCompanion.insert(
        id: '5',
        name: Value('家庭群'),
        type: ChatType.group,
        avatarUrl: Value(
            '[{"url":"https://randomuser.me/api/portraits/women/22.jpg"},{"url":"https://randomuser.me/api/portraits/men/33.jpg"},{"url":"https://randomuser.me/api/portraits/women/55.jpg"},{"url":"https://randomuser.me/api/portraits/men/65.jpg"}]'),
        lastMessagePreview: Value('晚上六点在老地方聚餐'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(hours: 5))),
        unreadCount: Value(0),
        isPinned: Value(true),
        isMuted: Value(false),
        mentionsMe: Value(false),
        memberCount: Value(5),
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),

      // 单聊 - 图片消息
      ChatsCompanion.insert(
        id: '6',
        name: Value('赵六'),
        type: ChatType.direct,
        avatarUrl: Value('https://randomuser.me/api/portraits/women/22.jpg'),
        lastMessagePreview: Value('[图片]'),
        lastMessageType: Value('image'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(hours: 8))),
        unreadCount: Value(1),
        isPinned: Value(false),
        isMuted: Value(false),
        mentionsMe: Value(false),
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),

      // 群聊 - 文件消息
      ChatsCompanion.insert(
        id: '7',
        name: Value('技术交流群'),
        type: ChatType.group,
        avatarUrl: Value(
            '[{"url":"https://randomuser.me/api/portraits/men/22.jpg"},{"url":"https://randomuser.me/api/portraits/men/23.jpg"},{"url":"https://randomuser.me/api/portraits/men/24.jpg"}]'),
        lastMessagePreview: Value('[文件] 产品需求文档.pdf'),
        lastMessageType: Value('file'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(days: 2))),
        unreadCount: Value(3),
        isPinned: Value(false),
        isMuted: Value(true),
        mentionsMe: Value(false),
        memberCount: Value(32),
        createdAt: DateTime.now().subtract(const Duration(days: 120)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),

      // 系统通知
      ChatsCompanion.insert(
        id: '8',
        name: Value('系统通知'),
        type: ChatType.system,
        avatarUrl: Value(''),
        lastMessagePreview: Value('您的账号已在新设备登录'),
        lastMessageType: Value('text'),
        lastMessageTime:
            Value(DateTime.now().subtract(const Duration(days: 3))),
        unreadCount: Value(1),
        isPinned: Value(false),
        isMuted: Value(false),
        mentionsMe: Value(false),
        createdAt: DateTime.now().subtract(const Duration(days: 200)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];

    // 插入测试数据
    for (final chat in testChats) {
      await _chatDao.upsertChat(chat);
    }
  }
}
