import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custom_layout_page.dart';
import '../widgets/custom_action_button.dart';
import 'home_page.dart';

class AddComplaintForm extends StatefulWidget {
  final String subCategory;
  final String complaintType;
  final String selectedCategory;
  final String serviceType;
  final String title;

  const AddComplaintForm({
    Key? key,
    required this.subCategory,
    required this.complaintType,
    required this.selectedCategory,
    required this.serviceType,
    required this.title,
  }) : super(key: key);

  @override
  _AddComplaintFormState createState() => _AddComplaintFormState();
}

class _AddComplaintFormState extends State<AddComplaintForm> {
  String? selectedGovernorate;
  String? selectedDistrict;
  String? description;
  String? streetNameOrNumber;
  XFile? imageFile;
  XFile? videoFile;
  File? voiceFile;
  int? userId;

  final ImagePicker _picker = ImagePicker();

  final Map<String, List<String>> governorateDistricts = {
    'بغداد': ['الرصافة', 'الكرخ', 'مدينة الصدر', 'الشعلة'],
    'البصرة': ['الزبير', 'القرنة', 'الفاو', 'أم قصر', 'شط العرب'],
    // Add more governorates and districts as needed
  };

  final List<String> iraqiGovernorates = [
    'بغداد',
    'نينوى',
    'البصرة',
    'الأنبار',
    'السليمانية',
    'أربيل',
    'دهوك',
    'ديالى',
    'كربلاء',
    'النجف',
    'بابل',
    'واسط',
    'ذي قار',
    'ميسان',
    'القادسية',
    'صلاح الدين',
    'كركوك',
    'المثنى',
  ];

  final List<String> complaintOptions = [
    'تسرب المياه',
    'عدم وجود مياه',
    'ضعف ضغط المياه',
    'مشاكل في الفواتير',
    'أخرى',
  ];

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

  Future<String?> uploadMediaToDirectus(File file) async {
    const apiUrl = 'https://complaint.top-wp.com/files';
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers['Authorization'] = 'Bearer b5vPGIUKQ6KmC7KF_epByziEO0szRfQ9'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    try {
      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);
        return jsonResponse['data']['id'];
      } else {
        print('File upload failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> pickMedia(String type) async {
    XFile? pickedFile;
    if (type == 'image') {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = pickedFile;
      });
    } else if (type == 'video') {
      pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      setState(() {
        videoFile = pickedFile;
      });
    }
  }

  Future<void> pickVoiceFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      setState(() {
        voiceFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> handleSubmit() async {
    String? imageFileId, videoFileId, voiceFileId;

    if (imageFile != null) {
      imageFileId = await uploadMediaToDirectus(File(imageFile!.path));
    }
    if (videoFile != null) {
      videoFileId = await uploadMediaToDirectus(File(videoFile!.path));
    }
    if (voiceFile != null) {
      voiceFileId = await uploadMediaToDirectus(voiceFile!);
    }

    final complaintData = {
      'sub_category': int.parse(widget.subCategory),
      'complaint_type': widget.complaintType,
      'selected_category': widget.selectedCategory,
      'Service_type': widget.serviceType,
      'title': widget.title,
      'description': description ?? '',
      'user': userId,
      'governorate_name': selectedGovernorate ?? '',
      'district_name': selectedDistrict ?? '',
      'street_name_or_number': streetNameOrNumber ?? '',
      'image': imageFileId,
      'video': videoFileId,
      'voice': voiceFileId,
    };

    const apiUrl = 'https://complaint.top-wp.com/items/Complaint';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(complaintData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تقديم الشكوى بنجاح')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ أثناء تقديم الشكوى')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "add_complaint_form",
        cardContent: _card(context),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _card(BuildContext context) {
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
                'تقديم شكوى عن ${widget.title}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'نوع الشكوى',
                border: OutlineInputBorder(),
              ),
              items: complaintOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  description = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
Row(
  children: [
    Expanded(
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'إسم المحافظة',
          border: OutlineInputBorder(),
        ),
        value: selectedGovernorate,
        items: iraqiGovernorates.map((String governorate) {
          return DropdownMenuItem<String>(
            value: governorate,
            child: Text(governorate),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGovernorate = newValue;
            selectedDistrict = null; // Reset district when governorate changes
          });
        },
      ),
    ),
    const SizedBox(width: 20),
    Expanded(
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'إسم القضاء',
          border: OutlineInputBorder(),
        ),
        value: selectedDistrict,
        items: selectedGovernorate != null
            ? (governorateDistricts[selectedGovernorate!] ?? [])
                .map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList()
            : [],
        onChanged: (String? newValue) {
          setState(() {
            selectedDistrict = newValue;
          });
        },
        // Display a placeholder if no governorate is selected
        hint: selectedGovernorate == null
            ? const Text('اختر المحافظة')
            : null,
      ),
    ),
  ],
),

            const SizedBox(height: 16),
            const Text(
              'اسم او رقم الشارع',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'إسم او رقم الشارع',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                streetNameOrNumber = value;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'اضف صورة / فيديو / تسجيل صوتي',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMediaBox(context, Icons.image, 'صورة', () => pickMedia('image'), imageFile),
                _buildMediaBox(context, Icons.videocam, 'فيديو', () => pickMedia('video'), videoFile),
                _buildMediaBox(context, Icons.mic, 'صوت', pickVoiceFile, voiceFile),
              ],
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: 'إضافة شكوى',
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaBox(BuildContext context, IconData icon, String label, VoidCallback onTap, dynamic file) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: file != null ? Colors.transparent : Colors.white,
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: Colors.grey, size: 40),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
