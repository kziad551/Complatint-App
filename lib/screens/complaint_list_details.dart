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
  List<Map<String, dynamic>> timeline = [];  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchComplaintDetails();
    fetchTimeline();
  }

  Future<void> fetchComplaintDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://complaint.top-wp.com/items/Complaint/${widget.complaintId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        // Extract current values
        final currentStatus = data['status_subcategory']?.toString() ?? 'غير محدد';
        final currentDate = data['date'] ?? '';

        // Update complaint details
        setState(() {
          complaintTitle = data['title'] ?? 'عنوان غير محدد';
          description = data['description'] ?? 'لا يوجد وصف';
          subCategoryName = currentStatus;
          date = currentDate.isNotEmpty ? _parseDate(currentDate) : 'غير محدد';
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

  Future<void> fetchTimeline() async {
    try {
      // Fetch Status Subcategories first
      final subcatResponse = await http.get(
        Uri.parse('https://complaint.top-wp.com/items/Status_subcategory'),
      );

      print('Subcategory API Status: ${subcatResponse.statusCode}');
      print('Subcategory API Response: ${subcatResponse.body}');

      final Map<String, String> subcatMap = {};

      if (subcatResponse.statusCode == 200) {
        final subcatJson = jsonDecode(subcatResponse.body);
        final List<dynamic> subcatItems = subcatJson['data'] ?? [];

        for (final subcat in subcatItems) {
          final id = subcat['id']?.toString();
          final name = subcat['name']?.toString() ?? 'Unknown Status';
          if (id != null) {
            subcatMap[id] = name;
          }
        }
      }

      // Now fetch the timeline data
      final response = await http.get(
        Uri.parse(
          'https://complaint.top-wp.com/items/ComplaintTimeline?filter[complaint_id]=${widget.complaintId}',
        ),
      );

      print('Timeline API Status: ${response.statusCode}');
      print('Timeline API Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> items = jsonData['data'] ?? [];

        final List<Map<String, dynamic>> parsedTimeline = items.map((item) {
          final statusId = item['status_subcategory']?.toString();
          String statusName;

          // Use subcategory name if available, otherwise fallback to ID or 'Unknown Status'
          if (subcatMap.isNotEmpty && statusId != null) {
            statusName = subcatMap[statusId] ?? 'Unknown Status';
          } else {
            statusName = statusId ?? 'Unknown Status';
          }

          return {
            'status_subcategory': statusName,
            'statusDate': _parseDate(item['statusDate']),
          };
        }).toList();

        setState(() {
          timeline = parsedTimeline.reversed.toList(); // Show newest first
          isLoading = false;
        });
      }
    } catch (e) {
      print("Timeline Error: $e");
      setState(() => isLoading = false);
    }
  }
    
  String _parseDate(dynamic date) {
    if (date == null) return 'Unknown Date';
    try {
      final parsed = DateTime.parse(date.toString());
      return "${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}";
    } catch (e) {
      print("Date Parse Error: $e");
      return 'Invalid Date';
    }
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
              _buildTimelineSection(),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      width: double.infinity,
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
        // const Text(
        //   'أعطي تقييم للشكاوي',
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: List.generate(5, (index) {
        //     return const Icon(
        //       Icons.star_border,
        //       size: 40,
        //       color: Color(0xFFFFCD03),
        //     );
        //   }),
        // ),
      ],
    );
  }

  Widget _buildTimelineSection() {
    if (timeline.isEmpty) {
      return const Text(
        'لا توجد بيانات في الخط الزمني حاليًا.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: timeline.length,
      itemBuilder: (context, index) {
        final item = timeline[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['statusDate'] ?? 'غير محدد',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    item['status_subcategory'] ?? 'غير محدد',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}