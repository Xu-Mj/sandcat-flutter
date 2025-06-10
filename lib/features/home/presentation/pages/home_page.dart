import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

import '../../../../app/widgets/app_scaffold.dart';
import '../../../utils/responsive_layout.dart';
import '../../../chat/presentation/pages/chat_list_page.dart';
import '../../../chat/presentation/pages/chat_room_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';

/// Home page with responsive layout
class HomePage extends StatefulWidget {
  /// Creates a home page
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? _selectedChatId;

  final List<Widget> _tabs = [
    const ChatListPage(),
    const SettingsPage(),
  ];

  // 选择一个聊天
  void _onChatSelected(String chatId) {
    setState(() {
      _selectedChatId = chatId;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 根据设备类型构建不同的布局
    return AppScaffold(
      title: 'SandCat',
      child: ResponsiveLayout.builder(
        context: context,
        // 移动端布局 - 使用标准的底部标签页
        mobile: _buildMobileLayout(),
        // 桌面端布局 - 使用分栏视图
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  // 移动端布局
  Widget _buildMobileLayout() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            activeIcon: Icon(CupertinoIcons.settings_solid),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return _tabs[index];
          },
        );
      },
    );
  }

  // 桌面端布局
  Widget _buildDesktopLayout() {
    return CupertinoPageScaffold(
      child: Row(
        children: [
          // 侧边导航栏
          Container(
            width: 80,
            color: CupertinoColors.systemBackground,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // 聊天按钮
                _buildNavButton(
                  icon: _currentIndex == 0
                      ? CupertinoIcons.chat_bubble_2_fill
                      : CupertinoIcons.chat_bubble_2,
                  isSelected: _currentIndex == 0,
                  onTap: () => setState(() {
                    _currentIndex = 0;
                  }),
                ),
                // 设置按钮
                _buildNavButton(
                  icon: _currentIndex == 1
                      ? CupertinoIcons.settings_solid
                      : CupertinoIcons.settings,
                  isSelected: _currentIndex == 1,
                  onTap: () => setState(() {
                    _currentIndex = 1;
                    _selectedChatId = null;
                  }),
                ),
              ],
            ),
          ),

          // 主内容区域
          Expanded(
            child: Row(
              children: [
                // 会话列表面板
                Expanded(
                  flex: 1,
                  child: _buildChatListWrapper(),
                ),

                // 聊天详情或空状态面板
                if (_currentIndex == 0)
                  Expanded(
                    flex: 2,
                    child: _selectedChatId != null
                        ? ChatRoomPage(chatId: _selectedChatId!)
                        : _buildEmptyChatPanel(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建导航按钮
  Widget _buildNavButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? CupertinoColors.activeBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected
              ? CupertinoColors.activeBlue
              : CupertinoColors.inactiveGray,
          size: 28,
        ),
      ),
    );
  }

  // 构建聊天列表包装器
  Widget _buildChatListWrapper() {
    return IndexedStack(
      index: _currentIndex,
      sizing: StackFit.expand,
      children: [
        // 聊天列表，带有选择回调
        ChatListPage(
          onChatSelected:
              ResponsiveLayout.isDesktop(context) ? _onChatSelected : null,
        ),
        // 设置页面
        const SettingsPage(),
      ],
    );
  }

  // 未选择会话时的空面板
  Widget _buildEmptyChatPanel() {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chat_bubble_text,
              size: 80,
              color: CupertinoColors.systemGrey,
            ),
            SizedBox(height: 20),
            Text(
              '选择一个会话开始聊天',
              style: TextStyle(
                fontSize: 18,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
