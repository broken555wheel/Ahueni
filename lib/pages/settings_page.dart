import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      drawer: MyDrawer(),
    );
  }
}
