import 'package:flutter/cupertino.dart';
import 'package:im_flutter/features/chat/presentation/widgets/chat_input_area.dart';
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

  // Mock data for demonstration
  final Map<String, dynamic> _chatInfo = {
    'id': '1',
    'name': '张三',
    'avatar': 'assets/images/avatars/avatar1.png',
    'online': true,
  };

  final List<Map<String, dynamic>> _mockMessages = [
    {
      'id': '1',
      'senderId': 'other',
      'content': 'Hey there!',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      'status': 'read',
    },
    {
      'id': '2',
      'senderId': 'me',
      'content': 'Hi! How are you?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 25)),
      'status': 'read',
    },
    {
      'id': '3',
      'senderId': 'other',
      'content': 'I\'m good, thanks! Just wanted to check in.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 24)),
      'status': 'read',
    },
    {
      'id': '4',
      'senderId': 'me',
      'content':
          'That\'s nice of you. I\'ve been working on that project we discussed last week.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 20)),
      'status': 'read',
    },
    {
      'id': '5',
      'senderId': 'other',
      'content': 'Oh great! How\'s it going?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 18)),
      'status': 'read',
    },
    {
      'id': '6',
      'senderId': 'me',
      'content':
          'Making good progress! I should have something to show you by the end of the week.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'status': 'delivered',
    },
    {
      'id': '7',
      'senderId': 'other',
      'content': 'That sounds excellent! Looking forward to seeing it.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
      'status': 'read',
    },
    {
      'id': '8',
      'senderId': 'other',
      'content': 'Oh great! How\'s it going?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 18)),
      'status': 'read',
    },
    {
      'id': '9',
      'senderId': 'me',
      'content':
          'Making good progress! I should have something to show you by the end of the week.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'status': 'delivered',
    },
    {
      'id': '10',
      'senderId': 'other',
      'content': 'That sounds excellent! Looking forward to seeing it.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 10)),
      'status': 'read',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    if (message.isEmpty) return;

    setState(() {
      _mockMessages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'senderId': 'me',
        'content': message,
        'timestamp': DateTime.now(),
        'status': 'sending',
      });

      _messageController.clear();
    });

    _scrollToBottom();

    _simulateMessageStatusChanges();
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 处理消息操作
  void _handleMessageAction(String action, Map<String, dynamic> message) {
    switch (action) {
      case 'tap':
        debugPrint('Tapped message: ${message['content']}');
        break;
      case 'copy':
        debugPrint('Copied: ${message['content']}');
        // TODO: 实现复制功能
        break;
      case 'forward':
        debugPrint('Forward: ${message['content']}');
        // TODO: 实现转发功能
        break;
      case 'reply':
        debugPrint('Reply to: ${message['content']}');
        // TODO: 实现回复功能
        break;
      case 'edit':
        if (message['senderId'] == 'me') {
          debugPrint('Edit: ${message['content']}');
          // TODO: 实现编辑功能
        }
        break;
      case 'delete':
        if (message['senderId'] == 'me') {
          debugPrint('Delete: ${message['content']}');
          // TODO: 删除消息的真实逻辑
          setState(() {
            _mockMessages.removeWhere((msg) => msg['id'] == message['id']);
          });
        }
        break;
    }
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
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CupertinoColors.systemBlue,
            ),
            child: const Icon(
              CupertinoIcons.person_fill,
              color: CupertinoColors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),

          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _chatInfo['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _chatInfo['online'] ? 'Online' : 'Last seen recently',
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

  // 构建消息列表
  Widget _buildMessagesList() {
    _scrollToBottom(needAnimate: false);
    return GestureDetector(
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: _mockMessages.length,
        itemBuilder: (context, index) {
          final message = _mockMessages[index];
          return ChatMessageItem(
            message: message,
            formatTimeFunc: _formatTime,
            onAction: _handleMessageAction,
          );
        },
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
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      }
    });
  }

  void _simulateMessageStatusChanges() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (_mockMessages.isNotEmpty) {
            _mockMessages.last['status'] = 'sent';
          }
        });

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              if (_mockMessages.isNotEmpty) {
                _mockMessages.last['status'] = 'delivered';
              }
            });
          }
        });
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
        middle: Text(
          _chatInfo['name'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
