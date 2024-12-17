import 'package:complaint_application/widgets/custom_action_button.dart';
import 'package:complaint_application/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_layout_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEditable = false; // Track if the fields are editable

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "settings",
        cardContent: _card(),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
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
                const SizedBox(height: 20),
                CustomActionButton(
                  title: isEditable ? "إلغاء التعديل" : "تعديل",
                  titleSize: 16,
                  backgroundColor: const Color(0xFFBA110C),
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable; // Toggle edit state
                    });
                  },
                  isFull: false,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Form Inputs
            CustomInputField(
              label: "الإسم",
              hint: "أدخل الإسم",
              isEditable: isEditable,
              initialValue: 'أحمد',
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "الهاتف",
              hint: "أدخل الهاتف",
              isEditable: isEditable,
              initialValue: '+٩٦١٧٠٧٨٩٦٥٤',
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: "البريد الإلكتروني",
              hint: "أدخل البريد الإلكتروني",
              isEditable: false, // Always read-only
              initialValue: 'example@gmail.com',
            ),
            const SizedBox(height: 16),
            CustomInputField(
              label: "كلمة المرور",
              hint: "أدخل كلمة المرور",
              isEditable: isEditable,
              initialValue: 'example@123',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Submit Button
            CustomActionButton(
              title: "إدخال",
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: () {
                // Handle form submission
              },
            ),
          ],
        ),
      ),
    );
  }
}
