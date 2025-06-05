import 'package:flutter/material.dart';
import '../../data/storage/repository/message/message_model.dart';
import '../../data/storage/repository/user/user_model.dart';
import 'package:intl/intl.dart';

/// 消息气泡组件
class MessageBubble extends StatelessWidget {
  /// 消息对象
  final Message message;

  /// 是否是发送者
  final bool isSender;

  /// 消息状态组件
  final Widget? statusWidget;

  /// 用户头像组件
  final Widget? avatarWidget;

  /// 显示发送者名称
  final bool showSenderName;

  /// 发送者名称
  final String? senderName;

  /// 消息气泡颜色
  final Color? bubbleColor;

  /// 消息文本颜色
  final Color? textColor;

  /// 长按回调
  final Function(Message)? onLongPress;

  /// 点击回调
  final Function(Message)? onTap;

  /// 日期格式化
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  /// 创建消息气泡
  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSender,
    this.statusWidget,
    this.avatarWidget,
    this.showSenderName = false,
    this.senderName,
    this.bubbleColor,
    this.textColor,
    this.onLongPress,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBubbleColor = isSender
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final defaultTextColor = isSender
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurfaceVariant;

    // 确定气泡颜色和文字颜色
    final bgColor = bubbleColor ?? defaultBubbleColor;
    final txtColor = textColor ?? defaultTextColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 接收者显示头像在左侧
          if (!isSender && avatarWidget != null) ...[
            avatarWidget!,
            const SizedBox(width: 8),
          ],

          // 消息内容
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // 显示发送者名称
                if (showSenderName && senderName != null && !isSender)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                    child: Text(
                      senderName!,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // 消息气泡
                GestureDetector(
                  onLongPress:
                      onLongPress != null ? () => onLongPress!(message) : null,
                  onTap: onTap != null ? () => onTap!(message) : null,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _buildMessageContent(txtColor, theme),
                    ),
                  ),
                ),

                // 消息时间
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.createdAt),
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.colorScheme.onSurfaceVariant
                              .withOpacity(0.7),
                        ),
                      ),
                      if (isSender && statusWidget != null) ...[
                        const SizedBox(width: 4),
                        statusWidget!,
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 发送者显示头像在右侧
          if (isSender && avatarWidget != null) ...[
            const SizedBox(width: 8),
            avatarWidget!,
          ],
        ],
      ),
    );
  }

  /// 构建消息内容
  Widget _buildMessageContent(Color textColor, ThemeData theme) {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: TextStyle(color: textColor),
        );

      case MessageType.image:
        return _buildImageMessage(theme);

      case MessageType.video:
        return _buildVideoMessage(theme);

      case MessageType.audio:
        return _buildAudioMessage(theme);

      case MessageType.file:
        return _buildFileMessage(theme);

      case MessageType.location:
        return _buildLocationMessage(theme);

      case MessageType.sticker:
        return _buildStickerMessage();

      default:
        return Text(
          '不支持的消息类型',
          style: TextStyle(color: textColor, fontStyle: FontStyle.italic),
        );
    }
  }

  /// 构建图片消息
  Widget _buildImageMessage(ThemeData theme) {
    final String? imageUrl = message.metadata?['url'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.error_outline),
                        ),
                      ),
                    );
                  },
                )
              : AspectRatio(
                  aspectRatio: 1.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Icon(Icons.image)),
                  ),
                ),
        ),
        if (message.content.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            message.content,
            style: TextStyle(color: textColor),
          ),
        ],
      ],
    );
  }

  /// 构建视频消息
  Widget _buildVideoMessage(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Icon(Icons.play_circle, size: 48, color: Colors.white),
          ],
        ),
        if (message.content.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            message.content,
            style: TextStyle(color: textColor),
          ),
        ],
      ],
    );
  }

  /// 构建音频消息
  Widget _buildAudioMessage(ThemeData theme) {
    // 假设音频长度（秒）
    final int duration = message.metadata?['duration'] ?? 0;
    final String durationText = _formatDuration(duration);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.play_arrow, color: textColor),
        const SizedBox(width: 8),
        Container(
          width: 100, // 应该根据音频长度动态调整
          height: 4,
          decoration: BoxDecoration(
            color: textColor?.withAlpha(77) ??
                theme.colorScheme.onSurfaceVariant.withAlpha(77),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          durationText,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ],
    );
  }

  /// 构建文件消息
  Widget _buildFileMessage(ThemeData theme) {
    final fileName = message.metadata?['fileName'] ?? '文件';
    final fileSize = message.metadata?['fileSize'] ?? 0;
    final fileSizeText = _formatFileSize(fileSize);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fileSizeText,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.download, size: 20),
        ],
      ),
    );
  }

  /// 构建位置消息
  Widget _buildLocationMessage(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.location_on, size: 32)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          message.content,
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }

  /// 构建贴纸消息
  Widget _buildStickerMessage() {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(4),
      child: const Center(child: Text('贴纸')), // 这里应该显示贴纸图片
    );
  }

  /// 格式化时间
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    if (messageDate == today) {
      return _timeFormat.format(dateTime);
    } else if (messageDate == yesterday) {
      return '昨天 ${_timeFormat.format(dateTime)}';
    } else {
      return _dateFormat.format(dateTime);
    }
  }

  /// 格式化音频长度
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// 格式化文件大小
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      final mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    } else {
      final gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(1)} GB';
    }
  }
}
