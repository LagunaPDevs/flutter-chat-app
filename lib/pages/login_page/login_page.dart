import 'package:flutter/material.dart';
import 'package:realtime_chat/common/labels.dart';
import 'package:realtime_chat/pages/login_page/widgets/login_form.dart';
import 'package:realtime_chat/common/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: 'Messenger'),
                  LoginForm(),
                  Labels(
                      account: 'Don\'t have an account?',
                      textButton: 'Create an account now!',
                      destination: 'register'),
                  const Text(
                    'Terms & Conditions of use',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
