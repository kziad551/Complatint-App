import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          // Tabs
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          foregroundColor: Colors.black,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'إنشاء حساب جديد',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          // Handle "تسجيل الدخول" click
                                        },
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          foregroundColor:
                                              Colors.black, // Text color
                                          backgroundColor: Colors
                                              .white, // Active background color
                                        ),
                                        child: const Text(
                                          'تسجيل الدخول',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Login Card
                          Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'البريد الإلكتروني / رقم الهاتف',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText:
                                          'ادخل البريد الإلكتروني / رقم الهاتف',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'كلمة المرور',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'ادخل كلمة المرور',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: true,
                                              onChanged: (value) {}),
                                          const Text('تذكر كلمة المرور'),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'هل نسيت كلمة المرور؟',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double
                                        .infinity, // Makes the button full width
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // TODO: Login action
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                14.0), // Remove horizontal padding
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      child: const Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                        color: Colors.grey,
                                      )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text('أو'),
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color: Colors.grey,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Facebook button
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.facebook),
                                          iconSize: 35,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      // Google button
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.g_mobiledata),
                                          iconSize: 35,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Footer
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
