import 'dart:async';

import '../storage/repository/user/user_model.dart';
import '../storage/repository/chat/chat_model.dart';
import '../storage/repository/message/message_model.dart';
import '../storage/engines/sqlite_storage_engine.dart';
import '../storage/engines/storage_engine.dart';
import '../storage/engines/query_condition.dart';
import '../mock/mock_data.dart'; // 用于初始化数据
import 'repository.dart';

/// SQLite用户仓库
class SqliteUserRepository implements UserRepository {
  static const String _collectionName = 'users';

  /// 存储引擎
  final StorageEngine _engine;

  /// 创建SQLite用户仓库
  SqliteUserRepository(this._engine);

  /// 初始化
  Future<void> initialize() async {
    await _engine.initialize();

    // 检查是否需要初始化数据
    final userCount = await _engine.count(_collectionName);
    if (userCount == 0) {
      // 从模拟数据中初始化
      final mockData = MockDataProvider.instance;
      for (final user in mockData.users.values) {
        await _engine.write(_collectionName, user.id, user.toJson());
      }
    }
  }

  @override
  Future<User> getCurrentUser() async {
    final userData =
        await _engine.read(_collectionName, MockDataProvider.currentUserId);
    if (userData != null) {
      return User.fromJson(userData);
    }
    throw Exception('当前用户不存在');
  }

  @override
  Future<User?> getUser(String userId) async {
    final userData = await _engine.read(_collectionName, userId);
    if (userData != null) {
      return User.fromJson(userData);
    }
    return null;
  }

  @override
  Future<List<User>> getAllUsers() async {
    final usersData =
        await _engine.query(_collectionName, QueryCondition.empty());
    return usersData.map((userData) => User.fromJson(userData)).toList();
  }

  @override
  Future<List<User>> getUserContacts() async {
    // 简化版本，获取除了当前用户之外的所有用户
    final usersData = await _engine.query(
        _collectionName,
        QueryCondition.fromOperator(
            'id', QueryOperator.notEqual, MockDataProvider.currentUserId));
    return usersData.map((userData) => User.fromJson(userData)).toList();
  }

  @override
  Future<User> updateUserStatus(String userId, UserStatus status) async {
    final userData = await _engine.read(_collectionName, userId);
    if (userData != null) {
      final user = User.fromJson(userData);
      final updatedUser = user.updateStatus(status);
      await _engine.write(_collectionName, userId, updatedUser.toJson());
      return updatedUser;
    }
    throw Exception('用户不存在');
  }
}

/// SQLite聊天仓库
class SqliteChatRepository implements ChatRepository {
  static const String _collectionName = 'chats';

  /// 存储引擎
  final StorageEngine _engine;

  /// 聊天列表流控制器
  final StreamController<List<Chat>> _chatListController =
      StreamController<List<Chat>>.broadcast();

  /// 创建SQLite聊天仓库
  SqliteChatRepository(this._engine);

  /// 初始化
  Future<void> initialize() async {
    await _engine.initialize();

    // 检查是否需要初始化数据
    final chatCount = await _engine.count(_collectionName);
    if (chatCount == 0) {
      // 从模拟数据中初始化
      final mockData = MockDataProvider.instance;
      for (final chat in mockData.chats.values) {
        await _engine.write(_collectionName, chat.id, chat.toJson());
      }
    }

    // 加载初始聊天列表并通知监听器
    _notifyChatListListeners();
  }

  /// 通知聊天列表监听器
  Future<void> _notifyChatListListeners() async {
    if (!_chatListController.isClosed) {
      final chats = await getAllChats();
      _chatListController.add(chats);
    }
  }

  @override
  Future<Chat?> getChat(String chatId) async {
    final chatData = await _engine.read(_collectionName, chatId);
    if (chatData != null) {
      return Chat.fromJson(chatData);
    }
    return null;
  }

  @override
  Future<List<Chat>> getAllChats() async {
    final chatsData =
        await _engine.query(_collectionName, QueryCondition.empty());
    return chatsData.map((chatData) => Chat.fromJson(chatData)).toList();
  }

  @override
  Stream<List<Chat>> getChatListStream() {
    return _chatListController.stream;
  }

  @override
  Future<Chat> createPrivateChat(String userId) async {
    final currentUserId = MockDataProvider.currentUserId;

    // 检查是否已存在此会话
    final chatsData = await _engine.query(
        _collectionName,
        QueryCondition.and([
          QueryCondition.fromOperator(
              'type', QueryOperator.equal, ChatType.private.index),
          QueryCondition.fromOperator(
              'participantIds', QueryOperator.contains, currentUserId),
          QueryCondition.fromOperator(
              'participantIds', QueryOperator.contains, userId),
        ]));

    if (chatsData.isNotEmpty) {
      return Chat.fromJson(chatsData.first);
    }

    // 创建新会话
    final chatId = 'chat_${DateTime.now().millisecondsSinceEpoch}';
    final newChat = Chat(
      id: chatId,
      type: ChatType.private,
      name: '', // 将在UI层填充
      avatar: '',
      participantIds: [currentUserId, userId],
      createdBy: currentUserId,
      createdAt: DateTime.now(),
      lastMessageText: '',
      lastMessageTime: DateTime.now(),
      lastMessageSenderId: '',
      unreadCount: 0,
    );

    await _engine.write(_collectionName, chatId, newChat.toJson());
    await _notifyChatListListeners();
    return newChat;
  }

  @override
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
    final chatId = 'group_${DateTime.now().millisecondsSinceEpoch}';
    final newChat = Chat(
      id: chatId,
      type: ChatType.group,
      name: name,
      avatar: avatarUrl ?? '',
      participantIds: memberIds,
      createdBy: currentUserId,
      createdAt: DateTime.now(),
      lastMessageText: '',
      lastMessageTime: DateTime.now(),
      lastMessageSenderId: '',
      unreadCount: 0,
    );

    await _engine.write(_collectionName, chatId, newChat.toJson());
    await _notifyChatListListeners();
    return newChat;
  }

  @override
  Future<void> markChatAsRead(String chatId) async {
    final chatData = await _engine.read(_collectionName, chatId);
    if (chatData != null) {
      final chat = Chat.fromJson(chatData);
      if (chat.unreadCount > 0) {
        final updatedChat = chat.copyWith(unreadCount: 0);
        await _engine.write(_collectionName, chatId, updatedChat.toJson());
        await _notifyChatListListeners();
      }
    }
  }

  @override
  Future<Chat> updateChat(Chat chat) async {
    await _engine.write(_collectionName, chat.id, chat.toJson());
    await _notifyChatListListeners();
    return chat;
  }

  @override
  Future<void> deleteChat(String chatId) async {
    await _engine.delete(_collectionName, chatId);
    await _notifyChatListListeners();
  }

  /// 更新聊天的最后一条消息
  Future<void> updateChatLastMessage(
      String chatId, String content, String senderId, DateTime time,
      {bool incrementUnread = false}) async {
    final chatData = await _engine.read(_collectionName, chatId);
    if (chatData != null) {
      final chat = Chat.fromJson(chatData);
      final unreadCount =
          incrementUnread ? chat.unreadCount + 1 : chat.unreadCount;

      final updatedChat = chat.copyWith(
        lastMessageText: content,
        lastMessageTime: time,
        lastMessageSenderId: senderId,
        unreadCount: unreadCount,
      );

      await _engine.write(_collectionName, chatId, updatedChat.toJson());
      await _notifyChatListListeners();
    }
  }

  /// 释放资源
  void dispose() {
    if (!_chatListController.isClosed) {
      _chatListController.close();
    }
  }
}

/// SQLite消息仓库
class SqliteMessageRepository implements MessageRepository {
  static const String _collectionName = 'messages';

  /// 存储引擎
  final StorageEngine _engine;

  /// 消息流控制器
  final Map<String, StreamController<Message>> _messageControllers = {};

  /// 消息列表流控制器
  final Map<String, StreamController<List<Message>>> _messageListControllers =
      {};

  /// 聊天仓库
  final SqliteChatRepository _chatRepository;

  /// 创建SQLite消息仓库
  SqliteMessageRepository(this._engine, this._chatRepository);

  /// 初始化
  Future<void> initialize() async {
    await _engine.initialize();

    // 检查是否需要初始化数据
    final messageCount = await _engine.count(_collectionName);
    if (messageCount == 0) {
      // 从模拟数据中初始化
      final mockData = MockDataProvider.instance;
      for (final entry in mockData.messages.entries) {
        final chatId = entry.key;
        final messages = entry.value;

        for (final message in messages) {
          await _engine.write(_collectionName, message.id, message.toJson());
        }
      }
    }
  }

  @override
  Future<List<Message>> getMessages(
    String chatId, {
    int limit = 20,
    DateTime? before,
    DateTime? after,
  }) async {
    // 构建查询条件
    final List<QueryCondition> conditions = [
      QueryCondition.fromOperator('chatId', QueryOperator.equal, chatId),
    ];

    // 添加时间过滤条件
    if (before != null) {
      conditions.add(
        QueryCondition.fromOperator(
            'createdAt', QueryOperator.lessThan, before.millisecondsSinceEpoch),
      );
    }

    if (after != null) {
      conditions.add(
        QueryCondition.fromOperator('createdAt', QueryOperator.greaterThan,
            after.millisecondsSinceEpoch),
      );
    }

    // 执行查询
    final messagesData = await _engine.query(
      _collectionName,
      QueryCondition.and(conditions),
      // 注意：如果引擎API不支持limit和orderBy参数，需要在内存中处理
    );

    // 将结果转换为消息对象
    final messages = messagesData
        .map((messageData) => Message.fromJson(messageData))
        .toList();

    // 如果是向前加载（before不为空），则按时间降序排序后取最新的limit条
    if (before != null) {
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final limitedMessages = messages.take(limit).toList();
      // 返回前再按时间升序排序
      limitedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return limitedMessages;
    } else if (after != null) {
      // 按时间升序排序，取after之后的limit条
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return messages.take(limit).toList();
    } else {
      // 默认按时间降序排序，取最新的limit条，然后返回前按时间升序排序
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final limitedMessages = messages.take(limit).toList();
      limitedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return limitedMessages;
    }
  }

  @override
  Future<Message> sendTextMessage({
    required String chatId,
    required String content,
  }) async {
    final message = await _createAndSaveMessage(
      chatId: chatId,
      content: content,
      type: MessageType.text,
    );

    // 更新聊天的最后一条消息
    await _chatRepository.updateChatLastMessage(
      chatId,
      content,
      message.senderId,
      message.createdAt,
    );

    // 模拟回声机器人
    if (message.recipientId == 'user_bot') {
      await Future.delayed(const Duration(seconds: 2));
      await _simulateBotReply(chatId, content);
    }

    return message;
  }

  @override
  Future<Message> sendImageMessage({
    required String chatId,
    required String imageUrl,
    String? caption,
  }) async {
    final message = await _createAndSaveMessage(
      chatId: chatId,
      content: caption ?? '',
      type: MessageType.image,
      metadata: {'url': imageUrl},
    );

    // 更新聊天的最后一条消息
    await _chatRepository.updateChatLastMessage(
      chatId,
      caption ?? '[图片]',
      message.senderId,
      message.createdAt,
    );

    return message;
  }

  @override
  Future<Message> sendFileMessage({
    required String chatId,
    required String fileName,
    required String fileUrl,
    required int fileSize,
  }) async {
    final message = await _createAndSaveMessage(
      chatId: chatId,
      content: fileName,
      type: MessageType.file,
      metadata: {
        'fileName': fileName,
        'fileUrl': fileUrl,
        'fileSize': fileSize,
      },
    );

    // 更新聊天的最后一条消息
    await _chatRepository.updateChatLastMessage(
      chatId,
      '[文件] $fileName',
      message.senderId,
      message.createdAt,
    );

    return message;
  }

  /// 创建并保存消息
  Future<Message> _createAndSaveMessage({
    required String chatId,
    required String content,
    required MessageType type,
    Map<String, dynamic>? metadata,
  }) async {
    final chat = await _chatRepository.getChat(chatId);
    if (chat == null) {
      throw Exception('Chat not found');
    }

    final currentUserId = MockDataProvider.currentUserId;
    String recipientId;

    if (chat.type == ChatType.private) {
      recipientId = chat.participantIds.firstWhere((id) => id != currentUserId);
    } else {
      recipientId = chatId; // 群聊消息接收者是群ID
    }

    // 创建消息
    final message = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}',
      chatId: chatId,
      senderId: currentUserId,
      recipientId: recipientId,
      content: content,
      type: type,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      metadata: metadata,
    );

    // 保存消息
    await _engine.write(_collectionName, message.id, message.toJson());

    // 通知监听器
    _notifyMessageListener(chatId, message);

    // 模拟发送成功
    await Future.delayed(const Duration(milliseconds: 500));
    final sentMessage = message.markSent();
    await _updateMessage(sentMessage);

    // 模拟消息已送达
    await Future.delayed(const Duration(seconds: 1));
    final deliveredMessage = sentMessage.markDelivered();
    await _updateMessage(deliveredMessage);

    return deliveredMessage;
  }

  /// 模拟机器人回复
  Future<void> _simulateBotReply(String chatId, String content) async {
    final botMessage = Message.text(
      id: 'bot_msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: 'user_bot',
      recipientId: MockDataProvider.currentUserId,
      content: content, // 回声机器人，返回相同内容
      status: MessageStatus.delivered,
      createdAt: DateTime.now(),
    );

    // 保存消息
    await _engine.write(_collectionName, botMessage.id, botMessage.toJson());

    // 更新聊天的最后一条消息，并增加未读数
    await _chatRepository.updateChatLastMessage(
      chatId,
      content,
      botMessage.senderId,
      botMessage.createdAt,
      incrementUnread: true,
    );

    // 通知监听器
    _notifyMessageListener(chatId, botMessage);
  }

  /// 更新消息
  Future<void> _updateMessage(Message message) async {
    await _engine.write(_collectionName, message.id, message.toJson());
    _notifyMessageListener(message.chatId, message);
  }

  /// 通知消息监听器
  void _notifyMessageListener(String chatId, Message message) {
    final controller = _messageControllers[chatId];
    if (controller != null && !controller.isClosed) {
      controller.add(message);
    }
  }

  /// 获取或创建消息StreamController
  StreamController<Message> _getOrCreateController(String chatId) {
    if (!_messageControllers.containsKey(chatId)) {
      _messageControllers[chatId] = StreamController<Message>.broadcast();
    }
    return _messageControllers[chatId]!;
  }

  @override
  Stream<Message> getMessageStream(String chatId) {
    // 使用获取或创建控制器的辅助方法
    final controller = _getOrCreateController(chatId);
    return controller.stream;
  }

  @override
  Future<void> markMessageAsRead(String messageId) async {
    final messageData = await _engine.read(_collectionName, messageId);
    if (messageData != null) {
      final message = Message.fromJson(messageData);
      if (message.status != MessageStatus.read) {
        final readMessage = message.markRead();
        await _updateMessage(readMessage);
      }
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    await _engine.delete(_collectionName, messageId);
  }

  @override
  Stream<List<Message>> getMessageListStream(String chatId) {
    // 懒创建聊天消息的流控制器
    _getOrCreateListController(chatId);

    // 返回消息列表流
    return _messageListControllers[chatId]!.stream;
  }

  // 获取或创建消息列表的StreamController
  StreamController<List<Message>> _getOrCreateListController(String chatId) {
    if (!_messageListControllers.containsKey(chatId)) {
      final controller = StreamController<List<Message>>.broadcast();
      _messageListControllers[chatId] = controller;

      // 监听消息流，更新消息列表
      final messageController = _getOrCreateController(chatId);
      messageController.stream.listen((message) {
        _updateMessageList(chatId, message);
      });

      // 初始加载消息
      getMessages(chatId).then((messages) {
        if (!controller.isClosed) {
          controller.add(messages);
        }
      });
    }
    return _messageListControllers[chatId]!;
  }

  // 更新消息列表
  void _updateMessageList(String chatId, Message message) async {
    final controller = _messageListControllers[chatId];
    if (controller == null || controller.isClosed) return;

    // 获取当前消息列表
    final messages = await getMessages(chatId);

    // 通知监听器
    if (!controller.isClosed) {
      controller.add(messages);
    }
  }

  /// 释放资源
  void dispose() {
    // 关闭所有消息控制器
    for (final controller in _messageControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _messageControllers.clear();

    // 关闭所有消息列表控制器
    for (final controller in _messageListControllers.values) {
      if (!controller.isClosed) {
        controller.close();
      }
    }
    _messageListControllers.clear();
  }
}

/// SQLite应用仓库
class SqliteAppRepository implements AppRepository {
  /// SQLite引擎配置
  final SQLiteEngineConfig _config = const SQLiteEngineConfig(
    databaseName: 'im_chat.db',
    version: 1,
  );

  /// 存储引擎
  late final SQLiteStorageEngine _engine;

  /// 用户仓库
  @override
  late final SqliteUserRepository userRepository;

  /// 聊天仓库
  @override
  late final SqliteChatRepository chatRepository;

  /// 消息仓库
  @override
  late final SqliteMessageRepository messageRepository;

  /// 是否已初始化
  bool _initialized = false;

  /// 单例实例
  static final SqliteAppRepository _instance = SqliteAppRepository._internal();
  static SqliteAppRepository get instance => _instance;

  /// 私有构造函数
  SqliteAppRepository._internal() {
    _engine = SQLiteStorageEngine(
      engineId: 'im_sqlite',
      engineName: 'SQLite Storage',
      config: _config,
    );

    // 创建仓库实例
    userRepository = SqliteUserRepository(_engine);
    chatRepository = SqliteChatRepository(_engine);
    messageRepository = SqliteMessageRepository(_engine, chatRepository);

    // 初始化
    _initialize();
  }

  /// 初始化仓库
  Future<void> _initialize() async {
    if (_initialized) return;

    try {
      await userRepository.initialize();
      await chatRepository.initialize();
      await messageRepository.initialize();
      _initialized = true;
    } catch (e) {
      print('初始化SQLite仓库失败: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    chatRepository.dispose();
    messageRepository.dispose();
    _engine.close();
  }
}
