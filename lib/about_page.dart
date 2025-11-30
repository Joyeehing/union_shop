import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                'About Union Shop',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Welcome to the Union Shop!',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
              SizedBox(height: 16),
              Text(
                'Contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text('Email: info@unionshop.example.com'),
              SizedBox(height: 4),
              Text('Phone: 01234 567890'),
            ],
          ),
        ),
      ),
    );
  }
}
