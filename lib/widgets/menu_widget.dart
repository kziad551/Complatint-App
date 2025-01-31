import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_page.dart';
import '../screens/complaint_form.dart';
import '../screens/complaint_list.dart';
import '../screens/settings.dart';
import '../screens/complaint_rating.dart';
import '../screens/login_page.dart'; // Import LoginPage for redirection after logout

class MenuWidget extends StatelessWidget {
  final String currentPage;

  const MenuWidget({Key? key, required this.currentPage}) : super(key: key);

  Future<void> handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login status

    // Navigate to Login Page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId'); // Retrieve user ID
  }

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
            text: 'الصفحة رئيسية',
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
            onTap: () async {
              final userId = await getUserId();
              if (userId != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintRatingPage(userId: userId),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('User not logged in')),
                );
              }
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
          const Divider(color: Colors.grey), // Divider for better UI
          _buildMenuRow(
            context,
            icon: Icons.logout,
            text: 'تسجيل الخروج',
            isActive: false, // Logout doesn't have an active state
            onTap: () => handleLogout(context), // Call logout function
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
