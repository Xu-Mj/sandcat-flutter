import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:sandcat/core/db/friend_repo.dart';
import 'package:sandcat/core/db/message_repo.dart';
import 'package:sandcat/core/di/injection.dart';
import 'package:sandcat/core/db/app.dart';
import 'package:sandcat/core/db/tables/chat_table.dart';
import 'package:sandcat/core/db/tables/message_table.dart';
import 'package:sandcat/ui/chat/domain/services/chat_service.dart';
import 'package:sandcat/ui/chat/presentation/widgets/chat_avatar.dart';
import 'package:sandcat/ui/chat/presentation/widgets/chat_input_area.dart';
import '../widgets/chat_message_item.dart';
import '../../../utils/responsive_layout.dart';

/// Chat room page for a specific chat
class ChatRoomPage extends StatefulWidget {
  /// The ID of the chat
  final String chatId;

  /// Creates a chat room page
  const ChatRoomPage({super.key, required this.chatId});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = getIt<ChatService>();
  final MessageRepository _messageDao = getIt<MessageRepository>();
  final FriendRepository _friendRepository = getIt<FriendRepository>();
  Friend? _friend;

  // 聊天信息
  Chat? _chatInfo;

  // 当前用户ID
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadChatInfo();

    // 标记所有消息为已读
    _chatService.markAllMessagesAsRead(widget.chatId);

    // 滚动到最新消息
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(needAnimate: false);
    });
  }

  @override
  void didUpdateWidget(ChatRoomPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当chatId变化时重新加载数据
    if (oldWidget.chatId != widget.chatId) {
      _loadChatInfo();
      _chatService.markAllMessagesAsRead(widget.chatId);

      // 重置滚动控制器
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  Future<void> _loadChatInfo() async {
    final chat = await _chatService.getChatById(widget.chatId);
    final currentUserId = await _chatService.getCurrentUserId();
    final friend = await _friendRepository.getFriend(widget.chatId);
    if (mounted) {
      setState(() {
        _chatInfo = chat;
        _currentUserId = currentUserId;
        _friend = friend;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) async {
    if (message.isEmpty) return;

    try {
      // 发送消息到数据库
      await _chatService.sendTextMessage(
        name: _chatInfo?.name ?? _friend?.name ?? '',
        chatId: widget.chatId,
        content: message,
        senderId: _currentUserId!,
        receiverId:
            _chatInfo?.id ?? _friend?.friendId ?? '', // 在实际应用中需要设置真实的接收者ID
        groupId: _chatInfo?.type == ChatType.group ? widget.chatId : null,
      );

      _scrollToBottom();
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 处理消息操作
  void _handleMessageAction(String action, Message message) async {
    final messageId = message.clientId;

    switch (action) {
      case 'tap':
        debugPrint('Tapped message: ${message.content}');
        break;
      case 'copy':
        debugPrint('Copied: ${message.content}');
        // TODO: 实现复制功能
        break;
      case 'forward':
        debugPrint('Forward: ${message.content}');
        // TODO: 实现转发功能
        break;
      case 'reply':
        debugPrint('Reply to: ${message.content}');
        // TODO: 实现回复功能
        break;
      case 'edit':
        if (message.senderId == _currentUserId) {
          debugPrint('Edit: ${message.content}');
          // TODO: 实现编辑功能
        }
        break;
      case 'delete':
        _chatService.deleteMessage(messageId);
        break;
      case 'resend':
        // 重新发送失败的消息
        if (message.status == MessageStatus.failed.value) {
          try {
            await _chatService.resendMessage(message);
          } catch (e) {
            debugPrint('Error resending message: $e');
          }
        }
        break;
    }
  }

  // 构建消息列表
  Widget _buildMessagesList() {
    return StreamBuilder<List<Message>>(
      stream: _messageDao.watchMessagesByConversationId(widget.chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final messages = snapshot.data ?? [];
        if (messages.isEmpty) {
          return const Center(
            child: Text('No messages yet'),
          );
        }

        // 检查是否有新消息到达，如果有则滚动到底部
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData &&
              _scrollController.hasClients &&
              _scrollController.position.pixels == 0) {
            // 反转列表后，0位置是底部
            _scrollToBottom(needAnimate: true);
          }
        });

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          // 反转列表以使最新消息在底部
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            // 收到新消息且是对方发送的，标记为已读
            if (message.isRead == false) {
              _chatService.markMessageAsRead(message.clientId);
            }

            // 将DB状态映射到MessageStatus
            MessageStatus messageStatus = MessageStatus.success;
            if (message.status == MessageStatus.sending.value) {
              messageStatus = MessageStatus.sending;
            } else if (message.status == MessageStatus.failed.value) {
              messageStatus = MessageStatus.failed;
            }

            return ChatMessageItem(
              message: message,
              formatTimeFunc: _formatTime,
              onAction: _handleMessageAction,
              sendStatus: messageStatus,
            );
          },
        );
      },
    );
  }

  // 构建聊天头部
  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey5),
        ),
      ),
      child: Row(
        children: [
          // 用户头像
          ChatAvatar(
            chatType: _chatInfo?.type ?? ChatType.single,
            avatarUrl: _chatInfo?.avatarUrl,
            radius: 18,
          ),
          const SizedBox(width: 8),

          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _chatInfo?.name ?? 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last active: ${_chatInfo?.updatedAt != null ? _formatTime(_chatInfo!.updatedAt) : 'Unknown'}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),

          // 通话按钮
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.video_camera),
                onPressed: () {
                  // TODO: Start video call
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.phone),
                onPressed: () {
                  // TODO: Start voice call
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建输入区域
  Widget _buildInputArea() {
    return ChatInputArea(
      onSendMessage: _sendMessage,
      scrollMsgList: _scrollToBottom,
    );
  }

  void _scrollToBottom({bool needAnimate = true}) {
    Future.delayed(Duration(milliseconds: needAnimate ? 100 : 0), () {
      if (_scrollController.hasClients) {
        if (needAnimate) {
          _scrollController.animateTo(
            0, // 由于列表被反转，滚动到0位置才是底部
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(0); // 直接跳转到0位置
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 检测是否在桌面模式下被嵌入使用
    final bool isEmbedded = ResponsiveLayout.isDesktop(context) &&
        ModalRoute.of(context)?.settings.name != '/chat/${widget.chatId}';

    // 嵌入模式 - 不使用CupertinoPageScaffold
    if (isEmbedded) {
      return Column(
        children: [
          // 聊天头部
          _buildChatHeader(),

          // 消息列表
          Expanded(child: _buildMessagesList()),

          // 输入区域
          _buildInputArea(),
        ],
      );
    }

    // 独立页面模式 - 使用CupertinoPageScaffold
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'chat_room',
        transitionBetweenRoutes: false,
        // 上下padding给10
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatAvatar(
              chatType: _chatInfo?.type ?? ChatType.single,
              avatarUrl: _chatInfo?.avatarUrl,
              radius: 14,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _chatInfo?.name ?? 'Chat',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.video_camera),
              onPressed: () {
                // TODO: Start video call
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.phone),
              onPressed: () {
                // TODO: Start voice call
              },
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          // 消息列表
          Expanded(
            child: SafeArea(
              bottom: false,
              child: _buildMessagesList(),
            ),
          ),

          // 输入区域 - 带SafeArea
          SafeArea(
            top: false,
            child: _buildInputArea(),
          ),
        ],
      ),
    );
  }
}
