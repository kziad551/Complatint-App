import 'package:flutter/material.dart';
import 'complaint_list.dart'; // Import the ComplaintList page
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_layout_page.dart';

class AddComplaintForm extends StatelessWidget {
  final String complaintTitle;

  const AddComplaintForm({super.key, required this.complaintTitle});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "add_complaint_form",
        cardContent: _card(complaintTitle, context),
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
            const Center(
              child: Text(
                'تسجيل شكوى عن تلوث المياه',
                style: TextStyle(
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
                    label: 'اسم المدينة',
                    hint: '',
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomInputField(
                    label: 'اسم المدينة',
                    hint: '',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // One input in one row
            const CustomInputField(
              label: 'اسم او رقم الشارع',
              hint: '',
            ),
            const SizedBox(height: 16),
            // Three boxes with icons
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اضف صورة / فيديو / تسجيل صوتي',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconBox(context, Icons.image, 'صورة', () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم اختيار الصورة: ${image.name}'),
                      ),
                    );
                  }
                }),
                _buildIconBox(context, Icons.videocam, 'فيديو', () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? video =
                      await picker.pickVideo(source: ImageSource.gallery);
                  if (video != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم اختيار الفيديو: ${video.name}'),
                      ),
                    );
                  }
                }),
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
              title: 'اضافة شكوى',
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
}
