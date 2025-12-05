import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'sale_page.dart';
import 'services/cart_service.dart';
import 'models/cart_item.dart';

class SaleDetailPage extends StatefulWidget {
  final SaleItem item;

  const SaleDetailPage({super.key, required this.item});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  int _quantity = 1;
  String _selectedColor = 'Grey';
  String _selectedSize = 'M';
  final CartService _cartService = CartService();

  final List<String> _colors = ['Grey', 'Navy', 'Black', 'Purple'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    final cartItem = CartItem(
      id: '${widget.item.id}-$_selectedSize-$_selectedColor',
      name: widget.item.name,
      imageUrl: widget.item.imageUrl ?? '',
      price: widget.item.salePrice,
      size: _selectedSize,
      color: _selectedColor,
      quantity: _quantity,
    );

    _cartService.addItem(cartItem, id: '${widget.item.id}-$_selectedSize-$_selectedColor');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity × ${widget.item.name} to cart'),
        backgroundColor: const Color(0xFF4d2963),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart page (to be implemented)
          },
        ),
      ),
    );

    // Reset quantity after adding
    setState(() {
      _quantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListenableBuilder(
        listenable: _cartService,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Header(activePage: 'sale', cartItemCount: _cartService.itemCount),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    // Desktop layout - image on left, details on right
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Expanded(
                          flex: 1,
                          child: _buildProductImage(),
                        ),
                        const SizedBox(width: 60),
                        // Product details
                        Expanded(
                          flex: 1,
                          child: _buildProductDetails(context),
                        ),
                      ],
                    );
                  } else {
                    // Mobile layout - stacked
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductImage(),
                        const SizedBox(height: 30),
                        _buildProductDetails(context),
                      ],
                    );
                  }
                },
              ),
            ),
            
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.grey[200],
      ),
      child: widget.item.imageUrl != null
          ? (widget.item.imageUrl!.startsWith('assets/')
              ? Image.asset(
                  widget.item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image, size: 150, color: Colors.grey),
                    );
                  },
                )
              : Image.network(
                  widget.item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image, size: 150, color: Colors.grey),
                    );
                  },
                ))
          : const Center(
              child: Icon(Icons.image, size: 150, color: Colors.grey),
            ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product name
        Text(
          widget.item.name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 20),
        
        // Prices - show original with strikethrough and sale price
        Row(
          children: [
            // Sale price
            Text(
              '£${widget.item.salePrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 12),
            // Original price with strikethrough
            Text(
              '£${widget.item.originalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 12),
            // Discount badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SAVE ${widget.item.discountPercentage.round()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // In Stock indicator
        const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 18),
            SizedBox(width: 6),
            Text(
              'In Stock',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Size selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Size',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _sizes.map((size) {
                final isSelected = _selectedSize == size;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSize = size;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4d2963) : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: isSelected ? const Color(0xFF4d2963).withValues(alpha: 0.05) : Colors.white,
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF4d2963) : const Color(0xFF333333),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Color selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.map((color) {
                final isSelected = _selectedColor == color;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4d2963) : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: isSelected ? const Color(0xFF4d2963).withValues(alpha: 0.05) : Colors.white,
                    ),
                    child: Text(
                      color,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? const Color(0xFF4d2963) : const Color(0xFF333333),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Quantity selector
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementQuantity,
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementQuantity,
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'ADD TO CART',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        
        const SizedBox(height: 32),
        
        // Description
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.item.description.isNotEmpty 
              ? widget.item.description 
              : 'High-quality university branded hoodie made from premium cotton blend. Perfect for staying warm on campus or showing your university pride.',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
