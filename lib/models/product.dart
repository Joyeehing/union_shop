class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> sizes;
  final List<String> colors;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sizes,
    required this.colors,
    this.inStock = true,
  });
}

// Mock product data
class ProductService {
  static Product getProductById(String id) {
    // For demo, return a sample product
    return Product(
      id: '1',
      name: 'University Hoodie',
      description:
          'High-quality university branded hoodie made from premium cotton blend. Perfect for staying warm on campus or showing your university pride.',
      price: 35.00,
      imageUrl:
          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      colors: ['Navy', 'Grey', 'Black', 'Purple'],
      inStock: true,
    );
  }
}
