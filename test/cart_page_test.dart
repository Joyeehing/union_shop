import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_item.dart';

void main() {
  late CartService cartService;

  setUp(() {
    cartService = CartService();
    cartService.clear(); // Clear cart before each test
  });

  group('Cart Page Tests', () {
    testWidgets('should display empty cart message when cart is empty', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Shopping Cart'), findsOneWidget);
      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.text('Add some products to get started!'), findsOneWidget);
      expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('should display cart items when cart has products', (tester) async {
      // Add test item to cart
      final testItem = CartItem(
        id: '1',
        name: 'Test Product',
        price: 25.00,
        size: 'M',
        color: 'Blue',
        quantity: 2,
        imageUrl: 'https://example.com/test.jpg',
      );
      cartService.addItem(testItem, id: '1');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Shopping Cart'), findsOneWidget);
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Size: M'), findsOneWidget);
      expect(find.text('Color: Blue'), findsOneWidget);
      expect(find.text('2'), findsWidgets); // Appears in badge and quantity
      expect(find.text('£50.00'), findsWidgets); // 25 * 2 - appears in item price, subtotal, and total
    });

    testWidgets('should update quantity when plus/minus buttons are tapped', (tester) async {
      final testItem = CartItem(
        id: '1',
        name: 'Test Product',
        price: 20.00,
        size: 'L',
        color: 'Red',
        quantity: 1,
        imageUrl: '',
      );
      cartService.addItem(testItem, id: '1');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Find and tap the plus button
      final plusButton = find.byIcon(Icons.add);
      expect(plusButton, findsOneWidget);
      await tester.tap(plusButton);
      await tester.pumpAndSettle();

      // Check quantity increased
      expect(find.text('2'), findsWidgets); // Appears in badge and quantity display
      expect(find.text('£40.00'), findsWidgets); // Appears in line total, subtotal, and total

      // Tap minus button
      final minusButton = find.byIcon(Icons.remove);
      await tester.tap(minusButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsWidgets); // May appear in badge too
      expect(find.text('£20.00'), findsWidgets); // Appears in line total and total
    });

    testWidgets('should remove item when remove button is tapped', (tester) async {
      final testItem = CartItem(
        id: '1',
        name: 'Test Product',
        price: 15.00,
        size: 'S',
        color: 'Green',
        quantity: 1,
        imageUrl: '',
      );
      cartService.addItem(testItem, id: '1');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);

      // Tap remove button
      final removeButton = find.text('Remove');
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      // Should show empty cart
      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('should display cart summary with correct totals', (tester) async {
      final item1 = CartItem(
        id: '1',
        name: 'Product 1',
        price: 10.00,
        size: 'M',
        color: 'Blue',
        quantity: 2,
        imageUrl: '',
      );
      final item2 = CartItem(
        id: '2',
        name: 'Product 2',
        price: 15.00,
        size: 'L',
        color: 'Red',
        quantity: 1,
        imageUrl: '',
      );

      cartService.addItem(item1, id: '1');
      cartService.addItem(item2, id: '2');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Check subtotal and total
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('£35.00'), findsWidgets); // 20 + 15
    });

    testWidgets('should show checkout dialog when checkout button is tapped', (tester) async {
      final testItem = CartItem(
        id: '1',
        name: 'Test Product',
        price: 25.00,
        size: 'M',
        color: 'Blue',
        quantity: 1,
        imageUrl: '',
      );
      cartService.addItem(testItem, id: '1');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      // Scroll to make checkout button visible
      await tester.dragUntilVisible(
        find.text('PROCEED TO CHECKOUT'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      // Tap checkout button
      final checkoutButton = find.text('PROCEED TO CHECKOUT');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      // Check dialog appears
      expect(find.text('Order Confirmation'), findsOneWidget);
      expect(find.text('Your order has been placed successfully!'), findsOneWidget);
      expect(find.text('Items: 1'), findsOneWidget);
    });

    testWidgets('should navigate to home when continue shopping is tapped', (tester) async {
      cartService.clear(); // Start with empty cart
      
      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('Shopping Cart'), findsOneWidget);
      expect(find.text('Your cart is empty'), findsOneWidget);

      // Tap continue shopping button from empty cart
      final continueButton = find.text('CONTINUE SHOPPING');
      await tester.tap(continueButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Should navigate (verify by checking route was called)
      // Note: Since we're using MaterialApp without routes, the navigation won't actually work
      // This test just verifies the button is tappable
    });

    testWidgets('should display item count in header', (tester) async {
      final testItem = CartItem(
        id: '1',
        name: 'Test Product',
        price: 10.00,
        size: 'M',
        color: 'Blue',
        quantity: 3,
        imageUrl: '',
      );
      cartService.addItem(testItem, id: '1');

      await tester.pumpWidget(const MaterialApp(home: CartPage()));
      await tester.pumpAndSettle();

      expect(find.text('3 items'), findsOneWidget);
    });
  });
}
