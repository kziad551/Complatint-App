import 'package:flutter/material.dart';
import 'complaint_list.dart'; // Import the ComplaintList page
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_layout_page.dart';

class AddComplaintForm extends StatefulWidget {
  final String complaintTitle;

  const AddComplaintForm({super.key, required this.complaintTitle});

  @override
  _AddComplaintFormState createState() => _AddComplaintFormState();
}

class _AddComplaintFormState extends State<AddComplaintForm> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "add_complaint_form",
        cardContent: _card(widget.complaintTitle, context),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _card(String complaintTitle, BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'تسجيل شكوى عن $complaintTitle',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomInputField(
              label: 'عنوان الشكوى',
              hint: '',
              isEditable: false,
              initialValue: complaintTitle,
            ),
            const SizedBox(height: 16),
            const CustomInputField(
              label: 'ما هي شكواك',
              hint: '',
            ),
            const SizedBox(height: 16),
            // Two inputs in one row
            const Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    label: 'إسم المحافظة',
                    hint: '',
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomInputField(
                    label: 'إسم القضاء',
                    hint: '',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // One input in one row
            const CustomInputField(
              label: 'إسم او رقم الشارع',
              hint: '',
            ),
            const SizedBox(height: 16),
            // Three boxes with icons
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'أضف صورة / فيديو / تسجيل صوتي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Photo Box
                _buildIconBox(context, Icons.image, 'صورة', () async {
                  final ImagePicker picker = ImagePicker();
                  // Show options to the user
                  final ImageSource? source =
                      await _showSourceSelectionDialog(context);
                  if (source != null) {
                    final XFile? image = await picker.pickImage(source: source);
                    if (image != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم اختيار الصورة: ${image.name}'),
                        ),
                      );
                    }
                  }
                }),
                // Video Box
                _buildIconBox(context, Icons.videocam, 'فيديو', () async {
                  final ImagePicker picker = ImagePicker();
                  // Show options to the user
                  final ImageSource? source =
                      await _showSourceSelectionDialog(context);
                  if (source != null) {
                    final XFile? video = await picker.pickVideo(source: source);
                    if (video != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم اختيار الفيديو: ${video.name}'),
                        ),
                      );
                    }
                  }
                }),
                // Voice Memo Box
                _buildIconBox(context, Icons.mic, 'مذكرة صوتية', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم فتح تسجيل المذكرة الصوتية'),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            // Bottom button
            CustomActionButton(
              title: 'إضافة شكوى',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: () {
                // Navigate to ComplaintList
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComplaintList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Future<ImageSource?> _showSourceSelectionDialog(BuildContext context) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر المصدر'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('الكاميرا'),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('المعرض'),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
