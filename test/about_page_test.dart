import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_page.dart';

void main() {
  testWidgets('AboutPage shows header, centered content and Home button', (WidgetTester tester) async {
    // Provide routes so the Home button can navigate to '/'.
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/about',
      routes: {
        '/': (context) => const Scaffold(body: Center(child: Text('HomeScreen'))),
        '/about': (context) => const AboutPage(),
      },
    ));

    await tester.pumpAndSettle();

    // Verify About title is present (updated to match actual implementation)
    expect(find.text('About us'), findsOneWidget);

    // Verify main paragraph text exists (partial match)
    expect(find.textContaining('Welcome to the Union Shop'), findsOneWidget);

    // Verify Home button exists in the header
    final homeButton = find.widgetWithText(TextButton, 'Home');
    expect(homeButton, findsWidgets);

    // Tap the first Home button (in the header) and ensure navigation to '/' happens
    await tester.tap(homeButton.first);
    await tester.pumpAndSettle();

    // After navigation we should see the HomeScreen placeholder
    expect(find.text('HomeScreen'), findsOneWidget);
  });
}
