import 'package:flutter/material.dart';
import '../widgets/custom_action_button.dart';

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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
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
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'طريقة استلام رابط إعادة تعيين كلمة المرور',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSmsSelected = !isSmsSelected;
                              if (isSmsSelected) {
                                isEmailSelected = false; // Deselect the other
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSmsSelected,
                                activeColor: const Color(0xFFBA110C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    isSmsSelected = value ?? false;
                                    if (isSmsSelected) {
                                      isEmailSelected =
                                          false; // Deselect the other
                                    }
                                  });
                                },
                              ),
                              const Text(
                                'عن طريق الرسائل القصيرة',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEmailSelected = !isEmailSelected;
                              if (isEmailSelected) {
                                isSmsSelected = false; // Deselect the other
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                value: isEmailSelected,
                                activeColor: const Color(0xFFBA110C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    isEmailSelected = value ?? false;
                                    if (isEmailSelected) {
                                      isSmsSelected =
                                          false; // Deselect the other
                                    }
                                  });
                                },
                              ),
                              const Text(
                                'عن طريق البريد الإلكتروني',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomActionButton(
                          title: 'إرسال رابط إعادة التعيين',
                          titleSize: 16,
                          backgroundColor: const Color(0xFFBA110C),
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const NewPassword()),
                            // );
                          },
                        ),
                        const SizedBox(height: 40),
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
