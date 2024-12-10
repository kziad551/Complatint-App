import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color:
            Color(0xFFBC0019), // Red background for the left and right sections
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 100, // Adjust height as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section with Logo
          Expanded(
            flex: 1, // Allocate 1/3 of the space
            child: Container(
              color: const Color(0xFFBC0019), // Red background
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo_left.jpeg', // Ensure this logo exists
                height: 50, // Adjust logo size
              ),
            ),
          ),

          // Middle Section with Button
          Expanded(
            flex: 1, // Allocate 1/3 of the space
            child: Container(
              color: const Color(
                  0xFFDAD8D9), // Light gray background for the middle section
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background
                  foregroundColor: Colors.black, // Button text color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Rounded button corners
                  ),
                ),
                child: const Text(
                  'القائمة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Right Section with Logo
          Expanded(
            flex: 1, // Allocate 1/3 of the space
            child: Container(
              color: const Color(0xFFBC0019), // Red background
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo_right.jpeg', // Ensure this logo exists
                height: 50, // Adjust logo size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
