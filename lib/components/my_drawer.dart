import 'package:ahueni/components/my_logo_image.dart';
import 'package:ahueni/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ahueni/pages/accountability_partners_page.dart';
import 'package:ahueni/pages/home/home_page.dart';
import 'package:ahueni/pages/journal_page.dart';
import 'package:ahueni/pages/profile_page.dart';
import 'package:ahueni/pages/settings_page.dart';
import 'package:ahueni/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      final authService = Provider.of<AuthService>(context, listen: false);
      authService.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AuthGate() ));
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const DrawerHeader(
                  child: Center(child: LogoImage()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'H O M E',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      leading: Icon(Icons.home, color: Theme.of(context).colorScheme.primary,),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                  child: ListTile(
                    title: Text(
                      'A C C O U N T A B I L I T Y',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    leading: Icon(Icons.people, color: Theme.of(context).colorScheme.primary,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AccountabilityPartnersPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                  child: ListTile(
                    title: Text(
                      'J O U R N A L',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    leading: Icon(Icons.book, color: Theme.of(context).colorScheme.primary,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JournalPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                  child: ListTile(
                    title: Text(
                      'P R O F I L E',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    leading: Icon(Icons.person, color: Theme.of(context).colorScheme.primary,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                      
                  child: ListTile(
                    title: Text(
                      'S E T T I N G S',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary,),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.surface, width: 0.1),
                  borderRadius: BorderRadius.circular(50)),
              child: ListTile(
                title: Text(
                  'L O G O U T',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary,),
                onTap: () {
                  signOut();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
