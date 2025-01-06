import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screens/home_page.dart';
import 'custom_action_button.dart';
import 'custom_input_field.dart';
import 'custom_dropdown_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? selectedCommunicationMethod;
  bool isLoading = false;

  // Base API URL
  final String baseUrl = 'http://157.230.87.143:8055/items/Users';

  Future<void> handleSignUp() async {
    // Validate required fields
    if (emailController.text.trim().isEmpty ||
        fullNameController.text.trim().isEmpty ||
        phoneNumberController.text.trim().isEmpty ||
        nationalIdController.text.trim().isEmpty ||
        selectedCommunicationMethod == null ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      _showMessage('خطأ', 'يجب ملء جميع الحقول المطلوبة');
      return;
    }

    // Validate password
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      _showMessage('خطأ', 'كلمات المرور غير متطابقة');
      return;
    }
    if (passwordController.text.trim().length < 6) {
      _showMessage('خطأ', 'كلمة المرور يجب أن تكون أطول من 6 أحرف');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Check if the email is already used
      final emailCheckResponse = await http.get(
        Uri.parse('$baseUrl?filter[email][_eq]=${emailController.text.trim()}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (emailCheckResponse.statusCode == 200) {
        final emailCheckData = jsonDecode(emailCheckResponse.body);
        if (emailCheckData['data'].isNotEmpty) {
          _showMessage('خطأ', 'البريد الإلكتروني مستخدم مسبقًا');
          setState(() {
            isLoading = false;
          });
          return;
        }
      } else {
        _showMessage('خطأ', 'حدث خطأ أثناء التحقق من البريد الإلكتروني');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Make API request to create a new user
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'full_name': fullNameController.text.trim(),
          'phone_number': phoneNumberController.text.trim(),
          'national_id_number': nationalIdController.text.trim(),
          'communication_method': selectedCommunicationMethod,
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showMessage('نجاح', 'تم إنشاء الحساب بنجاح', onSuccess: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        });
      } else {
        final error = jsonDecode(response.body);
        _showMessage('خطأ', error['errors']?.first['message'] ?? 'حدث خطأ ما');
      }
    } catch (error) {
      _showMessage('خطأ', 'حدث خطأ أثناء الاتصال بالخادم.\n$error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessage(String title, String message, {VoidCallback? onSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('موافق'),
            onPressed: () {
              Navigator.of(context).pop();
              if (onSuccess != null) {
                onSuccess();
              }
            },
          ),
        ],
      ),
    );
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
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'البريد الإلكتروني',
              hint: 'أدخل البريد الإلكتروني',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'الاسم الثلاثي',
              hint: 'أدخل الاسم الثلاثي',
              controller: fullNameController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'الهاتف',
              hint: 'أدخل الهاتف',
              controller: phoneNumberController,
            ),
            const SizedBox(height: 16),
            CustomDropdownField(
              label: 'طريقة الاستلام',
              hint: 'إختر طريقة الاستلام',
              items: ['رسائل نصية', 'واتساب', 'ايميل', 'اتصال هاتفي'],
              selectedItem: selectedCommunicationMethod,
              onChanged: (value) {
                setState(() {
                  selectedCommunicationMethod = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'رقم الهوية',
              hint: 'أدخل رقم الهوية',
              controller: nationalIdController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            CustomInputField(
              label: 'إعادة كلمة المرور',
              hint: 'أدخل كلمة المرور مجددًا',
              obscureText: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: isLoading ? '' : 'إنشاء حساب جديد',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: isLoading ? null : handleSignUp,
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
          ],
        ),
      ),
    );
  }
}
