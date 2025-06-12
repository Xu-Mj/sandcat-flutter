// lib/features/chat/presentation/widgets/chat_avatar.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar;
import 'package:im_flutter/core/database/tables/chat_table.dart';
import 'dart:convert';

class ChatAvatar extends StatelessWidget {
  final ChatType chatType;
  final String? avatarUrl;
  final double radius;
  final bool showOnlineIndicator;

  const ChatAvatar({
    super.key,
    required this.chatType,
    this.avatarUrl,
    this.radius = 20,
    this.showOnlineIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    if (chatType == ChatType.group) {
      return _buildGroupAvatar();
    } else {
      return _buildSingleAvatar();
    }
  }

  Widget _buildSingleAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: CupertinoColors.systemGrey5,
          backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
              ? NetworkImage(avatarUrl!)
              : null,
          child: avatarUrl == null || avatarUrl!.isEmpty
              ? Icon(
                  CupertinoIcons.person_fill,
                  size: radius * 1.2,
                  color: CupertinoColors.systemGrey,
                )
              : null,
        ),
        if (showOnlineIndicator)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.5,
              height: radius * 0.5,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupAvatar() {
    // 处理群聊多头像
    List<String> avatarUrls = [];

    if (avatarUrl != null) {
      try {
        if (avatarUrl is String) {
          // 如果是字符串，尝试解析JSON
          if (avatarUrl!.isNotEmpty) {
            try {
              final dynamic decoded = jsonDecode(avatarUrl!);
              if (decoded is List) {
                avatarUrls = decoded.map((url) => url.toString()).toList();
              } else if (decoded is Map) {
                avatarUrls =
                    decoded.values.map((url) => url.toString()).toList();
              }
            } catch (e) {
              // 如果不是JSON，可能是单个URL或逗号分隔的URL列表
              avatarUrls = avatarUrl!
                  .split(',')
                  .where((url) => url.trim().isNotEmpty)
                  .toList();
            }
          }
        } else if (avatarUrl is List) {
          // 直接是列表
          avatarUrls =
              (avatarUrl as List).map((url) => url.toString()).toList();
        } else if (avatarUrl is Map) {
          // 直接是Map
          avatarUrls =
              (avatarUrl as Map).values.map((url) => url.toString()).toList();
        }
      } catch (e) {
        debugPrint('Error parsing avatar URLs: $e');
      }
    }

    // 如果没有有效的头像，显示默认头像
    if (avatarUrls.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: CupertinoColors.systemGrey5,
        child: Icon(
          CupertinoIcons.group_solid,
          size: radius * 1.2,
          color: CupertinoColors.systemGrey,
        ),
      );
    }

    // 限制最多显示4个头像
    avatarUrls = avatarUrls.take(4).toList();

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemGrey6,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: avatarUrls.length == 1
            ? Image.network(
                avatarUrls[0],
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
                errorBuilder: (context, error, stackTrace) => Icon(
                  CupertinoIcons.group_solid,
                  size: radius * 1.2,
                  color: CupertinoColors.systemGrey,
                ),
              )
            : _buildMultiAvatar(avatarUrls),
      ),
    );
  }

  Widget _buildMultiAvatar(List<String> avatarUrls) {
    final int count = avatarUrls.length;
    const double padding = 2.0;

    return Container(
      padding: const EdgeInsets.all(padding),
      child: GridView.count(
        crossAxisCount: count <= 2 ? 1 : 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: padding,
        crossAxisSpacing: padding,
        children: avatarUrls.map((url) {
          return ClipRRect(
            borderRadius:
                BorderRadius.circular(count == 1 ? radius : radius / 2),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: CupertinoColors.systemGrey5,
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: count == 1 ? radius : radius / 2,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
