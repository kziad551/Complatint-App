import 'package:flutter/material.dart';
import 'menu_widget.dart'; // Import the MenuWidget for the swipe-up menu

class FooterWidget extends StatelessWidget {
  final String currentPage; // Add currentPage parameter to track active page

  const FooterWidget({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/footer_waves.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFBC0019),
      ),
      height: 70, // Adjust height as needed
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
                'assets/images/logo_left.jpeg',
                height: 70, // Adjust logo size
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
                      return MenuWidget(currentPage: currentPage); // Pass currentPage
                    },
                  );
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
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 70, // Adjust logo size
              ),
            ),
          ),
        ],
      ),
    );
  }
}
