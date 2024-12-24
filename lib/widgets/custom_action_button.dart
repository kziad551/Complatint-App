import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double titleSize;
  final Color backgroundColor;
  final bool isFull;

  const CustomActionButton({
    super.key,
    this.onPressed,
    required this.title,
    required this.titleSize,
    required this.backgroundColor,
    this.isFull = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: isFull ? double.infinity : 2 * MediaQuery.of(context).size.width / 5,
      width: isFull
          ? double.infinity
          : (MediaQuery.of(context).size.width / 2) - 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
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
