import 'package:flutter/material.dart';
import 'menu_widget.dart'; // Import the MenuWidget for the swipe-up menu

class FooterWidget extends StatelessWidget {
  final String currentPage; // Add currentPage parameter to track active page

  const FooterWidget({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/footer_waves.png'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        color: Color(0xFFBC0019),
      ),
      height: 86, // Adjust height as needed
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Section with Logo
          Expanded(
            flex: 1, // Allocate 1/3 of the space
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/app_logo.png',
              ),
            ),
          ),

          // Middle Section with Button
          Expanded(
            flex: 1, // Allocate 1/3 of the space
            child: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Show swipe-up menu
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return MenuWidget(currentPage: currentPage);
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4D6D9),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black,
                ),
                child: const Text(
                  'القائمة',
                  style: TextStyle(
                    fontSize: 16,
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
              alignment: Alignment.center,
              child: const Text(
                "giz",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // child: Image.asset(
              //   'assets/images/giz_logo.jpeg',
              // ),
            ),
          ),
        ],
      ),

      // Stack(
      //   children: [
      //     // Background Image
      //     Positioned.fill(
      //       child: Image.asset(
      //         "assets/images/footer_waves.png",
      //         fit: BoxFit.fitWidth,
      //         width: double.infinity,
      //         // height: 60,
      //       ),
      //     ),
      //     // Row of Elements on Top of the Image
      //   ],
      // ),
    );
  }
}
