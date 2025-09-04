import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tema
import 'core/app_theme.dart';

// Providers
import 'providers/auth_provider.dart';
import 'providers/requests_provider.dart';
import 'providers/notifications_provider.dart';

// Screens
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/create_help_screen.dart';
import 'screens/request_details_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/map_screen.dart';
import 'screens/my_requests_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notifications_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HelpMeApp());
}

class HelpMeApp extends StatelessWidget {
  const HelpMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..load()),
        ChangeNotifierProvider(create: (_) => RequestsProvider()..seed()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HelpMe',
        theme: AppTheme.light(),
        initialRoute: '/welcome',
        routes: {
          '/welcome': (_) => WelcomeScreen(),
          '/login': (_) => LoginScreen(),
          '/signup': (_) => SignupScreen(),
          '/home': (_) => HomeScreen(),
          '/create': (_) => CreateHelpScreen(),
          '/details': (_) => RequestDetailsScreen(),
          '/chat': (_) => ChatScreen(),
          '/map': (_) => MapScreen(),
          '/my': (_) => MyRequestsScreen(),
          '/profile': (_) => ProfileScreen(),
          '/notifications': (_) => NotificationsScreen(),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
          settings: settings,
        ),
      ),
    );
  }
}
