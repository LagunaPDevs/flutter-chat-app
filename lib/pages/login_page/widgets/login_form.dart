import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/common/blue_button.dart';
import 'package:realtime_chat/common/custom_input_field.dart';
import 'package:realtime_chat/common/labels.dart';
import 'package:realtime_chat/common/show_alert.dart';
import 'package:realtime_chat/services/auth_service.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final pswdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInputField(
              controller: emailController,
              inputType: TextInputType.emailAddress,
              obscure: false,
              icon: Icon(Icons.email_outlined),
              hintText: 'Email',
            ),
            CustomInputField(
              controller: pswdController,
              obscure: true,
              icon: Icon(Icons.lock_outline),
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
                          // TODO: Connect to socket server
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
