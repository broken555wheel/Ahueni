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
          minWidth: 120,
          maxWidth: 250,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary
          )
        ),

        child: Center(
          widthFactor: 1,
          child: Text(buttonText,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
          ),
        ),
      ),
    );
  }
}
