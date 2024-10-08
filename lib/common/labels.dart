import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String account;
  final String textButton;
  final String destination;
  const Labels(
      {Key? key,
      required this.account,
      required this.textButton,
      required this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            account,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(context, destination),
            child: Text(textButton,
                style: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
