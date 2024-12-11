import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('أو'),
            ),
            Expanded(
                child: Divider(
              color: Colors.grey,
            )),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Facebook button
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.facebook),
                iconSize: 35,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 20),
            // Google button
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata),
                iconSize: 35,
                color: const Color(0xFFBA110C),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
