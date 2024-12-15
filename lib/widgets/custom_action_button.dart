import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double titleSize;
  final Color backgroundColor;

  const CustomActionButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.titleSize,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
