import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';
import 'complaint_form_cat.dart';
import '../widgets/custom_action_button.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  bool isSelected = false; // Track if the box is selected

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
                                      'اضافة شكوى',
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
                                      'الفئة',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Selectable main box
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected =
                                            !isSelected; // Toggle selection
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: isSelected
                                                ? Colors.blue[50]
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 80,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
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
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                              // Bottom button
                              CustomActionButton(
                                title: 'اضافة شكوى',
                                titleSize: 24,
                                backgroundColor: isSelected
                                    ? const Color(0xFFBA110C)
                                    : Colors.grey,
                                onPressed: isSelected
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ComplaintFormCat(),
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
        bottomNavigationBar: const FooterWidget(currentPage: 'complaint_form'),
      ),
    );
  }
}
