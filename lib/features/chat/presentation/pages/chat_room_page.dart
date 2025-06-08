import 'package:flutter/cupertino.dart';
import '../widgets/chat_message_item.dart';

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
  bool _isAttachmentMenuVisible = false;

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
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
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

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate message sent
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _mockMessages.last['status'] = 'sent';
      });

      // Simulate message delivered
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _mockMessages.last['status'] = 'delivered';
        });
      });
    });
  }

  void _toggleAttachmentMenu() {
    setState(() {
      _isAttachmentMenuVisible = !_isAttachmentMenuVisible;
    });
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // 处理消息点击事件
  void _handleMessageTap(Map<String, dynamic> message) {
    // 暂时只打印消息内容，后续可以实现更多功能
    debugPrint('Message tapped: ${message['content']}');
  }

  // 处理消息长按事件
  void _handleMessageLongPress(Map<String, dynamic> message) {
    // 显示操作菜单
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // 复制消息内容
              // TODO: 实现复制功能
              debugPrint('Copy: ${message['content']}');
            },
            child: const Text('复制'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // 转发消息
              // TODO: 实现转发功能
              debugPrint('Forward: ${message['content']}');
            },
            child: const Text('转发'),
          ),
          if (message['senderId'] == 'me')
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                // 删除消息
                // TODO: 实现删除功能
                debugPrint('Delete: ${message['content']}');
              },
              isDestructiveAction: true,
              child: const Text('删除'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Column(
              mainAxisSize: MainAxisSize.min,
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
          // Messages list
          Expanded(
            child: SafeArea(
              bottom: false,
              child: GestureDetector(
                onTap: () {
                  // Dismiss attachment menu when tapping on messages
                  if (_isAttachmentMenuVisible) {
                    setState(() {
                      _isAttachmentMenuVisible = false;
                    });
                  }
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _mockMessages.length,
                  itemBuilder: (context, index) {
                    final message = _mockMessages[index];
                    return ChatMessageItem(
                      message: message,
                      onTap: () => _handleMessageTap(message),
                      onLongPress: () => _handleMessageLongPress(message),
                      formatTimeFunc: _formatTime,
                    );
                  },
                ),
              ),
            ),
          ),

          // Attachment menu
          if (_isAttachmentMenuVisible)
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: CupertinoColors.systemGrey5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAttachmentOption(
                    icon: CupertinoIcons.photo,
                    label: 'Photos',
                    onTap: () {
                      // TODO: Open photo picker
                      _toggleAttachmentMenu();
                    },
                  ),
                  _buildAttachmentOption(
                    icon: CupertinoIcons.camera,
                    label: 'Camera',
                    onTap: () {
                      // TODO: Open camera
                      _toggleAttachmentMenu();
                    },
                  ),
                  _buildAttachmentOption(
                    icon: CupertinoIcons.doc,
                    label: 'Document',
                    onTap: () {
                      // TODO: Open file picker
                      _toggleAttachmentMenu();
                    },
                  ),
                  _buildAttachmentOption(
                    icon: CupertinoIcons.location,
                    label: 'Location',
                    onTap: () {
                      // TODO: Share location
                      _toggleAttachmentMenu();
                    },
                  ),
                ],
              ),
            ),

          // Message input - 使用SafeArea包装
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: CupertinoColors.systemGrey5),
                ),
              ),
              child: Row(
                children: [
                  // Attachment button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.plus_circle,
                      color: _isAttachmentMenuVisible
                          ? CupertinoColors.systemBlue
                          : CupertinoColors.systemGrey,
                    ),
                    onPressed: _toggleAttachmentMenu,
                  ),

                  // Text input
                  Expanded(
                    child: CupertinoTextField(
                      controller: _messageController,
                      placeholder: 'Message',
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),

                  // Send button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      CupertinoIcons.arrow_up_circle_fill,
                      color: CupertinoColors.systemBlue,
                      size: 30,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: CupertinoColors.systemBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
