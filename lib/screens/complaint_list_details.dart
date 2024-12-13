import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';

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
      child: Scaffold(
        backgroundColor: const Color(0xFFD4D6D9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFBC0019),
          title: Text('تفاصيل $complaintTitle'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView( // Added to make the content scrollable
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
                      Text(
                        'تفاصيل $complaintTitle',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      _buildReadOnlyInput('عنوان الشكوى', 'لوريم إيبسوم'),
                      const SizedBox(height: 10),
                      _buildReadOnlyInput('الوصف',
                          'لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر.'),
                      const SizedBox(height: 10),
                      _buildReadOnlyInput('الفئة', complaintTitle),
                      const SizedBox(height: 10),
                      _buildReadOnlyInput('التاريخ', date),
                      const SizedBox(height: 10),
                      _buildStatusButton(status, statusColor),
                      const Divider(color: Colors.grey),
                      const Text('الخط الزمني', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      _buildTimelineRow('١٠/١١/٢٠٢٤', 'قيد المراجعة', Colors.yellow),
                      _buildTimelineRow('٢١/١١/٢٠٢٤', 'تمت المراجعة', Colors.green),
                      const Divider(color: Colors.grey),
                      const Text('اضف تعليق', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'اكتب تعليقك هنا',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('اعطي تقييم للشكاوي', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          return Icon(Icons.star_border, size: 32);
                        }),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle submission
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          child: const Text('ادخال',
                              style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const FooterWidget(currentPage: 'complaint_list'),
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
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(value),
        ),
      ],
    );
  }

  Widget _buildStatusButton(String status, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTimelineRow(String date, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style: const TextStyle(fontSize: 14, color: Colors.black)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            status,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
