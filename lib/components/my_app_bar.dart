import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ahueni/pages/profile_page.dart';
import 'package:ahueni/pages/settings_page.dart';
import 'package:ahueni/services/auth/auth_service.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    void logout() {
      authService.signOut();
    }

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (String result) {
            switch (result) {
              case 'Profile':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
                break;
              case 'Settings':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
                break;
              case 'Logout':
                logout();
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Profile',
              child: Text('Profile'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'Logout',
              child: Text('Logout'),
            ),
          ],
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(''),
          ) ,
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
