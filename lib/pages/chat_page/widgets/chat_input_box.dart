import 'package:flutter/material.dart';
import 'package:realtime_chat/common/chat_message.dart';

import 'package:realtime_chat/pages/chat_page/widgets/send_button.dart';

class ChatInputBox extends StatefulWidget {
  List<ChatMessage> messages;
  ChatInputBox({Key? key, required this.messages}) : super(key: key);

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}

class _ChatInputBoxState extends State<ChatInputBox>
    with TickerProviderStateMixin {
  bool isWriting = false;
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        height: 50,
        child: Row(
          children: [
            Flexible(
                child: TextField(
              controller: controller,
              onSubmitted: (_) {},
              onChanged: (text) {
                setState(() {
                  if (text.trim().length > 0) {
                    isWriting = true;
                  } else {
                    isWriting = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Send message'),
              focusNode: focusNode,
            )),
            // Send button
            SendButton(
              clickAction: isWriting ? () => _handleSubmit() : null,
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit() {
    if (controller.text.length == 0) return;
    List<ChatMessage> listMsg = widget.messages;
    print(controller.text);
    setState(() {
      isWriting = false;
      final newMsg = ChatMessage(
          uid: '123',
          text: controller.text,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 400)));
      listMsg.insert(0, newMsg);
      newMsg.animationController.forward();
    });
    controller.clear();
    focusNode.requestFocus();
  }
}
