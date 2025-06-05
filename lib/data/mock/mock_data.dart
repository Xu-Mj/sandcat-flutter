import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../storage/repository/user/user_model.dart';
import '../storage/repository/chat/chat_model.dart';
import '../storage/repository/message/message_model.dart';

/// 模拟数据提供者
class MockDataProvider {
  // 单例实例
  static final MockDataProvider _instance = MockDataProvider._internal();
  static MockDataProvider get instance => _instance;
  MockDataProvider._internal();

  // 当前登录用户ID
  static const String currentUserId = 'user_current';

  // 用户数据
  final Map<String, User> users = {
    // 当前用户
    currentUserId: User.create(
      id: currentUserId,
      username: 'xiaoming',
      displayName: '小明',
      avatarUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      bio: '我是小明，喜欢编程和旅行',
      metadata: {
        'phone': '13800138000',
        'email': 'xiaoming@example.com',
      },
    ),

    // 回声机器人
    'user_bot': User.create(
      id: 'user_bot',
      username: 'echobot',
      displayName: '回声机器人',
      avatarUrl: 'https://robohash.org/echobot?set=set3',
      bio: '我是回声机器人，我会重复你说的话',
    ),

    // 好友用户
    'user_1': User.create(
      id: 'user_1',
      username: 'lisi',
      displayName: '李四',
      avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      bio: '工作忙，很少回复',
    ),
    'user_2': User.create(
      id: 'user_2',
      username: 'wangwu',
      displayName: '王五',
      avatarUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
      bio: '热爱生活，享受当下',
    ),
    'user_3': User.create(
      id: 'user_3',
      username: 'zhaoliu',
      displayName: '赵六',
      avatarUrl: 'https://randomuser.me/api/portraits/men/34.jpg',
      bio: '无聊时随时找我聊天',
    ),
    'user_4': User.create(
      id: 'user_4',
      username: 'xiaoqian',
      displayName: '小倩',
      avatarUrl: 'https://randomuser.me/api/portraits/women/32.jpg',
      bio: '设计师，处女座，完美主义者',
    ),
    'user_5': User.create(
      id: 'user_5',
      username: 'xiaohong',
      displayName: '小红',
      avatarUrl: 'https://randomuser.me/api/portraits/women/33.jpg',
      bio: '不闲聊，有事说事',
    ),
  };

  // 聊天数据
  final Map<String, Chat> chats = {
    // 回声机器人聊天
    'chat_bot': Chat(
      id: 'chat_bot',
      type: ChatType.private,
      name: '回声机器人',
      avatar: 'https://robohash.org/echobot?set=set3',
      participantIds: [currentUserId, 'user_bot'],
      createdBy: currentUserId,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastMessageText: '你好，我是回声机器人，发送消息我会回复相同内容',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      lastMessageSenderId: 'user_bot',
      unreadCount: 1,
    ),

    // 私聊会话
    'chat_1': Chat(
      id: 'chat_1',
      type: ChatType.private,
      name: '李四',
      avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
      participantIds: [currentUserId, 'user_1'],
      createdBy: currentUserId,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      lastMessageText: '好的，我们明天再讨论这个问题',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      lastMessageSenderId: 'user_1',
      unreadCount: 0,
    ),
    'chat_2': Chat(
      id: 'chat_2',
      type: ChatType.private,
      name: '王五',
      avatar: 'https://randomuser.me/api/portraits/men/33.jpg',
      participantIds: [currentUserId, 'user_2'],
      createdBy: 'user_2',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      lastMessageText: '周末一起去打球吧？',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
      lastMessageSenderId: 'user_2',
      unreadCount: 3,
    ),
    'chat_3': Chat(
      id: 'chat_3',
      type: ChatType.private,
      name: '小倩',
      avatar: 'https://randomuser.me/api/portraits/women/32.jpg',
      participantIds: [currentUserId, 'user_4'],
      createdBy: currentUserId,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      lastMessageText: '设计稿我已经发给你了，看一下',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      lastMessageSenderId: 'user_4',
      unreadCount: 0,
      isPinned: true,
    ),

    // 群聊会话
    'group_1': Chat(
      id: 'group_1',
      type: ChatType.group,
      name: '家庭群',
      avatar: 'https://randomuser.me/api/portraits/women/33.jpg',
      participantIds: [currentUserId, 'user_1', 'user_2', 'user_4'],
      createdBy: currentUserId,
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
      lastMessageText: '小明：今天晚上我会晚点回家',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
      lastMessageSenderId: currentUserId,
      unreadCount: 0,
    ),
    'group_2': Chat(
      id: 'group_2',
      type: ChatType.group,
      name: '工作项目组',
      avatar: 'https://randomuser.me/api/portraits/women/34.jpg',
      participantIds: [currentUserId, 'user_2', 'user_3', 'user_5'],
      createdBy: 'user_2',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      lastMessageText: '赵六：明天早上9点开会讨论项目进度',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 3)),
      lastMessageSenderId: 'user_3',
      unreadCount: 5,
      isPinned: true,
    ),
    'group_3': Chat(
      id: 'group_3',
      type: ChatType.group,
      name: '同学会',
      avatar: 'https://randomuser.me/api/portraits/women/35.jpg',
      participantIds: [currentUserId, 'user_1', 'user_3', 'user_4', 'user_5'],
      createdBy: 'user_1',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      lastMessageText: '小红：下个月初我们组织一次同学聚会如何？',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      lastMessageSenderId: 'user_5',
      unreadCount: 0,
      isMuted: true,
    ),
  };

  // 消息数据
  final Map<String, List<Message>> messages = {};

  // 初始化消息数据
  void initializeMessages() {
    // 回声机器人的聊天记录
    messages['chat_bot'] = [
      Message.system(
        chatId: 'chat_bot',
        content: '欢迎与回声机器人聊天！我会重复你发送的任何消息。',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Message.text(
        id: 'msg_bot_1',
        chatId: 'chat_bot',
        senderId: currentUserId,
        recipientId: 'user_bot',
        content: '你好，机器人！',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      ),
      Message.text(
        id: 'msg_bot_2',
        chatId: 'chat_bot',
        senderId: 'user_bot',
        recipientId: currentUserId,
        content: '你好，机器人！',
        status: MessageStatus.delivered,
        createdAt: DateTime.now()
            .subtract(const Duration(days: 2, hours: 1, minutes: 1)),
      ),
      Message.text(
        id: 'msg_bot_3',
        chatId: 'chat_bot',
        senderId: currentUserId,
        recipientId: 'user_bot',
        content: '你能做什么？',
        status: MessageStatus.read,
        createdAt:
            DateTime.now().subtract(const Duration(days: 1, minutes: 30)),
      ),
      Message.text(
        id: 'msg_bot_4',
        chatId: 'chat_bot',
        senderId: 'user_bot',
        recipientId: currentUserId,
        content: '你能做什么？',
        status: MessageStatus.delivered,
        createdAt:
            DateTime.now().subtract(const Duration(days: 1, minutes: 29)),
      ),
      Message.text(
        id: 'msg_bot_5',
        chatId: 'chat_bot',
        senderId: currentUserId,
        recipientId: 'user_bot',
        content: '这只是个演示功能',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Message.text(
        id: 'msg_bot_6',
        chatId: 'chat_bot',
        senderId: 'user_bot',
        recipientId: currentUserId,
        content: '这只是个演示功能',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      Message.text(
        id: 'msg_bot_7',
        chatId: 'chat_bot',
        senderId: 'user_bot',
        recipientId: currentUserId,
        content: '你好，我是回声机器人，发送消息我会回复相同内容',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];

    // 私聊消息记录 - 李四
    messages['chat_1'] = [
      Message.system(
        chatId: 'chat_1',
        content: '你已经添加了李四，现在可以开始聊天了',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      Message.text(
        id: 'msg_1_1',
        chatId: 'chat_1',
        senderId: currentUserId,
        recipientId: 'user_1',
        content: '李四，那个项目进展如何了？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
      ),
      Message.text(
        id: 'msg_1_2',
        chatId: 'chat_1',
        senderId: 'user_1',
        recipientId: currentUserId,
        content: '进展还不错，预计下周能完成初稿',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
      ),
      Message.text(
        id: 'msg_1_3',
        chatId: 'chat_1',
        senderId: currentUserId,
        recipientId: 'user_1',
        content: '好的，到时我们再详细讨论一下',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 14)),
      ),
      Message.text(
        id: 'msg_1_4',
        chatId: 'chat_1',
        senderId: 'user_1',
        recipientId: currentUserId,
        content: '好的，我们明天再讨论这个问题',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];

    // 私聊消息记录 - 王五
    messages['chat_2'] = [
      Message.system(
        chatId: 'chat_2',
        content: '王五添加了你为好友',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      Message.text(
        id: 'msg_2_1',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        content: '嘿，你好啊！',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 3)),
      ),
      Message.text(
        id: 'msg_2_2',
        chatId: 'chat_2',
        senderId: currentUserId,
        recipientId: 'user_2',
        content: '你好，王五！',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 2)),
      ),
      Message.image(
        id: 'msg_2_3',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        imageUrl: 'https://picsum.photos/id/25/300/200',
        caption: '看看这张照片',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 8)),
      ),
      Message.text(
        id: 'msg_2_4',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        content: '我们上周去爬山拍的',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 8)),
      ),
      Message.text(
        id: 'msg_2_5',
        chatId: 'chat_2',
        senderId: currentUserId,
        recipientId: 'user_2',
        content: '哇，风景真不错！',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 7)),
      ),
      Message.text(
        id: 'msg_2_6',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        content: '周末一起去打球吧？',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Message.text(
        id: 'msg_2_7',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        content: '约了几个朋友，挺好玩的',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Message.text(
        id: 'msg_2_8',
        chatId: 'chat_2',
        senderId: 'user_2',
        recipientId: currentUserId,
        content: '你有空吗？',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];

    // 私聊消息记录 - 小倩
    messages['chat_3'] = [
      Message.text(
        id: 'msg_3_1',
        chatId: 'chat_3',
        senderId: currentUserId,
        recipientId: 'user_4',
        content: '小倩，那个设计稿做好了吗？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 9)),
      ),
      Message.text(
        id: 'msg_3_2',
        chatId: 'chat_3',
        senderId: 'user_4',
        recipientId: currentUserId,
        content: '正在最后修改，很快就发给你',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 8)),
      ),
      Message.text(
        id: 'msg_3_3',
        chatId: 'chat_3',
        senderId: currentUserId,
        recipientId: 'user_4',
        content: '好的，麻烦尽快',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 8)),
      ),
      Message.text(
        id: 'msg_3_4',
        chatId: 'chat_3',
        senderId: 'user_4',
        recipientId: currentUserId,
        content: '设计稿我已经发给你了，看一下',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Message.file(
        id: 'msg_3_5',
        chatId: 'chat_3',
        senderId: 'user_4',
        recipientId: currentUserId,
        fileName: 'design_draft_v1.zip',
        fileSize: 15 * 1024 * 1024, // 15 MB
        fileUrl: 'https://example.com/files/design_draft_v1.zip',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    // 群聊消息 - 家庭群
    messages['group_1'] = [
      Message.system(
        chatId: 'group_1',
        content: '小明创建了群聊"家庭群"',
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
      ),
      Message.system(
        chatId: 'group_1',
        content: '小明邀请李四加入了群聊',
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
      ),
      Message.system(
        chatId: 'group_1',
        content: '小明邀请王五加入了群聊',
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
      ),
      Message.system(
        chatId: 'group_1',
        content: '小明邀请小倩加入了群聊',
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
      ),
      Message.text(
        id: 'msg_g1_1',
        chatId: 'group_1',
        senderId: 'user_1',
        recipientId: 'group_1',
        content: '大家好，我是李四',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 14)),
      ),
      Message.text(
        id: 'msg_g1_2',
        chatId: 'group_1',
        senderId: 'user_4',
        recipientId: 'group_1',
        content: '你好，我是小倩',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 14)),
      ),
      Message.text(
        id: 'msg_g1_3',
        chatId: 'group_1',
        senderId: 'user_2',
        recipientId: 'group_1',
        content: '大家好！我是王五',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 13)),
      ),
      Message.text(
        id: 'msg_g1_4',
        chatId: 'group_1',
        senderId: currentUserId,
        recipientId: 'group_1',
        content: '欢迎大家！我们一家人以后就在这个群里交流啦',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 13)),
      ),
      Message.text(
        id: 'msg_g1_5',
        chatId: 'group_1',
        senderId: 'user_4',
        recipientId: 'group_1',
        content: '今天谁负责做晚饭？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 18)),
      ),
      Message.text(
        id: 'msg_g1_6',
        chatId: 'group_1',
        senderId: 'user_2',
        recipientId: 'group_1',
        content: '我来做吧，今天想吃什么？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 17)),
      ),
      Message.text(
        id: 'msg_g1_7',
        chatId: 'group_1',
        senderId: currentUserId,
        recipientId: 'group_1',
        content: '今天晚上我会晚点回家',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];

    // 群聊消息 - 工作项目组
    messages['group_2'] = [
      Message.system(
        chatId: 'group_2',
        content: '王五创建了群聊"工作项目组"',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
      Message.text(
        id: 'msg_g2_1',
        chatId: 'group_2',
        senderId: 'user_2',
        recipientId: 'group_2',
        content: '大家好，这是我们新项目的工作群',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
      Message.text(
        id: 'msg_g2_2',
        chatId: 'group_2',
        senderId: 'user_2',
        recipientId: 'group_2',
        content: '项目计划我已经发到邮箱了，大家看一下',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 40)),
      ),
      Message.text(
        id: 'msg_g2_3',
        chatId: 'group_2',
        senderId: currentUserId,
        recipientId: 'group_2',
        content: '收到，我这边已经开始准备了',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 40)),
      ),
      Message.text(
        id: 'msg_g2_4',
        chatId: 'group_2',
        senderId: 'user_5',
        recipientId: 'group_2',
        content: '我负责的模块预计下周完成',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 35)),
      ),
      Message.text(
        id: 'msg_g2_5',
        chatId: 'group_2',
        senderId: 'user_3',
        recipientId: 'group_2',
        content: '明天早上9点开会讨论项目进度',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message.text(
        id: 'msg_g2_6',
        chatId: 'group_2',
        senderId: 'user_3',
        recipientId: 'group_2',
        content: '请大家准时参加，带上本周的工作进度',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message.text(
        id: 'msg_g2_7',
        chatId: 'group_2',
        senderId: 'user_3',
        recipientId: 'group_2',
        content: '特别是UI部分，需要尽快确定下来',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message.text(
        id: 'msg_g2_8',
        chatId: 'group_2',
        senderId: 'user_3',
        recipientId: 'group_2',
        content: '有问题随时在群里讨论',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      Message.text(
        id: 'msg_g2_9',
        chatId: 'group_2',
        senderId: 'user_3',
        recipientId: 'group_2',
        content: '会议地点：3楼会议室',
        status: MessageStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];

    // 群聊消息 - 同学会
    messages['group_3'] = [
      Message.system(
        chatId: 'group_3',
        content: '李四创建了群聊"同学会"',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      Message.text(
        id: 'msg_g3_1',
        chatId: 'group_3',
        senderId: 'user_1',
        recipientId: 'group_3',
        content: '大家好，这是我们的同学群',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      Message.text(
        id: 'msg_g3_2',
        chatId: 'group_3',
        senderId: 'user_4',
        recipientId: 'group_3',
        content: '好久不见大家了！',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 58)),
      ),
      Message.text(
        id: 'msg_g3_3',
        chatId: 'group_3',
        senderId: 'user_3',
        recipientId: 'group_3',
        content: '是啊，毕业都5年了',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 58)),
      ),
      Message.text(
        id: 'msg_g3_4',
        chatId: 'group_3',
        senderId: currentUserId,
        recipientId: 'group_3',
        content: '要不要组织一次同学聚会？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 50)),
      ),
      Message.text(
        id: 'msg_g3_5',
        chatId: 'group_3',
        senderId: 'user_5',
        recipientId: 'group_3',
        content: '下个月初我们组织一次同学聚会如何？',
        status: MessageStatus.read,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
