import 'package:ahueni/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  bool showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.person,
          size: 40,
        ),
        const SizedBox(height: 20),
        const Text(
          'Get Started on Your Recovery Journey',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        MyTextField(
            hintText: 'Email',
            controller: _emailController,
            obscureText: false),
        const SizedBox(height: 20),
        MyTextField(
          hintText: 'Password',
          controller: _passwordController,
          obscureText: showPassword,
          suffixIcon: IconButton(
            icon: showPassword
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
            onPressed: () => setState(
              () {
                showPassword = !showPassword;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        MyTextField(
          hintText: 'Password',
          controller: _confirmPasswordController,
          obscureText: showPassword,
          suffixIcon: IconButton(
            icon: showPassword
                ? const Icon(CupertinoIcons.eye)
                : const Icon(CupertinoIcons.eye_slash),
            onPressed: () => setState(
              () {
                showPassword = !showPassword;
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text('Already a member?'),
            GestureDetector(
              onTap: widget.onTap,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
