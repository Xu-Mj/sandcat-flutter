import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// WhatsApp风格的聊天输入区域组件
class ChatInputArea extends ConsumerStatefulWidget {
  /// 消息发送回调
  final void Function(String message) onSendMessage;

  /// 创建聊天输入区域
  const ChatInputArea({
    super.key,
    required this.onSendMessage,
  });

  @override
  ConsumerState<ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends ConsumerState<ChatInputArea> {
  final TextEditingController _messageController = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _messageController.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    widget.onSendMessage(message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, bottom: 12.0, top: 6.0),
      // 最外层容器 - 完全透明，无阴影，仅作为布局容器
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 第一组：表情、输入框、附件、相机
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                borderRadius: BorderRadius.circular(24.0),
                // 将阴影移到这个容器
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withValues(alpha: 0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 表情按钮
                  CupertinoButton(
                    padding: const EdgeInsets.only(left: 8.0),
                    onPressed: () {
                      // TODO: 打开表情选择器
                    },
                    child: const Icon(
                      CupertinoIcons.smiley,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),

                  // 消息输入框
                  Expanded(
                    child: CupertinoTextField(
                      controller: _messageController,
                      placeholder: '输入信息',
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.transparent,
                        border: Border.all(color: CupertinoColors.transparent),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),

                  // 附件按钮
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // TODO: 打开附件选择器
                    },
                    child: const Icon(
                      CupertinoIcons.paperclip,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),

                  // 相机按钮
                  CupertinoButton(
                    padding: const EdgeInsets.only(right: 8.0),
                    onPressed: () {
                      // TODO: 打开相机
                    },
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 第二组：录音/发送按钮
          Container(
            margin: const EdgeInsets.only(left: 8.0, right: 6.0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _hasText ? _sendMessage : null,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF25D366), // WhatsApp绿色
                  shape: BoxShape.circle,
                ),
                child: _hasText
                    ? const Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xFFFFFFFF),
                        size: 22,
                      )
                    : const Icon(
                        CupertinoIcons.mic_fill,
                        color: Color(0xFFFFFFFF),
                        size: 22,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
