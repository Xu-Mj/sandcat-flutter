import 'dart:async';
import 'package:uuid/uuid.dart';
import '../storage/repository/user/user_model.dart';
import '../storage/repository/chat/chat_model.dart';
import '../storage/repository/message/message_model.dart';
import 'mock_data.dart';

/// 模拟数据服务
class MockService {
  static final _uuid = Uuid();
  final MockDataProvider _dataProvider = MockDataProvider.instance;
  final Map<String, StreamController<Message>> _messageControllers = {};

  // 添加聊天列表更新控制器
  final StreamController<List<Chat>> _chatListController =
      StreamController<List<Chat>>.broadcast();

  /// 获取聊天列表流
  Stream<List<Chat>> get chatListStream => _chatListController.stream;

  // 消息列表流控制器
  final Map<String, StreamController<List<Message>>> _messageListControllers =
      {};

  /// 单例实例
  static final MockService _instance = MockService._internal();
  static MockService get instance => _instance;
  MockService._internal() {
    // 初始化消息数据
    _dataProvider.initializeMessages();
    // 初始化消息流
    _initializeMessageStreams();
  }

  /// 初始化消息流
  void _initializeMessageStreams() {
    for (final chatId in _dataProvider.chats.keys) {
      _messageControllers[chatId] = StreamController<Message>.broadcast();
      _messageListControllers[chatId] =
          StreamController<List<Message>>.broadcast();
    }
  }

  /// 获取当前用户
  User getCurrentUser() {
    return _dataProvider.users[MockDataProvider.currentUserId]!;
  }

  /// 获取用户
  User? getUser(String userId) {
    return _dataProvider.users[userId];
  }

  /// 获取全部用户
  List<User> getAllUsers() {
    return _dataProvider.users.values.toList();
  }

  /// 获取用户联系人
  List<User> getUserContacts() {
    final currentUserId = MockDataProvider.currentUserId;
    final userIds = _dataProvider.chats.values
        .where((chat) => chat.type == ChatType.private)
        .expand((chat) => chat.participantIds)
        .where((id) => id != currentUserId)
        .toSet()
        .toList();

    return userIds.map((id) => _dataProvider.users[id]!).toList();
  }

  /// 获取聊天会话
  Chat? getChat(String chatId) {
    return _dataProvider.chats[chatId];
  }

  /// 获取全部会话
  List<Chat> getAllChats() {
    return _dataProvider.chats.values.toList();
  }

  /// 获取会话消息
  List<Message> getChatMessages(
    String chatId, {
    int limit = 20,
    DateTime? before,
    DateTime? after,
  }) {
    final messages = _dataProvider.messages[chatId] ?? [];

    // 根据过滤条件筛选消息
    List<Message> filteredMessages = List.from(messages);

    if (before != null) {
      filteredMessages = filteredMessages
          .where((msg) => msg.createdAt.isBefore(before))
          .toList();
    }

    if (after != null) {
      filteredMessages = filteredMessages
          .where((msg) => msg.createdAt.isAfter(after))
          .toList();
    }

    // 按时间排序
    if (before != null) {
      // 向前加载历史消息，先降序排序，取最新的limit条，然后再升序返回
      filteredMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final limitedMessages = filteredMessages.take(limit).toList();
      limitedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return limitedMessages;
    } else if (after != null) {
      // 向后加载新消息，按时间升序排序
      filteredMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return filteredMessages.take(limit).toList();
    } else {
      // 默认加载，按时间降序排序，取最新的limit条，然后再升序返回
      filteredMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final limitedMessages = filteredMessages.take(limit).toList();
      limitedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return limitedMessages;
    }
  }

  /// 发送消息
  Future<Message> sendMessage({
    required String chatId,
    required String content,
    MessageType type = MessageType.text,
    Map<String, dynamic>? metadata,
  }) async {
    final currentUserId = MockDataProvider.currentUserId;
    final chat = _dataProvider.chats[chatId];

    if (chat == null) {
      throw Exception('Chat not found');
    }

    String recipientId;
    if (chat.type == ChatType.private) {
      recipientId = chat.participantIds.firstWhere((id) => id != currentUserId);
    } else {
      recipientId = chatId; // 群聊消息接收者是群ID
    }

    // 创建消息
    final message = Message(
      id: _uuid.v4(),
      chatId: chatId,
      senderId: currentUserId,
      recipientId: recipientId,
      content: content,
      type: type,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      metadata: metadata,
    );

    // 添加到消息列表
    final messages = _dataProvider.messages[chatId] ?? [];
    messages.add(message);
    _dataProvider.messages[chatId] = messages;

    // 更新会话最后一条消息
    _dataProvider.chats[chatId] = chat.copyWith(
      lastMessageText: content,
      lastMessageTime: message.createdAt,
      lastMessageSenderId: currentUserId,
    );

    // 通知聊天列表监听器
    _notifyChatListListeners();

    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 500));

    // 更新消息状态为已发送
    final sentMessage = message.markSent();
    _updateMessage(chatId, sentMessage);

    // 模拟消息发送完成后的状态更新
    _simulateMessageDelivered(chatId, sentMessage);

    // 如果是与机器人聊天，模拟机器人回复
    if (recipientId == 'user_bot') {
      _simulateBotReply(chatId, content);
    }

    return sentMessage;
  }

  /// 模拟消息已送达
  void _simulateMessageDelivered(String chatId, Message message) async {
    await Future.delayed(const Duration(seconds: 1));

    // 更新消息状态为已送达
    final deliveredMessage = message.markDelivered();
    _updateMessage(chatId, deliveredMessage);

    // 通知监听器
    _notifyMessageListener(chatId, deliveredMessage);
  }

  /// 模拟机器人回复
  void _simulateBotReply(String chatId, String content) async {
    // 等待一小段时间再回复
    await Future.delayed(const Duration(seconds: 2));

    // 创建回复消息
    final botMessage = Message.text(
      id: _uuid.v4(),
      chatId: chatId,
      senderId: 'user_bot',
      recipientId: MockDataProvider.currentUserId,
      content: content, // 回声机器人，返回相同内容
      status: MessageStatus.delivered,
      createdAt: DateTime.now(),
    );

    // 添加到消息列表
    final messages = _dataProvider.messages[chatId] ?? [];
    messages.add(botMessage);
    _dataProvider.messages[chatId] = messages;

    // 更新会话最后一条消息
    final chat = _dataProvider.chats[chatId];
    if (chat != null) {
      _dataProvider.chats[chatId] = chat.copyWith(
        lastMessageText: content,
        lastMessageTime: botMessage.createdAt,
        lastMessageSenderId: 'user_bot',
        unreadCount: chat.unreadCount + 1,
      );

      // 通知聊天列表监听器
      _notifyChatListListeners();
    }

    // 通知监听器
    _notifyMessageListener(chatId, botMessage);
  }

  /// 更新消息
  void _updateMessage(String chatId, Message updatedMessage) {
    final messages = _dataProvider.messages[chatId] ?? [];
    final index = messages.indexWhere((msg) => msg.id == updatedMessage.id);

    if (index != -1) {
      messages[index] = updatedMessage;
      _dataProvider.messages[chatId] = messages;
      _notifyMessageListener(chatId, updatedMessage);
    }
  }

  /// 通知消息监听器
  void _notifyMessageListener(String chatId, Message message) {
    final controller = _messageControllers[chatId];
    if (controller != null && !controller.isClosed) {
      controller.add(message);
    }

    // 也通知消息列表监听器
    _notifyMessageListListener(chatId);
  }

  /// 获取消息流
  Stream<Message> getChatMessageStream(String chatId) {
    if (!_messageControllers.containsKey(chatId)) {
      _messageControllers[chatId] = StreamController<Message>.broadcast();
    }
    return _messageControllers[chatId]!.stream;
  }

  /// 标记会话为已读
  void markChatAsRead(String chatId) {
    final chat = _dataProvider.chats[chatId];
    if (chat != null && chat.unreadCount > 0) {
      _dataProvider.chats[chatId] = chat.copyWith(unreadCount: 0);
      // 通知聊天列表监听器
      _notifyChatListListeners();
    }

    // 将所有未读消息标记为已读
    final messages = _dataProvider.messages[chatId] ?? [];
    final currentUserId = MockDataProvider.currentUserId;

    for (int i = 0; i < messages.length; i++) {
      final message = messages[i];
      if (message.recipientId == currentUserId &&
          message.senderId != currentUserId &&
          message.status != MessageStatus.read) {
        messages[i] = message.markRead();
      }
    }

    _dataProvider.messages[chatId] = messages;
  }

  /// 将单个消息标记为已读
  void markMessageAsRead(String messageId) {
    // 查找包含该消息的聊天
    String? chatIdWithMessage;
    Message? foundMessage;

    for (final entry in _dataProvider.messages.entries) {
      final chatId = entry.key;
      final messages = entry.value;

      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);
      if (messageIndex >= 0) {
        chatIdWithMessage = chatId;
        foundMessage = messages[messageIndex];
        break;
      }
    }

    if (chatIdWithMessage != null && foundMessage != null) {
      // 将此消息标记为已读
      final messages = _dataProvider.messages[chatIdWithMessage]!;
      final messageIndex = messages.indexWhere((msg) => msg.id == messageId);

      if (messageIndex >= 0 &&
          messages[messageIndex].status != MessageStatus.read) {
        // 更新消息状态
        messages[messageIndex] = messages[messageIndex].markRead();
        _dataProvider.messages[chatIdWithMessage] = messages;

        // 通知监听器
        _notifyMessageListener(chatIdWithMessage, messages[messageIndex]);
      }
    }
  }

  /// 创建新的私聊会话
  Future<Chat> createPrivateChat(String userId) async {
    final currentUserId = MockDataProvider.currentUserId;
    final otherUser = _dataProvider.users[userId];

    if (otherUser == null) {
      throw Exception('User not found');
    }

    // 检查是否已存在此会话
    final existingChat = _dataProvider.chats.values.firstWhere(
      (chat) =>
          chat.type == ChatType.private &&
          chat.participantIds.contains(currentUserId) &&
          chat.participantIds.contains(userId),
      orElse: () => Chat.empty(),
    );

    if (existingChat.id.isNotEmpty) {
      return existingChat;
    }

    // 创建新会话
    final chatId = 'chat_${_uuid.v4()}';
    final newChat = Chat(
      id: chatId,
      type: ChatType.private,
      name: otherUser.displayName,
      avatar: otherUser.avatarUrl ?? '',
      participantIds: [currentUserId, userId],
      createdBy: currentUserId,
      createdAt: DateTime.now(),
      lastMessageText: '',
      lastMessageTime: DateTime.now(),
      lastMessageSenderId: '',
      unreadCount: 0,
    );

    // 保存会话
    _dataProvider.chats[chatId] = newChat;
    _dataProvider.messages[chatId] = [];

    // 创建消息控制器
    _messageControllers[chatId] = StreamController<Message>.broadcast();

    return newChat;
  }

  /// 创建新的群聊会话
  Future<Chat> createGroupChat({
    required String name,
    required List<String> memberIds,
    String? avatarUrl,
  }) async {
    final currentUserId = MockDataProvider.currentUserId;

    // 确保创建者也是成员
    if (!memberIds.contains(currentUserId)) {
      memberIds.add(currentUserId);
    }

    // 创建新群聊
    final chatId = 'group_${_uuid.v4()}';
    final newChat = Chat(
      id: chatId,
      type: ChatType.group,
      name: name,
      avatar: avatarUrl ??
          'https://via.placeholder.com/150/CCCCCC/FFFFFF?text=${name.substring(0, 1)}',
      participantIds: memberIds,
      createdBy: currentUserId,
      createdAt: DateTime.now(),
      lastMessageText: '',
      lastMessageTime: DateTime.now(),
      lastMessageSenderId: '',
      unreadCount: 0,
    );

    // 保存会话
    _dataProvider.chats[chatId] = newChat;

    // 创建系统消息
    final systemMessage = Message.system(
      chatId: chatId,
      content:
          '${_dataProvider.users[currentUserId]?.displayName ?? currentUserId}创建了群聊"$name"',
      createdAt: DateTime.now(),
    );

    // 保存消息
    _dataProvider.messages[chatId] = [systemMessage];

    // 创建消息控制器
    _messageControllers[chatId] = StreamController<Message>.broadcast();

    return newChat;
  }

  /// 关闭所有流
  void dispose() {
    for (final controller in _messageControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }

    for (final controller in _messageListControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }

    if (!_chatListController.isClosed) {
      _chatListController.close();
    }
  }

  // 通知聊天列表监听器
  void _notifyChatListListeners() {
    if (!_chatListController.isClosed) {
      _chatListController.add(_dataProvider.chats.values.toList());
    }
  }

  /// 获取消息列表流
  Stream<List<Message>> getChatMessageListStream(String chatId) {
    if (!_messageListControllers.containsKey(chatId)) {
      _messageListControllers[chatId] =
          StreamController<List<Message>>.broadcast();

      // 当单个消息更新时，也更新消息列表
      _messageControllers[chatId]?.stream.listen((_) {
        _notifyMessageListListener(chatId);
      });

      // 立即发送当前消息列表
      _notifyMessageListListener(chatId);
    }
    return _messageListControllers[chatId]!.stream;
  }

  /// 通知消息列表监听器
  void _notifyMessageListListener(String chatId) {
    final controller = _messageListControllers[chatId];
    if (controller != null && !controller.isClosed) {
      final messages = getChatMessages(chatId);
      controller.add(messages);
    }
  }
}
