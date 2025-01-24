import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'complaint_list_details.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintList extends StatefulWidget {
  const ComplaintList({Key? key}) : super(key: key);

  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  List<Map<String, dynamic>> complaints = [];
  bool isLoading = true;
  int? userId;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId'); // Retrieve the userId from SharedPreferences
    if (userId != null) {
      await fetchComplaints();
    } else {
      setState(() {
        isLoading = false; // Stop loading if no userId is found
      });
    }
  }

  Future<void> fetchComplaints() async {
    try {
      // Fetch complaints
      final complaintResponse = await http.get(
        Uri.parse(
            'https://complaint.top-wp.com/items/Complaint?filter[user][_eq]=$userId'),
      );

      if (complaintResponse.statusCode == 200) {
        final complaintData = jsonDecode(complaintResponse.body)['data'];

        // Fetch Status_subcategory data
        final subcategoryResponse = await http.get(
          Uri.parse('https://complaint.top-wp.com/items/Status_subcategory'),
        );

        if (subcategoryResponse.statusCode != 200) {
          print('Failed to fetch Status_subcategory.');
          return;
        }

        final subcategoryData = jsonDecode(subcategoryResponse.body)['data'];

        // Process complaints
        for (var complaint in complaintData) {
          String formattedDate = 'Unknown Date';
          if (complaint['date'] != null) {
            final parsedDate = DateTime.parse(complaint['date']);
            formattedDate =
                "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
          }

          // Get subcategory name or default to "استقبال الشكوى"
          final subcategoryId = complaint['status_subcategory'];
          final subcategory = subcategoryData.firstWhere(
            (sub) => sub['id'] == subcategoryId,
            orElse: () => null,
          );

          String subcategoryName = subcategory != null && subcategory['name'] != null
              ? subcategory['name']
              : 'استقبال الشكوى';

          // Add complaint data to list
          complaints.add({
            'id': complaint['id'],
            'name': complaint['title'] ?? 'Unknown Complaint',
            'date': formattedDate,
            'statusColor': getStatusColor(complaint['status']),
            'subcategory': subcategoryName,
          });
        }
      } else {
        print('Failed to fetch complaints. Status code: ${complaintResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching complaints: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Color getStatusColor(String? status) {
    if (status == null) {
      return Colors.grey; // Default color for null status
    }

    switch (status) {
      case 'تمت المراجعة':
        return const Color(0xFF48EF00); // Green
      case 'ملغاة':
        return const Color(0xFFEF3800); // Red
      case 'قيد المراجعة':
        return const Color(0xFFFFCD03); // Yellow
      default:
        return Colors.grey; // Default color for unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayoutPage(
      currentPage: "complaint_list",
      cardContent: _card(context),
      containFooter: true,
      containLogo: true,
      containToggle: false,
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
            const Center(
              child: Text(
                'قائمة الشكاوى',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ...complaints.map((complaint) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: _buildComplaintRow(
                context,
                complaint['id'],
                complaint['name'],
                complaint['date'],
                complaint['subcategory'],
                complaint['statusColor'],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintRow(
    BuildContext context,
    int complaintId,
    String complaint,
    String date,
    String subcategory,
    Color statusColor,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintListDetails(
              complaintId: complaintId,
              status: subcategory,
              statusColor: statusColor,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              alignment: Alignment.center,
              child: Text(
                subcategory,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  complaint,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
