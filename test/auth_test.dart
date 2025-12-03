import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/signup_page.dart';

void main() {
  group('Login Page Tests', () {
    testWidgets('LoginPage shows all form fields and elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const LoginPage(),
        routes: {
          '/signup': (context) => const SignupPage(),
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
        },
      ));

      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Welcome back! Please login to your account.'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('LoginPage validates required fields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const LoginPage(),
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
        },
      ));

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
        home: const LoginPage(),
        routes: {
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
        },
      ));

      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
      await tester.pumpAndSettle();

      // Verify email validation error
      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });
  });

  group('Signup Page Tests', () {
    testWidgets('SignupPage shows all form fields and elements', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const SignupPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/': (context) => const Scaffold(body: Center(child: Text('Home'))),
        },
      ));

      await tester.pumpAndSettle();

      // Verify page elements
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Sign up to start shopping with us!'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'), findsOneWidget);
      expect(find.text("Already have an account? "), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('SignupPage validates required fields', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const SignupPage(),
        routes: {
          '/account': (context) => const AccountPage(),
        },
      ));

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
        home: const SignupPage(),
        routes: {
          '/account': (context) => const AccountPage(),
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
      
      await tester.tap(find.widgetWithText(ElevatedButton, 'CREATE ACCOUNT'));
      await tester.pumpAndSettle();

      // Verify password mismatch error
      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
