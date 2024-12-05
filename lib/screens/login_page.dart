import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart'; // Import the footer widget

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // For Arabic
      child: Scaffold(
        backgroundColor: const Color(0xFFEFEFEF), // Light background color
        body: SafeArea(
          child: Column(
            children: [
              // Header with Tabs
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Handle "تسجيل الدخول"
                        },
                        child: const Text('تسجيل الدخول'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // Handle "إنشاء حساب جديد"
                        },
                        child: const Text('إنشاء حساب جديد'),
                      ),
                    ),
                  ],
                ),
              ),
              // Login Form Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'البريد الإلكتروني / رقم الهاتف',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'ادخل البريد الإلكتروني / رقم الهاتف',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'كلمة المرور',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'ادخل كلمة المرور',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (value) {}),
                              const Text('تذكر كلمة المرور'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'هل نسيت كلمة المرور؟',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Login action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: const [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('أو'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // TODO: Google login action
                                },
                                icon: const Icon(Icons.g_mobiledata),
                                iconSize: 40,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: () {
                                  // TODO: Facebook login action
                                },
                                icon: const Icon(Icons.facebook),
                                iconSize: 40,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Add the reusable footer widget
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
