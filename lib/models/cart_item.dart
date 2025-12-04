class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String size;
  final String color;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.color,
    this.quantity = 1,
  });
}
