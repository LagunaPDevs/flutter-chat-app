import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/common/blue_button.dart';
import 'package:realtime_chat/common/custom_input_field.dart';
import 'package:realtime_chat/common/show_alert.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();
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
              controller: nameController,
              inputType: TextInputType.text,
              obscure: false,
              icon: const Icon(Icons.perm_identity),
              hintText: 'Name',
            ),
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
              text: 'Sign up',
              onPressed: authService.authenticating
                  ? null
                  : () async {
                      // Close keyboard
                      FocusScope.of(context).unfocus();

                      final registerOk = await authService.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          pswdController.text.trim());
                      if (registerOk == true) {
                        // Connect to socket server
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        showAlert(context, 'Registration failed',
                            registerOk.toString());
                      }
                    },
            ),
          ],
        ));
  }
}
