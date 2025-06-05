import 'package:flutter/material.dart';
import '../data/repository/repository_factory.dart';
import '../data/repository/repository.dart';
import '../utils/app_config.dart';

/// 提供仓库访问的Provider
class RepositoryProvider extends InheritedWidget {
  /// 应用仓库
  final AppRepository repository;

  const RepositoryProvider({
    Key? key,
    required this.repository,
    required Widget child,
  }) : super(key: key, child: child);

  static RepositoryProvider of(BuildContext context) {
    final RepositoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();
    assert(result != null, 'No RepositoryProvider found in context');
    return result!;
  }

  /// 用于便捷访问用户仓库
  static UserRepository userRepository(BuildContext context) {
    return of(context).repository.userRepository;
  }

  /// 用于便捷访问聊天仓库
  static ChatRepository chatRepository(BuildContext context) {
    return of(context).repository.chatRepository;
  }

  /// 用于便捷访问消息仓库
  static MessageRepository messageRepository(BuildContext context) {
    return of(context).repository.messageRepository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) {
    return repository != oldWidget.repository;
  }
}

/// 创建一个包含仓库的应用根Widget
class RepositoryProviderRoot extends StatefulWidget {
  final Widget child;

  const RepositoryProviderRoot({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<RepositoryProviderRoot> createState() => _RepositoryProviderRootState();
}

class _RepositoryProviderRootState extends State<RepositoryProviderRoot> {
  late AppRepository _repository;
  late StorageType _currentStorageType;

  @override
  void initState() {
    super.initState();
    _initRepository();
    // 监听配置变化
    AppConfig.instance.appConfigChanged.addListener(_onAppConfigChanged);
  }

  void _initRepository() {
    // 根据存储类型创建相应的仓库
    _currentStorageType = AppConfig.instance.storageType;
    _repository = RepositoryFactory.createRepository(_currentStorageType);
  }

  void _onAppConfigChanged() {
    // 当配置更改时，如果存储类型有变化，则重新创建仓库
    final newStorageType = AppConfig.instance.storageType;
    if (newStorageType != _currentStorageType) {
      if (mounted) {
        setState(() {
          _disposeCurrentRepository();
          _currentStorageType = newStorageType;
          _repository = RepositoryFactory.createRepository(newStorageType);
        });
      }
    }
  }

  void _disposeCurrentRepository() {
    _repository.dispose();
  }

  @override
  void dispose() {
    // 移除监听器
    AppConfig.instance.appConfigChanged.removeListener(_onAppConfigChanged);
    _disposeCurrentRepository();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      repository: _repository,
      child: widget.child,
    );
  }
}
