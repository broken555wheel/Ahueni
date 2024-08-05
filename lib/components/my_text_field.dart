import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  const MyTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
