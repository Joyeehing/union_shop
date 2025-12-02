import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  testWidgets('SalePage displays title and description', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    // Verify the SALE title is displayed
    expect(find.text('SALE'), findsOneWidget);
    
    // Verify the description text is displayed
    expect(find.textContaining('Don\'t miss out!'), findsOneWidget);
    expect(find.textContaining('All prices shown are inclusive of the discount'), findsOneWidget);
  });

  testWidgets('SalePage displays filter and sort dropdowns', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    // Verify Filter By label exists
    expect(find.text('Filter By:'), findsOneWidget);
    
    // Verify Sort By label exists
    expect(find.text('Sort By:'), findsOneWidget);
    
    // Verify product count is displayed
    expect(find.textContaining('Products'), findsOneWidget);
  });

  testWidgets('SalePage displays sale items grid', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that sale items are displayed (first page should show 8 items)
    expect(find.text('University Hoodie'), findsOneWidget);
    expect(find.text('Student Backpack'), findsOneWidget);
    expect(find.text('Campus T-Shirt'), findsOneWidget);
  });

  testWidgets('SalePage displays pagination controls', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify pagination text is displayed
    expect(find.textContaining('Page'), findsOneWidget);
    
    // Verify navigation buttons exist
    expect(find.byIcon(Icons.chevron_left), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
  });

  testWidgets('SalePage pagination works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify we're on page 1
    expect(find.text('Page 1 of 2'), findsOneWidget);

    // Tap next page button
    await tester.tap(find.byIcon(Icons.chevron_right));
    await tester.pumpAndSettle();

    // Verify we're now on page 2
    expect(find.text('Page 2 of 2'), findsOneWidget);

    // Verify different products are shown on page 2
    expect(find.text('Sweatpants'), findsOneWidget);
    expect(find.text('Gym Bag'), findsOneWidget);

    // Tap previous page button
    await tester.tap(find.byIcon(Icons.chevron_left));
    await tester.pumpAndSettle();

    // Verify we're back on page 1
    expect(find.text('Page 1 of 2'), findsOneWidget);
  });

  testWidgets('SalePage filter dropdown works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Find and tap the filter dropdown
    final filterDropdown = find.byType(DropdownButton<String>).first;
    await tester.tap(filterDropdown);
    await tester.pumpAndSettle();

    // Verify filter options are displayed
    expect(find.text('All').hitTestable(), findsWidgets);
    expect(find.text('Under £15').hitTestable(), findsOneWidget);
    expect(find.text('£15 - £30').hitTestable(), findsOneWidget);
    expect(find.text('Over £30').hitTestable(), findsOneWidget);

    // Tap 'Under £15' option
    await tester.tap(find.text('Under £15').last);
    await tester.pumpAndSettle();

    // Verify page reset to 1 after filter change
    expect(find.text('Page 1 of'), findsOneWidget);
  });

  testWidgets('SalePage sort dropdown works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Find and tap the sort dropdown
    final sortDropdown = find.byType(DropdownButton<String>).last;
    await tester.tap(sortDropdown);
    await tester.pumpAndSettle();

    // Verify sort options are displayed
    expect(find.text('Featured').hitTestable(), findsWidgets);
    expect(find.text('Price: Low to High').hitTestable(), findsOneWidget);
    expect(find.text('Price: High to Low').hitTestable(), findsOneWidget);
    expect(find.text('Discount: High to Low').hitTestable(), findsOneWidget);

    // Tap 'Price: Low to High' option
    await tester.tap(find.text('Price: Low to High').last);
    await tester.pumpAndSettle();

    // Verify page reset to 1 after sort change
    expect(find.text('Page 1 of'), findsOneWidget);
  });

  testWidgets('SalePage displays header and footer', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Header is displayed
    expect(find.byType(Header), findsOneWidget);
    
    // Verify Footer is displayed
    expect(find.byType(Footer), findsOneWidget);
  });

  testWidgets('SalePage navigates to detail page on item tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SalePage(),
      ),
    );

    await tester.pumpAndSettle();

    // Find and tap the first sale item
    final firstItem = find.text('University Hoodie');
    await tester.tap(firstItem);
    await tester.pumpAndSettle();

    // Verify navigation to detail page by checking for detail page elements
    expect(find.text('ADD TO CART'), findsOneWidget);
    expect(find.text('BACK TO SALE'), findsOneWidget);
  });

  test('SaleItem model calculates discount percentage correctly', () {
    final item = SaleItem(
      id: 'test',
      name: 'Test Item',
      originalPrice: 100.00,
      salePrice: 75.00,
    );

    expect(item.discountPercentage, equals(25));
  });

  test('SaleItem model handles different discount calculations', () {
    final item1 = SaleItem(
      id: 'test1',
      name: 'Test Item 1',
      originalPrice: 50.00,
      salePrice: 25.00,
    );
    expect(item1.discountPercentage, equals(50));

    final item2 = SaleItem(
      id: 'test2',
      name: 'Test Item 2',
      originalPrice: 35.00,
      salePrice: 24.99,
    );
    expect(item2.discountPercentage, equals(29));
  });
}
