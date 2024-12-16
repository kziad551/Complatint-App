import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';

class ComplaintRatingPage extends StatefulWidget {
  const ComplaintRatingPage({Key? key}) : super(key: key);

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
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBA110C),
          title: const Text('قيم نوع مستوى الخدمة'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Small Title
                      const Text(
                        'اعطي تقييم للشكاوي',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // Custom Dropdown with List
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: activeComplaint,
                            hint: const Text(
                              'قائمة الشكاوى',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            dropdownColor: Colors.white, // White background for dropdown list
                            alignment: Alignment.centerRight, // Align dropdown text to right
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
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                activeComplaint = value;
                                selectedStars = 0;
                                isRatingEnabled = false;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Rating Section
                      if (activeComplaint != null)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFB8282),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                activeComplaint!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Star Rating Section
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedStars = index + 1;
                                        isRatingEnabled = true;
                                      });
                                    },
                                    icon: Icon(
                                      index < selectedStars
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 32,
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: commentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'ادخل الفئة',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isRatingEnabled
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم إرسال التقييم بنجاح'),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFBA110C),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'اضافة تعليق',
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
        bottomNavigationBar: const FooterWidget(currentPage: 'rate_service'),
      ),
    );
  }
}
