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
            const CustomInputField(
              label: 'البريد الإلكتروني',
              hint: 'ادخل البريد الإلكتروني',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'الاسم الثلاثي',
              hint: 'ادخل الاسم الثلاثي',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'الهاتف',
              hint: 'ادخل الهاتف',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'طريقة الاستلام',
              hint: 'ادخل طريقة الاستلام',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'رقم الهوية او استخدم NFC',
              hint: 'ادخل رقم الهوية او استخدم NFC',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'كلمة المرور',
              hint: 'ادخل كلمة المرور',
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomActionButton(
              title: 'إنشاء حساب جديد',
              titleSize: 24,
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
