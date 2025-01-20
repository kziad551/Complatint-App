import 'package:flutter/material.dart';
import '../widgets/custom_action_button.dart';
import '../widgets/custom_layout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMainPage = true; // Toggle state for the tabs

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomLayoutPage(
        currentPage: "home_page",
        cardContent:
            isMainPage ? _buildMainPageContent() : _buildAboutUsContent(),
        onTabSelected: (value) {
          setState(() {
            isMainPage = value;
          });
        },
        labelTabOne: 'الصفحة الرئيسية', // Updated term here
        labelTabTwo: 'من نحن',
        stateActive: isMainPage,
        containFooter: true,
        containLogo: true,
        containToggle: true,
      ),
    );
  }

  Widget _buildMainPageContent() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: 280,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الصفحة الرئيسية', // Updated term here
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomActionButton(
                title: 'إضافة شكوى',
                titleSize: 16,
                backgroundColor: const Color(0xFFBA110C),
                onPressed: () {
                  Navigator.pushNamed(context, '/complaint_form');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutUsContent() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const SizedBox(
        height: 280,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'من نحن',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'تأسست الأمانة العامة لمجلس الوزراء عام 2003  بعد الإعلان عن تشكيل مجلس الحكم العراقي كممثل رسمي للحكومة العراقية لتأخذ على عاتقها إعادة التنظيم الإداري للدولة العراقية من خلال دوائرها عقب إنهيار النظام الدكتاتوري.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
