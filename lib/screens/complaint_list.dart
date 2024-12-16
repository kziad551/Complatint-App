import 'package:flutter/material.dart';
import 'complaint_list_details.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintList extends StatelessWidget {
  const ComplaintList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "complaint_list",
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
            _buildComplaintRow(
              context,
              'شكوى ١',
              '٢١/١١/٢٠٢٤',
              'تمت المراجعة',
              const Color(0xFF48EF00),
            ),
            const SizedBox(height: 10),
            _buildComplaintRow(
              context,
              'شكوى ٢',
              '٢١/١١/٢٠٢٤',
              'ملغاة',
              const Color(0xFFEF3800),
            ),
            const SizedBox(height: 10),
            _buildComplaintRow(
              context,
              'شكوى ٣',
              '٢١/١١/٢٠٢٤',
              'تمت المراجعة',
              const Color(0xFF48EF00),
            ),
            const SizedBox(height: 10),
            _buildComplaintRow(
              context,
              'شكوى ٤',
              '٢١/١١/٢٠٢٤',
              'قيد المراجعة',
              const Color(0xFFFFCD03),
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Status Button
            Container(
              width: 110,
              // height: 40,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              alignment: Alignment.center,
              child: Text(
                status,
                style: const TextStyle(
                  fontSize: 12,
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
