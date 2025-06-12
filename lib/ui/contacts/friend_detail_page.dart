import 'package:drift/drift.dart' hide Column;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide Column, Tab, TabBar, TabBarView, TabController;
import 'package:get_it/get_it.dart';
import 'package:im_flutter/core/db/app.dart';
import 'package:im_flutter/core/db/friend_repo.dart';

class FriendDetailPage extends StatefulWidget {
  final String friendId;
  final bool isEmbedded;

  const FriendDetailPage({
    super.key,
    required this.friendId,
    this.isEmbedded = false,
  });

  @override
  State<FriendDetailPage> createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  final FriendRepository _friendRepository = GetIt.instance<FriendRepository>();
  late Future<Friend?> _friendFuture;
  late Future<List<FriendTag>> _tagsFuture;
  late Future<FriendNote?> _noteFuture;
  // 当前选中的标签索引
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadFriend();
    _loadTags();
    _loadNote();
  }

  void _loadFriend() {
    _friendFuture = _friendRepository.getFriend(widget.friendId);
    setState(() {});
  }

  void _loadTags() {
    _tagsFuture = _friendRepository.getFriendTagsByFriendId(widget.friendId);
    setState(() {});
  }

  void _loadNote() {
    _noteFuture = _friendRepository.getFriendNote(widget.friendId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 确定是否为嵌入式模式（用于桌面端）
    final Widget content = SafeArea(
      child: FutureBuilder<Friend?>(
        future: _friendFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('加载失败: ${snapshot.error}'),
            );
          }

          final friend = snapshot.data;
          if (friend == null) {
            return const Center(
              child: Text('未找到好友信息'),
            );
          }

          return Column(
            children: [
              // 用户信息卡片
              _buildUserInfoCard(friend),

              // 分段控件替代标签栏
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSegmentedControl<int>(
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('好友资料'),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('标签'),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('备忘录'),
                    ),
                  },
                  onValueChanged: (int index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                  groupValue: _currentTabIndex,
                ),
              ),

              // 标签内容
              Expanded(
                child: IndexedStack(
                  index: _currentTabIndex,
                  children: [
                    // 好友资料标签
                    _buildProfileTab(friend),

                    // 标签标签
                    _buildTagsTab(),

                    // 备忘录标签
                    _buildNoteTab(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // 如果是嵌入式模式，直接返回内容；否则包装在CupertinoPageScaffold中
    if (widget.isEmbedded) {
      return content;
    } else {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          heroTag: 'friend_detail',
          middle: Text('好友详情'),
          transitionBetweenRoutes: false,
        ),
        child: content,
      );
    }
  }

  Widget _buildUserInfoCard(Friend friend) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: CupertinoColors.systemBackground,
      child: Column(
        children: [
          // 头像和名称
          Row(
            children: [
              // 头像
              Hero(
                tag: 'friend_avatar_${friend.id}',
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: CupertinoColors.systemBlue,
                  child: Text(
                    friend.remark?.substring(0, 1).toUpperCase() ??
                        friend.friendId.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // 名称和状态
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          friend.remark ?? friend.friendId,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (friend.isStarred)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              CupertinoIcons.star_fill,
                              color: CupertinoColors.systemYellow,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${friend.friendId}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(friend.status)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _getStatusText(friend.status),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(friend.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 快捷操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: CupertinoIcons.chat_bubble_2_fill,
                label: '发消息',
                onTap: () {
                  // 导航到聊天页面
                  Navigator.pop(context, friend.id);
                },
              ),
              _buildActionButton(
                icon: CupertinoIcons.star,
                label: friend.isStarred ? '取消星标' : '设为星标',
                onTap: () async {
                  await _friendRepository.toggleStarFriend(
                      friend.id, !friend.isStarred);
                  _loadFriend();
                },
              ),
              _buildActionButton(
                icon: CupertinoIcons.person_badge_minus,
                label: '删除好友',
                onTap: () {
                  _showDeleteConfirmation(context, friend);
                },
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(Friend friend) {
    return ListView(
      children: [
        const SizedBox(height: 16),

        // 基本信息卡片
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildInfoRow('备注', friend.remark ?? '未设置', onTap: () {
                _showEditRemarkDialog(context, friend);
              }),
              _buildDivider(),
              _buildInfoRow('分组', '默认分组', onTap: () {
                _showGroupSelectionDialog(context, friend);
              }),
              _buildDivider(),
              _buildInfoRow('状态', _getStatusText(friend.status)),
              _buildDivider(),
              _buildInfoRow('来源', friend.source ?? '未知'),
              _buildDivider(),
              _buildInfoRow('添加时间', _formatTimestamp(friend.createTime)),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 隐私设置卡片
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
                child: Text(
                  '隐私设置',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
              ),
              _buildDivider(),
              _buildSwitchRow('发现对方可见', true),
              _buildDivider(),
              _buildSwitchRow('朋友圈可见', true),
              _buildDivider(),
              _buildSwitchRow('状态可见', true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsTab() {
    return FutureBuilder<List<FriendTag>>(
      future: _tagsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('加载失败: ${snapshot.error}'),
          );
        }

        final tags = snapshot.data ?? [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton.filled(
                child: const Text('添加标签'),
                onPressed: () {
                  _showAddTagDialog(context);
                },
              ),
            ),
            Expanded(
              child: tags.isEmpty
                  ? const Center(
                      child: Text(
                        '暂无标签',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: tags.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final tag = tags[index];
                        return ListTile(
                          leading: Icon(
                            CupertinoIcons.tag_fill,
                            color: Color(
                                int.parse(tag.color.replaceAll('#', '0xFF'))),
                          ),
                          title: Text(tag.name),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(
                              CupertinoIcons.clear_circled,
                              color: CupertinoColors.systemGrey,
                            ),
                            onPressed: () async {
                              await _friendRepository.removeTagFromFriend(
                                  widget.friendId, tag.id);
                              _loadTags();
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNoteTab() {
    return FutureBuilder<FriendNote?>(
      future: _noteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('加载失败: ${snapshot.error}'),
          );
        }

        final note = snapshot.data;
        final noteController = TextEditingController(
          text: note?.content ?? '',
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: noteController,
                  placeholder: '添加备忘录...',
                  maxLines: null,
                  expands: true,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CupertinoColors.systemGrey4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CupertinoButton.filled(
                child: const Text('保存备忘录'),
                onPressed: () async {
                  await _friendRepository.saveFriendNote(
                    widget.friendId,
                    noteController.text.trim(),
                  );
                  _loadNote();
                  // 显示保存成功提示
                  if (mounted) {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('保存成功'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('确定'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isDestructive
                  ? CupertinoColors.systemRed
                  : CupertinoColors.systemBlue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: CupertinoColors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isDestructive
                  ? CupertinoColors.systemRed
                  : CupertinoColors.label,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {VoidCallback? onTap}) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          if (onTap != null) ...[
            const SizedBox(width: 8),
            const Icon(
              CupertinoIcons.forward,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: row,
      );
    }

    return row;
  }

  Widget _buildSwitchRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: (newValue) {
              // 更新隐私设置
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
    );
  }

  void _showEditRemarkDialog(BuildContext context, Friend friend) {
    final remarkController = TextEditingController(text: friend.remark);

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('设置备注'),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: CupertinoTextField(
            controller: remarkController,
            placeholder: '请输入备注',
            autofocus: true,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('保存'),
            onPressed: () async {
              final remark = remarkController.text.trim();
              // 更新备注
              await _friendRepository.updateFriend(
                FriendsCompanion(
                  id: Value(friend.id),
                  remark: Value(remark.isEmpty ? null : remark),
                ),
              );
              _loadFriend();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showGroupSelectionDialog(BuildContext context, Friend friend) {
    // 这里应该加载分组列表，简化处理
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('选择分组'),
        content: const Text('暂不支持分组选择'),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAddTagDialog(BuildContext context) {
    // 这里应该加载标签列表，简化处理
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('添加标签'),
        content: const Text('暂不支持添加标签'),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Friend friend) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('删除好友'),
        content: Text('确定要删除 ${friend.remark ?? friend.friendId} 吗？此操作不可撤销。'),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('删除'),
            onPressed: () async {
              Navigator.pop(context);
              await _friendRepository.deleteFriend(friend.id);
              Navigator.pop(context); // 返回好友列表
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return CupertinoColors.systemGreen;
      case 'Pending':
        return CupertinoColors.systemOrange;
      case 'Rejected':
      case 'Blacked':
      case 'Deleted':
        return CupertinoColors.systemRed;
      case 'Muted':
        return CupertinoColors.systemGrey;
      case 'Hidden':
        return CupertinoColors.systemIndigo;
      default:
        return CupertinoColors.systemGrey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'Accepted':
        return '已添加';
      case 'Pending':
        return '待验证';
      case 'Rejected':
        return '已拒绝';
      case 'Blacked':
        return '已拉黑';
      case 'Deleted':
        return '已删除';
      case 'Muted':
        return '已静音';
      case 'Hidden':
        return '已隐藏';
      default:
        return status;
    }
  }

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
  }
}
