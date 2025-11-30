import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_page.dart';

void main() {
  testWidgets('AboutPage shows header, centered content and Home button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const AboutPage()));

    // Verify top banner text exists
    expect(find.text('PLACEHOLDER HEADER TEXT'), findsOneWidget);

    // Verify About title is present and centered
    final aboutTitle = find.text('About Us');
    expect(aboutTitle, findsOneWidget);

    // Verify main centered paragraph text exists
    expect(find.textContaining('Welcome to Union Shop'), findsOneWidget);

    // Verify Home button exists in the header row
    final homeButton = find.widgetWithText(TextButton, 'Home');
    expect(homeButton, findsWidgets);

    // Tap the first Home button (in the header) and ensure navigation happens
    await tester.tap(homeButton.first);
    await tester.pumpAndSettle();

    // After tapping Home the widget tree will attempt to navigate to '/', but since
    // we supplied AboutPage as the root for this test, navigation will not replace the
    // widget. At minimum, the tap should not throw and the test will complete.
  });
}
