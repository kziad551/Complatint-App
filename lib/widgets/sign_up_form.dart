import 'package:complaint_application/screens/home_page.dart';
import 'package:complaint_application/widgets/social_media.dart';
import 'package:flutter/material.dart';
import 'custom_action_button.dart';
import 'custom_input_field.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'البريد الإلكتروني',
              hint: 'أدخل البريد الإلكتروني',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'الاسم الثلاثي',
              hint: 'أدخل الاسم الثلاثي',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'الهاتف',
              hint: 'أدخل الهاتف',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'طريقة الاستلام',
              hint: 'أدخل طريقة الاستلام',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'رقم الهوية او استخدم NFC',
              hint: 'أدخل رقم الهوية او استخدم NFC',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: 'إنشاء حساب جديد',
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
}
