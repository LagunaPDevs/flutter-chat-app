import 'package:flutter/material.dart';

// external libraries
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// project imports
import 'package:realtime_chat/pages/start_page/start_page.dart';
import 'package:realtime_chat/pages/users_page/users_page.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Lottie.asset('assets/lottie/loading_lottie.json')),
              ));
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final authenticated = await authService.isLoggedIn();

    if (authenticated) {
      // Connect to socket server
      socketService.connect();

      // Replace default animation between pages
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsersPage(),
              transitionDuration: const Duration(milliseconds: 400)));
    } else {
      // Replace default animation between pages
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const StartPage(),
              transitionDuration: const Duration(milliseconds: 400)));
    }
  }
}
