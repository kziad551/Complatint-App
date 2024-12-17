import 'package:flutter/material.dart';

class ToggleTabs extends StatelessWidget {
  final bool isTabOne;
  final String labelTabOne;
  final String labelTabTwo;
  final Function(bool) onTabSelected;

  const ToggleTabs({
    super.key,
    required this.isTabOne,
    required this.onTabSelected,
    required this.labelTabOne,
    required this.labelTabTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              child: _buildTabButton(
                label: labelTabOne,
                isActive: isTabOne,
                onPressed: () => onTabSelected(true),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _buildTabButton(
                label: labelTabTwo,
                isActive: !isTabOne,
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
      height: 35.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
