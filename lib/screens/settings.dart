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
          Uri.parse('https://complaint.top-wp.com/items/Users/$userId'),
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body)['data'];
          setState(() {
            fullNameController.text = userData['full_name'] ?? '';
            phoneNumberController.text = userData['phone_number'] ?? '';
            nationalIdController.text = userData['national_id_number'] ?? '';
            communicationMethodController.text = userData['communication_method'] ?? '';
            emailController.text = userData['email'] ?? '';
            passwordController.text = userData['password'] ?? '';
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "settings",
        cardContent: isLoading ? _loadingCard() : _settingsContent(),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _loadingCard() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _settingsContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'الإعدادات',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _userInfoSection(),
            const SizedBox(height: 20),
            _extraPagesSection(),
          ],
        ),
      ),
    );
  }

  Widget _userInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background for the form
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomInputField(
              label: "الإسم",
              hint: "أدخل الإسم",
              isEditable: isEditable,
              controller: fullNameController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "الهاتف",
              hint: "أدخل الهاتف",
              isEditable: isEditable,
              controller: phoneNumberController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "الرقم الوطني",
              hint: "أدخل الرقم الوطني",
              isEditable: isEditable,
              controller: nationalIdController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "طريقة التواصل",
              hint: "أدخل طريقة التواصل",
              isEditable: isEditable,
              controller: communicationMethodController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "البريد الإلكتروني",
              hint: "أدخل البريد الإلكتروني",
              isEditable: false,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "كلمة المرور",
              hint: "أدخل كلمة المرور",
              isEditable: isEditable,
              controller: passwordController,
              obscureText: obscurePassword,
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: isEditable ? "حفظ" : "تعديل",
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: () {
                setState(() {
                  isEditable = !isEditable;
                  obscurePassword = !isEditable;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

Widget _extraPagesSection() {
  final sections = [
    {'icon': Icons.language, 'title': "خيارات اللغة"},
    {'icon': Icons.notifications, 'title': "تفضيلات الإشعارات"},
    {'icon': Icons.history, 'title': "تاريخ الشكاوى"},
    {'icon': Icons.rate_review, 'title': "التقييمات والملاحظات"},
    {'icon': Icons.privacy_tip, 'title': "إعدادات الخصوصية"},
    {'icon': Icons.help, 'title': "المساعدة والدعم"},
  ];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white, // White background
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return Card(
            elevation: 0, // Flat card within the white container
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: ListTile(
              leading: Icon(section['icon'] as IconData, color: const Color(0xFFBA110C)),
              title: Text(section['title'] as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                // Handle navigation or action for each item
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${section['title']} تم الضغط على')),
                );
              },
            ),
          );
        },
      ),
    ),
  );
}

}