import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive: single column on mobile, row on desktop
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShopColumn(),
                const SizedBox(height: 24),
                _buildHelpColumn(),
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildShopColumn()),
                Expanded(child: _buildHelpColumn()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildShopColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SHOP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLink('Clothing'),
        _buildFooterLink('Merchandise'),
        _buildFooterLink('Signature & Essential Range'),
        _buildFooterLink('Portsmouth City Collection'),
        _buildFooterLink('Graduation'),
      ],
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
        _buildFooterLink('Search'),
        _buildFooterLink('Terms and Condition of Sale Policy'),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

