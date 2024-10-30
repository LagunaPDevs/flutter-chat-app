import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const Text(
            'Terms & Conditions of use',
            style: TextStyle(fontWeight: FontWeight.w200),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "login");
              },
              child: const Center(child: Text("Start messaging"))),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
