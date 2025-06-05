import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import '../../data/repository/repository.dart';
import '../../data/storage/repository/message/message_model.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../data/storage/repository/chat/chat_model.dart';
import '../../providers/repository_provider.dart';

import 'message_input.dart';
import 'message_list.dart';

/// 聊天屏幕
class ChatScreen extends StatefulWidget {
  /// 会话ID
  final String chatId;

  /// 当前用户ID
  final String? currentUserId;

  /// 创建聊天屏幕
  const ChatScreen({
    Key? key,
    required this.chatId,
    this.currentUserId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  /// 消息列表
  List<Message> _messages = [];

  /// 聊天详情
  Chat? _chat;

  /// 参与者
  Map<String, User> _participants = {};

  /// 是否加载中
  bool _isLoading = true;

  /// 是否正在发送消息
  bool _isSending = false;

  /// 是否已初始化
  bool _initialized = false;

  /// 消息滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 消息监听器
  StreamSubscription<Message>? _messagesSubscription;

  /// 当前用户ID
  late String _currentUserId;

  /// 仓库实例
  late ChatRepository _chatRepository;
  late UserRepository _userRepository;
  late MessageRepository _messageRepository;

  /// 是否正在加载更多消息
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 获取仓库实例
    _chatRepository = RepositoryProvider.chatRepository(context);
    _userRepository = RepositoryProvider.userRepository(context);
    _messageRepository = RepositoryProvider.messageRepository(context);

    // 在这里初始化当前用户ID
    if (!_initialized) {
      _initializeCurrentUser();
    }
  }

  /// 初始化当前用户ID
  Future<void> _initializeCurrentUser() async {
    // 使用提供的ID或从仓库获取
    if (widget.currentUserId != null) {
      _currentUserId = widget.currentUserId!;
      _initialize();
    } else {
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser != null && mounted) {
        _currentUserId = currentUser.id;
        _initialize();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取当前用户失败')),
        );
      }
    }
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  /// 初始化
  Future<void> _initialize() async {
    if (_initialized) return;
    setState(() => _isLoading = true);

    try {
      await _loadChat();
      await _loadParticipants();
      await _loadMessages();

      // 标记消息为已读
      await _markMessagesAsRead();

      // 设置消息监听器
      _setupMessageListener();

      _initialized = true;
    } catch (e) {
      // 处理错误
      _showErrorSnackbar('加载聊天数据失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 加载聊天信息
  Future<void> _loadChat() async {
    _chat = await _chatRepository.getChat(widget.chatId);

    if (_chat == null) {
      throw Exception('无法找到聊天');
    }
  }

  /// 加载参与者
  Future<void> _loadParticipants() async {
    if (_chat == null) return;

    for (final participantId in _chat!.participantIds) {
      final user = await _userRepository.getUser(participantId);
      if (user != null) {
        _participants[participantId] = user;
      }
    }
  }

  /// 加载消息
  Future<void> _loadMessages() async {
    // 先设置加载状态
    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      // 获取所有消息
      final messages = await _messageRepository.getMessages(widget.chatId);

      // 更新消息列表
      if (mounted) {
        setState(() {
          _messages = messages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackbar('加载消息失败: $e');
      }
    }
  }

  /// 设置消息监听器
  void _setupMessageListener() {
    _messagesSubscription =
        _messageRepository.getMessageStream(widget.chatId).listen((message) {
      if (mounted) {
        setState(() {
          // 添加新消息或更新现有消息
          print("receive message: $message");
          final index = _messages.indexWhere((m) => m.id == message.id);
          if (index >= 0) {
            _messages[index] = message;
          } else {
            _messages.add(message);
          }

          // 标记消息为已读
          if (message.senderId != _currentUserId) {
            _markMessageAsRead(message);
          }
        });
      }
    });
  }

  /// 标记所有消息为已读
  Future<void> _markMessagesAsRead() async {
    if (_chat == null) return;

    // 如果有未读消息
    if (_chat!.unreadCount > 0) {
      await _chatRepository.markChatAsRead(widget.chatId);

      // 更新本地缓存中的未读消息数
      if (mounted && _chat != null) {
        setState(() {
          _chat = _chat!.copyWith(unreadCount: 0);
        });
      }
    }
  }

  /// 标记单条消息为已读
  Future<void> _markMessageAsRead(Message message) async {
    // 在实际应用中，这里应该调用API更新消息状态
    await _messageRepository.markMessageAsRead(message.id);
  }

  /// 发送文本消息
  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() => _isSending = true);

    try {
      if (_chat == null) return;

      // 发送消息
      await _messageRepository.sendTextMessage(
        chatId: widget.chatId,
        content: text,
      );

      // 发送消息后，滚动到底部
      _scrollToBottom();
    } catch (e) {
      _showErrorSnackbar('发送消息失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  /// 发送图片消息
  Future<void> _handleSendImage(File imageFile) async {
    setState(() => _isSending = true);

    try {
      if (_chat == null) return;

      // 发送图片消息
      await _messageRepository.sendImageMessage(
        chatId: widget.chatId,
        imageUrl: imageFile.path,
        caption: '图片',
      );

      // 发送图片后，滚动到底部
      _scrollToBottom();
    } catch (e) {
      _showErrorSnackbar('发送图片失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  /// 滚动到底部方法
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // 使用jumpTo方法直接跳转到底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(0); // 由于列表是反向的，0是底部
      });
    }
  }

  /// 获取接收者ID
  String _getRecipientId() {
    if (_chat == null) return '';

    if (_chat!.type == ChatType.group) {
      return widget.chatId; // 群聊的接收者是群ID
    } else {
      // 私聊的接收者是另一个参与者
      return _chat!.participantIds.firstWhere(
        (id) => id != _currentUserId,
        orElse: () => '',
      );
    }
  }

  /// 显示错误提示
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// 加载更多消息
  Future<void> _loadMoreMessages() async {
    if (_isLoadingMore || _messages.isEmpty) return;

    setState(() => _isLoadingMore = true);

    try {
      // 获取最早的消息作为分页参数
      final earliestMessage = _messages.first;

      // 加载更早的消息
      final olderMessages = await _messageRepository.getMessages(
        widget.chatId,
        limit: 20,
        before: earliestMessage.createdAt,
      );

      if (mounted) {
        setState(() {
          if (olderMessages.isNotEmpty) {
            // 在列表开头添加更早的消息
            _messages.insertAll(0, olderMessages);
          }
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      _showErrorSnackbar('加载更多消息失败: $e');
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 在用户离开页面前确保所有消息已标记为已读
        if (_chat != null && _chat!.unreadCount > 0) {
          await _markMessagesAsRead();
        }
        // 返回给上一页面，给它一个机会刷新
        Navigator.of(context).pop();
        return false; // 我们已经处理了pop逻辑
      },
      child: Scaffold(
        appBar: AppBar(
          title: _buildAppBarTitle(),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // 显示更多选项
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    // 消息列表
                    Expanded(
                      child: _messages.isEmpty
                          ? _buildEmptyChat()
                          : _buildMessageList(),
                    ),

                    // 消息输入框
                    _buildInputArea(),
                  ],
                ),
              ),
      ),
    );
  }

  /// 构建AppBar标题
  Widget _buildAppBarTitle() {
    if (_chat == null) {
      return const Text('聊天');
    }

    // 获取聊天标题
    final chatName =
        _chat!.name.isNotEmpty ? _chat!.name : _getParticipantNames();

    // 获取聊天子标题
    String? subtitle;
    if (_chat!.type == ChatType.private) {
      // 获取对方的在线状态
      final otherUserId = _chat!.participantIds.firstWhere(
        (id) => id != _currentUserId,
        orElse: () => '',
      );

      final otherUser = _participants[otherUserId];
      if (otherUser != null && otherUser.status == UserStatus.online) {
        subtitle = '在线';
      }
    } else {
      // 显示群成员数量
      subtitle = '${_chat!.participantIds.length} 位成员';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(chatName),
        if (subtitle != null)
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
          ),
      ],
    );
  }

  /// 获取参与者名称
  String _getParticipantNames() {
    if (_chat == null || _participants.isEmpty) return '';

    if (_chat!.type == ChatType.private) {
      // 直接聊天，显示对方名称
      final otherUserId = _chat!.participantIds.firstWhere(
        (id) => id != _currentUserId,
        orElse: () => '',
      );

      final otherUser = _participants[otherUserId];
      return otherUser?.displayName ?? '';
    } else {
      // 群聊，显示所有参与者名称（最多3个）
      final names =
          _participants.values.map((user) => user.displayName).take(3).toList();

      if (_participants.length > 3) {
        names.add('等${_participants.length}人');
      }

      return names.join(', ');
    }
  }

  /// 构建空聊天提示
  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无消息',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建消息列表
  Widget _buildMessageList() {
    if (_messages.isEmpty) {
      return _buildEmptyChat();
    }

    return MessageList(
      messages: _messages,
      chat: _chat,
      participants: _participants,
      currentUserId: _currentUserId,
      scrollController: _scrollController,
      reverse: true,
      isLoadingMore: _isLoadingMore,
      onLoadMore: _loadMoreMessages,
      showNewMessageButton: false,
    );
  }

  /// 构建输入区域
  Widget _buildInputArea() {
    return MessageInput(
      disabled: _isSending,
      hintText: '输入消息...',
      onSendText: _handleSendMessage,
      onSendImage: _handleSendImage,
    );
  }
}
