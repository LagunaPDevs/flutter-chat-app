import 'package:flutter/material.dart';
import 'package:realtime_chat/common/chat_message.dart';
import 'package:realtime_chat/pages/chat_page/widgets/chat_input_box.dart';
import 'package:realtime_chat/pages/chat_page/widgets/send_button.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  List<ChatMessage> _messages = [];
  bool isWriting = false;
  TextEditingController controller = new TextEditingController();
  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text('Maria Laguna',
                style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            // TODO: Caja de texto
            _ChatInputBox(),
          ],
        ),
      ),
    );
  }

  Widget _ChatInputBox() {
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
              clickAction: isWriting ? () => _handleSubmit(_messages) : null,
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(List<ChatMessage> listMsg) {
    if (controller.text.length == 0) return;
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

  @override
  void dispose() {
    //TODO: Socket off
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
