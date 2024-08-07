import 'package:ahueni/components/my_logo_image.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ahueni/components/my_button.dart';
import 'package:ahueni/components/my_text_field.dart';
import 'package:provider/provider.dart';

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

  void signUp(BuildContext context) async {
    final auth = Provider.of<AuthService>(context, listen: false);
    print(_emailController.text);
    print(_passwordController.text);
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await auth.signUpWithEmailAndPassword(
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
                label: const Text(
                  'Ok',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Passwords do not match'),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              label: const Text(
                'Ok',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.check),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoImage(),
                const SizedBox(height: 20),
                // const Text(
                //   'Get Started on Your Recovery Journey',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
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
                MyButton(
                    buttonText: 'Signup',
                    onTap: () {
                      signUp(context);
                    }),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('Already a member?', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
color: Theme.of(context).colorScheme.secondary                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
