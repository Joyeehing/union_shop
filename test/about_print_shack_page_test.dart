import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_print_shack_page.dart';

void main() {
  group('About Print Shack Page Tests', () {
    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('The Union Print Shack'), findsOneWidget);
    });

    testWidgets('should display all content sections', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      // Check all section titles
      expect(find.text('Make It Yours at The Union Print Shack'), findsOneWidget);
      expect(find.text('Uni Gear or Your Gear - We\'ll Personalise It'), findsOneWidget);
      expect(find.text('Simple Pricing, No Surprises'), findsOneWidget);
      expect(find.text('Personalisation Terms & Conditions'), findsOneWidget);
      expect(find.text('Ready to Make It Yours?'), findsOneWidget);
    });

    testWidgets('should display pricing information', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('£3 for one line'), findsOneWidget);
      expect(find.textContaining('£5 for two lines'), findsOneWidget);
      expect(find.textContaining('three working days'), findsOneWidget);
    });

    testWidgets('should display personalisation details', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('heat-pressed customisation'), findsOneWidget);
      expect(find.textContaining('official uni-branded clothing'), findsOneWidget);
      expect(find.textContaining('your own items'), findsOneWidget);
    });

    testWidgets('should display terms and conditions', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('not responsible for any spelling errors'), findsOneWidget);
      expect(find.textContaining('Refunds are not provided'), findsOneWidget);
    });

    testWidgets('should display hero images', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      // Should have 3 images in the hero section
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should display header and footer', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      // Check header is present
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Scroll to bottom to check footer
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -2000));
      await tester.pumpAndSettle();

      // Check footer sections
      expect(find.text('ABOUT'), findsOneWidget);
      expect(find.text('HELP AND INFORMATION'), findsOneWidget);
    });

    testWidgets('should be scrollable', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      // Find the scrollable widget
      final scrollable = find.byType(SingleChildScrollView);
      expect(scrollable, findsOneWidget);

      // Verify initial position
      expect(find.text('The Union Print Shack'), findsOneWidget);

      // Scroll down
      await tester.drag(scrollable, const Offset(0, -500));
      await tester.pumpAndSettle();

      // Should still be able to find content
      expect(find.textContaining('Simple Pricing'), findsOneWidget);
    });

    testWidgets('should be responsive on mobile', (tester) async {
      tester.view.physicalSize = const Size(400, 1200);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('The Union Print Shack'), findsOneWidget);
      expect(find.text('Make It Yours at The Union Print Shack'), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('should be responsive on desktop', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      expect(find.text('The Union Print Shack'), findsOneWidget);
      expect(find.text('Make It Yours at The Union Print Shack'), findsOneWidget);

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('should display call to action', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutPrintShackPage()));
      await tester.pumpAndSettle();

      // Scroll to find the call to action
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -1500));
      await tester.pumpAndSettle();

      expect(find.text('Ready to Make It Yours?'), findsOneWidget);
      expect(find.textContaining('Pop in or get in touch today'), findsOneWidget);
    });
  });
}
