# 主题系统设计

## 1. 主题系统概述

IM Flutter采用灵活的主题系统，支持自动跟随系统深浅模式、预设主题和用户自定义主题。主题系统设计遵循以下原则：

- **一致性**: 确保所有UI元素在主题切换时保持设计一致性
- **可扩展性**: 易于添加新主题而不需修改核心代码
- **性能优化**: 主题切换高效，不引起性能问题
- **层次分明**: 主题数据组织结构清晰，易于维护和使用

## 2. 主题数据结构

### 2.1 基础主题数据

```dart
class AppTheme {
  final String id;           // 主题唯一标识
  final String name;         // 主题显示名称
  final Brightness brightness; // 亮色/暗色模式
  final ColorScheme colorScheme; // 颜色方案
  final TextTheme textTheme;  // 文字样式
  final bool isSystem;       // 是否为系统主题
  final bool isCustom;       // 是否为用户自定义

  // 扩展属性
  final double borderRadius;  // 全局圆角
  final double elevationFactor; // 阴影强度因子
  final Map<String, dynamic> extraData; // 扩展数据
}
```

### 2.2 颜色方案设计

```dart
class AppColorScheme extends ColorScheme {
  // 基础色调
  final Color primary;        // 主色调
  final Color secondary;      // 次要色调
  final Color tertiary;       // 第三色调
  final Color accent;         // 强调色
  
  // 语义色调
  final Color success;        // 成功色
  final Color warning;        // 警告色
  final Color error;          // 错误色
  final Color info;           // 信息色
  
  // 背景色
  final Color background;     // 主背景
  final Color surface;        // 表面背景
  final Color surfaceVariant; // 表面背景变体
  final Color card;           // 卡片背景
  
  // 文本色
  final Color onPrimary;      // 主色上的文本
  final Color onSecondary;    // 次色上的文本
  final Color onBackground;   // 背景上的文本
  final Color onSurface;      // 表面上的文本
  
  // 特殊效果色
  final Color shimmer;        // 闪烁效果色
  final Color shadow;         // 阴影色
  
  // 渐变色
  final Gradient primaryGradient;  // 主色渐变
  final Gradient secondaryGradient; // 次色渐变
}
```

## 3. 预设主题

### 3.1 浅色主题 (Light)

```
- 背景: 纯白 (#FFFFFF) 到浅灰 (#F7F7FC)
- 表面: 纯白 (#FFFFFF)
- 主色: 蓝紫色 (#6E66FA)
- 次色: 青色 (#00D2FF)
- 文本: 深灰 (#2D2D3A)
```

### 3.2 深色主题 (Dark)

```
- 背景: 深蓝黑 (#141432) 到深蓝灰 (#1D1D42)
- 表面: 深蓝灰 (#1D1D42)
- 主色: 亮蓝紫 (#8A84FF)
- 次色: 亮青色 (#47DFFF)
- 文本: 浅灰白 (#EDEDF2)
```

### 3.3 高对比度主题 (High Contrast)

```
- 背景: 纯黑 (#000000)
- 表面: 深灰 (#121212)
- 主色: 明亮黄 (#FFDD00)
- 次色: 亮蓝 (#00AAFF)
- 文本: 纯白 (#FFFFFF)
```

### 3.4 自然主题 (Nature)

```
- 背景: 米白 (#F5F5E9)
- 表面: 纯白 (#FFFFFF)
- 主色: 森林绿 (#34A853)
- 次色: 天蓝 (#4285F4)
- 文本: 深棕 (#3C2A21)
```

## 4. 主题管理

### 4.1 主题存储与持久化

使用本地存储保存用户主题选择：

```dart
class ThemeStorage {
  // 保存当前主题ID
  Future<void> saveThemeId(String themeId);
  
  // 获取当前主题ID
  Future<String?> getThemeId();
  
  // 保存自定义主题
  Future<void> saveCustomTheme(AppTheme theme);
  
  // 获取所有自定义主题
  Future<List<AppTheme>> getCustomThemes();
}
```

### 4.2 主题状态管理

使用BLoC管理主题状态：

```dart
// 事件
sealed class ThemeEvent {}
class ThemeChanged extends ThemeEvent {
  final String themeId;
  ThemeChanged(this.themeId);
}
class SystemThemeChanged extends ThemeEvent {
  final Brightness brightness;
  SystemThemeChanged(this.brightness);
}
class CustomThemeAdded extends ThemeEvent {
  final AppTheme theme;
  CustomThemeAdded(this.theme);
}

// 状态
class ThemeState {
  final AppTheme currentTheme;
  final List<AppTheme> availableThemes;
  final bool isSystemTheme;
  
  ThemeState({
    required this.currentTheme,
    required this.availableThemes,
    this.isSystemTheme = false,
  });
}
```

### 4.3 系统主题跟随

监听系统主题变化并自动切换：

```dart
void listenToSystemTheme(ThemeBloc themeBloc) {
  WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    themeBloc.add(SystemThemeChanged(brightness));
  };
}
```

## 5. 主题切换机制

### 5.1 主题切换动画

平滑过渡效果确保主题切换不突兀：

```dart
class ThemeAnimatedBuilder extends StatelessWidget {
  final Widget Function(ThemeData theme) builder;
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AnimatedTheme(
          data: _convertToThemeData(state.currentTheme),
          duration: const Duration(milliseconds: 300),
          child: builder(_convertToThemeData(state.currentTheme)),
        );
      }
    );
  }
}
```

### 5.2 主题应用范围

确保主题应用到应用的各个角落：

```dart
void main() {
  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: ThemeAnimatedBuilder(
        builder: (theme) => MaterialApp(
          theme: theme,
          // ...其余配置
        ),
      ),
    ),
  );
}
```

## 6. 自定义主题创建

### 6.1 主题编辑器

提供界面让用户自定义主题：

- 颜色选择器（主色、次色、强调色）
- 预览面板实时显示效果
- 保存和应用选项

### 6.2 主题模板

基于预设主题创建自定义主题：

```dart
AppTheme createCustomTheme({
  required String name,
  required Color primary,
  required Color secondary,
  required Brightness brightness,
  double borderRadius = 16.0,
}) {
  // 基于主次色自动生成其他颜色
  final accent = _generateAccent(primary, secondary);
  final background = brightness == Brightness.light
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF141432);
      
  // ...生成其他颜色
  
  return AppTheme(
    id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
    name: name,
    brightness: brightness,
    colorScheme: AppColorScheme(
      primary: primary,
      secondary: secondary,
      accent: accent,
      background: background,
      // ...其他颜色
    ),
    borderRadius: borderRadius,
    isCustom: true,
    isSystem: false,
  );
}
```

## 7. 主题切换界面

### 7.1 主题展示卡片

每个主题以卡片形式展示其预览效果：

```dart
class ThemePreviewCard extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final VoidCallback onSelect;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          border: isSelected 
              ? Border.all(color: theme.colorScheme.primary, width: 2) 
              : null,
          boxShadow: [/* 阴影 */],
        ),
        child: Column(
          children: [
            Text(theme.name, style: TextStyle(color: theme.colorScheme.onSurface)),
            SizedBox(height: 8),
            // 颜色预览...
            Row(
              children: [
                _buildColorCircle(theme.colorScheme.primary),
                _buildColorCircle(theme.colorScheme.secondary),
                _buildColorCircle(theme.colorScheme.background),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### 7.2 主题设置页面

提供完整的主题管理功能：

- 系统主题跟随开关
- 预设主题选择
- 自定义主题管理（编辑/删除）
- 创建新主题按钮

## 8. 主题适配考虑

### 8.1 第三方组件适配

为第三方组件提供主题适配器：

```dart
class ThemeAdapter {
  static ThirdPartyWidgetTheme adaptToThirdParty(AppTheme theme) {
    return ThirdPartyWidgetTheme(
      primaryColor: theme.colorScheme.primary,
      // ...其他属性
    );
  }
}
```

### 8.2 原生控件适配

确保原生控件同样应用当前主题：

```dart
Future<void> applyToSystemUI(AppTheme theme) async {
  // 应用到状态栏和导航栏
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: theme.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: theme.colorScheme.background,
      systemNavigationBarIconBrightness: theme.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    ),
  );
}
```

## 9. 实现示例

### 9.1 主题注册

```dart
void registerThemes() {
  final themeBloc = getIt<ThemeBloc>();
  
  // 注册预设主题
  themeBloc.add(ThemeRegister(lightTheme));
  themeBloc.add(ThemeRegister(darkTheme));
  themeBloc.add(ThemeRegister(highContrastTheme));
  themeBloc.add(ThemeRegister(natureTheme));
  
  // 加载自定义主题
  getIt<ThemeStorage>().getCustomThemes().then((customThemes) {
    for (final theme in customThemes) {
      themeBloc.add(ThemeRegister(theme));
    }
  });
}
```

### 9.2 主题使用

在组件中使用主题：

```dart
Widget build(BuildContext context) {
  final theme = AppTheme.of(context);
  
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(theme.borderRadius),
      boxShadow: [
        BoxShadow(
          color: theme.colorScheme.shadow.withOpacity(0.1),
          blurRadius: 10 * theme.elevationFactor,
          offset: Offset(0, 4 * theme.elevationFactor),
        ),
      ],
    ),
    child: Text(
      'Hello World',
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    ),
  );
}
```

## 10. 未来扩展

- **语义主题**: 基于内容自动调整主题 
- **动态色彩**: 从壁纸提取颜色创建主题
- **主题分享**: 导出/导入主题配置
- **主题定时切换**: 定时自动切换主题（如日出/日落）
- **主题动画过渡**: 更丰富的主题切换动画效果 