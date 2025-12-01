import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF333333)),
                child: const Text('Home'),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF333333)),
                child: const Text('About'),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF333333)),
                child: const Text('Products'),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF333333)),
                child: const Text('Contact'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Union Shop — Cambridge Rd,Portsmouth, PO1 2EF',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 6),
          const Text(
            'Email: contact@example.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
