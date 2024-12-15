import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';
import 'add_complaint_form.dart';
import '../widgets/custom_action_button.dart';

class ComplaintFormCat extends StatefulWidget {
  const ComplaintFormCat({Key? key}) : super(key: key);

  @override
  _ComplaintFormCatState createState() => _ComplaintFormCatState();
}

class _ComplaintFormCatState extends State<ComplaintFormCat> {
  String? selectedCategory; // Tracks the selected category

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 80),
                    child: Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: SizedBox(
                        height: 650,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 32, 16, 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'اضافة شكوى مياه',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'الفئة الفرعية',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // First row with two boxes
                                  Wrap(
                                    spacing: 16.0,
                                    runSpacing: 16.0,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      _buildComplaintBox(
                                          'انقطاع المياه', Icons.water_drop),
                                      _buildComplaintBox(
                                          'تلوث المياه', Icons.water_damage),
                                      _buildComplaintBox('تسرب المياه',
                                          Icons.plumbing_outlined),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Second row with one box
                                  const SizedBox(height: 20),
                                ],
                              ),
                              // Bottom button
                              CustomActionButton(
                                title: 'اضافة شكوى',
                                titleSize: 24,
                                backgroundColor: selectedCategory != null
                                    ? const Color(0xFFBA110C)
                                    : Colors.grey,
                                onPressed: selectedCategory != null
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddComplaintForm(
                                              complaintTitle: selectedCategory!,
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            const FooterWidget(currentPage: 'complaint_form_cat'),
      ),
    );
  }

  Widget _buildComplaintBox(String title, IconData icon) {
    final isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 110,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: isSelected ? Colors.blue[50] : Colors.white,
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: Colors.blue,
                  size: 35,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
