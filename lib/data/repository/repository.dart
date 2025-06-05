import '../storage/repository/user/user_model.dart';
import '../storage/repository/chat/chat_model.dart';
import '../storage/repository/message/message_model.dart';

/// 用户仓库接口
abstract class UserRepository {
  /// 获取当前用户
  Future<User> getCurrentUser();

  /// 获取用户
  Future<User?> getUser(String userId);

  /// 获取全部用户
  Future<List<User>> getAllUsers();

  /// 获取用户联系人
  Future<List<User>> getUserContacts();

  /// 更新用户状态
  Future<User> updateUserStatus(String userId, UserStatus status);
}

/// 聊天仓库接口
abstract class ChatRepository {
  /// 获取聊天会话
  Future<Chat?> getChat(String chatId);

  /// 获取全部会话
  Future<List<Chat>> getAllChats();

  /// 获取聊天列表流
  Stream<List<Chat>> getChatListStream();

  /// 创建私聊会话
  Future<Chat> createPrivateChat(String userId);

  /// 创建群聊会话
  Future<Chat> createGroupChat({
    required String name,
    required List<String> memberIds,
    String? avatarUrl,
  });

  /// 标记会话为已读
  Future<void> markChatAsRead(String chatId);

  /// 更新会话
  Future<Chat> updateChat(Chat chat);

  /// 删除会话
  Future<void> deleteChat(String chatId);
}

/// 消息仓库接口
abstract class MessageRepository {
  /// 获取会话消息
  /// [chatId] 会话ID
  /// [limit] 每次获取的消息数量，默认为20
  /// [before] 获取指定时间之前的消息，用于向上加载历史消息
  /// [after] 获取指定时间之后的消息，用于向下加载新消息
  Future<List<Message>> getMessages(
    String chatId, {
    int limit = 20,
    DateTime? before,
    DateTime? after,
  });

  /// 发送文本消息
  Future<Message> sendTextMessage({
    required String chatId,
    required String content,
  });

  /// 发送图片消息
  Future<Message> sendImageMessage({
    required String chatId,
    required String imageUrl,
    String? caption,
  });

  /// 发送文件消息
  Future<Message> sendFileMessage({
    required String chatId,
    required String fileName,
    required String fileUrl,
    required int fileSize,
  });

  /// 获取消息流
  Stream<Message> getMessageStream(String chatId);

  /// 将消息标记为已读
  Future<void> markMessageAsRead(String messageId);

  /// 删除消息
  Future<void> deleteMessage(String messageId);

  /// 获取消息列表流
  Stream<List<Message>> getMessageListStream(String chatId);
}

/// 应用仓库接口
abstract class AppRepository {
  /// 用户仓库
  UserRepository get userRepository;

  /// 聊天仓库
  ChatRepository get chatRepository;

  /// 消息仓库
  MessageRepository get messageRepository;

  /// 释放资源
  void dispose();
}
