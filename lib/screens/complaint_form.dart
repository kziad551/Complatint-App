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
  String selectedCategory = 'الخدمات العامة'; // Updated default category
  List<Map<String, dynamic>> categories = []; // Store fetched categories

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    const apiUrl = 'https://complaint.top-wp.com/items/Complaint_main_category';
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
                  title: 'الخدمات العامة',
                  isSelected: selectedCategory == 'الخدمات العامة',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'الخدمات العامة';
                    });
                  },
                ),
                _buildCategoryButton(
                  context,
                  title: 'خدمات فردية',
                  isSelected: selectedCategory == 'خدمات فردية',
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'خدمات فردية';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                        title: category['name'] ?? 'No Name',
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
                                complaintType: selectedComplaint ?? '',
                                selectedCategory: selectedCategory,
                                serviceType: selectedCategory, // Pass to the next page
                                selectedTitle: selectedComplaint ?? '',
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
