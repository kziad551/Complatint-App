import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';
import '../widgets/toggle_tabs.dart';
import '../widgets/login_form.dart';
import '../widgets/sign_up_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignUp = false; // State for toggling between login and sign-up

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          // Toggle Tabs for switching between Login and Sign-Up
                          ToggleTabs(
                            isSignUp: isSignUp,
                            onTabSelected: (value) {
                              setState(() {
                                isSignUp = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Display the appropriate form
                          isSignUp
                              ? const SignUpForm() // Sign-Up Form
                              : LoginForm(
                                  onForgotPassword: () {
                                    Navigator.pushNamed(
                                        context, '/reset-password');
                                  },
                                ), // Login Form
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Footer Widget
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
