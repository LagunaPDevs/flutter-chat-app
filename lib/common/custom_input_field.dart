import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  bool obscure;
  TextInputType? inputType;
  Icon? icon;
  String? hintText;

  CustomInputField(
      {Key? key,
      required this.controller,
      this.obscure = false,
      this.inputType = TextInputType.text,
      this.icon,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5.0)
            ]),
        child: TextField(
          controller: controller,
          autocorrect: false,
          keyboardType: inputType,
          obscureText: obscure,
          decoration: InputDecoration(
              prefixIcon: icon,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: hintText),
        ));
  }
}
