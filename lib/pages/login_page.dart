import 'package:ahueni/components/my_button.dart';
import 'package:ahueni/components/my_text_field.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.toString()),
                actions: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    label: const Text('Ok'),
                    icon: const Icon(Icons.check),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/ahueni_logo.png'),
                    radius: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  MyButton(
                    buttonText: 'Login',
                    onTap: () => login(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
