import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_layout_page.dart';

class ComplaintListDetails extends StatefulWidget {
  final int complaintId;
  final String status;
  final Color statusColor;

  const ComplaintListDetails({
    Key? key,
    required this.complaintId,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

  @override
  _ComplaintListDetailsState createState() => _ComplaintListDetailsState();
}

class _ComplaintListDetailsState extends State<ComplaintListDetails> {
  String complaintTitle = '';
  String description = '';
  String subCategoryName = '';
  String date = '';
  List<Map<String, String>> timeline = []; // Store all status history
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndBuildTimeline();
  }

  Future<void> fetchAndBuildTimeline() async {
    try {
      // Fetch data from API
      final response = await http.get(
        Uri.parse('https://complaint.top-wp.com/items/Complaint/${widget.complaintId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // Extract current values
        final currentStatus = data['status_subcategory']?.toString() ?? 'غير محدد';
        final currentDate = data['statusDate1'] ?? '';

        // Check if the timeline needs to be updated
        if (timeline.isEmpty ||
            timeline.last['status'] != currentStatus ||
            timeline.last['date'] != currentDate) {
          setState(() {
            timeline.add({
              'status': currentStatus,
              'date': formatDate(currentDate),
            });
          });
        }

        // Update other complaint details
        setState(() {
          complaintTitle = data['title'] ?? 'عنوان غير محدد';
          description = data['description'] ?? 'لا يوجد وصف';
          subCategoryName = currentStatus;
          date = currentDate.isNotEmpty ? formatDate(currentDate) : 'غير محدد';
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load complaint details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching complaint details: $e");
    }
  }

  String formatDate(String rawDate) {
    if (rawDate.isEmpty) return 'غير محدد';
    final parsedDate = DateTime.parse(rawDate);
    return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "complaint_list_details",
        cardContent: _card(context),
        containFooter: true,
        containLogo: true,
        containToggle: false,
      ),
    );
  }

  Widget _card(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyInput('عنوان الشكوى', complaintTitle),
            const SizedBox(height: 12),
            _buildReadOnlyInput('الوصف', description),
            const SizedBox(height: 12),
            _buildReadOnlyInput('الفئة', subCategoryName),
            const SizedBox(height: 12),
            _buildReadOnlyInput('التاريخ', date),
            const SizedBox(height: 12),
            _buildStatusButton(widget.status, widget.statusColor),
            const SizedBox(height: 32),
            const Divider(color: Colors.grey),
            const SizedBox(height: 32),
            const Text(
              'الخط الزمني',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...timeline.map((entry) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry['date'] ?? '',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      _buildStatusButton(
                        entry['status'] ?? 'غير محدد',
                        Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
            const Divider(color: Colors.grey),
            const SizedBox(height: 32),
            _buildCommentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyInput(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE1E1E1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusButton(String status, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25.0),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أضف تعليق',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'اكتب تعليقك هنا',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'أعطي تقييم للشكاوي',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return const Icon(
              Icons.star_border,
              size: 40,
              color: Color(0xFFFFCD03),
            );
          }),
        ),
      ],
    );
  }
}
