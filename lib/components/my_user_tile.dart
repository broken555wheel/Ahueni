import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyUserTile({required this.text, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
