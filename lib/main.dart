import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_page.dart'; // Import the Login Page
import 'screens/reset_password_page.dart'; // Import the Reset Password Page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint Application',
      theme: ThemeData(
        fontFamily: 'Inter', // Arabic font
        primarySwatch: Colors.deepPurple,
      ),
      locale: const Locale('ar', 'AE'), // Arabic Locale
      supportedLocales: const [
        Locale('ar', 'AE'), // Arabic
        Locale('en', 'US'), // English
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: '/', // Define the initial route
      routes: {
        '/': (context) => const LoginPage(), // Login Page as the initial route
        '/reset-password': (context) => const ResetPasswordPage(), // Reset Password Page
      },
    );
  }
}
