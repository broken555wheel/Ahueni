import 'dart:async';
import 'package:ahueni/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:ahueni/components/my_user_tile.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:ahueni/services/chat/chat_service.dart';

class AccountabilityPartnersPage extends StatefulWidget {
  const AccountabilityPartnersPage({super.key});

  @override
  State<AccountabilityPartnersPage> createState() =>
      _AccountabilityPartnersPage();
}

class _AccountabilityPartnersPage extends State<AccountabilityPartnersPage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Accountability',
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _buildUserList(),
    );
  }

  // build a list of users except the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStreamExcludingBlocked(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting || _loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyUserTile(
          text: userData['email'],
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverID: userData['uid'],
                ),
              )),
        ),
      );
    } else {
      return Container();
    }
  }
}
