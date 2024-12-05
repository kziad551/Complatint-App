import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo_left.jpeg', 
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Handle footer button action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('القائمة'),
          ),
          Image.asset(
            'assets/images/logo_right.jpeg',
            height: 40,
          ),
        ],
      ),
    );
  }
}
