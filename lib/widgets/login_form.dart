import 'package:complaint_application/widgets/social_media.dart';
import 'package:flutter/material.dart';
import '../screens/home_page.dart'; // Import HomePage

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildInputField(
                label: 'البريد الإلكتروني / رقم الهاتف',
                hint: 'ادخل البريد الإلكتروني / رقم الهاتف'),
            const SizedBox(height: 16),
            _buildInputField(
                label: 'كلمة المرور',
                hint: 'ادخل كلمة المرور',
                obscureText: true),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text('تذكر كلمة المرور'),
                  ],
                ),
                TextButton(
                  onPressed: onForgotPassword,
                  child: const Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildActionButton('تسجيل الدخول', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }),
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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBA110C),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
