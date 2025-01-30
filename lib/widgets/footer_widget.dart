import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_page.dart';
import '../screens/complaint_form.dart';
import '../screens/complaint_list.dart';
import '../screens/settings.dart';
import '../screens/complaint_rating.dart';
import '../screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaint App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class FooterWidget extends StatelessWidget {
  final String currentPage;

  const FooterWidget({super.key, required this.currentPage});

  Future<void> _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality( // Ensure consistent text direction
      textDirection: TextDirection.ltr, // Change to rtl if needed
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 8,
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavIcon(
                context,
                icon: Icons.home,
                isActive: currentPage == 'home_page',
                onTap: () => _navigateTo(context, const HomePage(), 'home_page'),
              ),
              _buildNavIcon(
                context,
                icon: Icons.list_alt,
                isActive: currentPage == 'complaint_list',
                onTap: () => _navigateTo(context, const ComplaintList(), 'complaint_list'),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFBC0019),
                  shape: const CircleBorder(),
                  elevation: 5,
                  onPressed: () => _navigateTo(context, const ComplaintForm(), 'add_complaint'),
                  child: const Icon(Icons.add, color: Colors.white, size: 32),
                ),
              ),
              _buildNavIcon(
                context,
                icon: Icons.star,
                isActive: currentPage == 'rate_service',
                onTap: () async {
                  final userId = await _getUserId();
                  if (userId != null) {
                    _navigateTo(context, ComplaintRatingPage(userId: userId), 'rate_service');
                  }
                },
              ),
              _buildNavIcon(
                context,
                icon: Icons.settings,
                isActive: currentPage == 'settings',
                onTap: () => _navigateTo(context, const SettingsPage(), 'settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(BuildContext context, {
    required IconData icon,
    required bool isActive,
    required Function() onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: isActive ? const Color(0xFFBC0019) : Colors.grey),
      iconSize: 28,
      onPressed: onTap,
    );
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  void _navigateTo(BuildContext context, Widget page, String pageName) {
    if (currentPage != pageName) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Directionality( // Ensure Directionality on all pages
            textDirection: TextDirection.ltr, // Change to rtl if needed
            child: page,
          ),
        ),
      );
    }
  }
}
