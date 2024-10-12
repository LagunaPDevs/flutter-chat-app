import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/common/chat_message.dart';
import 'package:realtime_chat/models/message_response.dart';
import 'package:realtime_chat/pages/chat_page/widgets/send_button.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  bool isWriting = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    // event we are listening to
    socketService.socket.on('personal-message', _listenMessage);

    // refresh messages of selected chat
    _refreshHistory(chatService.userTo.uid);
    super.initState();
  }

  // listen message controller
  void _listenMessage(dynamic payload) {
    print('Message sent! $payload');
    // Create ChatMessage instance
    ChatMessage message = ChatMessage(
      text: payload['message'],
      uid: payload['from'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    setState(() {
      _messages.insert(0, message);
    });
    // set animation to make it work
    message.animationController.forward();
  }

  // refresh history of messages
  void _refreshHistory(String uidTo) async {
    List<Message> chat = await chatService.getChat(uidTo);
    print(chat);
    // fill array with messages
    final history = chat.map((m) => ChatMessage(
        text: m.message,
        uid: m.from,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTo;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                userTo.name.substring(0, 2),
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue.shade100,
              maxRadius: 14,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(userTo.name,
                style: const TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            const Divider(
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
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
                  if (text.trim().isNotEmpty) {
                    isWriting = true;
                  } else {
                    isWriting = false;
                  }
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Send message'),
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
    if (controller.text.isEmpty) return;
    setState(() {
      isWriting = false;
      final newMsg = ChatMessage(
          uid: authService.user.uid,
          text: controller.text,
          animationController: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 400)));
      listMsg.insert(0, newMsg);
      newMsg.animationController.forward();
    });

    // emit sms to server
    socketService.emit('personal-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': controller.text
    });

    // clean message from textfield
    controller.clear();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    // stop listening to server when we close chat
    socketService.socket.off('personal-message');
    super.dispose();
  }
}
