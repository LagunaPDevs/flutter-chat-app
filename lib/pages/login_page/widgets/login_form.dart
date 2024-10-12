import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/common/blue_button.dart';
import 'package:realtime_chat/common/custom_input_field.dart';
import 'package:realtime_chat/common/show_alert.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInputField(
              controller: emailController,
              inputType: TextInputType.emailAddress,
              obscure: false,
              icon: const Icon(Icons.email_outlined),
              hintText: 'Email',
            ),
            CustomInputField(
              controller: pswdController,
              obscure: true,
              icon: const Icon(Icons.lock_outline),
              hintText: 'Password',
            ),
            BlueButton(
                text: 'Sign in',
                onPressed: authService.authenticating
                    ? null
                    : () async {
                        // Close keyboard
                        FocusScope.of(context).unfocus();

                        final loginOk = await authService.login(
                            emailController.text.trim(),
                            pswdController.text.trim());

                        if (loginOk) {
                          // Connect to socket server
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, 'users');
                        } else {
                          showAlert(
                              context, 'Login failed', 'Invalid credentials');
                        }
                      })
          ],
        ));
  }

  returnNull() {
    return null;
  }
}
