import 'package:complaint_application/services/api_service.dart';
import 'package:complaint_application/widgets/social_media.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/home_page.dart'; // Import HomePage
import 'custom_action_button.dart';
import 'custom_input_field.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.onForgotPassword,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService =
      ApiService(baseUrl: 'http://157.230.87.143:8055');

  bool isLoading = false;

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await apiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      if (kDebugMode) {
        print("user: $user");
      }
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      final errorMessage = error is Exception
          ? error.toString().replaceFirst('Exception: ', '')
          : error.toString();
      if (!mounted) return; // Ensure the widget is still mounted
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'البريد الإلكتروني / رقم الهاتف',
              hint: 'أدخل البريد الإلكتروني / رقم الهاتف',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              obscureText: true,
              controller: passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(
                      'تذكر كلمة المرور',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: widget.onForgotPassword,
                  child: const Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: isLoading ? '' : 'تسجيل الدخول',
              // title: 'تسجيل الدخول',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: isLoading ? null : () => handleLogin(),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3.0,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            const SocialMedia(),
          ],
        ),
      ),
    );
  }
}
