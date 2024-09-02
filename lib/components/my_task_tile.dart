import 'package:flutter/material.dart';

class MyTaskTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyTaskTile({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.task
              ),
              Text(text, style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
