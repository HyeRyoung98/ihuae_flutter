import 'package:flutter/material.dart';
import 'package:flutter_ihuae/chat/chat_item.dart';
import 'package:flutter_ihuae/chat/input_container.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';

class ChatContainer extends StatefulWidget {
  const ChatContainer({
    super.key,
    required this.deviceHeight,
    required this.statusBarHeight,
    required this.chatDataService,
  });

  final double deviceHeight;
  final double statusBarHeight;
  final ChatDataService chatDataService;

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  final ScrollController _scrollController = ScrollController();
  bool _didInitialScroll = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(jump: true);
      _didInitialScroll = true;
    });
  }

  @override
  void didUpdateWidget(covariant ChatContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_didInitialScroll) return;

    if (oldWidget.chatDataService.chatDataList.length !=
        widget.chatDataService.chatDataList.length) {
      _scrollToBottom();
    }
  }

   void _scrollToBottom({bool jump = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      final position = _scrollController.position.maxScrollExtent;

      if (jump) {
        _scrollController.jumpTo(position);
      } else {
        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

    void _handleInputFocused() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chatItems = [];
    for (var i = 0; i < widget.chatDataService.chatDataList.length; i++) {
      final chatData = widget.chatDataService.chatDataList[i];
      chatItems.add(ChatItem(
        messageContent: chatData.content,
        index: i,
      ));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 64, bottom: 12),
            itemCount: widget.chatDataService.chatDataList.length,
            itemBuilder: (context, i) {
              final chatData = widget.chatDataService.chatDataList[i];
              return ChatItem(
                messageContent: chatData.content,
                index: i,
              );
            },
          ),
        ),
        InputContainer(chatDataService: widget.chatDataService,
          onMessageSent: _scrollToBottom,
          onInputFocused: _handleInputFocused),
      ],
    );
  }
}
