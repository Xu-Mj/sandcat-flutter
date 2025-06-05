import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// 媒体文件类型
enum MediaType {
  /// 图片
  image,

  /// 音频
  audio,

  /// 视频
  video,

  /// 文件
  file,
}

/// 媒体文件实体
class Media extends Equatable {
  /// UUID生成器
  static final _uuid = Uuid();

  /// 媒体ID
  final String id;

  /// 文件名
  final String fileName;

  /// 本地路径
  final String? localPath;

  /// 远程URL
  final String? remoteUrl;

  /// 媒体类型
  final MediaType type;

  /// 文件大小（字节）
  final int size;

  /// MIME类型
  final String mimeType;

  /// 缩略图路径
  final String? thumbnailPath;

  /// 缩略图URL
  final String? thumbnailUrl;

  /// 上传状态
  final MediaUploadStatus uploadStatus;

  /// 文件哈希值
  final String? fileHash;

  /// 所属会话ID
  final String? conversationId;

  /// 所属消息ID
  final String? messageId;

  /// 上传者ID
  final String? uploaderId;

  /// 创建时间
  final DateTime createdAt;

  /// 是否临时文件
  final bool isTemporary;

  /// 自定义数据
  final Map<String, dynamic>? metadata;

  /// 创建媒体文件
  const Media({
    required this.id,
    required this.fileName,
    this.localPath,
    this.remoteUrl,
    required this.type,
    required this.size,
    required this.mimeType,
    this.thumbnailPath,
    this.thumbnailUrl,
    this.uploadStatus = MediaUploadStatus.pending,
    this.fileHash,
    this.conversationId,
    this.messageId,
    this.uploaderId,
    required this.createdAt,
    this.isTemporary = false,
    this.metadata,
  });

  /// 创建新媒体文件
  factory Media.create({
    required String fileName,
    required MediaType type,
    required int size,
    required String mimeType,
    String? localPath,
    String? remoteUrl,
    String? thumbnailPath,
    String? conversationId,
    String? messageId,
    String? uploaderId,
    String? id,
    bool isTemporary = false,
    Map<String, dynamic>? metadata,
  }) {
    return Media(
      id: id ?? _uuid.v4(),
      fileName: fileName,
      localPath: localPath,
      remoteUrl: remoteUrl,
      type: type,
      size: size,
      mimeType: mimeType,
      thumbnailPath: thumbnailPath,
      uploadStatus: MediaUploadStatus.pending,
      conversationId: conversationId,
      messageId: messageId,
      uploaderId: uploaderId,
      createdAt: DateTime.now(),
      isTemporary: isTemporary,
      metadata: metadata,
    );
  }

  /// 复制媒体文件，并应用修改
  Media copyWith({
    String? id,
    String? fileName,
    String? localPath,
    String? remoteUrl,
    MediaType? type,
    int? size,
    String? mimeType,
    String? thumbnailPath,
    String? thumbnailUrl,
    MediaUploadStatus? uploadStatus,
    String? fileHash,
    String? conversationId,
    String? messageId,
    String? uploaderId,
    DateTime? createdAt,
    bool? isTemporary,
    Map<String, dynamic>? metadata,
  }) {
    return Media(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      type: type ?? this.type,
      size: size ?? this.size,
      mimeType: mimeType ?? this.mimeType,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      fileHash: fileHash ?? this.fileHash,
      conversationId: conversationId ?? this.conversationId,
      messageId: messageId ?? this.messageId,
      uploaderId: uploaderId ?? this.uploaderId,
      createdAt: createdAt ?? this.createdAt,
      isTemporary: isTemporary ?? this.isTemporary,
      metadata: metadata ?? this.metadata,
    );
  }

  /// 将媒体文件转换为Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fileName': fileName,
      'localPath': localPath,
      'remoteUrl': remoteUrl,
      'type': type.index,
      'size': size,
      'mimeType': mimeType,
      'thumbnailPath': thumbnailPath,
      'thumbnailUrl': thumbnailUrl,
      'uploadStatus': uploadStatus.index,
      'fileHash': fileHash,
      'conversationId': conversationId,
      'messageId': messageId,
      'uploaderId': uploaderId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isTemporary': isTemporary ? 1 : 0,
      'metadata': metadata,
    };
  }

  /// 从Map创建媒体文件
  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'],
      fileName: map['fileName'],
      localPath: map['localPath'],
      remoteUrl: map['remoteUrl'],
      type: MediaType.values[map['type']],
      size: map['size'],
      mimeType: map['mimeType'],
      thumbnailPath: map['thumbnailPath'],
      thumbnailUrl: map['thumbnailUrl'],
      uploadStatus: MediaUploadStatus.values[map['uploadStatus'] ?? 0],
      fileHash: map['fileHash'],
      conversationId: map['conversationId'],
      messageId: map['messageId'],
      uploaderId: map['uploaderId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      isTemporary: map['isTemporary'] == 1,
      metadata: map['metadata'],
    );
  }

  /// 更新上传状态
  Media updateUploadStatus(MediaUploadStatus status) {
    return copyWith(uploadStatus: status);
  }

  /// 更新远程URL
  Media withRemoteUrl(String url) {
    return copyWith(
      remoteUrl: url,
      uploadStatus: MediaUploadStatus.completed,
    );
  }

  /// 更新缩略图
  Media withThumbnail(String localPath, [String? remoteUrl]) {
    return copyWith(
      thumbnailPath: localPath,
      thumbnailUrl: remoteUrl,
    );
  }

  /// 关联到会话和消息
  Media associate({String? conversationId, String? messageId}) {
    return copyWith(
      conversationId: conversationId,
      messageId: messageId,
      isTemporary: false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fileName,
        localPath,
        remoteUrl,
        type,
        size,
        mimeType,
        thumbnailPath,
        thumbnailUrl,
        uploadStatus,
        fileHash,
        conversationId,
        messageId,
        uploaderId,
        createdAt,
        isTemporary,
        metadata,
      ];

  @override
  String toString() {
    return 'Media(id: $id, fileName: $fileName, type: $type)';
  }
}

/// 媒体上传状态
enum MediaUploadStatus {
  /// 等待中
  pending,

  /// 上传中
  uploading,

  /// 已取消
  canceled,

  /// 失败
  failed,

  /// 已完成
  completed,
}
