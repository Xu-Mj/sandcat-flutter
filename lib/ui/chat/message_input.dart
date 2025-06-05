import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'emoji_panel.dart';
import '../../generated/l10n.dart';

/// 消息输入组件
class MessageInput extends StatefulWidget {
  /// 发送消息回调
  final Function(String) onSendText;

  /// 发送图片回调
  final Function(File)? onSendImage;

  /// 发送文件回调
  final Function(File)? onSendFile;

  /// 发送音频回调
  final Function(File, Duration)? onSendAudio;

  /// 是否禁用
  final bool disabled;

  /// 占位文本
  final String hintText;

  /// 创建消息输入组件
  const MessageInput({
    Key? key,
    required this.onSendText,
    this.onSendImage,
    this.onSendFile,
    this.onSendAudio,
    this.disabled = false,
    this.hintText = '输入消息...',
  }) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  /// 文本控制器
  final TextEditingController _textController = TextEditingController();

  /// 是否显示发送按钮
  bool _showSendButton = false;

  /// 图片选择器
  final _imagePicker = ImagePicker();

  /// 输入框焦点
  final FocusNode _focusNode = FocusNode();

  /// 是否显示表情面板
  bool _showEmojiPanel = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_handleTextChanged);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _showEmojiPanel = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_handleTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 处理文本变化
  void _handleTextChanged() {
    final text = _textController.text;
    final showSendButton = text.trim().isNotEmpty;
    if (showSendButton != _showSendButton) {
      setState(() {
        _showSendButton = showSendButton;
      });
    }
  }

  /// 处理发送文本消息
  void _handleSendText() {
    print("handleSendText");
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSendText(text);
      _textController.clear();
    }
  }

  /// 处理选择图片
  Future<void> _handlePickImage() async {
    if (widget.onSendImage == null) return;

    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      widget.onSendImage!(imageFile);
    }
  }

  /// 处理拍照
  Future<void> _handleTakePhoto() async {
    if (widget.onSendImage == null) return;

    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      widget.onSendImage!(imageFile);
    }
  }

  /// 处理选择文件
  Future<void> _handlePickFile() async {
    if (widget.onSendFile == null) return;

    // 显示暂不支持提示，作为练习项目为了简化依赖问题
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('由于依赖问题，暂不支持发送文件。实际项目中可使用file_picker包')),
    );
  }

  /// 显示附加功能菜单
  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('图片'),
              onTap: () {
                Navigator.pop(context);
                _handlePickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('拍照'),
              onTap: () {
                Navigator.pop(context);
                _handleTakePhoto();
              },
            ),
            if (widget.onSendFile != null)
              ListTile(
                leading: const Icon(Icons.attach_file),
                title: const Text('文件'),
                onTap: () {
                  Navigator.pop(context);
                  _handlePickFile();
                },
              ),
          ],
        ),
      ),
    );
  }

  /// 切换表情面板
  void _toggleEmojiPanel() {
    setState(() {
      _showEmojiPanel = !_showEmojiPanel;
      if (_showEmojiPanel) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  /// 处理表情选择
  void _handleEmojiSelected(String emoji) {
    // 获取当前光标位置
    final TextSelection selection = _textController.selection;
    final String currentText = _textController.text;

    // 在光标位置插入表情
    final newText = currentText.replaceRange(
      selection.start,
      selection.end,
      emoji,
    );

    // 更新文本和光标位置
    _textController.text = newText;
    _textController.selection = TextSelection.collapsed(
      offset: selection.start + emoji.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3.0,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              // 附加功能按钮
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: widget.disabled ? null : _showAttachmentOptions,
                tooltip: s.addButton,
              ),

              // 输入框
              Expanded(
                child: KeyboardListener(
                  focusNode: FocusNode(), // 用于监听键盘事件
                  onKeyEvent: (KeyEvent event) {
                    // 只处理按键按下事件
                    if (event is KeyDownEvent) {
                      // 检查是否按下了Enter键
                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                        // 检查Shift键是否被按下
                        if (HardwareKeyboard.instance.isShiftPressed) {
                          // Shift + Enter：插入换行符
                          final currentText = _textController.text;
                          final selection = _textController.selection;
                          final newText = currentText.replaceRange(
                            selection.start,
                            selection.end,
                            '\n',
                          );
                          _textController.value = TextEditingValue(
                            text: newText,
                            selection: TextSelection.collapsed(
                              offset: selection.start + 1,
                            ),
                          );
                        } else {
                          // 单独按Enter：发送消息
                          _handleSendText();
                        }
                      }
                    }
                  },
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      border: InputBorder.none,
                      enabled: !widget.disabled,
                    ),
                    maxLines: 5,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    // 移除onEditingComplete，因为我们用键盘监听器处理
                    keyboardAppearance: Theme.of(context).brightness,
                    onTap: () {
                      // 当点击输入框时隐藏表情面板
                      if (_showEmojiPanel) {
                        setState(() {
                          _showEmojiPanel = false;
                        });
                      }
                    },
                  ),
                ),
              ),

              // 表情按钮
              IconButton(
                icon: Icon(_showEmojiPanel
                    ? Icons.keyboard
                    : Icons.emoji_emotions_outlined),
                onPressed: widget.disabled ? null : _toggleEmojiPanel,
                tooltip: s.emojiButton,
              ),

              // 发送按钮
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _showSendButton
                    ? IconButton(
                        key: const ValueKey<String>("send_button"),
                        icon: const Icon(Icons.send),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: widget.disabled ? null : _handleSendText,
                        tooltip: s.sendButton,
                      )
                    : IconButton(
                        key: const ValueKey<String>("voice_button"),
                        icon: const Icon(Icons.mic),
                        onPressed: widget.disabled
                            ? null
                            : () {
                                // TODO: 实现语音录制
                              },
                      ),
              ),
            ],
          ),
        ),

        // 表情面板
        if (_showEmojiPanel)
          SizedBox(
            height: 300,
            child: EmojiPanel(
              onEmojiSelected: _handleEmojiSelected,
            ),
          ),
      ],
    );
  }
}
