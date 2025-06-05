import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_util;
import '../../generated/l10n.dart';

/// 表情分类模型
class EmojiCategory {
  /// 分类ID
  final String id;

  /// 分类名称
  String name;

  /// 表情列表
  List<EmojiItem> emojis;

  /// 分类排序索引
  int order;

  /// 是否是系统分类
  final bool isSystem;

  EmojiCategory({
    required this.id,
    required this.name,
    required this.emojis,
    required this.order,
    this.isSystem = false,
  });

  /// 从JSON转换
  factory EmojiCategory.fromJson(Map<String, dynamic> json) {
    return EmojiCategory(
      id: json['id'],
      name: json['name'],
      emojis:
          (json['emojis'] as List).map((e) => EmojiItem.fromJson(e)).toList(),
      order: json['order'],
      isSystem: json['isSystem'] ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'emojis': emojis.map((e) => e.toJson()).toList(),
        'order': order,
        'isSystem': isSystem,
      };
}

/// 表情项模型
class EmojiItem {
  /// 表情ID
  final String id;

  /// 表情类型 (unicode/image)
  final String type;

  /// 表情内容（Unicode字符或图片路径）
  final String content;

  /// 表情名称
  final String name;

  /// 使用频率
  int usageCount;

  EmojiItem({
    required this.id,
    required this.type,
    required this.content,
    required this.name,
    this.usageCount = 0,
  });

  /// 从JSON转换
  factory EmojiItem.fromJson(Map<String, dynamic> json) {
    return EmojiItem(
      id: json['id'],
      type: json['type'],
      content: json['content'],
      name: json['name'],
      usageCount: json['usageCount'] ?? 0,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'content': content,
        'name': name,
        'usageCount': usageCount,
      };
}

/// 表情管理器
class EmojiManager {
  /// 所有表情分类
  List<EmojiCategory> _categories = [];

  /// 常用表情列表
  final List<EmojiItem> _frequentlyUsed = [];

  /// 表情配置文件路径
  late String _configPath;

  /// 自定义表情保存目录
  late String _customEmojiDir;

  /// 单例实例
  static final EmojiManager _instance = EmojiManager._internal();

  /// 获取实例
  static EmojiManager get instance => _instance;

  /// 私有构造函数
  EmojiManager._internal();

  /// 初始化
  Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    final baseDir = path_util.join(appDir.path, 'im_emojis');

    // 创建目录
    final dir = Directory(baseDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _configPath = path_util.join(baseDir, 'emoji_config.json');
    _customEmojiDir = path_util.join(baseDir, 'custom');

    // 创建自定义表情目录
    final customDir = Directory(_customEmojiDir);
    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
    }

    // 加载配置
    await _loadConfig();

    // 如果是首次运行，初始化默认数据
    if (_categories.isEmpty) {
      _initializeDefaultData();
      await saveConfig();
    }

    // 构建常用表情列表
    _updateFrequentlyUsed();
  }

  /// 加载配置
  Future<void> _loadConfig() async {
    try {
      final configFile = File(_configPath);
      if (await configFile.exists()) {
        final content = await configFile.readAsString();
        final List<dynamic> jsonData = jsonDecode(content);
        _categories = jsonData.map((e) => EmojiCategory.fromJson(e)).toList();

        // 确保按order排序
        _categories.sort((a, b) => a.order.compareTo(b.order));
      }
    } catch (e) {
      print('加载表情配置失败：$e');
      // 错误时创建空列表
      _categories = [];
    }
  }

  /// 保存配置
  Future<void> saveConfig() async {
    try {
      final configFile = File(_configPath);
      final jsonData = _categories.map((e) => e.toJson()).toList();
      await configFile.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      print('保存表情配置失败：$e');
    }
  }

  /// 初始化默认数据
  void _initializeDefaultData() {
    // 系统Unicode表情
    final unicodeEmojis = [
      '😀',
      '😃',
      '😄',
      '😁',
      '😆',
      '😅',
      '😂',
      '🤣',
      '☺️',
      '😊',
      '😇',
      '🙂',
      '🙃',
      '😉',
      '😌',
      '😍',
      '🥰',
      '😘',
      '😗',
      '😙',
      '😚',
      '😋',
      '😛',
      '😝',
      '😜',
      '🤪',
      '🤨',
      '🧐',
      '🤓',
      '😎',
      '👋',
      '🤚',
      '🖐',
      '✋',
      '🖖',
      '👌',
      '🤌',
      '🤏',
      '✌️',
      '🤞',
      '🫰',
      '🤟',
      '🤘',
      '🤙',
      '👈',
      '👉',
      '👆',
      '🖕',
      '👇',
      '☝️',
      '👍',
      '👎',
      '✊',
      '👊',
      '🤛',
      '🤜',
      '👏',
      '🙌',
      '👐',
      '🤲'
    ];

    // 创建系统表情分类
    List<EmojiItem> systemItems = unicodeEmojis.map((emoji) {
      return EmojiItem(
        id: 'unicode_${unicodeEmojis.indexOf(emoji)}',
        type: 'unicode',
        content: emoji,
        name: 'emoji_${unicodeEmojis.indexOf(emoji)}',
      );
    }).toList();

    _categories.add(EmojiCategory(
      id: 'system_unicode',
      name: '表情',
      emojis: systemItems,
      order: 0,
      isSystem: true,
    ));

    // 添加一个默认的空自定义表情分类
    _categories.add(EmojiCategory(
      id: 'custom_default',
      name: '我的表情',
      emojis: [],
      order: 1,
    ));
  }

  /// 更新常用表情列表
  void _updateFrequentlyUsed() {
    // 从所有分类中收集表情
    List<EmojiItem> allEmojis = [];
    for (var category in _categories) {
      allEmojis.addAll(category.emojis);
    }

    // 按使用频率排序，并取前20个
    allEmojis.sort((a, b) => b.usageCount.compareTo(a.usageCount));
    _frequentlyUsed.clear();
    _frequentlyUsed.addAll(allEmojis.take(20).toList());
  }

  /// 获取所有分类
  List<EmojiCategory> get categories => List.unmodifiable(_categories);

  /// 获取常用表情
  List<EmojiItem> get frequentlyUsed => List.unmodifiable(_frequentlyUsed);

  /// 记录表情使用
  Future<void> recordEmojiUsage(String categoryId, String emojiId) async {
    // 查找表情并增加使用次数
    for (var category in _categories) {
      if (category.id == categoryId) {
        for (var emoji in category.emojis) {
          if (emoji.id == emojiId) {
            emoji.usageCount++;
            break;
          }
        }
        break;
      }
    }

    // 更新常用表情列表
    _updateFrequentlyUsed();

    // 保存配置
    await saveConfig();
  }

  /// 添加自定义表情分类
  Future<EmojiCategory> addCategory(String name) async {
    // 计算最大的排序值
    int maxOrder = 0;
    for (var category in _categories) {
      if (category.order > maxOrder) {
        maxOrder = category.order;
      }
    }

    // 创建新分类
    final newCategory = EmojiCategory(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      emojis: [],
      order: maxOrder + 1,
    );

    _categories.add(newCategory);
    await saveConfig();

    return newCategory;
  }

  /// 移动分类顺序
  Future<void> moveCategoryOrder(String categoryId, int newOrder) async {
    // 如果是表情分类，不允许移动
    if (categoryId == 'system_unicode') return;

    // 获取分类索引
    int categoryIndex = -1;
    for (int i = 0; i < _categories.length; i++) {
      if (_categories[i].id == categoryId) {
        categoryIndex = i;
        break;
      }
    }

    if (categoryIndex == -1) return;

    // 保存当前分类
    final category = _categories[categoryIndex];

    // 表情分类始终保持在位置0
    if (newOrder <= 0) newOrder = 1;

    // 更新所有分类的顺序(除了表情分类)
    for (var cat in _categories) {
      if (cat.order >= newOrder &&
          cat.id != categoryId &&
          cat.id != 'system_unicode') {
        cat.order += 1;
      }
    }

    // 设置新顺序
    category.order = newOrder;

    // 重新排序
    _categories.sort((a, b) => a.order.compareTo(b.order));

    await saveConfig();
  }

  /// 添加自定义表情
  Future<EmojiItem?> addCustomEmoji(
      String categoryId, File emojiFile, String name) async {
    try {
      // 检查分类是否存在
      int categoryIndex = -1;
      for (int i = 0; i < _categories.length; i++) {
        if (_categories[i].id == categoryId) {
          categoryIndex = i;
          break;
        }
      }

      if (categoryIndex == -1) return null;

      // 复制文件到自定义表情目录
      final fileName =
          'emoji_${DateTime.now().millisecondsSinceEpoch}${path_util.extension(emojiFile.path)}';
      final targetPath = path_util.join(_customEmojiDir, fileName);
      final targetFile = await emojiFile.copy(targetPath);

      // 创建新表情项
      final newEmoji = EmojiItem(
        id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
        type: 'image',
        content: targetFile.path,
        name: name,
      );

      // 添加到分类
      _categories[categoryIndex].emojis.add(newEmoji);

      await saveConfig();

      return newEmoji;
    } catch (e) {
      print('添加自定义表情失败：$e');
      return null;
    }
  }

  /// 删除自定义表情
  Future<bool> deleteCustomEmoji(String categoryId, String emojiId) async {
    try {
      // 查找分类和表情
      for (var category in _categories) {
        if (category.id == categoryId) {
          int emojiIndex = -1;
          for (int i = 0; i < category.emojis.length; i++) {
            if (category.emojis[i].id == emojiId) {
              emojiIndex = i;
              break;
            }
          }

          if (emojiIndex != -1) {
            final emoji = category.emojis[emojiIndex];

            // 如果是图片类型，删除文件
            if (emoji.type == 'image') {
              final file = File(emoji.content);
              if (await file.exists()) {
                await file.delete();
              }
            }

            // 从列表中移除
            category.emojis.removeAt(emojiIndex);

            // 更新常用表情列表
            _updateFrequentlyUsed();

            await saveConfig();
            return true;
          }
        }
      }

      return false;
    } catch (e) {
      print('删除自定义表情失败：$e');
      return false;
    }
  }
}

/// 表情面板组件
class EmojiPanel extends StatefulWidget {
  /// 表情选择回调
  final Function(String) onEmojiSelected;

  /// 创建表情面板
  const EmojiPanel({
    Key? key,
    required this.onEmojiSelected,
  }) : super(key: key);

  @override
  State<EmojiPanel> createState() => _EmojiPanelState();
}

class _EmojiPanelState extends State<EmojiPanel>
    with SingleTickerProviderStateMixin {
  /// Tab控制器
  late TabController _tabController;

  /// 表情管理器
  final EmojiManager _manager = EmojiManager.instance;

  /// 是否正在加载
  bool _isLoading = true;

  /// 是否处于编辑模式
  bool _isEditMode = false;

  /// 当前选中的分类索引
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeEmojiPanel();
  }

  /// 初始化表情面板
  Future<void> _initializeEmojiPanel() async {
    // 初始化表情管理器
    await _manager.initialize();

    // 设置Tab控制器
    _tabController =
        TabController(length: _manager.categories.length, vsync: this);

    // 监听标签变化
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedCategoryIndex = _tabController.index;
        });
      }
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 300,
        color: Theme.of(context).cardColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final categories = _manager.categories;
    final s = S.of(context); // 获取国际化文本

    // 更新系统表情分类名称为当前语言的文本
    for (var category in categories) {
      if (category.isSystem && category.id == 'system_unicode') {
        category.name = s.emojis;
      } else if (category.id == 'custom_default') {
        category.name = s.customStickers;
      }
    }

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        children: [
          // 操作栏
          _buildActionBar(s),

          // 表情分类标签栏 - 使用可拖拽的标签栏
          _buildDraggableTabs(categories),

          // 表情内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: categories.map((category) {
                return _buildCategoryContent(category);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建操作栏
  Widget _buildActionBar(S s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左侧按钮
          _isEditMode
              ? TextButton(
                  onPressed: _addNewCategory,
                  child: Text(s.addCategory),
                )
              : const SizedBox.shrink(),

          // 右侧按钮
          TextButton(
            onPressed: () {
              setState(() {
                _isEditMode = !_isEditMode;
              });
            },
            child: Text(_isEditMode ? s.doneEditing : s.editMode),
          ),
        ],
      ),
    );
  }

  /// 添加新分类
  void _addNewCategory() {
    final textController = TextEditingController();
    final s = S.of(context); // 获取国际化文本

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.newCategoryTitle),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: s.categoryNameHint,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          TextButton(
            onPressed: () async {
              final name = textController.text.trim();
              if (name.isNotEmpty) {
                await _manager.addCategory(name);
                setState(() {}); // 刷新UI
              }
              Navigator.pop(context);
            },
            child: Text(s.confirm),
          ),
        ],
      ),
    );
  }

  /// 构建可拖拽的标签栏
  Widget _buildDraggableTabs(List<EmojiCategory> categories) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: ReorderableListView(
              scrollDirection: Axis.horizontal,
              onReorder: _handleTabReorder,
              proxyDecorator: (child, index, animation) {
                return Material(
                  elevation: 4.0,
                  child: child,
                );
              },
              children: categories.map((category) {
                final isEmojiTab = category.id == 'system_unicode';
                // 表情分类不可移动
                return SizedBox(
                  key: ValueKey(category.id),
                  width: 80,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [Tab(text: category.name)],
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    onTap: (index) {
                      if (_tabController.index !=
                          categories.indexOf(category)) {
                        _tabController.animateTo(categories.indexOf(category));
                      }
                    },
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// 处理标签重新排序
  void _handleTabReorder(int oldIndex, int newIndex) {
    if (oldIndex == 0 || newIndex == 0) {
      // 表情分类不可移动
      return;
    }

    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      final category = _manager.categories[oldIndex];

      // 更新分类顺序
      _manager.moveCategoryOrder(category.id, newIndex);

      // 更新Tab控制器
      int currentIndex = _tabController.index;
      _tabController = TabController(
        length: _manager.categories.length,
        vsync: this,
        initialIndex:
            currentIndex < _manager.categories.length ? currentIndex : 0,
      );
    });
  }

  /// 构建分类内容
  Widget _buildCategoryContent(EmojiCategory category) {
    return Column(
      children: [
        // 如果是表情分类，在顶部显示常用表情
        if (category.id == 'system_unicode') _buildFrequentlyUsedSection(),

        // 表情内容网格
        Expanded(
          child: _buildEmojiGrid(category.emojis, category.id),
        ),
      ],
    );
  }

  /// 构建常用表情区域
  Widget _buildFrequentlyUsedSection() {
    final frequentlyUsed = _manager.frequentlyUsed;

    if (frequentlyUsed.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: Text(
            '常用',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        SizedBox(
          height: 70, // 约两行高度
          child: GridView.builder(
            padding: const EdgeInsets.all(4.0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8, // 每行8个
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1.0,
            ),
            itemCount: frequentlyUsed.length > 16
                ? 16
                : frequentlyUsed.length, // 最多显示两行(16个)
            itemBuilder: (context, index) {
              final emoji = frequentlyUsed[index];
              return InkWell(
                onTap: () => _handleEmojiTap('frequent', emoji),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: _buildEmojiContent(emoji),
                ),
              );
            },
          ),
        ),
        Divider(height: 1, thickness: 0.5, color: Colors.grey.withOpacity(0.2)),
      ],
    );
  }

  /// 构建表情网格
  Widget _buildEmojiGrid(List<EmojiItem> emojis, String categoryId) {
    if (emojis.isEmpty) {
      return const Center(
        child: Text('没有表情', style: TextStyle(color: Colors.grey)),
      );
    }

    // Unicode表情使用更紧凑的布局
    final bool isUnicodeCategory = categoryId == 'system_unicode';

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isUnicodeCategory ? 8 : 5, // Unicode表情每行8个，自定义表情每行5个
        crossAxisSpacing: isUnicodeCategory ? 4.0 : 8.0, // Unicode表情间距更小
        mainAxisSpacing: isUnicodeCategory ? 4.0 : 8.0,
        childAspectRatio: isUnicodeCategory ? 1.0 : 1.0, // 保持方形比例
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        final emoji = emojis[index];

        return InkWell(
          onTap: () {
            _handleEmojiTap(categoryId, emoji);
          },
          onLongPress: _isEditMode
              ? () => _handleEmojiLongPress(categoryId, emoji)
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(isUnicodeCategory ? 4.0 : 8.0),
              border: _isEditMode
                  ? Border.all(color: Colors.grey.withOpacity(0.3))
                  : null,
            ),
            child: _buildEmojiContent(emoji),
          ),
        );
      },
    );
  }

  /// 构建表情内容
  Widget _buildEmojiContent(EmojiItem emoji) {
    if (emoji.type == 'unicode') {
      // Unicode表情
      return Center(
        child: Text(
          emoji.content,
          style: const TextStyle(fontSize: 24),
        ),
      );
    } else if (emoji.type == 'image') {
      // 图片表情
      return ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Image.file(
          File(emoji.content),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.red),
            );
          },
        ),
      );
    }

    // 未知类型
    return const Center(
      child: Icon(Icons.help_outline),
    );
  }

  /// 处理表情点击
  void _handleEmojiTap(String categoryId, EmojiItem emoji) {
    if (_isEditMode) return; // 编辑模式不处理点击

    if (emoji.type == 'unicode') {
      // 直接插入Unicode表情
      widget.onEmojiSelected(emoji.content);
    } else if (emoji.type == 'image') {
      // 对于图片表情，可以插入一个特殊标记，或者路径
      // 这里暂时插入路径，实际应用中可能需要更复杂的处理
      widget.onEmojiSelected('[表情:${emoji.id}]');
    }

    // 记录使用情况
    _manager.recordEmojiUsage(categoryId, emoji.id);
  }

  /// 处理表情长按（编辑模式）
  void _handleEmojiLongPress(String categoryId, EmojiItem emoji) {
    // 只有编辑模式且非系统表情才可删除
    if (!_isEditMode) return;

    // 常用表情不能删除
    if (categoryId == 'frequent') return;

    // 查找分类
    final category = _manager.categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => EmojiCategory(id: '', name: '', emojis: [], order: 0),
    );

    // 系统表情不能删除
    if (category.isSystem) return;

    // 显示删除确认对话框
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除表情'),
        content: const Text('确定要删除这个表情吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              await _manager.deleteCustomEmoji(categoryId, emoji.id);
              setState(() {}); // 刷新UI
              Navigator.pop(context);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
