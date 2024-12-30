import 'dart:ui';

import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final bool? isEditable;
  final TextEditingController? controller; // Added controller parameter

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialValue = '',
    this.obscureText = false,
    this.isEditable = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          // initialValue: initialValue,
          enabled: isEditable,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: const TextStyle(
            height: 1,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
