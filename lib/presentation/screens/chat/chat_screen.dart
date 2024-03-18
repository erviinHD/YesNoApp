import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/screens/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ChatHeader(),
      body: _ChatView(),
    );
  }
}

class _ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Lana del Rey",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Singing of Indie",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://estaticos-cdn.prensaiberica.es/clip/ef1c49f2-3c8d-4040-afa4-c1fc86b18575_alta-libre-aspect-ratio_default_0.jpg"),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble(message: message)
                    : MyMessageBubble(
                        message: message,
                      );
              },
            )),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendmessage(value),
              //onValue: (value) => chatProvider.sendmessage,
            ), // Input Field
          ],
        ),
      ),
    );
  }
}
