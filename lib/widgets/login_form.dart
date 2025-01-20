import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/api_service.dart';
import '../screens/home_page.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_input_field.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback onForgotPassword;

  const LoginForm({
    Key? key,
    required this.onForgotPassword,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService(baseUrl: 'https://complaint.top-wp.com');


  bool isLoading = false;
  bool rememberPassword = false;

  @override
  void initState() {
    super.initState();
    _loadSavedPassword();
  }

  Future<void> _loadSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPassword = prefs.getString('savedPassword');
    if (savedPassword != null) {
      setState(() {
        passwordController.text = savedPassword;
        rememberPassword = true;
      });
    }
  }

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await apiService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final userId = user['id'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setInt('userId', userId);

      if (rememberPassword) {
        await prefs.setString('savedPassword', passwordController.text.trim());
      } else {
        await prefs.remove('savedPassword');
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('خطأ'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('موافق'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomInputField(
              label: 'البريد الإلكتروني',
              hint: 'أدخل البريد الإلكتروني',
              controller: emailController,
            ),
            CustomInputField(
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              obscureText: true,
              controller: passwordController,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberPassword,
                        activeColor: const Color(0xFFBA110C),
                        onChanged: (value) {
                          setState(() {
                            rememberPassword = value ?? false;
                          });
                        },
                      ),
                      const Text('تذكر كلمة المرور'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: widget.onForgotPassword,
                  child: const Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(
                      color: Color(0xFFBA110C),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            CustomActionButton(
              title: isLoading ? '' : 'تسجيل الدخول',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: isLoading ? null : handleLogin,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'أو',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                ),
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Facebook Button
                SizedBox(
                  width: 60, // Cube dimensions
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Facebook login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade400),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
                // Google Button
                SizedBox(
                  width: 60, // Cube dimensions
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Google login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade400),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.google, // Google icon
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
