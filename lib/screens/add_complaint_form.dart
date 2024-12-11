import 'package:flutter/material.dart';

class AddComplaintForm extends StatefulWidget {
  const AddComplaintForm({Key? key}) : super(key: key);

  @override
  _AddComplaintFormState createState() => _AddComplaintFormState();
}

class _AddComplaintFormState extends State<AddComplaintForm> {
  String? selectedCategory; // Tracks the selected category

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: const Text('اضافة شكوى مياه'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'اضافة شكوى مياه',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // First row with two boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildComplaintBox(
                            'انقطاع المياه', Icons.water_drop),
                        _buildComplaintBox(
                            'تلوث المياه', Icons.water_damage),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Second row with one box
                    _buildComplaintBox(
                        'تسرب المياه', Icons.plumbing_outlined),
                    const SizedBox(height: 20),
                    // Bottom button inside the white background
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedCategory != null
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'تم إضافة الشكوى: $selectedCategory',
                                    ),
                                  ),
                                );
                              }
                            : null, // Disable button if no selection
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCategory != null
                              ? Colors.red
                              : Colors.grey, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'اضافة شكوى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
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
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
              color: isSelected ? Colors.blue[50] : Colors.white,
            ),
            child: Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
