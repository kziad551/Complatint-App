import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/complaint_form.dart';
import '../screens/complaint_list.dart';
import '../screens/settings.dart';
class MenuWidget extends StatelessWidget {
  final String currentPage;

  const MenuWidget({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust height dynamically
        children: [
          _buildMenuRow(
            context,
            icon: Icons.home,
            text: 'صفحة رئيسية',
            isActive: currentPage == 'home_page',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          _buildMenuRow(
            context,
            icon: Icons.assignment,
            text: 'تقديم الشكوى',
            isActive: currentPage == 'complaint_form',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ComplaintForm()),
              );
            },
          ),
          _buildMenuRow(
            context,
            icon: Icons.list,
            text: 'قائمة الشكاوى',
            isActive: currentPage == 'complaint_list',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ComplaintList()),
              );
            },
          ),
          _buildMenuRow(
            context,
            icon: Icons.star,
            text: 'قيم نوع مستوى الخدمة',
            isActive: currentPage == 'rate_service',
            onTap: () {
              // TODO: Navigate to rating page
            },
          ),
        _buildMenuRow(
          context,
          icon: Icons.settings,
          text: 'الإعدادات',
          isActive: currentPage == 'settings',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        ],
      ),
    );
  }

  Widget _buildMenuRow(BuildContext context,
      {required IconData icon,
      required String text,
      required bool isActive,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0), // Space between rows
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFB8282) : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align to the right
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              color: Colors.black54,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
