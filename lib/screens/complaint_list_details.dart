import 'package:complaint_application/widgets/custom_action_button.dart';
import 'package:complaint_application/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_layout_page.dart';

class ComplaintListDetails extends StatelessWidget {
  final String complaintTitle;
  final String date;
  final String status;
  final Color statusColor;

  const ComplaintListDetails({
    Key? key,
    required this.complaintTitle,
    required this.date,
    required this.status,
    required this.statusColor,
  }) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'تفاصيل $complaintTitle',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReadOnlyInput('عنوان الشكوى', 'لوريم إيبسوم'),
                  const SizedBox(height: 12),
                  _buildReadOnlyInput('الوصف',
                      'لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر.'),
                  const SizedBox(height: 12),
                  _buildReadOnlyInput('الفئة', complaintTitle),
                  const SizedBox(height: 12),
                  _buildReadOnlyInput('التاريخ', date),
                  const SizedBox(height: 12),
                  const Text(
                    'الحالة',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildStatusButton(status, statusColor),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: Colors.grey),
            const SizedBox(height: 32),
            const Text(
              'الخط الزمني',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('١٠/١١/٢٠٢٤',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                _buildStatusButton('قيد المراجعة', const Color(0xFFFFCD03)),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('٢١/١١/٢٠٢٤',
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                _buildStatusButton('تمت المراجعة', const Color(0xFF48EF00)),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(color: Colors.grey),
            const SizedBox(height: 32),
            const CustomInputField(label: 'أضف تعليق', hint: 'اكتب تعليقك هنا'),
            const SizedBox(height: 20),
            const Text(
              'أعطي تقييم للشكاوي',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star_border,
                    size: 40,
                    color: Color(0xFFFFCD03),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              title: "إدخال",
              titleSize: 16,
              backgroundColor: const Color(0xFFBA110C),
              onPressed: () {},
              isFull: false,
            ),
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
}
