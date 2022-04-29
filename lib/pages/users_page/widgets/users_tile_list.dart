import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/services/chat_service.dart';

class UsersTileList extends StatelessWidget {
  final User user;
  const UsersTileList({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue.shade100,
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green.shade300 : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
