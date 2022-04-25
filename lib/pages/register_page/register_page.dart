import 'package:flutter/material.dart';
import 'package:realtime_chat/common/labels.dart';
import 'package:realtime_chat/common/logo.dart';
import 'package:realtime_chat/pages/register_page/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: 'Register'),
                  RegisterForm(),
                  Labels(
                      account: 'Have an account?',
                      textButton: 'Sing in now!',
                      destination: 'login'),
                  Text(
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
