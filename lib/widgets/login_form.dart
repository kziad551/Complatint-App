import 'package:complaint_application/widgets/social_media.dart';
import 'package:flutter/material.dart';
import '../screens/home_page.dart'; // Import HomePage
import 'custom_action_button.dart';
import 'custom_input_field.dart';

class LoginForm extends StatelessWidget {
  final VoidCallback onForgotPassword;

  const LoginForm({
    Key? key,
    required this.onForgotPassword,
  }) : super(key: key);

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
            const CustomInputField(
              label: 'البريد الإلكتروني / رقم الهاتف',
              hint: 'أدخل البريد الإلكتروني / رقم الهاتف',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              obscureText: true,
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
                  onPressed: onForgotPassword,
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
              title: 'تسجيل الدخول',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const SizedBox(height: 20),
            const SocialMedia(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required String label, required String hint, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
