import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandcat/core/db/app.dart';

class FriendListItem extends StatelessWidget {
  final Friend friend;
  final VoidCallback onTap;
  final Function(bool) onToggleStar;
  final bool isSelected;

  const FriendListItem({
    super.key,
    required this.friend,
    required this.onTap,
    required this.onToggleStar,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color:
              isSelected ? CupertinoColors.systemBlue.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            // 好友头像 - 这里应该显示用户信息中的头像，暂时使用占位符
            Hero(
              tag: 'friend_avatar_${friend.fsId}',
              child: CircleAvatar(
                radius: 25,
                backgroundColor: CupertinoColors.systemBlue,
                child: Text(
                  // 使用备注或ID的第一个字符作为占位符，确保不会出现空字符串
                  _getAvatarText(friend),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // 好友信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 优先显示备注，没有则显示好友ID
                    friend.remark == null || friend.remark!.isEmpty
                        ? friend.name
                        : friend.remark!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    // 显示状态或其他信息
                    friend.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),

            // 星标图标
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                friend.isStarred
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
                color: friend.isStarred
                    ? CupertinoColors.systemYellow
                    : CupertinoColors.systemGrey,
                size: 22,
              ),
              onPressed: () {
                onToggleStar(!friend.isStarred);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getAvatarText(Friend friend) {
    if (friend.remark != null && friend.remark!.isNotEmpty) {
      return friend.remark!.substring(0, 1).toUpperCase();
    } else if (friend.friendId.isNotEmpty) {
      return friend.name.substring(0, 1).toUpperCase();
    } else {
      return '?';
    }
  }
}
