import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
  XFile? audioFile;
  int? userId;

  final Map<String, List<String>> governorateDistricts = {
    'بغداد': ['الرصافة', 'الكرخ', 'مدينة الصدر', 'الشعلة'],
    'البصرة': ['الزبير', 'القرنة', 'الفاو', 'أم قصر', 'شط العرب'],
    'نينوى': ['الموصل', 'تلعفر', 'سنجار', 'بعشيقة', 'الحمدانية'],
    'الأنبار': ['الرمادي', 'الفلوجة', 'القائم', 'هيت', 'حديثة', 'الرطبة'],
    'بابل': ['الحلة', 'المسيب', 'المحاويل', 'المدحتية'],
    'ذي قار': ['الناصرية', 'سوق الشيوخ', 'الرفاعي', 'الشطرة', 'الجبايش'],
    'ديالى': ['بعقوبة', 'المقدادية', 'الخالص', 'بلدروز', 'خانقين', 'المنصورية'],
    'دهوك': ['دهوك', 'زاخو', 'سيميل', 'عقرة'],
    'أربيل': ['أربيل', 'شقلاوة', 'كويسنجق', 'حرير'],
    'كركوك': ['كركوك', 'الدبس', 'الحويجة', 'الرياض', 'التون كوبري'],
    'السليمانية': ['السليمانية', 'جمجمال', 'رانية', 'دوكان', 'كلار'],
    'صلاح الدين': ['تكريت', 'سامراء', 'بيجي', 'بلد', 'الشرقاط', 'الضلوعية'],
    'القادسية': ['الديوانية', 'الشامية', 'عفك', 'البدير'],
    'واسط': ['الكوت', 'النعمانية', 'الصويرة', 'العزيزية'],
    'المثنى': ['السماوة', 'الرميثة', 'الخضر', 'الوركاء'],
    'ميسان': ['العمارة', 'المجر الكبير', 'الكحلاء', 'علي الغربي'],
    'كربلاء': ['كربلاء', 'عين التمر', 'الحر'],
    'النجف': ['النجف', 'الكوفة', 'المناذرة', 'أبو صخير'],
  };

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

  Future<void> pickMedia(String type) async {
    final ImagePicker picker = ImagePicker();
    try {
      if (type == 'image') {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            imageFile = pickedFile;
          });
        }
      } else if (type == 'video') {
        final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            videoFile = pickedFile;
          });
        }
      } else if (type == 'audio') {
        print("Audio picker not implemented.");
      }
    } catch (e) {
      print('Error picking media: $e');
    }
  }

  Future<void> handleSubmit() async {
    final complaintData = {
      'sub_category': int.parse(widget.subCategory),
      'complaint_type': widget.complaintType,
      'selected_category': widget.selectedCategory,
      'service_type': widget.serviceType,
      'title': widget.title,
      'description': description ?? '',
      'user': userId,
      'governorate_name': selectedGovernorate ?? '',
      'district_name': selectedDistrict ?? '',
      'street_name_or_number': streetNameOrNumber ?? '',
      'image': imageFile?.path,
      'video': videoFile?.path,
      'voice': audioFile?.path,
    };

    const apiUrl = 'http://157.230.87.143:8055/items/Complaint';
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
                'تسجيل شكوى عن ${widget.title}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'ما هي شكواك',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                description = value;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownField(
                    label: 'إسم المحافظة',
                    hint: '',
                    items: governorateDistricts.keys.toList(),
                    selectedItem: selectedGovernorate,
                    onChanged: (value) {
                      setState(() {
                        selectedGovernorate = value;
                        selectedDistrict = null;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomDropdownField(
                    label: 'إسم القضاء',
                    hint: '',
                    items: selectedGovernorate != null
                        ? governorateDistricts[selectedGovernorate] ?? []
                        : [],
                    selectedItem: selectedDistrict,
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMediaBox(context, Icons.image, 'صورة', () => pickMedia('image')),
                _buildMediaBox(context, Icons.videocam, 'فيديو', () => pickMedia('video')),
                _buildMediaBox(context, Icons.mic, 'مذكرة صوتية', () => pickMedia('audio')),
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

  Widget _buildMediaBox(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
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
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
