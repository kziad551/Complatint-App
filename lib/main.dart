import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/complaint_form.dart';
import 'screens/complaint_list.dart';
import 'screens/reset_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaint App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/complaint_form': (context) => const ComplaintForm(),
        '/complaint_list': (context) => const ComplaintList(),
        '/reset-password': (context) => const ResetPasswordPage(),
      },
    );
  }
}
