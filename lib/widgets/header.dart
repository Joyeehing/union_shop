import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final String activePage; // 'home', 'about', etc.

  const Header({super.key, this.activePage = ''});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToSale(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/sale',
      (route) => route.settings.name == '/',
    );
  }

  void _navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void _placeholderCallback() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Main header navbar
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Logo (left)
                  GestureDetector(
                    onTap: () {
                      _navigateToHome(context);
                    },
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Center navigation (Home and About) - desktop view
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => _navigateToHome(context),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: widget.activePage == 'home'
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Shop dropdown
                        PopupMenuButton<String>(
                          offset: const Offset(0, 40),
                          onSelected: (value) {
                            // Placeholder for future navigation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$value - Coming soon!')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Shop',
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: widget.activePage == 'shop'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(0xFF333333),
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Clothing',
                              child: Text('Clothing'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Merchandise',
                              child: Text('Merchandise'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Signature & Essential Range',
                              child: Text('Signature & Essential Range'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Portsmouth City Collection',
                              child: Text('Portsmouth City Collection'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Pride Collection🏳️‍🌈',
                              child: Text('Pride Collection🏳️‍🌈'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Graduation🎓',
                              child: Text('Graduation🎓'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        // The Print Shack dropdown
                        PopupMenuButton<String>(
                          offset: const Offset(0, 40),
                          onSelected: (value) {
                            // Placeholder for future navigation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$value - Coming soon!')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'The Print Shack',
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: widget.activePage == 'printshack'
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                  color: Color(0xFF333333),
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'About',
                              child: Text('About'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Personalisation',
                              child: Text('Personalisation'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => _navigateToSale(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'SALE!',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: widget.activePage == 'sale'
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: widget.activePage == 'about'
                              ? null
                              : () => _navigateToAbout(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'About',
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: widget.activePage == 'about'
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icons (right)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _placeholderCallback,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.person_outline,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _placeholderCallback,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _placeholderCallback,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 18,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _placeholderCallback,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
