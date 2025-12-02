import 'package:flutter/material.dart';
import 'widgets/footer.dart';
import 'widgets/header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (same as HomeScreen)
            const Header(activePage: 'about'),

            // About content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'About us',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Welcome to the Union Shop!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          height: 1.8,
                        ),
                        children: [
                          TextSpan(
                            text: 'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive ',
                          ),
                          TextSpan(
                            text: 'personalisation service',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: '!'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'All online purchases are available for delivery or instore collection!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Happy shopping!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'The Union Shop & Reception Team',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}


