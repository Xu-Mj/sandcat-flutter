import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../storage_repository.dart';
import 'media_model.dart';
import '../../engines/query_condition.dart';
import '../../engines/storage_engine.dart';

/// 媒体文件仓库
class MediaRepository extends StorageRepository<Media> {
  final StorageEngine _engine;
  late final Directory _mediaDir;
  late final Directory _thumbnailDir;
  bool _initialized = false;
  final _uuid = Uuid();

  MediaRepository(this._engine);

  @override
  StorageEngine get engine => _engine;

  @override
  String get collectionName => 'media';

  @override
  Media fromMap(Map<String, dynamic> map) => Media.fromMap(map);

  @override
  Map<String, dynamic> toMap(Media entity) => entity.toMap();

  /// 初始化媒体目录
  Future<void> initialize() async {
    if (_initialized) return;

    final appDir = await getApplicationDocumentsDirectory();
    _mediaDir = Directory('${appDir.path}/media');
    _thumbnailDir = Directory('${appDir.path}/thumbnails');

    if (!await _mediaDir.exists()) {
      await _mediaDir.create(recursive: true);
    }

    if (!await _thumbnailDir.exists()) {
      await _thumbnailDir.create(recursive: true);
    }

    _initialized = true;
  }

  /// 保存媒体文件
  Future<Media> saveMedia(
    File file, {
    MediaType type = MediaType.file,
    String? conversationId,
    String? messageId,
    String? uploaderId,
    bool isTemporary = true,
    Map<String, dynamic>? metadata,
  }) async {
    await initialize();

    final fileName = path.basename(file.path);
    final fileSize = await file.length();
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    final fileHash = await _computeFileHash(file);

    // 检查是否已存在相同的文件
    final existingMedia = await _findByHash(fileHash);
    if (existingMedia != null) {
      // 如果找到相同的文件，创建一个新的引用
      return existingMedia.copyWith(
        conversationId: conversationId,
        messageId: messageId,
        uploaderId: uploaderId,
        isTemporary: isTemporary,
      );
    }

    // 创建新的媒体文件ID
    final mediaId = _uuid.v4();
    final localPath = await _copyToMediaDir(file, mediaId);

    // 为图片和视频生成缩略图
    String? thumbnailPath;
    if (type == MediaType.image || type == MediaType.video) {
      thumbnailPath = await _generateThumbnail(file, mediaId, type);
    }

    // 创建媒体实体
    final media = Media.create(
      id: mediaId,
      fileName: fileName,
      localPath: localPath,
      type: type,
      size: fileSize,
      mimeType: mimeType,
      thumbnailPath: thumbnailPath,
      conversationId: conversationId,
      messageId: messageId,
      uploaderId: uploaderId,
      isTemporary: isTemporary,
      metadata: metadata,
    );

    // 保存到存储
    await save(mediaId, media);

    return media;
  }

  /// 从二进制数据保存媒体文件
  Future<Media> saveMediaFromBytes(
    Uint8List bytes,
    String fileName, {
    MediaType type = MediaType.file,
    String? conversationId,
    String? messageId,
    String? uploaderId,
    bool isTemporary = true,
    Map<String, dynamic>? metadata,
  }) async {
    await initialize();

    // 创建临时文件
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/$fileName');
    await tempFile.writeAsBytes(bytes);

    try {
      // 使用已有方法处理文件
      return await saveMedia(
        tempFile,
        type: type,
        conversationId: conversationId,
        messageId: messageId,
        uploaderId: uploaderId,
        isTemporary: isTemporary,
        metadata: metadata,
      );
    } finally {
      // 删除临时文件
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }

  /// 获取媒体文件
  Future<Media?> getMedia(String id) async {
    return getById(id);
  }

  /// 获取媒体文件内容
  Future<File?> getMediaFile(String id) async {
    final media = await getMedia(id);
    if (media == null || media.localPath == null) {
      return null;
    }

    final file = File(media.localPath!);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// 获取缩略图文件
  Future<File?> getThumbnailFile(String id) async {
    final media = await getMedia(id);
    if (media == null || media.thumbnailPath == null) {
      return null;
    }

    final file = File(media.thumbnailPath!);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// 获取会话的所有媒体文件
  Future<List<Media>> getConversationMedia(String conversationId) async {
    return query(
      QueryCondition.equals('conversationId', conversationId),
    );
  }

  /// 获取消息的所有媒体文件
  Future<List<Media>> getMessageMedia(String messageId) async {
    return query(
      QueryCondition.equals('messageId', messageId),
    );
  }

  /// 更新媒体文件上传状态
  Future<void> updateUploadStatus(
    String id,
    MediaUploadStatus status,
  ) async {
    final media = await getMedia(id);
    if (media != null) {
      await save(id, media.updateUploadStatus(status));
    }
  }

  /// 更新媒体文件远程URL
  Future<void> updateRemoteUrl(String id, String url) async {
    final media = await getMedia(id);
    if (media != null) {
      await save(id, media.withRemoteUrl(url));
    }
  }

  /// 关联媒体文件到会话和消息
  Future<void> associateMedia(
    String id, {
    String? conversationId,
    String? messageId,
  }) async {
    final media = await getMedia(id);
    if (media != null) {
      await save(
        id,
        media.associate(
          conversationId: conversationId,
          messageId: messageId,
        ),
      );
    }
  }

  /// 删除媒体文件
  @override
  Future<void> delete(String id) async {
    final media = await getMedia(id);
    if (media != null) {
      // 删除本地文件
      if (media.localPath != null) {
        final file = File(media.localPath!);
        if (await file.exists()) {
          await file.delete();
        }
      }

      // 删除缩略图
      if (media.thumbnailPath != null) {
        final thumbnail = File(media.thumbnailPath!);
        if (await thumbnail.exists()) {
          await thumbnail.delete();
        }
      }

      // 删除数据库记录
      await super.delete(id);
    }
  }

  /// 清理临时媒体文件
  Future<void> cleanupTemporaryMedia() async {
    final tempMedia = await query(
      QueryCondition.equals('isTemporary', true),
    );

    for (final media in tempMedia) {
      await delete(media.id);
    }
  }

  /// 清理旧媒体文件
  Future<void> cleanupOldMedia(Duration maxAge) async {
    final cutoff = DateTime.now().subtract(maxAge);
    final oldMedia = await query(
      QueryCondition.lessThan('createdAt', cutoff.millisecondsSinceEpoch),
    );

    for (final media in oldMedia) {
      await delete(media.id);
    }
  }

  /// 计算文件哈希值
  Future<String> _computeFileHash(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      // 如果出错，使用文件名和大小作为替代
      final fileSize = await file.length();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      return sha256
          .convert(utf8.encode('${file.path}:$fileSize:$timestamp'))
          .toString();
    }
  }

  /// 复制文件到媒体目录
  Future<String> _copyToMediaDir(File file, String id) async {
    final extension = path.extension(file.path);
    final mediaFile = File('${_mediaDir.path}/$id$extension');
    await file.copy(mediaFile.path);
    return mediaFile.path;
  }

  /// 生成缩略图
  Future<String?> _generateThumbnail(
    File file,
    String id,
    MediaType type,
  ) async {
    // 在真正的实现中，这里会使用图片/视频处理库来生成缩略图
    // 这里为了简单，假设我们已经生成了缩略图
    final extension = path.extension(file.path);
    final thumbnailFile = File('${_thumbnailDir.path}/$id$extension');

    try {
      // 这里应该是缩放图片或生成视频预览帧
      // 暂时简单复制原文件作为缩略图
      await file.copy(thumbnailFile.path);
      return thumbnailFile.path;
    } catch (e) {
      print('Failed to generate thumbnail: $e');
      return null;
    }
  }

  /// 根据哈希查找媒体
  Future<Media?> _findByHash(String hash) async {
    final results = await query(
      QueryCondition.equals('fileHash', hash),
    );
    return results.isNotEmpty ? results.first : null;
  }
}
