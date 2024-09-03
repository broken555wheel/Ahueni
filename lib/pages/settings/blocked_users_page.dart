import 'package:ahueni/components/my_user_tile.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:ahueni/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Unblock User'),
                content:
                    const Text('Are you sure you want to unblock this user?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        chatService.unblockUser(userId);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Unblocked'),
                          ),
                        );
                      },
                      child: const Text('Okay'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
        appBar: AppBar(
          title: const Text('BLOCKED USERS'),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: chatService.getBlockedUserStream(userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final blockedUsers = snapshot.data ?? [];

              if (blockedUsers.isEmpty) {
                return const Center(
                  child: Text('No blocked users'),
                );
              }

              return ListView.builder(
                itemCount: blockedUsers.length,
                itemBuilder: (context, index) {
                  final user = blockedUsers[index];
                  return MyUserTile(
                    text: user['email'],
                    onTap: () => _showUnblockBox(context, user['uid']),
                  );
                },
              );
            }));
  }
}
