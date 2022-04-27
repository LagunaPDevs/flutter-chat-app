import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/pages/login_page/login_page.dart';
import 'package:realtime_chat/pages/users_page/users_page.dart';
import 'package:realtime_chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text('Wait...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context);

    final authenticated = await authService.isLoggedIn();

    if (authenticated) {
      // TODO: Connect to socket server

      // Replace default animation between pages
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsersPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      // Replace default animation between pages
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
