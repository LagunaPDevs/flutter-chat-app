import 'package:flutter/cupertino.dart';
import 'package:realtime_chat/pages/chat_page/chat_page.dart';
import 'package:realtime_chat/pages/loading_page/loading_page.dart';
import 'package:realtime_chat/pages/login_page/login_page.dart';
import 'package:realtime_chat/pages/register_page/register_page.dart';
import 'package:realtime_chat/pages/users_page/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': (_) => const UsersPage(),
  'chat': (_) => const ChatPage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
};
