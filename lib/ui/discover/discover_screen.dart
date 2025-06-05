import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../providers/repository_provider.dart';
import '../chat/create_group_screen.dart';

/// 发现页中的功能项
class DiscoverItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
  final Widget? badge;

  DiscoverItem({
    required this.title,
    required this.icon,
    this.iconColor = Colors.blue,
    this.onTap,
    this.badge,
  });
}

/// 发现页面
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // 定义功能列表
    final List<List<DiscoverItem>> sections = [
      // 通讯功能
      [
        DiscoverItem(
          title: '创建群聊',
          icon: Icons.group_add,
          iconColor: Colors.green,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateGroupScreen()));
          },
        ),
        DiscoverItem(
          title: '发起会议',
          icon: Icons.video_call,
          iconColor: Colors.blue,
          onTap: () {
            _showFeatureNotImplemented(context, '视频会议功能尚未实现');
          },
        ),
      ],

      // 第一部分：朋友圈、视频号
      [
        DiscoverItem(
          title: '朋友圈',
          icon: Icons.people_alt,
          iconColor: Colors.blue,
          onTap: () {
            _showFeatureNotImplemented(context, '朋友圈功能尚未实现');
          },
          badge: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        DiscoverItem(
          title: '视频号',
          icon: Icons.videocam,
          iconColor: Colors.orange,
          onTap: () {
            _showFeatureNotImplemented(context, '视频号功能尚未实现');
          },
        ),
      ],

      // 第二部分：扫一扫、摇一摇
      [
        DiscoverItem(
          title: '扫一扫',
          icon: Icons.qr_code_scanner,
          iconColor: Colors.green,
          onTap: () {
            _showFeatureNotImplemented(context, '扫一扫功能尚未实现');
          },
        ),
        DiscoverItem(
          title: '摇一摇',
          icon: Icons.screen_rotation,
          iconColor: Colors.blue,
          onTap: () {
            _showFeatureNotImplemented(context, '摇一摇功能尚未实现');
          },
        ),
      ],

      // 第三部分：附近的人、游戏
      [
        DiscoverItem(
          title: '附近的人',
          icon: Icons.location_on,
          iconColor: Colors.orange,
          onTap: () {
            _showFeatureNotImplemented(context, '附近的人功能尚未实现');
          },
        ),
        DiscoverItem(
          title: '游戏',
          icon: Icons.sports_esports,
          iconColor: Colors.red,
          onTap: () {
            _showFeatureNotImplemented(context, '游戏功能尚未实现');
          },
        ),
      ],

      // 第四部分：小程序
      [
        DiscoverItem(
          title: '小程序',
          icon: Icons.apps,
          iconColor: Colors.blue,
          onTap: () {
            _showFeatureNotImplemented(context, '小程序功能尚未实现');
          },
        ),
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(s.discoverTab),
      ),
      body: ListView.separated(
        itemCount: sections.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, sectionIndex) {
          final section = sections[sectionIndex];

          return Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
            ),
            child: Column(
              children: section
                  .map((item) => _buildDiscoverItem(context, item))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  /// 构建发现项
  Widget _buildDiscoverItem(BuildContext context, DiscoverItem item) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: item.iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item.icon,
          color: item.iconColor,
        ),
      ),
      title: Text(item.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.badge != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: item.badge,
            ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: item.onTap,
    );
  }

  /// 显示功能未实现提示
  void _showFeatureNotImplemented(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
