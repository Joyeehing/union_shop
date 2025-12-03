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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

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
                  // Center navigation - desktop view only
                  if (isDesktop)
                    Expanded(
                      child: Center(
                        child: ClipRect(
                          child: OverflowBox(
                            maxWidth: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _HoverButton(
                                  label: 'Home',
                                  isActive: widget.activePage == 'home',
                                  onPressed: () => _navigateToHome(context),
                                ),
                                const SizedBox(width: 12),
                                // Shop dropdown
                                _HoverDropdown(
                                  label: 'Shop',
                                  isActive: widget.activePage == 'shop',
                                  items: const [
                                    'Clothing',
                                    'Merchandise',
                                    'Signature & Essential Range',
                                    'Portsmouth City Collection',
                                    'Pride Collection🏳️‍🌈',
                                    'Graduation🎓',
                                  ],
                                  onSelected: (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('$value - Coming soon!')),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                // The Print Shack dropdown
                                _HoverDropdown(
                                  label: 'The Print Shack',
                                  isActive: widget.activePage == 'printshack',
                                  items: const [
                                    'About',
                                    'Personalisation',
                                  ],
                                  onSelected: (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('$value - Coming soon!')),
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _HoverButton(
                                  label: 'SALE!',
                                  isActive: widget.activePage == 'sale',
                                  onPressed: () => _navigateToSale(context),
                                ),
                                const SizedBox(width: 12),
                                _HoverButton(
                                  label: 'About',
                                  isActive: widget.activePage == 'about',
                                  onPressed: widget.activePage == 'about' ? null : () => _navigateToAbout(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  // Icons (right)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isDesktop) ...[
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
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
                      ],
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
                        onPressed: () => _openDrawer(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: Color(0xFF333333)),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToHome(context);
                },
              ),
              ExpansionTile(
                leading: const Icon(Icons.shopping_bag, color: Color(0xFF333333)),
                title: const Text('Shop'),
                children: [
                  'Clothing',
                  'Merchandise',
                  'Signature & Essential Range',
                  'Portsmouth City Collection',
                  'Pride Collection🏳️‍🌈',
                  'Graduation🎓',
                ].map((item) => ListTile(
                  title: Text(item),
                  contentPadding: const EdgeInsets.only(left: 72),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$item - Coming soon!')),
                    );
                  },
                )).toList(),
              ),
              ExpansionTile(
                leading: const Icon(Icons.print, color: Color(0xFF333333)),
                title: const Text('The Print Shack'),
                children: [
                  'About',
                  'Personalisation',
                ].map((item) => ListTile(
                  title: Text(item),
                  contentPadding: const EdgeInsets.only(left: 72),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$item - Coming soon!')),
                    );
                  },
                )).toList(),
              ),
              ListTile(
                leading: const Icon(Icons.local_offer, color: Color(0xFF333333)),
                title: const Text('SALE!'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToSale(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Color(0xFF333333)),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToAbout(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.search, color: Color(0xFF333333)),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  _placeholderCallback();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline, color: Color(0xFF333333)),
                title: const Text('Account'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF333333)),
                title: const Text('Cart'),
                onTap: () {
                  Navigator.pop(context);
                  _placeholderCallback();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Hover button widget for navigation items
class _HoverButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onPressed;

  const _HoverButton({
    required this.label,
    required this.isActive,
    this.onPressed,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: const Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            decoration: widget.isActive || _isHovered
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// Hover dropdown widget for navigation items with submenus
class _HoverDropdown extends StatefulWidget {
  final String label;
  final bool isActive;
  final List<String> items;
  final Function(String) onSelected;

  const _HoverDropdown({
    required this.label,
    required this.isActive,
    required this.items,
    required this.onSelected,
  });

  @override
  State<_HoverDropdown> createState() => _HoverDropdownState();
}

class _HoverDropdownState extends State<_HoverDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        onSelected: widget.onSelected,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: widget.isActive || _isHovered
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
        itemBuilder: (BuildContext context) => widget.items
            .map((item) => PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
      ),
    );
  }
}
