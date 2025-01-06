import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'complaint_form_cat.dart';
import '../widgets/custom_complaint_box.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  String? selectedComplaint;
  String selectedCategory = 'خدمة عامة'; // Default category
  List<Map<String, dynamic>> categories = []; // Store fetched categories

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    const apiUrl = 'http://157.230.87.143:8055/items/Complaint_main_category';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          categories = List<Map<String, dynamic>>.from(data['data']);
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

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
            const Text(
              'الفئة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 3 / 2.5,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CustomComplaintBox(
                        title: category['name'] ?? 'No Name', // Display title
                        icon: _mapStringToIcon(category['icon']),
                        iconColor: Colors.blue,
                        isSelected: selectedComplaint == category['name'],
                        onTap: () {
                          setState(() {
                            selectedComplaint = category['name'];
                          });
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ComplaintFormCat(
      complaintType: category['name'] ?? '', // Pass the complaint type
      selectedCategory: selectedCategory, // Pass the selected category
      serviceType: selectedCategory, // Pass the serviceType
      selectedTitle: category['name'] ?? 'No Name', // Pass the selected title
    ),
  ),
);

                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  IconData _mapStringToIcon(String? iconName) {
    final Map<String, IconData> iconsMap = {
      'Icons.water': Icons.water,
      'Icons.category': Icons.category,
      'Icons.home': Icons.home,
      'Icons.plumbing_outlined': Icons.plumbing_outlined,
      'Icons.star': Icons.star,
      'Icons.water_damage': Icons.water_damage,
    };
    return iconsMap[iconName] ?? Icons.help;
  }

  Widget _buildCategoryButton(BuildContext context,
      {required String title, required bool isSelected, required VoidCallback onPressed}) {
    return SizedBox(
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
