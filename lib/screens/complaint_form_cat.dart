import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add_complaint_form.dart';
import '../widgets/custom_complaint_box.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintFormCat extends StatefulWidget {
  final String complaintType;
  final String selectedCategory;
  final String serviceType;
  final String selectedTitle;

  const ComplaintFormCat({
    Key? key,
    required this.complaintType,
    required this.selectedCategory,
    required this.serviceType,
    required this.selectedTitle,
  }) : super(key: key);

  @override
  _ComplaintFormCatState createState() => _ComplaintFormCatState();
}

class _ComplaintFormCatState extends State<ComplaintFormCat> {
  int? selectedSubCategoryId;
  List<Map<String, dynamic>> subCategories = [];

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }

  Future<void> fetchSubCategories() async {
    const apiUrl = 'http://157.230.87.143:8055/items/Complaint_sub_category';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          subCategories = List<Map<String, dynamic>>.from(data['data']);
        });
      } else {
        throw Exception('Failed to load sub-categories');
      }
    } catch (error) {
      print('Error fetching sub-categories: $error');
    }
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
    return iconsMap[iconName] ?? Icons.help; // Default to help if no match
  }

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
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'الفئة الفرعية: ${widget.complaintType}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            subCategories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: subCategories.length,
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      final iconString = subCategory['icon'];
                      print('Fetched icon: $iconString'); // Debugging
                      return CustomComplaintBox(
                        title: subCategory['name'],
                        icon: _mapStringToIcon(iconString),
                        iconColor: Colors.green,
                        isSelected: selectedSubCategoryId == subCategory['id'],
                        onTap: () {
                          setState(() {
                            selectedSubCategoryId = subCategory['id'];
                          });
                          print('Navigating to ziad ddComplaintForm with service_type: ${widget.serviceType}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddComplaintForm(
                              subCategory: selectedSubCategoryId.toString(),
                              complaintType: widget.complaintType,
                              selectedCategory: widget.selectedCategory,
                              serviceType: widget.serviceType,
                              title: widget.selectedTitle,
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
}
