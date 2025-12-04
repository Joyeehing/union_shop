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
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 80,
                    vertical: isMobile ? 24 : 60,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'About us',
                            style: TextStyle(
                              fontSize: isMobile ? 22 : 25,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 24 : 40),
                        Text(
                          'Welcome to the Union Shop!',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.8,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 20),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: const Color(0xFF666666),
                              height: 1.8,
                        ),
                            children: const [
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
                        SizedBox(height: isMobile ? 16 : 20),
                        Text(
                          'All online purchases are available for delivery or instore collection!',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.8,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 20),
                        Text(
                          'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.8,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 20),
                        Text(
                          'Happy shopping!',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.8,
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 20),
                        Text(
                          'The Union Shop & Reception Team',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: const Color(0xFF666666),
                            height: 1.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}


