import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/create_help_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const HelpMeApp());
}

class HelpMeApp extends StatelessWidget {
  const HelpMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelpMe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),

      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const CreateHelpScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
