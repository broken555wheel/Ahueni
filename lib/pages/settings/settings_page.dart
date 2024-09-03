import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:ahueni/pages/profile/profile_page.dart';
import 'package:ahueni/pages/settings/blocked_users_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  bool _darkMode = false; // Example setting
  double _fontSize = 14.0; // Example setting

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Settings'),
      drawer: const MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Settings
          const SettingsSectionTitle('Account Settings'),
          SettingsTile(
            title: 'Profile Information',
            icon: Icons.person,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
          ),
          SettingsTile(
            title: 'Change Password',
            icon: Icons.lock,
            onTap: () {
              //TODO Add navigation to change password functionality
            },
          ),
          
          // Appearance Settings
          const SettingsSectionTitle('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            secondary: const Icon(Icons.brightness_6),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
                //TODO Implement dark mode functionality
              });
            },
          ),
          ListTile(
            title: const Text('Font Size'),
            subtitle: Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              label: _fontSize.toString(),
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                  //TODO Implement font size adjustment
                });
              },
            ),
          ),
          
          // Notification Settings
          const SettingsSectionTitle('Notifications'),
          SwitchListTile(
            title: const Text('Push Notifications'),
            secondary: const Icon(Icons.notifications),
            value: true, // Add actual value
            onChanged: (bool value) {
              //TODO Implement toggle for push notifications
            },
          ),
          SwitchListTile(
            title: const Text('Email Notifications'),
            secondary: const Icon(Icons.email),
            value: true, // Add actual value
            onChanged: (bool value) {
              //TODO Implement toggle for email notifications
            },
          ),

          // Privacy Settings
          const SettingsSectionTitle('Privacy'),
          
          SettingsTile(
            title: 'Blocked Users',
            icon: Icons.block,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BlockedUsersPage())),
          ),

          // Add more settings here
        ],
      ),
    );
  }
}

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.secondary,)
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsTile({required this.title, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
