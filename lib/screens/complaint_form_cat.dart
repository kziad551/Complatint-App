import 'package:flutter/material.dart';
import 'add_complaint_form.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintFormCat extends StatefulWidget {
  const ComplaintFormCat({super.key});

  @override
  _ComplaintFormCatState createState() => _ComplaintFormCatState();
}

class _ComplaintFormCatState extends State<ComplaintFormCat> {
  String? selectedCategory; // Tracks the selected category

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "complaint_form_cat",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'إضافة شكوى مياه',
                    style: TextStyle(
                      fontSize: 28,
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
                      fontSize: 18,
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
                    _buildComplaintBox('انقطاع المياه', Icons.water_drop),
                    _buildComplaintBox('تلوث المياه', Icons.water_damage),
                    _buildComplaintBox('تسرب المياه', Icons.plumbing_outlined),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
            // Bottom button
            CustomActionButton(
              title: 'إضافة شكوى',
              titleSize: 16,
              backgroundColor: selectedCategory != null
                  ? const Color(0xFFBA110C)
                  : Colors.grey,
              onPressed: selectedCategory != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddComplaintForm(
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
            width: 140,
            height: 100,
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
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
