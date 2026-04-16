import 'package:flutter/material.dart';
import 'package:flutter_ihuae/chat/chat_item.dart';
import 'package:flutter_ihuae/chat/input_container.dart';
import 'package:flutter_ihuae/services/chat_data_service.dart';

class ChatContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    List<Widget> chatItems = [];
    for (var i = 0; i < chatDataService.chatDataList.length; i++) {
      final chatData = chatDataService.chatDataList[i];
      chatItems.add(ChatItem(
        messageContent: chatData.content,
        index: i,
      ));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: false,
            padding: EdgeInsets.only(top: 64),
            itemCount: chatDataService.chatDataList.length,
            itemBuilder: (context, i) {
              final chatData = chatDataService.chatDataList[i];
              return ChatItem(
                messageContent: chatData.content,
                index: i,
              );
            },
          ),
        ),
        InputContainer(chatDataService: chatDataService),
      ],
    );
  }
}
