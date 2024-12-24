// import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
import 'package:complaint_application/widgets/custom_dropdown_field.dart';
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

class _AddComplaintFormState extends State<AddComplaintForm>
    with WidgetsBindingObserver {
  String? selectedGovernorate; // Selected governorate
  String? selectedDistrict; // Selected district

  // Iraq's governorates and their districts
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
    // Fetch user's location and set the governorate
    fetchUserLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
    if (kDebugMode) {
      print("disposed");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (kDebugMode) {
      print("state: $state");
    }
    if (state == AppLifecycleState.resumed) {
      // Re-check location services when app is resumed
      fetchUserLocation();
    }
  }

  void fetchUserLocation() async {
    // Simulate fetching the user's location (replace with actual location fetching logic)
    String userGovernorate = 'بغداد'; // Example: fetched governorate
    setState(() {
      selectedGovernorate = userGovernorate;
    });
  }
  // Fetch user location and extract the governorate
  // Future<void> fetchUserLocation() async {
  //   try {
  //     // Check location service and permissions
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       if (mounted) {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: const Text('Location Services Disabled'),
  //               content: const Text(
  //                   'Location services are disabled. Please enable them to proceed.'),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const Text('Cancel'),
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     Geolocator.openLocationSettings();
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const Text('Open Settings'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //       return; // Exit the function to prevent further processing
  //     }

  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         throw Exception('Location permission denied.');
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       throw Exception('Location permissions are permanently denied.');
  //     }

  //     const String apiKey = 'AIzaSyANwACdCLadd5KmXYeKKU2ERoJtbl0EfkE';
  //     if (apiKey.isEmpty) {
  //       throw Exception('Google API key is not set in the .env file.');
  //     }

  //     // Fetch the current position
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     // Reverse geocode to get governorate
  //     final response = await http.get(
  //       Uri.parse(
  //           'https://maps.googleapis.com/maps/api/geocode/json?language=ar&latlng=${position.latitude},${position.longitude}&key=$apiKey'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);

  //       // Parse results to find the governorate
  //       String? userGovernorate;
  //       final results = data['results'] as List<dynamic>;
  //       for (var result in results) {
  //         if (result['types'] != null &&
  //             result['types'].contains('administrative_area_level_1')) {
  //           userGovernorate = result['address_components'][0]['long_name'];
  //           break;
  //         }
  //       }

  //       // Fallback to default if no governorate is found
  //       if (userGovernorate == null || userGovernorate.isEmpty) {
  //         userGovernorate = 'بغداد';
  //       }

  //       setState(() {
  //         selectedGovernorate = userGovernorate;
  //       });
  //     } else {
  //       throw Exception('Failed to fetch geolocation data.');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print('Error fetching location: $e');
  //     setState(() {
  //       selectedGovernorate = 'بغداد'; // Default fallback
  //     });
  //   }
  // }

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
                        selectedDistrict =
                            null; // Reset district when governorate changes
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
                        ? governorateDistricts[selectedGovernorate]!
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
            // const Row(
            //   children: [
            //     Expanded(
            //       child: CustomInputField(
            //         label: 'إسم المحافظة',
            //         hint: '',
            //       ),
            //     ),
            //     SizedBox(width: 20),
            //     Expanded(
            //       child: CustomInputField(
            //         label: 'إسم القضاء',
            //         hint: '',
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),
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
