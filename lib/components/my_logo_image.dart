import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.4;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary
            ),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/ahueni_logo.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}