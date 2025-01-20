import 'package:flutter/material.dart';

class CustomComplaintBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomComplaintBox({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 2) - 32,
            height: 100, // Adjusted height for better spacing
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
              color: isSelected ? Colors.blue[50] : Colors.white,
            ),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9), // Grey background
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 35,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Prevents text clipping
            ),
          ),
        ],
      ),
    );
  }
}
