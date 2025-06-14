import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sandcat/ui/chat/presentation/widgets/chat_input_field.dart';
import 'package:sandcat/ui/chat/presentation/widgets/emoji_picker.dart';
import 'package:sandcat/ui/utils/responsive_layout.dart';

/// WhatsApp风格的聊天输入区域组件
class ChatInputArea extends ConsumerStatefulWidget {
  /// 消息发送回调
  final void Function(String message) onSendMessage;

  final void Function({bool needAnimate}) scrollMsgList;

  /// 创建聊天输入区域
  const ChatInputArea({
    super.key,
    required this.onSendMessage,
    required this.scrollMsgList,
  });

  @override
  ConsumerState<ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends ConsumerState<ChatInputArea>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  bool _hasText = false;
  // 表情按钮的key，用于定位弹出面板
  final GlobalKey _emojiButtonKey = GlobalKey();

  // 表情面板显示状态
  bool _isEmojiPanelVisible = false;

  // 动画控制器
  late AnimationController _emojiPanelController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);

    // 初始化动画控制器
    _emojiPanelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 创建高度动画
    _heightAnimation = Tween<double>(
      begin: 0.0,
      end: 250.0,
    ).animate(CurvedAnimation(
      parent: _emojiPanelController,
      curve: Curves.easeOutCubic,
    ));

    // 添加动画帧监听器，在动画过程中持续更新滚动位置
    _emojiPanelController.addListener(_onAnimationChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _emojiPanelController.removeListener(_onAnimationChanged);
    _emojiPanelController.dispose();
    super.dispose();
  }

  void _onAnimationChanged() {
    // 只有在表情面板显示时才触发滚动
    if (_isEmojiPanelVisible) {
      // 无论是否为最后一帧，都使用needAnimate=false以实现平滑滚动
      widget.scrollMsgList(needAnimate: false);
    }
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
    final message = _messageController.text;
    if (message.isEmpty || message == '\n') return;

    widget.onSendMessage(message);
  }

  // 插入表情到输入框
  void _insertEmoji(String emoji) {
    try {
      // 获取当前光标位置，如果没有选择，默认为文本末尾
      final TextSelection selection = _messageController.selection;
      final int cursorPos = selection.isValid && selection.start >= 0
          ? selection.start
          : _messageController.text.length;

      // 在光标位置插入表情
      final text = _messageController.text;
      final newText =
          text.substring(0, cursorPos) + emoji + text.substring(cursorPos);

      // 更新文本并设置新的光标位置
      _messageController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursorPos + emoji.length),
      );
    } catch (e) {
      debugPrint('Error inserting emoji: $e');
      // 如果发生错误，简单地将表情添加到文本末尾
      _messageController.text = _messageController.text + emoji;
      // 将光标移动到末尾
      _messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      );
    }
  }

  // 处理表情按钮点击
  void _handleEmojiButtonTap() {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    if (isDesktop) {
      // 桌面端使用弹出式表情选择器
      showDesktopEmojiPicker(
        context: context,
        buttonKey: _emojiButtonKey,
        onEmojiSelected: _insertEmoji,
      );
    } else {
      // 移动端切换表情面板显示/隐藏
      setState(() {
        _isEmojiPanelVisible = !_isEmojiPanelVisible;
      });

      // 根据面板状态运行或反向运行动画
      if (_isEmojiPanelVisible) {
        _emojiPanelController.forward();
      } else {
        _emojiPanelController.reverse();
      }
    }
  }

  // 处理录音按钮点击
  void _handleRecordButtonTap() {
    // TODO: 实现录音功能
    debugPrint('开始录音...');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, bottom: 12.0, top: 6.0),
      // 最外层容器 - 完全透明，无阴影，仅作为布局容器
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 输入区域
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 主输入区域
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.circular(24.0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 表情按钮
                      CupertinoButton(
                        key: _emojiButtonKey,
                        padding: const EdgeInsets.only(left: 8.0),
                        onPressed: _handleEmojiButtonTap,
                        child: Icon(
                          _isEmojiPanelVisible
                              ? CupertinoIcons.keyboard
                              : CupertinoIcons.smiley,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),

                      // 消息输入框
                      Expanded(
                        child: ChatInputField(
                          controller: _messageController,
                          allowEnterNewline: true,
                          onSendMessage: (message) {
                            widget.onSendMessage(message);
                          },
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

              // 录音/发送按钮
              Container(
                margin: const EdgeInsets.only(left: 8.0, right: 6.0),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _hasText ? _sendMessage : _handleRecordButtonTap,
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

          // 表情面板 - 仅在非桌面模式下显示
          if (!ResponsiveLayout.isDesktop(context))
            AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: _heightAnimation.value,
                    margin: const EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: _isEmojiPanelVisible && _heightAnimation.value > 0
                        ? SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              height: 250,
                              child: RepaintBoundary(
                                child: EmojiPicker(
                                  height: 250,
                                  onEmojiSelected: _insertEmoji,
                                  isPopupMode: false,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
