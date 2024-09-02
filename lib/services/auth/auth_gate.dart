import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ahueni/pages/home/home_page.dart';
import 'package:ahueni/services/auth/login_or_signup.dart';
import 'package:ahueni/pages/profile/profile_creation_page.dart'; // Profile creation page

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _checkIfProfileExists(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;

            if (user == null) {
              // User is not logged in, show login/signup page
              return const LoginOrSignup();
            } else {
              // User is logged in, check if profile exists
              return FutureBuilder<bool>(
                future: _checkIfProfileExists(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData && snapshot.data == true) {
                    // Profile exists, go to home page
                    return const HomePage();
                  } else {
                    // Profile does not exist, go to profile creation page
                    return const ProfileCreationPage();
                  }
                },
              );
            }
          } else {
            // Waiting for authentication state
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
