import 'package:flutter/material.dart';
import 'widgets/footer.dart';
import 'widgets/header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (same as HomeScreen)
            Header(activePage: 'about'),

            // About content
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Welcome to Union Shop. \n\nWe’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!\n\nAll online purchases are available for delivery or instore collection!\n\nWe hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.\n\nHappy shopping!',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            // Footer
            Footer(),
          ],
        ),
      ),
    );
  }
}


