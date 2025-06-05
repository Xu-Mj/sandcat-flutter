import 'package:flutter/material.dart';
import 'dart:async';

import '../../data/storage/repository/chat/chat_model.dart';
import '../../data/storage/repository/message/message_model.dart';
import '../../data/storage/repository/user/user_model.dart';
import '../../providers/repository_provider.dart';
import 'message_list.dart'; // 导入消息列表组件

/// 扩展Chat类添加memberCount计算属性
extension ChatExtension on Chat {
  /// 获取成员数量
  int get memberCount => participantIds.length;
}

/// 自定义滚动行为，移除滚动阴影效果
class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 移除过度滚动发光效果
  }
}

/// 桌面端聊天界面
/// 包含更多的功能和更好的布局
class DesktopChatScreen extends StatefulWidget {
  final String chatId;
  final Function()? onBack;

  const DesktopChatScreen({
    Key? key,
    required this.chatId,
    this.onBack,
  }) : super(key: key);

  @override
  State<DesktopChatScreen> createState() => _DesktopChatScreenState();
}

class _DesktopChatScreenState extends State<DesktopChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];
  User? _currentUser;
  Chat? _chat;

  StreamSubscription<List<Message>>? _messagesSubscription;
  bool _isLoadingMore = false;
  bool _hasMoreMessages = true;
  bool _hasNewMessage = false;

  // 添加一个只在发送消息后滚动的标记
  bool _shouldScrollAfterSend = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(DesktopChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果chatId变化了，重新加载数据
    if (oldWidget.chatId != widget.chatId) {
      // 取消旧的流订阅
      _messagesSubscription?.cancel();
      _messagesSubscription = null;

      // 清空消息列表
      setState(() {
        _messages = [];
        _chat = null;
        _isLoadingMore = false;
        _hasMoreMessages = true;
      });

      // 重新加载数据
      _loadData();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messagesSubscription?.cancel();
    super.dispose();
  }

  void _loadData() async {
    final chatRepository = RepositoryProvider.chatRepository(context);
    final messageRepository = RepositoryProvider.messageRepository(context);
    final userRepository = RepositoryProvider.userRepository(context);

    // 获取当前用户
    _currentUser = await userRepository.getCurrentUser();

    // 获取聊天信息
    _chat = await chatRepository.getChat(widget.chatId);
    if (_chat == null) {
      // 如果聊天不存在，可能需要显示错误或返回
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('找不到该聊天')),
        );
      }
      return;
    }

    // 获取消息列表
    _messages = await messageRepository.getMessages(widget.chatId, limit: 20);

    // 订阅消息列表流，而不是单个消息流
    _setupMessageListSubscription();

    // 标记聊天为已读
    await chatRepository.markChatAsRead(widget.chatId);

    if (mounted) {
      setState(() {
        _hasNewMessage = false;
      });

      // 仅在首次加载时滚动到底部，使用微任务确保在布局完成后执行
      Future.microtask(() {
        // 使用jumpTo直接跳转到底部，无动画
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    }
  }

  void _setupMessageListSubscription() {
    final messageRepository = RepositoryProvider.messageRepository(context);
    _messagesSubscription = messageRepository
        .getMessageListStream(widget.chatId)
        .listen((updatedMessages) {
      if (mounted) {
        // 检查是否有新消息
        bool hasNewMessages = false;
        if (_messages.isNotEmpty && updatedMessages.isNotEmpty) {
          // 比较最后一条消息的ID，判断是否有新消息
          final lastMessageId = _messages.last.id;
          hasNewMessages = updatedMessages.last.id != lastMessageId;
        }

        setState(() {
          _messages = updatedMessages;

          // 只有在发送消息后才滚动到底部
          if (_shouldScrollAfterSend) {
            Future.microtask(() {
              _scrollToBottom();
              _shouldScrollAfterSend = false;
            });
          }
          // 如果不是用户发送的消息，显示有新消息提示
          else if (hasNewMessages) {
            // 只有当用户在看底部时才自动滚动
            if (_isUserAtBottom()) {
              _scrollToBottom();
            } else {
              // 设置新消息提示
              _hasNewMessage = true;
            }
          }
        });
      }
    });
  }

  // 检查用户是否在底部附近
  bool _isUserAtBottom() {
    if (!_scrollController.hasClients) return true;

    final position = _scrollController.position;
    // 如果用户滚动位置在距离底部50像素内，认为是在底部
    return position.pixels > position.maxScrollExtent - 50;
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // 直接跳转到底部，无动画
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
  }

  void _loadMoreMessages() async {
    if (!_hasMoreMessages || _isLoadingMore || _messages.isEmpty) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    final messageRepository = RepositoryProvider.messageRepository(context);
    final earliestMessage = _messages.first;

    try {
      final olderMessages = await messageRepository.getMessages(
        widget.chatId,
        limit: 20,
        before: earliestMessage.createdAt,
      );

      if (mounted) {
        setState(() {
          if (olderMessages.isNotEmpty) {
            _messages.insertAll(0, olderMessages);
          } else {
            _hasMoreMessages = false;
          }
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  void _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _currentUser == null) {
      return;
    }

    _messageController.clear();

    // 设置发送后应该滚动的标记
    _shouldScrollAfterSend = true;

    final messageRepository = RepositoryProvider.messageRepository(context);
    try {
      await messageRepository.sendTextMessage(
        chatId: widget.chatId,
        content: text,
      );

      // 发送成功后就不需要"新消息"提示了
      if (mounted) {
        setState(() {
          _hasNewMessage = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送消息失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chat != null
          ? AppBar(
              leading: widget.onBack != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: widget.onBack,
                    )
                  : null,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        _chat!.avatar != null && _chat!.avatar!.isNotEmpty
                            ? NetworkImage(_chat!.avatar!)
                            : null,
                    child: _chat!.avatar == null || _chat!.avatar!.isEmpty
                        ? Text(
                            _chat!.name.isNotEmpty
                                ? _chat!.name[0].toUpperCase()
                                : '?',
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _chat!.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (_chat!.type == ChatType.group)
                          Text(
                            '${_chat!.memberCount ?? 0} 位成员',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // TODO: 实现搜索功能
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: 显示更多选项
                  },
                ),
              ],
            )
          : null,
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: const Text('暂无消息，发送一条消息开始聊天吧！'),
                  )
                : MessageList(
                    messages: _messages,
                    chat: _chat,
                    participants: {
                      if (_currentUser != null) _currentUser!.id: _currentUser!,
                    },
                    currentUserId: _currentUser?.id ?? '',
                    scrollController: _scrollController,
                    isLoadingMore: _isLoadingMore,
                    onLoadMore: _loadMoreMessages,
                    reverse: true, // 保持最新消息在底部
                    showNewMessageButton: _hasNewMessage,
                    onNewMessageButtonPressed: () {
                      _scrollToBottom();
                      setState(() {
                        _hasNewMessage = false;
                      });
                    },
                  ),
          ),

          // 如果聊天加载完成才显示输入框
          if (_chat != null) ...[
            // 分隔线
            const Divider(height: 1),

            // 底部输入栏
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 表情按钮
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      // TODO: 显示表情选择器
                    },
                  ),

                  // 附件按钮
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: 显示附件选择器
                    },
                  ),

                  // 消息输入框
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 5,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      decoration: const InputDecoration(
                        hintText: '输入消息...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),

                  // 发送按钮
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
