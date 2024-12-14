import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';

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
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: const Text('الإعدادات'),
          centerTitle: true,
        ),
        body: SafeArea(
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
                    // Title Row with "تعديل" Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الإعدادات',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditable = !isEditable; // Toggle edit state
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBA110C),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0), // Increased size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'تعديل',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Form Inputs
                    _buildInputField('الاسم', 'احمد', isEditable),
                    const SizedBox(height: 10),
                    _buildInputField('الهاتف', '+٩٦١٧٠٧٨٩٦٥٤', isEditable),
                    const SizedBox(height: 10),
                    _buildInputField('البريد الإلكتروني', 'example@gmail.com',
                        false), // Always read-only
                    const SizedBox(height: 10),
                    _buildInputField(
                        'كلمة المرور', '••••••••', isEditable, isPassword: true),
                    const SizedBox(height: 20),
                    // Submit Button
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7, // Double width
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle form submission
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBA110C),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'ادخال',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
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
        bottomNavigationBar: const FooterWidget(currentPage: 'settings'),
      ),
    );
  }

  Widget _buildInputField(String label, String value, bool editable,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value, // Pre-fill input with the value
          enabled: editable, // Enable editing based on the `editable` flag
          obscureText: isPassword, // If it's a password field, obscure text
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: editable ? Colors.white : Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
