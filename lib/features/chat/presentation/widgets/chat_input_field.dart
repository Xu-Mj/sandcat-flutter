import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// 自定义的聊天输入框组件
class ChatInputField extends StatefulWidget {
  /// 输入框占位文本
  final String? placeholder;

  /// 发送消息的回调函数
  final ValueChanged<String>? onSendMessage;

  /// 是否允许通过Enter键换行（true则需要Shift+Enter发送，false则Enter直接发送）
  final bool allowEnterNewline;

  /// 可选的外部控制器
  final TextEditingController? controller;

  const ChatInputField({
    super.key,
    this.placeholder,
    this.onSendMessage,
    this.allowEnterNewline = false,
    this.controller,
  });

  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (_, KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          if (widget.allowEnterNewline) {
            // 检查是否按下了 Shift 键
            final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

            if (!isShiftPressed) {
              // 单独按 Enter: 发送消息
              _sendMessage();
              return KeyEventResult.handled;
            }
            // Shift + Enter: 允许换行（不做任何操作，交由系统默认处理）
            return KeyEventResult.ignored;
          } else {
            // 不允许换行，直接发送
            _sendMessage();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: CupertinoTextField(
        controller: _controller,
        placeholder: widget.placeholder ?? '输入消息...',
        decoration: const BoxDecoration(),
        maxLines: widget.allowEnterNewline ? 4 : 1,
        minLines: 1,
        textInputAction: widget.allowEnterNewline
            ? TextInputAction.newline
            : TextInputAction.send,
        onSubmitted: widget.allowEnterNewline
            ? null
            : (value) {
                _sendMessage();
              },
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 8.0,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      widget.onSendMessage?.call(message);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }
}
