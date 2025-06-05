import '../mock/mock_service.dart';
import '../storage/repository/user/user_model.dart';
import '../storage/repository/chat/chat_model.dart';
import '../storage/repository/message/message_model.dart';
import 'repository.dart';

/// 模拟用户仓库
class MockUserRepository implements UserRepository {
  final MockService _mockService = MockService.instance;

  /// 单例实例
  static final MockUserRepository _instance = MockUserRepository._internal();
  static MockUserRepository get instance => _instance;
  MockUserRepository._internal();

  @override
  Future<User> getCurrentUser() async {
    return _mockService.getCurrentUser();
  }

  @override
  Future<User?> getUser(String userId) async {
    return _mockService.getUser(userId);
  }

  @override
  Future<List<User>> getAllUsers() async {
    return _mockService.getAllUsers();
  }

  @override
  Future<List<User>> getUserContacts() async {
    return _mockService.getUserContacts();
  }

  @override
  Future<User> updateUserStatus(String userId, UserStatus status) async {
    // 模拟实现，实际应该调用API更新状态
    final user = _mockService.getUser(userId);
    if (user != null) {
      return user.updateStatus(status);
    }
    throw Exception('User not found');
  }
}

/// 模拟聊天仓库
class MockChatRepository implements ChatRepository {
  final MockService _mockService = MockService.instance;

  /// 单例实例
  static final MockChatRepository _instance = MockChatRepository._internal();
  static MockChatRepository get instance => _instance;
  MockChatRepository._internal();

  @override
  Future<Chat?> getChat(String chatId) async {
    return _mockService.getChat(chatId);
  }

  @override
  Future<List<Chat>> getAllChats() async {
    return _mockService.getAllChats();
  }

  @override
  Stream<List<Chat>> getChatListStream() {
    return _mockService.chatListStream;
  }

  @override
  Future<Chat> createPrivateChat(String userId) async {
    return _mockService.createPrivateChat(userId);
  }

  @override
  Future<Chat> createGroupChat({
    required String name,
    required List<String> memberIds,
    String? avatarUrl,
  }) async {
    return _mockService.createGroupChat(
      name: name,
      memberIds: memberIds,
      avatarUrl: avatarUrl,
    );
  }

  @override
  Future<void> markChatAsRead(String chatId) async {
    _mockService.markChatAsRead(chatId);
  }

  @override
  Future<Chat> updateChat(Chat chat) async {
    // 模拟实现，实际应该调用API更新聊天
    return chat;
  }

  @override
  Future<void> deleteChat(String chatId) async {
    // 模拟实现，实际应该调用API删除聊天
  }
}

/// 模拟消息仓库
class MockMessageRepository implements MessageRepository {
  final MockService _mockService = MockService.instance;

  /// 单例实例
  static final MockMessageRepository _instance =
      MockMessageRepository._internal();
  static MockMessageRepository get instance => _instance;
  MockMessageRepository._internal();

  @override
  Future<List<Message>> getMessages(
    String chatId, {
    int limit = 20,
    DateTime? before,
    DateTime? after,
  }) async {
    return _mockService.getChatMessages(chatId,
        limit: limit, before: before, after: after);
  }

  @override
  Future<Message> sendTextMessage({
    required String chatId,
    required String content,
  }) async {
    return _mockService.sendMessage(
      chatId: chatId,
      content: content,
      type: MessageType.text,
    );
  }

  @override
  Future<Message> sendImageMessage({
    required String chatId,
    required String imageUrl,
    String? caption,
  }) async {
    return _mockService.sendMessage(
      chatId: chatId,
      content: caption ?? '',
      type: MessageType.image,
      metadata: {'url': imageUrl},
    );
  }

  @override
  Future<Message> sendFileMessage({
    required String chatId,
    required String fileName,
    required String fileUrl,
    required int fileSize,
  }) async {
    return _mockService.sendMessage(
      chatId: chatId,
      content: fileName,
      type: MessageType.file,
      metadata: {
        'fileName': fileName,
        'fileUrl': fileUrl,
        'fileSize': fileSize,
      },
    );
  }

  @override
  Stream<Message> getMessageStream(String chatId) {
    return _mockService.getChatMessageStream(chatId);
  }

  @override
  Stream<List<Message>> getMessageListStream(String chatId) {
    return _mockService.getChatMessageListStream(chatId);
  }

  @override
  Future<void> markMessageAsRead(String messageId) async {
    return _mockService.markMessageAsRead(messageId);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    // 模拟实现，实际应该调用API删除消息
  }
}

/// 主应用仓库，提供对所有模拟仓库的访问
class MockAppRepository implements AppRepository {
  @override
  final userRepository = MockUserRepository.instance;

  @override
  final chatRepository = MockChatRepository.instance;

  @override
  final messageRepository = MockMessageRepository.instance;

  /// 单例实例
  static final MockAppRepository _instance = MockAppRepository._internal();
  static MockAppRepository get instance => _instance;
  MockAppRepository._internal();

  @override
  void dispose() {
    MockService.instance.dispose();
  }
}
