import 'package:flutter/material.dart';

class ToggleTabs extends StatelessWidget {
  final bool isSignUp;
  final Function(bool) onTabSelected;

  const ToggleTabs({
    Key? key,
    required this.isSignUp,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Expanded(
              child: _buildTabButton(
                label: 'إنشاء حساب جديد',
                isActive: isSignUp,
                onPressed: () => onTabSelected(true),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _buildTabButton(
                label: 'تسجيل الدخول',
                isActive: !isSignUp,
                onPressed: () => onTabSelected(false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          foregroundColor: Colors.black,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
