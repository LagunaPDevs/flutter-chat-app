import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/message_response.dart';
import 'package:realtime_chat/models/user.dart';
import 'package:realtime_chat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  User userTo = User(
      uid: '1',
      name: 'uno',
      email: 'test10@test.com',
      online: false); // User by default

  Future<List<Message>> getChat(String userId) async {
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/messages/$userId'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final messagesResp = messagesResponseFromJson(resp.body);

    return messagesResp.messages;
  }
}
