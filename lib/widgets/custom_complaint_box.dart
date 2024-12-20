import 'package:flutter/material.dart';

class CustomComplaintBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomComplaintBox({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 44,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
              color: isSelected ? Colors.blue[50] : Colors.white,
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 35,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
