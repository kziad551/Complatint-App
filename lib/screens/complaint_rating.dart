import 'package:complaint_application/widgets/custom_action_button.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintRatingPage extends StatefulWidget {
  const ComplaintRatingPage({super.key});

  @override
  _ComplaintRatingPageState createState() => _ComplaintRatingPageState();
}

class _ComplaintRatingPageState extends State<ComplaintRatingPage> {
  String? activeComplaint; // Currently selected complaint
  int selectedStars = 0; // Star rating tracker
  bool isRatingEnabled = false; // Enable/disable button
  TextEditingController commentController = TextEditingController();

  // List of complaints
  final List<String> complaints = [
    'شكوة ١ - انقطاع المياه',
    'شكوة ٢ - تلوث المياه',
    'شكوة ٣ - تسرب المياه',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "rate_service",
        cardContent: _card(
          context,
          activeComplaint,
          complaints,
          (value) {
            setState(() {
              activeComplaint = value;
              selectedStars = 0;
              isRatingEnabled = false;
            });
          },
          (int index) {
            setState(() {
              selectedStars = index + 1;
              isRatingEnabled = true;
            });
          },
          selectedStars,
          commentController,
          isRatingEnabled,
        ),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }
}

Widget _card(
    BuildContext context,
    String? activeComplaint,
    List<String> complaints,
    dynamic onChanged,
    dynamic onPressed,
    int selectedStars,
    TextEditingController commentController,
    bool isRatingEnabled) {
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

            // Small Title
            const Text(
              'أعطي تقييم للشكاوي',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Custom Dropdown with List
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  borderRadius: BorderRadius.circular(8.0),
                  style: const TextStyle(fontSize: 16),
                  isExpanded: true,
                  value: activeComplaint,
                  hint: const Text(
                    'قائمة الشكاوى',
                    style: TextStyle(color: Colors.grey),
                  ),
                  dropdownColor: Colors.white,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  ),
                  items: complaints.map((String complaint) {
                    return DropdownMenuItem<String>(
                      value: complaint,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          complaint,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Rating Section
            if (activeComplaint != null)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xC6FC4B4B),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      activeComplaint,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Star Rating Section
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            onPressed(index);
                          },
                          icon: Icon(
                            index < selectedStars
                                ? Icons.star
                                : Icons.star_border,
                            color: const Color(0xFFFFCD03),
                            size: 40,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // Comment Section
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
                hintText: 'أدخل الفئة',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: "إضافة تعليق",
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: isRatingEnabled
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إرسال التقييم بنجاح'),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}
