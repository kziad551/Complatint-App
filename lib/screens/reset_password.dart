import 'package:flutter/material.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_input_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? errorMessage; // Variable to store error messages

  void handlePasswordReset() {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      errorMessage = null; // Clear previous error message
    });

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = 'الرجاء إدخال كلمة المرور في الحقول المطلوبة.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = 'كلمة المرور الجديدة وتأكيد كلمة المرور غير متطابقتين.';
      });
      return;
    }

    // Add logic to reset the password in the CMS or backend here
    // Example: apiService.updateUserPassword(userId, newPassword);

    setState(() {
      errorMessage = null; // Clear error on success
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تمت إعادة تعيين كلمة المرور بنجاح.')),
    );

    Navigator.pop(context); // Navigate back or to the login page
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'إعادة تعيين كلمة المرور',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (errorMessage != null) // Display error message
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        CustomInputField(
                          label: 'كلمة المرور الجديدة',
                          hint: 'أدخل كلمة المرور الجديدة',
                          obscureText: true,
                          controller: newPasswordController,
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          label: 'تأكيد كلمة المرور',
                          hint: 'أعد إدخال كلمة المرور الجديدة',
                          obscureText: true,
                          controller: confirmPasswordController,
                        ),
                        const SizedBox(height: 40),
                        CustomActionButton(
                          title: 'تعديل',
                          titleSize: 16,
                          backgroundColor: const Color(0xFFBA110C),
                          onPressed: handlePasswordReset,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
