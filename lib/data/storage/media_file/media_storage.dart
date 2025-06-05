import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// 内容寻址存储系统接口
abstract class ContentAddressableStorage {
  /// 存储文件并返回其内容ID
  Future<String> storeFile(File file);

  /// 存储字节数据并返回其内容ID
  Future<String> storeBytes(Uint8List bytes, String extension);

  /// 根据内容ID获取文件
  Future<File?> getFile(String contentId);

  /// 增加文件引用计数
  Future<void> incrementReferenceCount(String contentId);

  /// 减少文件引用计数
  Future<void> decrementReferenceCount(String contentId);

  /// 清理未引用文件
  Future<int> cleanUnreferencedFiles({Duration? olderThan});

  /// 检查文件是否存在
  Future<bool> exists(String contentId);
}

/// 媒体文件存储配置
class MediaStorageConfig {
  /// 存储根路径
  final String? storagePath;

  /// 是否加密
  final bool encrypted;

  /// 最小清理天数
  final int minCleanupDays;

  MediaStorageConfig({
    this.storagePath,
    this.encrypted = false,
    this.minCleanupDays = 7,
  });
}

/// 媒体文件存储实现
class MediaStorage implements ContentAddressableStorage {
  /// 存储配置
  final MediaStorageConfig config;

  /// 存储根目录
  late String _rootDir;

  /// 引用计数文件
  late File _refCountFile;

  /// 引用计数映射
  final Map<String, int> _referenceCount = {};

  /// 是否已初始化
  bool _initialized = false;

  /// 创建媒体存储
  MediaStorage({required this.config});

  /// 初始化存储系统
  Future<void> initialize() async {
    if (_initialized) return;

    // 确定存储根目录
    if (config.storagePath != null) {
      _rootDir = config.storagePath!;
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      _rootDir = path.join(appDir.path, 'im_media_storage');
    }

    // 创建目录
    final contentDir = path.join(_rootDir, 'content');
    final metadataDir = path.join(_rootDir, 'metadata');

    for (final dir in [contentDir, metadataDir]) {
      final dirObj = Directory(dir);
      if (!await dirObj.exists()) {
        await dirObj.create(recursive: true);
      }
    }

    // 初始化引用计数文件
    _refCountFile = File(path.join(metadataDir, 'ref_counts.json'));

    // 加载引用计数
    await _loadReferenceCount();

    _initialized = true;
  }

  /// 确保已初始化
  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await initialize();
    }
  }

  /// 加载引用计数
  Future<void> _loadReferenceCount() async {
    if (!await _refCountFile.exists()) {
      return;
    }

    try {
      final content = await _refCountFile.readAsString();
      final Map<String, dynamic> data = jsonDecode(content);

      // 转换成正确的类型
      data.forEach((key, value) {
        _referenceCount[key] = value as int;
      });
    } catch (e) {
      print('Error loading reference counts: $e');
    }
  }

  /// 保存引用计数
  Future<void> _saveReferenceCount() async {
    try {
      await _refCountFile.writeAsString(jsonEncode(_referenceCount));
    } catch (e) {
      print('Error saving reference counts: $e');
    }
  }

  /// 计算文件的SHA-256哈希值
  Future<String> _computeFileHash(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return _computeBytesHash(bytes);
    } catch (e) {
      throw Exception('Failed to compute file hash: $e');
    }
  }

  /// 计算字节数据的SHA-256哈希值
  String _computeBytesHash(Uint8List bytes) {
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// 获取文件扩展名
  String _getFileExtension(File file) {
    final extension = path.extension(file.path);
    return extension.isEmpty ? '' : extension;
  }

  /// 获取内容文件路径
  String _getContentFilePath(String contentId, String extension) {
    // 使用前两个字符创建子目录，限制单目录文件数量
    final subDir = contentId.substring(0, 2);
    final dirPath = path.join(_rootDir, 'content', subDir);

    // 确保子目录存在
    final dir = Directory(dirPath);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    // 构建完整路径
    return path.join(dirPath, '$contentId$extension');
  }

  @override
  Future<String> storeFile(File file) async {
    await _ensureInitialized();

    // 计算文件哈希值
    final contentId = await _computeFileHash(file);
    final extension = _getFileExtension(file);

    // 检查文件是否已存在
    final targetPath = _getContentFilePath(contentId, extension);
    final targetFile = File(targetPath);

    // 如果文件不存在，复制到目标位置
    if (!await targetFile.exists()) {
      await file.copy(targetPath);
    }

    // 增加引用计数
    await incrementReferenceCount(contentId);

    return contentId;
  }

  @override
  Future<String> storeBytes(Uint8List bytes, String extension) async {
    await _ensureInitialized();

    // 计算字节数据哈希值
    final contentId = _computeBytesHash(bytes);

    // 确保extension以.开头
    final ext = extension.startsWith('.') ? extension : '.$extension';

    // 检查文件是否已存在
    final targetPath = _getContentFilePath(contentId, ext);
    final targetFile = File(targetPath);

    // 如果文件不存在，写入字节数据
    if (!await targetFile.exists()) {
      await targetFile.writeAsBytes(bytes);
    }

    // 增加引用计数
    await incrementReferenceCount(contentId);

    return contentId;
  }

  @override
  Future<File?> getFile(String contentId) async {
    await _ensureInitialized();

    // 在content目录中查找该文件
    final subDir = contentId.substring(0, 2);
    final contentDir = Directory(path.join(_rootDir, 'content', subDir));

    if (!await contentDir.exists()) {
      return null;
    }

    // 列出目录文件，查找匹配的文件
    final entities = await contentDir.list().toList();
    final files = entities
        .whereType<File>()
        .where((file) => path.basenameWithoutExtension(file.path) == contentId)
        .toList();

    if (files.isEmpty) {
      return null;
    }

    return files.first;
  }

  @override
  Future<void> incrementReferenceCount(String contentId) async {
    await _ensureInitialized();

    // 增加引用计数
    _referenceCount[contentId] = (_referenceCount[contentId] ?? 0) + 1;

    // 保存引用计数
    await _saveReferenceCount();
  }

  @override
  Future<void> decrementReferenceCount(String contentId) async {
    await _ensureInitialized();

    // 如果不存在或已经为0，则不做任何操作
    if (!_referenceCount.containsKey(contentId) ||
        _referenceCount[contentId]! <= 0) {
      return;
    }

    // 减少引用计数
    _referenceCount[contentId] = _referenceCount[contentId]! - 1;

    // 保存引用计数
    await _saveReferenceCount();
  }

  @override
  Future<int> cleanUnreferencedFiles({Duration? olderThan}) async {
    await _ensureInitialized();

    final cleanupDuration = olderThan ?? Duration(days: config.minCleanupDays);
    final now = DateTime.now();
    int removedCount = 0;

    // 遍历所有引用计数为0的内容ID
    final toRemove = <String>[];

    _referenceCount.forEach((contentId, count) {
      if (count <= 0) {
        toRemove.add(contentId);
      }
    });

    // 删除文件和引用计数
    for (final contentId in toRemove) {
      final file = await getFile(contentId);

      if (file != null) {
        // 检查文件修改时间
        final stat = await file.stat();
        final fileAge = now.difference(stat.modified);

        if (fileAge >= cleanupDuration) {
          try {
            await file.delete();
            _referenceCount.remove(contentId);
            removedCount++;
          } catch (e) {
            print('Failed to delete file: $e');
          }
        }
      } else {
        // 如果文件不存在，直接移除引用计数
        _referenceCount.remove(contentId);
      }
    }

    // 保存引用计数
    if (removedCount > 0) {
      await _saveReferenceCount();
    }

    return removedCount;
  }

  @override
  Future<bool> exists(String contentId) async {
    await _ensureInitialized();

    final file = await getFile(contentId);
    return file != null && await file.exists();
  }
}
