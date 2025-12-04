import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'models/product.dart';
import 'models/cart_item.dart';
import 'services/cart_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Product _product;
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _product = ProductService.getProductById('1');
    _selectedSize = _product.sizes.isNotEmpty ? _product.sizes[0] : null;
    _selectedColor = _product.colors.isNotEmpty ? _product.colors[0] : null;
  }

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
    if (_selectedSize == null || _selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select size and color'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final cartItem = CartItem(
      id: _product.id,
      name: _product.name,
      imageUrl: _product.imageUrl,
      price: _product.price,
      size: _selectedSize!,
      color: _selectedColor!,
      quantity: _quantity,
    );

    _cartService.addItem(cartItem, id: '');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity × ${_product.name} to cart'),
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
              // Header with cart badge
              _buildHeader(context),

              // Product details
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 768;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 80,
                        vertical: isMobile ? 24 : 48,
                      ),
                      child: isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildProductImage(isMobile),
                                const SizedBox(height: 24),
                                _buildProductDetails(isMobile),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildProductImage(isMobile),
                                ),
                                const SizedBox(width: 48),
                                Expanded(
                                  flex: 1,
                                  child: _buildProductDetails(isMobile),
                                ),
                              ],
                            ),
                    );
                  },
                ),

                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Header(
      activePage: '',
      cartItemCount: _cartService.itemCount,
    );
  }

  Widget _buildProductImage(bool isMobile) {
    return Container(
      height: isMobile ? 300 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          _product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product name
        Text(
          _product.name,
          style: TextStyle(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),

        // Product price
        Text(
          '£${_product.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 8),

        // Stock status
        Row(
          children: [
            Icon(
              _product.inStock ? Icons.check_circle : Icons.cancel,
              size: 16,
              color: _product.inStock ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              _product.inStock ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                color: _product.inStock ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Size selector
        Text(
          'Size',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _product.sizes.map((size) {
            final isSelected = size == _selectedSize;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4d2963) : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected ? const Color(0xFF4d2963).withValues(alpha: 0.1) : Colors.white,
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? const Color(0xFF4d2963) : const Color(0xFF333333),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Color selector
        Text(
          'Color',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _product.colors.map((color) {
            final isSelected = color == _selectedColor;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4d2963) : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected ? const Color(0xFF4d2963).withValues(alpha: 0.1) : Colors.white,
                ),
                child: Text(
                  color,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? const Color(0xFF4d2963) : const Color(0xFF333333),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Quantity selector
        Text(
          'Quantity',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: _decrementQuantity,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '$_quantity',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: _incrementQuantity,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _product.inStock ? _addToCart : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 14 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              _product.inStock ? 'ADD TO CART' : 'OUT OF STOCK',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Product description
        Text(
          'Description',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _product.description,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: const Color(0xFF666666),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
