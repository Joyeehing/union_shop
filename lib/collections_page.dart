import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(activePage: 'collections'),
            
            // Collections content
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 80,
                    vertical: isMobile ? 24 : 60,
                  ),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        'Our Collections',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Explore our curated collections',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          color: const Color(0xFF666666),
                        ),
                      ),
                      SizedBox(height: isMobile ? 24 : 40),
                  
                      // Collections Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth > 900 ? 3 : 
                                              constraints.maxWidth > 600 ? 2 : 1;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: collections.length,
                            itemBuilder: (context, index) {
                              final collection = collections[index];
                              return _CollectionCard(
                                title: collection['title']!,
                                description: collection['description']!,
                                imageUrl: collection['imageUrl']!,
                                route: collection['route']!,
                              );
                            },
                          );
                        },
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
}

class _CollectionCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String route;

  const _CollectionCard({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.route,
  });

  @override
  State<_CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<_CollectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.route);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.collections,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                      if (_isHovered)
                        Container(
                          color: const Color(0xFF4d2963).withValues(alpha: 0.2),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Shop Now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4d2963),
                              decoration: _isHovered ? TextDecoration.underline : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF4d2963),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Collections data
final List<Map<String, String>> collections = [
  {
    'title': 'Sale Items',
    'description': 'Big discounts on our essential range - over 20% off!',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
    'route': '/sale',
  },
  {
    'title': 'New Arrivals',
    'description': 'Check out our latest products and fresh designs',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/products/Navy-Hoodie-Front_1024x1024@2x.jpg?v=1614735854',
    'route': '/',
  },
  {
    'title': 'Clothing',
    'description': 'Hoodies, t-shirts, and more university branded apparel',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/products/Black-Tshirt-Front_1024x1024@2x.jpg?v=1614735854',
    'route': '/',
  },
  {
    'title': 'Merchandise',
    'description': 'Mugs, bags, stationery and other branded items',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/products/Mug_1024x1024@2x.jpg?v=1614735854',
    'route': '/',
  },
  {
    'title': 'Pride Collection 🏳️‍🌈',
    'description': 'Show your pride with our rainbow collection',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/products/Pride-Hoodie_1024x1024@2x.jpg?v=1614735854',
    'route': '/',
  },
  {
    'title': 'Graduation 🎓',
    'description': 'Celebrate your achievement with graduation gifts',
    'imageUrl': 'https://shop.upsu.net/cdn/shop/products/Graduation-Bear_1024x1024@2x.jpg?v=1614735854',
    'route': '/',
  },
];
