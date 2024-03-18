import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';

class MessageFieldBox extends StatefulWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    //final colors = Theme.of(context).colorScheme;
    final textController = TextEditingController();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10));
    final inputDecoration = InputDecoration(
        hintText: "Type of message",
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue = textController.value.text;
            textController.clear();
            chatProvider.sendmessage(textValue);
          },
        ));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        onTapOutside: (event) {
          focusNode.unfocus();
        },
        focusNode: focusNode,
        controller: textController,
        decoration: inputDecoration,
        onSubmitted: (value) {
          chatProvider.sendmessage(value);
          textController.clear();
          focusNode.requestFocus();
        },
      ),
    );
  }
}
