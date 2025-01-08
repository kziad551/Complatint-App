import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_layout_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEditable = false; // Track if fields are editable
  bool isLoading = true; // Track loading state
  bool isSubmitting = false; // Track submission state
  bool obscurePassword = true; // Toggle password visibility

  // Controllers for form fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController communicationMethodController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  int? userId; // Logged-in user ID

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch the user details
  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId');

      if (userId != null) {
        final response = await http.get(
          Uri.parse('http://157.230.87.143:8055/items/Users/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body)['data'];
          setState(() {
            fullNameController.text = userData['full_name'] ?? '';
            phoneNumberController.text = userData['phone_number']?.toString() ?? '';
            nationalIdController.text = userData['national_id_number']?.toString() ?? '';
            communicationMethodController.text = userData['communication_method'] ?? '';
            emailController.text = userData['email'] ?? '';
            passwordController.text = userData['password'] ?? ''; // Fetch the password
            isLoading = false;
          });
        } else {
          throw Exception('Failed to fetch user data');
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  // Update user details
  Future<void> updateUserDetails() async {
    if (userId == null) return;

    setState(() {
      isSubmitting = true;
    });

    final updatedData = {
      'full_name': fullNameController.text.trim(),
      'phone_number': phoneNumberController.text.trim(),
      'national_id_number': nationalIdController.text.trim(),
      'password': passwordController.text.trim(),
      'communication_method': communicationMethodController.text.trim(),
    };

    try {
      final response = await http.patch(
        Uri.parse('http://157.230.87.143:8055/items/Users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تحديث البيانات بنجاح')),
        );

        setState(() {
          isEditable = false; // Lock the fields after update
          obscurePassword = true; // Hide the password again
        });
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء تحديث البيانات')),
      );
      print('Error updating user data: $e');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "settings",
        cardContent: isLoading ? _loadingCard() : _card(),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _loadingCard() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _card() {
    return Card(
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
            // Title and Edit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الإعدادات',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomActionButton(
                  title: isEditable ? "إلغاء التعديل" : "تعديل",
                  titleSize: 16,
                  backgroundColor: const Color(0xFFBA110C),
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable; // Toggle edit mode
                      obscurePassword = !isEditable; // Show password when editable
                    });
                  },
                  isFull: false,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Full Name Field
            CustomInputField(
              label: "الإسم",
              hint: "أدخل الإسم",
              isEditable: isEditable,
              controller: fullNameController,
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            CustomInputField(
              label: "الهاتف",
              hint: "أدخل الهاتف",
              isEditable: isEditable,
              controller: phoneNumberController,
            ),
            const SizedBox(height: 16),

            // National ID Field
            CustomInputField(
              label: "الرقم الوطني",
              hint: "أدخل الرقم الوطني",
              isEditable: isEditable,
              controller: nationalIdController,
            ),
            const SizedBox(height: 16),

            // Communication Method Field
            CustomInputField(
              label: "طريقة التواصل",
              hint: "أدخل طريقة التواصل",
              isEditable: isEditable,
              controller: communicationMethodController,
            ),
            const SizedBox(height: 16),

            // Email Field (Always Read-Only)
            CustomInputField(
              label: "البريد الإلكتروني",
              hint: "أدخل البريد الإلكتروني",
              isEditable: false,
              controller: emailController,
            ),
            const SizedBox(height: 16),

            // Password Field
            CustomInputField(
              label: "كلمة المرور",
              hint: "أدخل كلمة المرور",
              isEditable: isEditable,
              controller: passwordController,
              obscureText: obscurePassword,
            ),
            const SizedBox(height: 20),

            // Submit Button
            CustomActionButton(
              title: isSubmitting ? 'جاري التحديث...' : "تحديث",
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: isEditable && !isSubmitting ? updateUserDetails : null,
            ),
          ],
        ),
      ),
    );
  }
}
