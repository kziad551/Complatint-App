import 'package:complaint_application/widgets/custom_complaint_box.dart';
import 'package:flutter/material.dart';
import 'add_complaint_form.dart';
// import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintFormCat extends StatefulWidget {
  final String complaintType;

  const ComplaintFormCat({super.key, required this.complaintType});

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
        cardContent: _card(context, widget.complaintType),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _card(BuildContext context, String complaintType) {
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
                Center(
                  child: Text(
                    'إضافة $complaintType',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // const Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     'الفئة الفرعية',
                //     style: TextStyle(
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    alignment: WrapAlignment.start,
                    children: [
                      CustomComplaintBox(
                        title: 'انقطاع المياه',
                        icon: Icons.water_drop,
                        iconColor: Colors.blue,
                        isSelected: selectedCategory == 'انقطاع المياه',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'انقطاع المياه';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddComplaintForm(
                                complaintTitle: selectedCategory as String,
                              ),
                            ),
                          );
                        },
                      ),
                      CustomComplaintBox(
                        title: 'تلوث المياه',
                        icon: Icons.water_damage,
                        iconColor: Colors.amber,
                        isSelected: selectedCategory == 'تلوث المياه',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'تلوث المياه';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddComplaintForm(
                                complaintTitle: selectedCategory as String,
                              ),
                            ),
                          );
                        },
                      ),
                      CustomComplaintBox(
                        title: 'تسرب المياه',
                        icon: Icons.plumbing_outlined,
                        iconColor: Colors.green,
                        isSelected: selectedCategory == 'تسرب المياه',
                        onTap: () {
                          setState(() {
                            selectedCategory = 'تسرب المياه';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddComplaintForm(
                                complaintTitle: selectedCategory as String,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
                // const SizedBox(height: 40),
              ],
            ),
            // Bottom button
            // CustomActionButton(
            //   title: 'إضافة شكوى',
            //   titleSize: 16,
            //   backgroundColor: selectedCategory != null
            //       ? const Color(0xFFBA110C)
            //       : Colors.grey,
            //   onPressed: selectedCategory != null
            //       ? () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => AddComplaintForm(
            //                 complaintTitle: selectedCategory!,
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
}
