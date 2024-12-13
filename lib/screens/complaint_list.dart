import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';
import 'complaint_list_details.dart';

class ComplaintList extends StatelessWidget {
  const ComplaintList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: const Text('قائمة الشكاوى'),
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
                      'قائمة الشكاوى',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildComplaintRow(context, 'شكوى ١', '٢١/١١/٢٠٢٤', 'تمت المراجعة', Colors.green),
                    const SizedBox(height: 10),
                    _buildComplaintRow(context, 'شكوى ٢', '٢١/١١/٢٠٢٤', 'ملغاة', Colors.red),
                    const SizedBox(height: 10),
                    _buildComplaintRow(context, 'شكوى ٣', '٢١/١١/٢٠٢٤', 'تمت المراجعة', Colors.green),
                    const SizedBox(height: 10),
                    _buildComplaintRow(context, 'شكوى ٤', '٢١/١١/٢٠٢٤', 'قيد المراجعة', Colors.yellow),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const FooterWidget(currentPage: 'complaint_list'),
      ),
    );
  }

  Widget _buildComplaintRow(
    BuildContext context,
    String complaint,
    String date,
    String status,
    Color statusColor,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to details page with arguments
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplaintListDetails(
              complaintTitle: complaint,
              date: date,
              status: status,
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Complaint Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complaint,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            // Status Button
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Text(
                status,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
