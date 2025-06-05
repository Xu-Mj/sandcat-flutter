# 项目结构

## 目录结构

```
im-flutter/
├── lib/                      # 主应用代码
│   ├── main.dart             # 应用入口点
│   ├── app.dart              # 应用配置
│   ├── config/               # 应用配置
│   │   ├── constants.dart    # 常量定义
│   │   ├── routes.dart       # 路由配置
│   │   └── themes.dart       # 主题配置
│   ├── core/                 # 核心功能
│   │   ├── di/               # 依赖注入
│   │   ├── utils/            # 工具类
│   │   └── extensions/       # Dart扩展
│   ├── data/                 # 数据层
│   │   ├── models/           # 数据模型
│   │   ├── repositories/     # 仓库实现
│   │   ├── providers/        # 数据提供者
│   │   ├── api/              # API客户端
│   │   └── local/            # 本地存储
│   ├── domain/               # 领域层
│   │   ├── entities/         # 业务实体
│   │   ├── repositories/     # 仓库接口
│   │   └── usecases/         # 用例
│   ├── presentation/         # 表现层
│   │   ├── blocs/            # 业务逻辑组件
│   │   ├── pages/            # 页面
│   │   │   ├── home/         # 首页
│   │   │   ├── auth/         # 认证页面
│   │   │   ├── chat/         # 聊天页面
│   │   │   ├── contacts/     # 联系人页面
│   │   │   └── settings/     # 设置页面
│   │   ├── widgets/          # 可复用组件
│   │   │   ├── common/       # 通用组件
│   │   │   ├── chat/         # 聊天相关组件
│   │   │   └── media/        # 媒体相关组件
│   │   └── navigation/       # 导航管理
│   └── services/             # 服务
│       ├── auth_service.dart # 认证服务
│       ├── chat_service.dart # 聊天服务
│       ├── storage_service.dart # 存储服务
│       └── call_service.dart # 通话服务
├── assets/                   # 静态资源
│   ├── images/               # 图片资源
│   ├── icons/                # 图标资源
│   ├── fonts/                # 字体资源
│   └── translations/         # 翻译资源
├── test/                     # 测试代码
│   ├── unit/                 # 单元测试
│   ├── widget/               # 组件测试
│   └── integration/          # 集成测试
└── docs/                     # 项目文档
    ├── requirements/         # 需求文档
    ├── architecture/         # 架构设计
    ├── design/               # UI/UX设计
    └── api/                  # API接口文档
```

## 代码组织原则

### 1. 分层架构

项目采用清晰的分层架构，每层职责明确：

- **表现层 (Presentation)**: 处理UI和用户交互
- **领域层 (Domain)**: 包含业务逻辑和规则
- **数据层 (Data)**: 处理数据获取和存储
- **核心层 (Core)**: 提供通用功能和工具

### 2. 特性模块化

功能按特性进行模块化组织，主要模块包括：

- **认证 (Authentication)**: 登录、注册、用户管理
- **消息 (Messaging)**: 聊天、会话管理
- **联系人 (Contacts)**: 联系人管理
- **群组 (Groups)**: 群组功能
- **通话 (Calls)**: 音视频通话
- **设置 (Settings)**: 应用设置和配置

### 3. 状态管理

采用Flutter BLoC模式统一管理应用状态：

- **Event**: 表示用户操作或系统事件
- **State**: 表示组件的状态
- **BLoC**: 处理事件并更新状态

### 4. 依赖注入

使用GetIt实现依赖注入，便于测试和模块解耦：

```dart
// 依赖注入示例
final getIt = GetIt.instance;

void setupDependencies() {
  // 仓库
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl());
  
  // 服务
  getIt.registerSingleton<AuthService>(AuthServiceImpl(getIt<UserRepository>()));
  getIt.registerSingleton<ChatService>(ChatServiceImpl(getIt<ChatRepository>()));
  
  // BLoCs
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthService>()));
  getIt.registerFactory<ChatBloc>(() => ChatBloc(getIt<ChatService>()));
}
```

### 5. 路由管理

使用GoRouter管理应用导航：

```dart
// 路由配置示例
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) => ChatPage(
        chatId: state.params['id']!,
      ),
    ),
  ],
);
```

### 6. 响应式设计

使用LayoutBuilder和MediaQuery实现响应式布局：

```dart
// 响应式布局示例
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return _buildMobileLayout();
      } else {
        return _buildDesktopLayout();
      }
    },
  );
}
```

## 命名约定

### 文件命名

- 所有文件名使用snake_case
- 类型定义文件：`user_model.dart`
- BLoC文件：`auth_bloc.dart`, `auth_event.dart`, `auth_state.dart`
- 页面文件：`login_page.dart`
- 组件文件：`message_bubble.dart`

### 类命名

- 所有类名使用PascalCase
- 模型类：`UserModel`
- BLoC类：`AuthBloc`, `AuthEvent`, `AuthState`
- 页面类：`LoginPage`
- 组件类：`MessageBubble`

### 变量和方法命名

- 变量和方法名使用camelCase
- 私有成员使用下划线前缀：`_privateVariable`
- 常量使用大写加下划线：`MAX_MESSAGE_LENGTH`

## 代码风格

遵循官方的Dart风格指南：

- 使用两个空格缩进
- 每行最大长度80字符
- 优先使用const构造函数
- 使用尾逗号改善格式化
- 优先使用async/await而非原始Future 