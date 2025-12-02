import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive: single column on mobile, row on desktop
          if (constraints.maxWidth < 900) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHelpColumn(),
                const SizedBox(height: 20),
                _buildAboutColumn(context),
                const SizedBox(height: 20),
                _buildLatestOffersColumn(),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildHelpColumn()),
                const SizedBox(width: 40),
                Expanded(flex: 1, child: _buildAboutColumn(context)),
                const SizedBox(width: 40),
                Expanded(flex: 3, child: _buildLatestOffersColumn()),
              ],
            );
          }
        },
      ),
    );
  }

 

  Widget _buildHelpColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HELP AND INFORMATION',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLink('Search', () {}),
        _buildFooterLink('Terms and Condition of Sale Policy', () {}),
      ],
    );
  }

  Widget _buildAboutColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ABOUT',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLink('About Us', () {
          Navigator.pushNamed(context, '/about');
        }),
      ],
    );
  }

  Widget _buildLatestOffersColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LATEST OFFERS',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 350,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Color(0xFF4d2963)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Subscribe action placeholder
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'SUBSCRIBE',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

