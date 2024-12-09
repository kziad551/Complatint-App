import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool isSmsSelected = false;
  bool isEmailSelected = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: const Text('إعادة تعيين كلمة المرور'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'إعادة تعيين كلمة المرور',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'طريقة استلام رابط إعادة تعيين كلمة المرور',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CheckboxListTile(
                          title: const Text("عن طريق الرسائل القصيرة"),
                          value: isSmsSelected,
                          onChanged: (value) {
                            setState(() {
                              isSmsSelected = value ?? false;
                              if (isSmsSelected) {
                                isEmailSelected = false; // Deselect the other
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text("عن طريق البريد الإلكتروني"),
                          value: isEmailSelected,
                          onChanged: (value) {
                            setState(() {
                              isEmailSelected = value ?? false;
                              if (isEmailSelected) {
                                isSmsSelected = false; // Deselect the other
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle sending the reset link
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBC0019),
                              padding: const EdgeInsets.symmetric(vertical: 14.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'إرسال رابط إعادة التعيين',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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
