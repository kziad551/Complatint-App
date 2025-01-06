import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/complaint_form.dart';
import 'screens/complaint_form_cat.dart'; // Import other screens if needed
import 'screens/reset_password_page.dart';
import 'screens/login_page.dart';

void main() {
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
      initialRoute: '/login', // Initial route
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/complaint_form': (context) => const ComplaintForm(),
        '/complaint_form_cat': (context) => const ComplaintFormCat(
              complaintType: '', // Provide default value
              selectedCategory: '', // Provide default value
              serviceType: '', // Provide default value
              selectedTitle: '', // Provide default value
            ),
        '/reset-password': (context) => const ResetPasswordPage(),
      },
    );
  }
}
