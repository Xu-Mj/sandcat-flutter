import 'package:flutter/cupertino.dart';

/// 表情类别
enum EmojiCategory {
  recent,
  smileys,
  people,
  animals,
  food,
  activities,
  travel,
  objects,
  symbols,
  flags,
}

/// 表情选择器组件
class EmojiPicker extends StatefulWidget {
  /// 当选择表情时的回调
  final Function(String emoji) onEmojiSelected;

  /// 弹出模式（true为弹出式，false为内嵌式）
  final bool isPopupMode;

  /// 表情面板高度
  final double height;

  /// 触发按钮的引用（用于定位弹出面板）
  final GlobalKey? buttonKey;

  /// 请求关闭面板的回调
  final VoidCallback? onCloseRequest;

  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    this.isPopupMode = true,
    this.height = 250,
    this.buttonKey,
    this.onCloseRequest,
  });

  @override
  State<EmojiPicker> createState() => _EmojiPickerState();
}

class _EmojiPickerState extends State<EmojiPicker>
    with SingleTickerProviderStateMixin {
  EmojiCategory _selectedCategory = EmojiCategory.smileys;
  // 页面控制器，用于滑动切换类别
  late PageController _pageController;

  // 常用表情符号
  final Map<EmojiCategory, List<String>> _emojis = {
    EmojiCategory.recent: ['🕒'], // 最近使用的表情，初始为空
    EmojiCategory.smileys: [
      '😀',
      '😃',
      '😄',
      '😁',
      '😆',
      '😅',
      '🤣',
      '😂',
      '🙂',
      '🙃',
      '😉',
      '😊',
      '😇',
      '😍',
      '🥰',
      '😘',
      '😗',
      '😚',
      '😙',
      '🥲',
      '😋',
      '😛',
      '😜',
      '😝',
      '🤑',
      '🤗',
      '🤭',
      '🤫',
      '🤔',
      '🤐',
      '🤨',
      '😐',
      '😑',
      '😶',
      '😏',
      '😒',
      '🙄',
      '😬',
      '🤥',
      '😌',
    ],
    EmojiCategory.people: [
      '👍',
      '👎',
      '👌',
      '✌️',
      '🤞',
      '🤟',
      '🤘',
      '🤙',
      '👈',
      '👉',
      '👆',
      '👇',
      '☝️',
      '👋',
      '🤚',
      '🖐️',
      '✋',
      '🖖',
      '👏',
      '🙌',
    ],
    EmojiCategory.animals: [
      '🐶',
      '🐱',
      '🐭',
      '🐹',
      '🐰',
      '🦊',
      '🐻',
      '🐼',
      '🐨',
      '🐯',
      '🦁',
      '🐮',
      '🐷',
      '🐸',
      '🐵',
      '🐔',
      '🐧',
      '🐦',
      '🐤',
      '🦆',
    ],
    EmojiCategory.food: [
      '🍎',
      '🍐',
      '🍊',
      '🍋',
      '🍌',
      '🍉',
      '🍇',
      '🍓',
      '🫐',
      '🍈',
      '🍒',
      '🍑',
      '🥭',
      '🍍',
      '🥥',
      '🥝',
      '🍅',
      '🥑',
      '🥦',
      '🥬',
    ],
    EmojiCategory.activities: [
      '⚽',
      '🏀',
      '🏈',
      '⚾',
      '🥎',
      '🎾',
      '🏐',
      '🏉',
      '🎱',
      '🏓',
      '🏸',
      '🥅',
      '🏒',
      '🏑',
      '🥍',
      '🏏',
      '🥌',
      '⛳',
      '🎣',
      '🤿',
    ],
    EmojiCategory.travel: [
      '🚗',
      '🚕',
      '🚙',
      '🚌',
      '🚎',
      '🏎️',
      '🚓',
      '🚑',
      '🚒',
      '🚐',
      '🛻',
      '🚚',
      '🚛',
      '🚜',
      '🛵',
      '🏍️',
      '🛺',
      '🚲',
      '🛴',
      '🛹',
    ],
    EmojiCategory.objects: [
      '⌚',
      '📱',
      '💻',
      '⌨️',
      '🖥️',
      '🖨️',
      '🖱️',
      '🖲️',
      '🕹️',
      '🗜️',
      '💽',
      '💾',
      '💿',
      '📀',
      '📼',
      '📷',
      '📸',
      '📹',
      '🎥',
      '📽️',
    ],
    EmojiCategory.symbols: [
      '❤️',
      '🧡',
      '💛',
      '💚',
      '💙',
      '💜',
      '🖤',
      '🤍',
      '🤎',
      '💔',
      '❣️',
      '💕',
      '💞',
      '💓',
      '💗',
      '💖',
      '💘',
      '💝',
      '💟',
      '☮️',
    ],
    EmojiCategory.flags: [
      '🏁',
      '🚩',
      '🎌',
      '🏴',
      '🏳️',
      '🏳️‍🌈',
      '🏳️‍⚧️',
      '🏴‍☠️',
      '🇦🇫',
      '🇦🇽',
      '🇦🇱',
      '🇩🇿',
      '🇦🇸',
      '🇦🇩',
      '🇦🇴',
      '🇦🇮',
      '🇦🇶',
      '🇦🇬',
      '🇦🇷',
      '🇦🇲',
    ],
  };

  @override
  void initState() {
    super.initState();
    // 初始化PageController，初始页面为当前选中类别的索引
    _pageController = PageController(
      initialPage: EmojiCategory.values.indexOf(_selectedCategory),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: CupertinoColors.systemGrey5,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // 表情符号网格 - 支持滑动切换
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: EmojiCategory.values.length,
              onPageChanged: (index) {
                setState(() {
                  _selectedCategory = EmojiCategory.values[index];
                });
              },
              itemBuilder: (context, index) {
                final category = EmojiCategory.values[index];
                return _buildEmojiGridForCategory(category);
              },
            ),
          ),

          // 分类选择器放在底部
          _buildCategorySelector(),
        ],
      ),
    );
  }

  /// 构建特定类别的表情网格
  Widget _buildEmojiGridForCategory(EmojiCategory category) {
    final emojis = _emojis[category] ?? [];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        final emoji = emojis[index];

        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            try {
              // 先执行外部回调，可能会关闭弹窗
              widget.onEmojiSelected(emoji);

              // 如果弹窗还存在，再更新内部状态
              if (mounted) {
                _addToRecent(emoji);
              }
            } catch (e) {
              debugPrint('Error selecting emoji: $e');
            }
          },
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }

  /// 构建类别选择器
  Widget _buildCategorySelector() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 1.0,
          ),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: EmojiCategory.values.length,
        itemBuilder: (context, index) {
          final category = EmojiCategory.values[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _selectedCategory = category;
                  // 滑动到对应类别页面
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: isSelected
                    ? BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: CupertinoColors.systemGrey5,
                          width: 1.0,
                        ),
                      )
                    : null,
                child: Icon(
                  _getCategoryIcon(category),
                  color: isSelected
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.systemGrey,
                  size: 22,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 获取类别对应的图标
  IconData _getCategoryIcon(EmojiCategory category) {
    switch (category) {
      case EmojiCategory.recent:
        return CupertinoIcons.clock;
      case EmojiCategory.smileys:
        return CupertinoIcons.smiley;
      case EmojiCategory.people:
        return CupertinoIcons.person_2;
      case EmojiCategory.animals:
        return CupertinoIcons.paw;
      case EmojiCategory.food:
        return CupertinoIcons.heart;
      case EmojiCategory.activities:
        return CupertinoIcons.sportscourt;
      case EmojiCategory.travel:
        return CupertinoIcons.car;
      case EmojiCategory.objects:
        return CupertinoIcons.gift;
      case EmojiCategory.symbols:
        return CupertinoIcons.number;
      case EmojiCategory.flags:
        return CupertinoIcons.flag;
    }
  }

  /// 添加到最近使用
  void _addToRecent(String emoji) {
    setState(() {
      // 从原位置删除（如果已存在）
      _emojis[EmojiCategory.recent]?.remove(emoji);

      // 添加到最前面
      _emojis[EmojiCategory.recent]?.insert(0, emoji);

      // 只保留前20个
      if ((_emojis[EmojiCategory.recent]?.length ?? 0) > 20) {
        _emojis[EmojiCategory.recent]?.removeLast();
      }
    });
  }
}

/// 桌面端弹出式表情选择器
class DesktopEmojiPickerPopup extends StatelessWidget {
  /// 触发按钮的引用
  final GlobalKey buttonKey;

  /// 当选择表情时的回调
  final Function(String emoji) onEmojiSelected;

  /// 关闭弹窗的回调
  final VoidCallback onClose;

  const DesktopEmojiPickerPopup({
    super.key,
    required this.buttonKey,
    required this.onEmojiSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // 计算弹窗位置
    final RenderBox? renderBox =
        buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final position = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox?.size;

    // 默认定位在按钮下方
    double top = (position?.dy ?? 0) + (size?.height ?? 0) + 5;
    double left = (position?.dx ?? 0) - 10; // 向左偏移一点，更美观
    const width = 320.0; // 固定宽度
    const height = 350.0; // 固定高度

    // 确保不超出屏幕
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (left + width > screenWidth) {
      left = screenWidth - width - 10;
    }

    // 如果底部空间不够，向上弹出
    if (top + height > screenHeight - 50) {
      top = (position?.dy ?? 0) - height - 5;
    }

    return Stack(
      children: [
        // 透明层，用于捕获点击事件关闭弹窗
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: CupertinoColors.black.withValues(alpha: 0.01),
            ),
          ),
        ),

        // 表情选择器
        Positioned(
          top: top,
          left: left,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: EmojiPicker(
              height: height,
              onEmojiSelected: onEmojiSelected,
              buttonKey: buttonKey,
              onCloseRequest: onClose,
            ),
          ),
        ),
      ],
    );
  }
}

// 全局变量用于防止重复显示表情面板
bool _isEmojiPickerShowing = false;

/// 显示桌面端弹出式表情选择器
void showDesktopEmojiPicker({
  required BuildContext context,
  required GlobalKey buttonKey,
  required Function(String emoji) onEmojiSelected,
}) {
  // 防止重复点击
  if (_isEmojiPickerShowing) return;
  _isEmojiPickerShowing = true;

  // 创建遮罩层
  final OverlayState overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  // 关闭函数
  void closePopup() {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
    _isEmojiPickerShowing = false;
  }

  // 创建遮罩项
  overlayEntry = OverlayEntry(
    builder: (context) => DesktopEmojiPickerPopup(
      buttonKey: buttonKey,
      onEmojiSelected: onEmojiSelected,
      onClose: closePopup,
    ),
  );

  // 插入遮罩层
  overlayState.insert(overlayEntry);
}

/// 移动端显示表情面板
/// 在移动端，表情面板应该从底部弹出
class MobileEmojiPicker extends StatefulWidget {
  /// 当选择表情时的回调
  final Function(String emoji) onEmojiSelected;

  const MobileEmojiPicker({
    super.key,
    required this.onEmojiSelected,
  });

  @override
  State<MobileEmojiPicker> createState() => _MobileEmojiPickerState();
}

class _MobileEmojiPickerState extends State<MobileEmojiPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        // borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey6,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        children: [
          // 顶部栏
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey5,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '表情符号',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('完成'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // 表情选择器
          Expanded(
            child: EmojiPicker(
              onEmojiSelected: widget.onEmojiSelected,
              isPopupMode: false,
              onCloseRequest: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
