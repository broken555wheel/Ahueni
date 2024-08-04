import 'package:ahueni/pages/login_page.dart';
import 'package:ahueni/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignup();
}

class _LoginOrSignup extends State<LoginOrSignup> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return SignupPage(onTap: togglePages);
    }
  }
}
