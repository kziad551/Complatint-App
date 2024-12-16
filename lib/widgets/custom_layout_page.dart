import 'dart:ui';

import 'package:flutter/material.dart';
import '../widgets/footer_widget.dart';
import '../widgets/toggle_tabs.dart';

class CustomLayoutPage extends StatelessWidget {
  final String currentPage;
  final Widget cardContent;
  final dynamic onTabSelected;
  final String labelTabOne;
  final String labelTabTwo;
  final bool stateActive;
  final bool containFooter;
  final bool containLogo;
  final bool containToggle;

  const CustomLayoutPage({
    super.key,
    required this.currentPage,
    required this.cardContent,
    this.onTabSelected,
    this.labelTabOne = "",
    this.labelTabTwo = "",
    this.stateActive = true,
    this.containFooter = true,
    this.containLogo = true,
    this.containToggle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4D6D9),
      body: SafeArea(
        child: Column(
          children: [
            if (containLogo)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            if (containToggle)
              Column(
                children: [
                  ToggleTabs(
                    isTabOne: stateActive,
                    labelTabOne: labelTabOne,
                    labelTabTwo: labelTabTwo,
                    onTabSelected: onTabSelected,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: cardContent,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: containFooter
          ? FooterWidget(currentPage: currentPage)
          : const SizedBox(),
    );
  }
}
