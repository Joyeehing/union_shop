import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('LoginPage shows all form fields and elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/login',
        routes: {
          '/signup': (context) => const SignupPage(),
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/login': (context) => const LoginPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Welcome back! Please login to your account.'), findsOneWidget);
      expect(find.text('Email Address'), findsWidgets); // Label appears, may have multiple instances
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      
      // Verify form fields exist
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
    });

    testWidgets('LoginPage validates required fields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/login',
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/login': (context) => const LoginPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Scroll to make button visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'LOGIN'));
      await tester.pumpAndSettle();

      // Tap login without filling fields
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
      await tester.pumpAndSettle();

      // Verify error messages
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('LoginPage validates email format', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/login',
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/login': (context) => const LoginPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      
      // Scroll to make button visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'LOGIN'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
      await tester.pumpAndSettle();

      // Verify email validation error
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });
  });

  group('Signup Page Tests', () {
    testWidgets('SignupPage shows all form fields and elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signup',
        routes: {
          '/login': (context) => const LoginPage(),
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/signup': (context) => const SignupPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Sign up to start shopping with us!'), findsOneWidget);
      expect(find.text('Full Name'), findsWidgets); // Label may appear multiple times
      expect(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'), findsOneWidget);
      expect(find.text("Already have an account? "), findsOneWidget);
      
      // Verify form fields exist
      expect(find.byType(TextFormField), findsNWidgets(4)); // Name, Email, Password, Confirm Password
    });

    testWidgets('SignupPage validates required fields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signup',
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/signup': (context) => const SignupPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Accept terms and conditions first - scroll to checkbox
      final checkbox = find.byType(Checkbox);
      await tester.ensureVisible(checkbox);
      await tester.pumpAndSettle();
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      // Scroll to make button visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();

      // Tap signup without filling fields
      await tester.tap(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();

      // Verify error messages
      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('SignupPage validates password match', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signup',
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/signup': (context) => const SignupPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Find text fields
      final textFields = find.byType(TextFormField);
      
      // Enter name
      await tester.enterText(textFields.at(0), 'John Doe');
      
      // Enter valid email
      await tester.enterText(textFields.at(1), 'john@example.com');
      
      // Enter password
      await tester.enterText(textFields.at(2), 'password123');
      
      // Enter different confirm password
      await tester.enterText(textFields.at(3), 'password456');

      // Accept terms and conditions - scroll to checkbox
      final checkbox = find.byType(Checkbox);
      await tester.ensureVisible(checkbox);
      await tester.pumpAndSettle();
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      
      // Scroll to make button visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();

      // Verify password mismatch error
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('SignupPage requires terms acceptance', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signup',
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
          '/signup': (context) => const SignupPage(),
        },
      ));

      await tester.pumpAndSettle();

      // Find text fields and fill them
      final textFields = find.byType(TextFormField);
      
      await tester.enterText(textFields.at(0), 'John Doe');
      await tester.enterText(textFields.at(1), 'john@example.com');
      await tester.enterText(textFields.at(2), 'password123');
      await tester.enterText(textFields.at(3), 'password123');
      
      // Scroll to make button visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();
      
      // Try to submit without accepting terms
      await tester.tap(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();

      // Verify terms acceptance error message
      expect(find.text('Please accept the terms and conditions'), findsOneWidget);
    });
  });
}
