import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';

class AboutPrintShackPage extends StatelessWidget {
  const AboutPrintShackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(activePage: 'printshack'),
            
            // Page Title
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 32 : 48,
                    horizontal: isMobile ? 16 : 80,
                  ),
                  child: Text(
                    'The Union Print Shack',
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),

            // Hero Images Section
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 80,
                    vertical: isMobile ? 16 : 24,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildImageCard(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          isMobile,
                        ),
                      ),
                      Expanded(
                        child: _buildImageCard(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          isMobile,
                        ),
                      ),
                      Expanded(
                        child: _buildImageCard(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          isMobile,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Content Sections
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 80,
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Make It Yours Section
                      _buildContentSection(
                        title: 'Make It Yours at The Union Print Shack',
                        content:
                            'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team\'s always happy to help you pick the right gear and answer any questions.',
                        isMobile: isMobile,
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Uni Gear or Your Gear Section
                      _buildContentSection(
                        title: 'Uni Gear or Your Gear - We\'ll Personalise It',
                        content:
                            'Whether you\'re repping your university or putting your own spin on a hoodie you already own, we\'ve got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let\'s get creative!',
                        isMobile: isMobile,
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Simple Pricing Section
                      _buildContentSection(
                        title: 'Simple Pricing, No Surprises',
                        content:
                            'Customising your gear won\'t break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we\'ll let you know as soon as it\'s ready to collect.',
                        isMobile: isMobile,
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Terms & Conditions Section
                      _buildContentSection(
                        title: 'Personalisation Terms & Conditions',
                        content:
                            'We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.',
                        isMobile: isMobile,
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Call to Action Section
                      _buildContentSection(
                        title: 'Ready to Make It Yours?',
                        content:
                            'Pop in or get in touch today - let\'s create something uniquely you with our personalisation service - The Union Print Shack!',
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                );
              },
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imageUrl, bool isMobile) {
    return SizedBox(
      height: isMobile ? 150 : 300,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection({
    required String title,
    required String content,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: const Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
