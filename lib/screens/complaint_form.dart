import 'package:flutter/material.dart';
import 'complaint_form_cat.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  bool isSelected = false; // Track if the box is selected

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "complaint_form",
        cardContent: _card(
          () {
            setState(() {
              isSelected = !isSelected; // Toggle selection
            });
          },
          isSelected,
          context,
        ),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }
}

Widget _card(VoidCallback onTap, bool isSelected, BuildContext context) {
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
              GestureDetector(
                onTap: onTap,
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
                    const Text(
                      'شكوى المياه',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
          // Bottom button
          CustomActionButton(
            title: 'إضافة شكوى',
            titleSize: 16,
            backgroundColor: isSelected ? const Color(0xFFBA110C) : Colors.grey,
            onPressed: isSelected
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComplaintFormCat(),
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
