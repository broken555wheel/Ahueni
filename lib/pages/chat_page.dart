import 'package:ahueni/components/my_app_bar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  const ChatPage({required this.receiverEmail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: receiverEmail),
    );
  }
}
