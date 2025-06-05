import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../utils/responsive.dart';
import '../chat/chat_list_screen.dart';
import '../contacts/contacts_screen.dart';
import '../discover/discover_screen.dart';
import '../settings/settings_screen.dart';

/// 主页面
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 当前选中的底部导航栏索引
  int _currentIndex = 0;

  // 页面列表
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // 初始化页面列表
    _pages = [
      const ChatListScreen(),
      const ContactsScreen(),
      const DiscoverScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // 使用响应式工具类判断设备类型
    return Responsive.buildResponsiveWidget(
      context: context,
      // 移动端布局 - 底部导航栏，一次显示一个页面
      mobile: _buildMobileLayout(s),
      // 桌面端布局 - 侧边导航栏，显示更宽敞的界面
      desktop: _buildDesktopLayout(s),
      // 平板布局 - 可以使用类似桌面的布局，但尺寸适中
      tablet: _buildTabletLayout(s),
    );
  }

  /// 构建移动端布局
  Widget _buildMobileLayout(S s) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.chat_outlined),
            selectedIcon: const Icon(Icons.chat),
            label: s.homeTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.people_outline),
            selectedIcon: const Icon(Icons.people),
            label: s.contactsTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore),
            label: s.discoverTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: s.settingsTab,
          ),
        ],
      ),
    );
  }

  /// 构建桌面端布局 - 侧边栏导航 + 内容区域
  Widget _buildDesktopLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航栏
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.chat_outlined),
                selectedIcon: const Icon(Icons.chat),
                label: Text(s.homeTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.people_outline),
                selectedIcon: const Icon(Icons.people),
                label: Text(s.contactsTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.explore_outlined),
                selectedIcon: const Icon(Icons.explore),
                label: Text(s.discoverTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: Text(s.settingsTab),
              ),
            ],
          ),

          // 内容区域
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }

  /// 构建平板布局 - 类似桌面布局但尺寸适中
  Widget _buildTabletLayout(S s) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航栏
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.chat_outlined),
                selectedIcon: const Icon(Icons.chat),
                label: Text(s.homeTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.people_outline),
                selectedIcon: const Icon(Icons.people),
                label: Text(s.contactsTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.explore_outlined),
                selectedIcon: const Icon(Icons.explore),
                label: Text(s.discoverTab),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: Text(s.settingsTab),
              ),
            ],
          ),

          // 内容区域
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
    );
  }
}
