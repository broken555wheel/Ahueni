import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const MyButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 150,
          maxWidth: 250,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          color: Colors.black,
        ),

        child: Center(
          widthFactor: 1,
          child: Text(buttonText,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          ),
        ),
      ),
    );
  }
}
