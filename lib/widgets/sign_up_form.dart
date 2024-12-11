import 'package:complaint_application/screens/home_page.dart';
import 'package:complaint_application/widgets/social_media.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildInputField(
                label: 'البريد الإلكتروني', hint: 'البريد الإلكتروني'),
            const SizedBox(height: 16),
            _buildInputField(label: 'الاسم الثلاثي', hint: 'الاسم الثلاثي'),
            const SizedBox(height: 16),
            _buildInputField(label: 'الهاتف', hint: 'الهاتف'),
            const SizedBox(height: 16),
            _buildInputField(label: 'طريقة الاستلام', hint: 'طريقة الاستلام'),
            const SizedBox(height: 16),
            _buildInputField(
                label: 'رقم الهوية او استخدم NFC',
                hint: 'رقم الهوية او استخدم NFC'),
            const SizedBox(height: 16),
            _buildInputField(
                label: 'كلمة المرور', hint: 'كلمة المرور', obscureText: true),
            const SizedBox(height: 16),
            _buildActionButton('إنشاء حساب جديد', () {
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
          child: Text(label, style: const TextStyle(fontSize: 16)),
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
