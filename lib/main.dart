import 'package:ahueni/providers/task_provider.dart';
import 'package:ahueni/providers/user_sobriety_provider.dart';
import 'package:ahueni/services/auth/auth_gate.dart';
import 'package:ahueni/themes/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ahueni/firebase_options.dart';
import 'package:ahueni/services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserSobrietyProvider()..fetchSobrietyData()),
        ChangeNotifierProvider(create: (context) => UserTaskProvider()..fetchTasks()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: appColors,
    );
  }
}
