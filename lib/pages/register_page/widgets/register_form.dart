import 'package:flutter/material.dart';
import 'package:realtime_chat/common/blue_button.dart';
import 'package:realtime_chat/common/custom_input_field.dart';

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
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInputField(
              controller: emailController,
              inputType: TextInputType.text,
              obscure: false,
              icon: Icon(Icons.perm_identity),
              hintText: 'Name',
            ),
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
              text: 'Sign up',
              onPressed: () => {},
            ),
          ],
        ));
  }
}
