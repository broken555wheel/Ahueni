import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ahueni/services/auth/auth_gate.dart';
import 'package:ahueni/pages/profile/profile_page.dart';
import 'package:ahueni/pages/settings/settings_page.dart';
import 'package:ahueni/services/auth/auth_service.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  
  const MyAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: <Widget>[
        _buildPopupMenuButton(context),
      ],
    );
  }

  Widget _buildPopupMenuButton(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Theme.of(context).colorScheme.primary,
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: (String result) => _handleMenuSelection(context, result),
        itemBuilder: (BuildContext context) => _buildMenuItems(),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage(''),
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems() {
    return <PopupMenuEntry<String>>[
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
    ];
  }

  void _handleMenuSelection(BuildContext context, String result) {
    switch (result) {
      case 'Profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 'Logout':
        _logout(context);
        break;
    }
  }

  void _logout(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthGate()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}