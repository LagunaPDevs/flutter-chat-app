import 'package:flutter/material.dart';

// project imports
import 'package:realtime_chat/pages/start_page/widgets/presentation_logo.dart';
import 'package:realtime_chat/pages/start_page/widgets/start_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PresentationLogo(
                    title:
                        "Connect easily with your family and friends over countries"),
                StartButton()
              ],
            ),
          ),
        )));
  }
}
