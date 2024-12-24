import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/complaint_form.dart';
import 'screens/complaint_list.dart';
import 'screens/reset_password_page.dart';
import 'screens/login_page.dart'; // Add the Login Page

void main() {
  // await dotenv.load(); // Load the .env file
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaint App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login', // Make Login Page the first route
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(), // Add Login Page route
        '/complaint_form': (context) => const ComplaintForm(),
        '/complaint_list': (context) => const ComplaintList(),
        '/reset-password': (context) => const ResetPasswordPage(),
      },
    );
  }
}
