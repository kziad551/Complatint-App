import 'package:complaint_application/widgets/custom_complaint_box.dart';
import 'package:flutter/material.dart';
import 'complaint_form_cat.dart';
// import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  String? selectedComplaint;
  String selectedCategory = 'خدمة عامة'; // Default category

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "complaint_form",
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
                    'إضافة شكوى',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryButton(
                      context,
                      title: 'خدمة عامة',
                      isSelected: selectedCategory == 'خدمة عامة',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'خدمة عامة';
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildCategoryButton(
                      context,
                      title: 'مستفيد من الخدمة',
                      isSelected: selectedCategory == 'مستفيد من الخدمة',
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'مستفيد من الخدمة';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'الفئة',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Selectable main box
                CustomComplaintBox(
                  title: 'شكوى المياه',
                  icon: Icons.water,
                  iconColor: Colors.blue,
                  isSelected: selectedComplaint == 'شكوى المياه',
                  onTap: () {
                    setState(() {
                      selectedComplaint = 'شكوى المياه';
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComplaintFormCat(
                          complaintType: selectedComplaint as String,
                        ),
                      ),
                    );
                  },
                ),
                // const SizedBox(height: 40),
              ],
            ),
            // Bottom button
            // CustomActionButton(
            //   title: 'إضافة شكوى',
            //   titleSize: 16,
            //   backgroundColor: selectedComplaint != null
            //       ? const Color(0xFFBA110C)
            //       : Colors.grey,
            //   onPressed: selectedComplaint != null
            //       ? () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => ComplaintFormCat(
            //                 complaintType: selectedComplaint,
            //               ),
            //             ),
            //           );
            //         }
            //       : null,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context,
      {required String title,
      required bool isSelected,
      required VoidCallback onPressed}) {
    return SizedBox(
      // width: isFull ? double.infinity : 2 * MediaQuery.of(context).size.width / 5,
      width: (MediaQuery.of(context).size.width / 2) - 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? const Color(0xFFBA110C) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
