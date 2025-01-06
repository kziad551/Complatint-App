import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complaint_application/main.dart';

void main() {
  testWidgets('App initializes and shows the correct screen', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for any asynchronous operations (e.g., FutureBuilder) to complete.
    await tester.pumpAndSettle();

    // Check if either the HomePage or LoginPage is shown based on login state.
    expect(find.text('صفحة رئيسية'), findsOneWidget, reason: 'HomePage should be shown if the user is logged in.');
    expect(find.text('تسجيل الدخول'), findsNothing, reason: 'LoginPage should not be shown when the user is logged in.');
  });
}
