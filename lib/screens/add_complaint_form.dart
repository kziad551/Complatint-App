import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddComplaintForm extends StatelessWidget {
  final String complaintTitle;

  const AddComplaintForm({Key? key, required this.complaintTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: const Text('تسجيل شكوى عن تلوث المياه'),
          centerTitle: true,
        ),
        body: SafeArea(
<<<<<<< Updated upstream
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
                    const Text(
                      'اضافة شكوى مياه',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // First row with two boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildComplaintBox(
                            'انقطاع المياه', Icons.water_drop),
                        _buildComplaintBox(
                            'تلوث المياه', Icons.water_damage),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Second row with one box
                    _buildComplaintBox(
                        'تسرب المياه', Icons.plumbing_outlined),
                    const SizedBox(height: 20),
                    // Bottom button inside the white background
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedCategory != null
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'تم إضافة الشكوى: $selectedCategory',
                                    ),
                                  ),
                                );
                              }
                            : null, // Disable button if no selection
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCategory != null
                              ? const Color(0xFFBA110C)
                              : Colors.grey, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
=======
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تسجيل شكوى عن تلوث المياه',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
>>>>>>> Stashed changes
                        ),
                      ),
                      const SizedBox(height: 20),
                      // عنوان الشكوى Input
                      _buildInputField('عنوان الشكوى', complaintTitle,
                          isEditable: false),
                      const SizedBox(height: 16),
                      // ما هي شكواك Textarea
                      _buildInputField('ما هي شكواك', ''),
                      const SizedBox(height: 16),
                      // Two inputs in one row
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField('اسم المدينة', ''),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildInputField('اسم او رقم المنطقة', ''),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // One input in one row
                      _buildInputField('اسم او رقم الشارع', ''),
                      const SizedBox(height: 16),
                      // Three boxes with icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconBox(context, Icons.image, 'صورة', () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
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
                            final XFile? video = await picker.pickVideo(
                                source: ImageSource.gallery);
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Submit complaint action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم إرسال الشكوى بنجاح!'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'اضافة شكوى',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint,
      {bool isEditable = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: hint,
          enabled: isEditable,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
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
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 40,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
