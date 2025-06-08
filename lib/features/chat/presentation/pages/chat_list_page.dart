import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar;

/// 聊天列表回调函数类型
typedef ChatSelectedCallback = void Function(String chatId);

/// Chat list page
class ChatListPage extends StatefulWidget {
  /// 聊天选择回调
  final ChatSelectedCallback? onChatSelected;

  /// Creates a chat list page
  const ChatListPage({
    super.key,
    this.onChatSelected,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  // Mock data for demonstration
  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': '张三',
      'lastMessage': '你好，在吗？',
      'time': '09:30',
      'unread': 2,
      'avatar': 'assets/images/avatars/avatar1.png',
    },
    {
      'id': '2',
      'name': '李四',
      'lastMessage': '晚上一起吃饭吧',
      'time': '昨天',
      'unread': 0,
      'avatar': 'assets/images/avatars/avatar2.png',
    },
    {
      'id': '3',
      'name': '王五',
      'lastMessage': '项目进展如何了？',
      'time': '周一',
      'unread': 5,
      'avatar': 'assets/images/avatars/avatar3.png',
    },
    {
      'id': '4',
      'name': '工作群',
      'lastMessage': '[张三]: 我已经提交了代码',
      'time': '08:55',
      'unread': 1,
      'avatar': 'assets/images/avatars/avatar4.png',
    },
    {
      'id': '5',
      'name': '家人群',
      'lastMessage': '[妈妈]: 今天晚上回来吃饭吗？',
      'time': '周日',
      'unread': 0,
      'avatar': 'assets/images/avatars/avatar5.png',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onChatTap(String chatId) {
    if (widget.onChatSelected != null) {
      widget.onChatSelected!(chatId);
    } else {
      // 使用导航跳转到聊天室页面
      Navigator.pushNamed(
        context,
        '/chat/$chatId',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: _isSearching
            ? CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search chats',
                onSubmitted: (_) {
                  setState(() {
                    _isSearching = false;
                  });
                },
              )
            : const Text('Chats'),
        trailing: _isSearching
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              )
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.search),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.plus),
          onPressed: () {
            // TODO: Show new chat dialog
          },
        ),
      ),
      child: SafeArea(
        child: ListView.separated(
          itemCount: _chats.length,
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: CupertinoColors.systemGrey5,
          ),
          itemBuilder: (context, index) {
            final chat = _chats[index];
            return CupertinoListTile(
              onTap: () => _onChatTap(chat['id']),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: CupertinoColors.systemBlue.withOpacity(0.2),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: CupertinoColors.systemBlue,
                  size: 30,
                ),
              ),
              title: Text(
                chat['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                chat['lastMessage'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    chat['time'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (chat['unread'] > 0)
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        chat['unread'].toString(),
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
