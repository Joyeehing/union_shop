import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/about_us_page.dart';

class _TestNavigatorObserver extends NavigatorObserver {
  bool didPopCalled = false;
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    didPopCalled = true;
  }
}

void main() {
  testWidgets('AboutUsPage displays content, shows snackbar and Back pops', (WidgetTester tester) async {
    final observer = _TestNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: const Text('Open'),
              ),
            ),
        '/about': (context) => const AboutUsPage(),
      },
      navigatorObservers: [observer],
    ));

    // Open the About page
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Verify static content
    expect(find.text('About Union Shop'), findsOneWidget);
    expect(find.text('Who we are'), findsOneWidget);
    expect(find.text('Our mission'), findsOneWidget);
    expect(find.text('Contact & help'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap "Open UPSU site" button -> should show SnackBar placeholder
    final Finder openButton = find.widgetWithIcon(ElevatedButton, Icons.open_in_new);
    expect(openButton, findsOneWidget);
    await tester.tap(openButton);
    await tester.pump(); // show SnackBar
    expect(find.text('Open external site (not implemented)'), findsOneWidget);

    // Tap Back button -> should pop
    final Finder backButton = find.text('Back');
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(observer.didPopCalled, isTrue);
    expect(find.text('About Union Shop'), findsNothing);
  });
}
