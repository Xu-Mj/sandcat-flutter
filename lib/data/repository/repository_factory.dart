import '../mock/mock_service.dart';
import 'mock_repository.dart';
import 'repository.dart';
import 'sqlite_repository.dart';
import '../../utils/app_config.dart';

/// 仓库工厂
class RepositoryFactory {
  /// 创建仓库
  static AppRepository createRepository(StorageType storageType) {
    switch (storageType) {
      case StorageType.memory:
        return MockAppRepository.instance;
      case StorageType.sqlite:
        return SqliteAppRepository.instance;
    }
  }
}
