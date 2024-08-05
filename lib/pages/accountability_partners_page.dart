import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_drawer.dart';
import 'package:flutter/material.dart';

class AccountabilityPartnersPage extends StatefulWidget {
  const AccountabilityPartnersPage({super.key});

  @override
  State<AccountabilityPartnersPage> createState() => _AccountabilityPartnersPage();
}

class _AccountabilityPartnersPage extends State<AccountabilityPartnersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Accountability',
      ),
      drawer: MyDrawer(),
    );
  }
}
