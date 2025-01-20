import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintRatingPage extends StatefulWidget {
  final int userId; // Logged-in user ID

  const ComplaintRatingPage({super.key, required this.userId});

  @override
  _ComplaintRatingPageState createState() => _ComplaintRatingPageState();
}

class _ComplaintRatingPageState extends State<ComplaintRatingPage> {
  List<Map<String, dynamic>> complaints = [];
  String? selectedComplaintId;
  String? selectedComplaintTitle;
  int selectedStars = 0;
  TextEditingController commentController = TextEditingController();
  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchUserComplaints();
  }

  // Fetch complaints for the logged-in user
  Future<void> fetchUserComplaints() async {
    try {
      final response = await http.get(
        Uri.parse('https://complaint.top-wp.com//items/Complaint?filter[user][_eq]=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          complaints = data
              .map<Map<String, dynamic>>((complaint) => {
                    'id': complaint['id'].toString(),
                    'title': complaint['title'] ?? 'No Title',
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch complaints');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching complaints: $e");
    }
  }

  // Submit the rating and comment to the API
  Future<void> submitRating() async {
    if (selectedComplaintId == null || selectedStars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار شكوى وتحديد تقييم.'),
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://complaint.top-wp.com/items/Complaint_ratings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Complaint': int.parse(selectedComplaintId!),
          'rating_value': selectedStars.toString(),
          'comment': commentController.text.trim(),
          'user': widget.userId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال التقييم بنجاح.'),
          ),
        );

        setState(() {
          selectedComplaintId = null;
          selectedComplaintTitle = null;
          selectedStars = 0;
          commentController.clear();
        });
      } else {
        throw Exception('Failed to submit rating');
      }
    } catch (e) {
      print("Error submitting rating: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء إرسال التقييم.'),
        ),
      );
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
        currentPage: "rate_service",
        cardContent: _card(context),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _card(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Title
              const Center(
                child: Text(
                  'قيم نوع مستوى الخدمة',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown to select a complaint
              const Text(
                'أعطي تقييم للشكاوي',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedComplaintId,
                items: complaints.map((complaint) {
                  return DropdownMenuItem<String>(
                    value: complaint['id'],
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        complaint['title'],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedComplaintId = value;
                    selectedComplaintTitle = complaints
                        .firstWhere((complaint) => complaint['id'] == value)['title'];
                    selectedStars = 0; // Reset rating
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'قائمة الشكاوى',
                ),
              ),
              const SizedBox(height: 20),

              // Display selected complaint
              if (selectedComplaintTitle != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xC6FC4B4B),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    selectedComplaintTitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Rating stars
              if (selectedComplaintTitle != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          selectedStars = index + 1;
                        });
                      },
                      icon: Icon(
                        index < selectedStars ? Icons.star : Icons.star_border,
                        color: const Color(0xFFFFCD03),
                        size: 40,
                      ),
                    );
                  }),
                ),
              const SizedBox(height: 20),

              // Comment input
              const Text(
                'تعليق',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: commentController,
                maxLines: 4,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'اكتب تعليقك هنا...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit button
              CustomActionButton(
                title: "إضافة تعليق",
                titleSize: 16,
                backgroundColor: const Color(0xFFBA110C),
                onPressed: selectedComplaintId != null && selectedStars > 0 && !isSubmitting
                    ? submitRating
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
