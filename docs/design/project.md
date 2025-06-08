lib/
├── main.dart                     # 程序入口（初始化+启动应用）
├── main_dev.dart                 # 开发环境入口
├── main_staging.dart             # 预发布环境入口 
├── main_prod.dart                # 生产环境入口
├── app/                          # 应用配置层（非UI）
│   ├── di/                       # 依赖注入配置
│   │   ├── injection.dart        # GetIt配置
│   │   ├── injection.config.dart # GetIt自动生成配置
│   │   └── modules/              # 依赖注入模块
│   │       ├── app_module.dart   # 应用模块依赖
│   │       ├── network_module.dart # 网络模块依赖
│   │       └── storage_module.dart # 存储模块依赖
│   ├── router/                   # 全局路由配置
│   │   ├── app_router.dart       # 主路由配置
│   │   ├── route_guards.dart     # 路由守卫
│   │   └── route_observers.dart  # 路由观察器(分析)
│   ├── theme/                    # 主题配置
│   │   ├── app_theme.dart        # 应用主题
│   │   ├── colors.dart           # 颜色定义
│   │   ├── text_styles.dart      # 文字样式
│   │   └── dimensions.dart       # 尺寸常量
│   ├── config/                   # 应用配置
│   │   ├── app_config.dart       # 环境配置
│   │   ├── constants.dart        # 全局常量
│   │   ├── feature_flags.dart    # 功能标志配置
│   │   └── build_config.dart     # 编译配置
│   ├── lifecycle/                # 应用生命周期管理
│   │   ├── app_lifecycle.dart    # 应用生命周期管理
│   │   └── lifecycle_observer.dart # 生命周期观察器
│   └── app.dart                  # 应用根Widget（MaterialApp配置）
├── core/                         # 核心基础设施层
│   ├── constants/                # 核心常量
│   │   ├── api_constants.dart    # API相关常量
│   │   ├── storage_keys.dart     # 存储键值常量
│   │   ├── app_constants.dart    # 应用级常量
│   │   └── plugin_constants.dart # 插件系统常量
│   ├── errors/                   # 错误处理体系
│   │   ├── failures.dart         # 统一错误定义
│   │   ├── exceptions.dart       # 异常定义
│   │   ├── error_handler.dart    # 全局错误处理器
│   │   └── error_logger.dart     # 错误日志记录
│   ├── extensions/               # 扩展方法
│   │   ├── string_extensions.dart
│   │   ├── datetime_extensions.dart
│   │   ├── list_extensions.dart
│   │   ├── context_extensions.dart
│   │   └── widget_extensions.dart
│   ├── network/                  # 网络基础设施
│   │   ├── api_client.dart       # HTTP客户端接口
│   │   ├── dio_client.dart       # Dio实现
│   │   ├── websocket_client.dart # WebSocket客户端
│   │   ├── grpc_client.dart      # gRPC客户端
│   │   ├── interceptors/         # 网络拦截器
│   │   │   ├── auth_interceptor.dart
│   │   │   ├── logging_interceptor.dart
│   │   │   ├── error_interceptor.dart
│   │   │   ├── retry_interceptor.dart
│   │   │   ├── cache_interceptor.dart # 请求缓存拦截器
│   │   │   └── rate_limiter_interceptor.dart # 限流拦截器
│   │   ├── network_info.dart     # 网络状态检测
│   │   ├── connection_manager.dart # 连接管理器
│   │   ├── socket_manager.dart   # WebSocket连接管理
│   │   ├── bandwidth_monitor.dart # 带宽监控
│   │   └── api_versioning.dart   # API版本管理
│   ├── realtime/                 # 实时消息基础设施
│   │   ├── realtime_client.dart  # 实时客户端抽象
│   │   ├── message_synchronizer.dart # 消息同步器
│   │   ├── delivery_manager.dart # 送达管理器
│   │   ├── typing_manager.dart   # 输入状态管理
│   │   ├── presence_manager.dart # 在线状态管理
│   │   └── sync_scheduler.dart   # 同步任务调度器
│   ├── storage/                  # 存储基础设施
│   │   ├── storage_service.dart  # 存储服务接口
│   │   ├── shared_prefs_storage.dart # SharedPreferences实现
│   │   ├── secure_storage.dart   # 安全存储实现
│   │   ├── database/             # 数据库相关
│   │   │   ├── database_service.dart # 数据库服务接口
│   │   │   ├── drift_database.dart   # Drift数据库实现
│   │   │   ├── isar_database.dart    # Isar数据库实现
│   │   │   ├── migration_manager.dart # 数据库迁移管理
│   │   │   └── tables/           # 数据表定义
│   │   │       ├── message_table.dart
│   │   │       ├── chat_table.dart
│   │   │       └── user_table.dart
│   │   ├── cache/                # 缓存系统
│   │   │   ├── cache_manager.dart
│   │   │   ├── memory_cache.dart
│   │   │   ├── disk_cache.dart
│   │   │   └── cache_policy.dart # 缓存策略
│   │   └── file_manager.dart     # 文件管理器
│   ├── media/                    # 媒体处理基础设施
│   │   ├── media_service.dart    # 媒体服务接口
│   │   ├── image_processor.dart  # 图片处理
│   │   ├── video_processor.dart  # 视频处理
│   │   ├── audio_processor.dart  # 音频处理
│   │   ├── thumbnail_generator.dart # 缩略图生成
│   │   ├── transcoder.dart       # 媒体转码器
│   │   ├── compression_service.dart # 压缩服务
│   │   └── progressive_loader.dart # 渐进式加载
│   ├── utils/                    # 工具类
│   │   ├── crypto_utils.dart     # 加密工具
│   │   ├── validation_utils.dart # 验证工具
│   │   ├── format_utils.dart     # 格式化工具
│   │   ├── permission_utils.dart # 权限工具
│   │   ├── device_utils.dart     # 设备信息工具
│   │   ├── image_utils.dart      # 图片处理工具
│   │   └── retry_utils.dart      # 重试工具
│   ├── services/                 # 核心服务
│   │   ├── logger_service.dart   # 日志服务
│   │   ├── notification_service.dart # 通知服务
│   │   ├── analytics_service.dart # 统计分析服务
│   │   ├── crash_service.dart    # 崩溃报告服务
│   │   ├── security_service.dart # 安全服务
│   │   ├── background_service.dart # 后台任务服务
│   │   └── location_service.dart # 定位服务
│   ├── e2ee/                     # 端到端加密系统
│   │   ├── crypto_manager.dart   # 加密管理器
│   │   ├── key_manager.dart      # 密钥管理
│   │   ├── encryption_service.dart # 加密服务
│   │   ├── key_exchange.dart     # 密钥交换协议
│   │   ├── message_encryption.dart # 消息加密
│   │   ├── secure_protocol.dart  # 安全通信协议
│   │   └── cipher_suite.dart     # 加密套件
│   ├── notifications/           # 通知系统
│   │   ├── push_service.dart    # 推送服务接口
│   │   ├── fcm_service.dart     # Firebase实现
│   │   ├── apns_service.dart    # Apple推送实现
│   │   ├── notification_handler.dart # 通知处理器
│   │   ├── notification_factory.dart # 通知构造器
│   │   ├── channels_manager.dart # 通知渠道管理(Android)
│   │   └── background_handler.dart # 后台通知处理
│   ├── plugins/                  # 插件系统核心
│   │   ├── plugin_manager.dart   # 插件管理器
│   │   ├── plugin_loader.dart    # 插件加载器
│   │   ├── plugin_registry.dart  # 插件注册表
│   │   ├── plugin_interface.dart # 插件接口定义
│   │   ├── plugin_context.dart   # 插件上下文
│   │   ├── plugin_security.dart  # 插件安全管理
│   │   ├── plugin_bridge.dart    # 插件桥接器
│   │   └── hooks/                # 插件钩子系统
│   │       ├── message_hooks.dart
│   │       ├── ui_hooks.dart
│   │       └── lifecycle_hooks.dart
│   ├── i18n/                     # 国际化核心
│   │   ├── localization_service.dart # 本地化服务
│   │   ├── app_localizations.dart # 应用本地化
│   │   ├── locale_manager.dart   # 语言管理器
│   │   └── translation_loader.dart # 翻译加载器
│   ├── security/                 # 安全框架
│   │   ├── encryption_service.dart
│   │   ├── key_manager.dart
│   │   ├── biometric_auth.dart
│   │   └── certificate_pinning.dart
│   ├── monitoring/               # 监控系统
│   │   ├── performance_monitor.dart # 性能监控
│   │   ├── memory_monitor.dart   # 内存监控
│   │   ├── network_monitor.dart  # 网络监控
│   │   ├── crash_monitor.dart    # 崩溃监控
│   │   ├── usage_analytics.dart  # 使用分析
│   │   ├── event_tracker.dart    # 事件跟踪器
│   │   ├── metrics_collector.dart # 指标收集器
│   │   └── structured_logger.dart # 结构化日志
│   └── offline/                  # 离线支持框架
│       ├── offline_queue.dart    # 离线队列
│       ├── sync_manager.dart     # 同步管理器
│       ├── conflict_resolver.dart # 冲突解决器
│       ├── retry_policy.dart     # 重试策略
│       └── connectivity_guard.dart # 连接守卫
├── features/                     # 功能模块（按业务垂直切分）
│   ├── authentication/           # 认证功能模块
│   │   ├── data/                 # 数据层
│   │   │   ├── datasources/      # 数据源（远程/本地）
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/           # 数据传输对象
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── token_model.dart
│   │   │   │   └── login_request.dart
│   │   │   └── repositories/     # 仓储模式实现
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/               # 领域层（业务逻辑）
│   │   │   ├── entities/         # 业务实体
│   │   │   │   ├── user.dart
│   │   │   │   └── auth_token.dart
│   │   │   ├── repositories/     # 仓储接口
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/         # 用例（业务操作）
│   │   │       ├── login.dart
│   │   │       ├── logout.dart
│   │   │       ├── register.dart
│   │   │       └── refresh_token.dart
│   │   └── presentation/         # 表现层（UI相关）
│   │       ├── providers/        # 状态管理
│   │       │   ├── auth_provider.dart
│   │       │   └── login_form_provider.dart
│   │       ├── pages/            # 页面级组件
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   └── verification_page.dart
│   │       ├── widgets/          # 功能组件
│   │       │   ├── login_form.dart
│   │       │   └── social_login_buttons.dart
│   │       └── dialogs/          # 对话框组件
│   │           └── forgot_password_dialog.dart
│   ├── home/                     # 主页模块
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── home_page.dart    # 主页（底部导航容器）
│   │       └── widgets/
│   │           └── bottom_nav_bar.dart
│   ├── chat/                     # 聊天功能模块
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── chat_remote_datasource.dart
│   │   │   │   └── chat_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── message_model.dart
│   │   │   │   ├── chat_model.dart
│   │   │   │   ├── message_status_model.dart
│   │   │   │   └── typing_status_model.dart
│   │   │   └── repositories/
│   │   │       └── chat_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── message.dart
│   │   │   │   ├── chat.dart
│   │   │   │   ├── message_status.dart
│   │   │   │   └── typing_status.dart
│   │   │   ├── repositories/
│   │   │   │   └── chat_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_messages.dart
│   │   │       ├── send_message.dart
│   │   │       ├── watch_incoming_messages.dart
│   │   │       ├── mark_as_read.dart
│   │   │       └── set_typing_status.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── chat_provider.dart
│   │       │   ├── message_provider.dart
│   │       │   └── typing_provider.dart
│   │       ├── pages/
│   │       │   ├── chat_list_page.dart
│   │       │   └── chat_room_page.dart
│   │       └── widgets/
│   │           ├── message_item.dart
│   │           ├── message_input.dart
│   │           ├── typing_indicator.dart
│   │           ├── read_receipt.dart
│   │           ├── media_preview.dart
│   │           └── chat_app_bar.dart
│   ├── group_chat/               # 群组聊天模块
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── group_remote_datasource.dart
│   │   │   │   └── group_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── group_model.dart
│   │   │   │   └── group_member_model.dart
│   │   │   └── repositories/
│   │   │       └── group_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── group.dart
│   │   │   │   ├── group_member.dart
│   │   │   │   └── group_permissions.dart
│   │   │   ├── repositories/
│   │   │   │   └── group_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_group.dart
│   │   │       ├── add_member.dart
│   │   │       ├── remove_member.dart
│   │   │       ├── change_role.dart
│   │   │       └── leave_group.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── group_provider.dart
│   │       │   └── group_members_provider.dart
│   │       ├── pages/
│   │       │   ├── groups_list_page.dart
│   │       │   ├── group_detail_page.dart
│   │       │   └── group_settings_page.dart
│   │       └── widgets/
│   │           ├── group_avatar.dart
│   │           ├── member_list_item.dart
│   │           └── role_selector.dart
│   ├── contacts/                 # 联系人模块
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   │   ├── contact_model.dart
│   │   │   │   └── presence_model.dart
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── contact.dart
│   │   │   │   └── presence.dart
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │       ├── get_contacts.dart
│   │   │       ├── add_contact.dart
│   │   │       ├── remove_contact.dart
│   │   │       └── watch_presence.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── contacts_provider.dart
│   │       │   └── presence_provider.dart
│   │       ├── pages/
│   │       └── widgets/
│   │           ├── contact_list_item.dart
│   │           ├── presence_indicator.dart
│   │           └── last_seen_info.dart
│   ├── media_sharing/            # 媒体分享模块
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   │   ├── media_file_model.dart
│   │   │   │   └── upload_progress_model.dart
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── media_file.dart
│   │   │   │   └── upload_progress.dart
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │       ├── upload_media.dart
│   │   │       ├── download_media.dart
│   │   │       ├── cancel_upload.dart
│   │   │       └── get_shared_media.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── media_upload_provider.dart
│   │       │   └── shared_media_provider.dart
│   │       ├── pages/
│   │       │   ├── media_gallery_page.dart
│   │       │   └── media_viewer_page.dart
│   │       └── widgets/
│   │           ├── media_picker.dart
│   │           ├── upload_progress_indicator.dart
│   │           ├── media_grid.dart
│   │           └── media_preview.dart
│   ├── profile/                  # 个人资料模块
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── settings/                 # 设置模块
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── search/                   # 搜索模块
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/                       # 共享层
│   ├── data/                     # 共享数据层
│   │   ├── models/               # 通用数据模型
│   │   └── repositories/         # 通用仓储
│   ├── domain/                   # 共享领域层
│   │   ├── entities/             # 通用实体
│   │   └── repositories/         # 通用仓储接口
│   └── presentation/             # 共享UI层
│       ├── widgets/              # 通用UI组件
│       │   ├── buttons/          # 按钮组件
│       │   ├── inputs/           # 输入组件
│       │   ├── loading/          # 加载组件
│       │   └── dialogs/          # 通用对话框
│       ├── pages/                # 通用页面（错误页、启动页等）
│       ├── themes/               # UI主题相关
│       └── utils/                # UI工具类
├── assets/                       # 资源文件
│   ├── images/                   # 图片资源
│   ├── icons/                    # 图标资源
│   ├── translations/             # 国际化翻译文件
│   │   ├── en.json              # 英文
│   │   ├── zh_CN.json           # 简体中文
│   │   ├── zh_TW.json           # 繁体中文
│   │   ├── ja.json              # 日文
│   │   ├── ko.json              # 韩文
│   │   ├── es.json              # 西班牙文
│   │   ├── fr.json              # 法文
│   │   └── de.json              # 德文
│   └── fonts/                    # 字体文件
├── l10n/                         # 国际化配置
│   ├── app_en.arb               # 英文ARB文件
│   ├── app_zh.arb               # 中文ARB文件
│   └── l10n.yaml                # 国际化配置文件
├── plugins/                      # 插件系统
│   ├── installed/                # 已安装插件
│   │   ├── plugin_a/
│   │   │   ├── manifest.json     # 插件清单文件
│   │   │   ├── lib/              # 插件代码
│   │   │   ├── assets/           # 插件资源
│   │   │   └── translations/     # 插件翻译文件
│   │   └── plugin_b/
│   ├── market/                   # 插件市场相关
│   └── sdk/                      # 插件开发SDK
├── gen/                          # 代码生成文件
├── test/                         # 单元测试
│   ├── mocks/                    # 模拟对象
│   ├── fixtures/                 # 测试固定数据
│   ├── core/                     # 核心层测试
│   └── features/                 # 功能模块测试
├── integration_test/            # 集成测试
│   ├── flows/                   # 用户流程测试
│   ├── pages/                   # 页面测试
│   └── performance/             # 性能测试
└── ci/                          # CI/CD配置
    ├── workflows/               # GitHub工作流
    │   ├── build.yml            # 构建工作流
    │   ├── test.yml             # 测试工作流
    │   └── release.yml          # 发布工作流
    ├── scripts/                 # CI脚本
    │   ├── setup.sh             # 环境设置脚本
    │   ├── test.sh              # 测试脚本
    │   └── deploy.sh            # 部署脚本
    ├── codemagic.yaml           # Codemagic配置
    └── firebase_distribution.sh # Firebase分发脚本