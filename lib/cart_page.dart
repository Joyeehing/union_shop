import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'services/cart_service.dart';
import 'models/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();

  void _updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      setState(() {
        item.quantity = newQuantity;
      });
      _cartService.updateQuantity(item.id, newQuantity);
    }
  }

  void _removeItem(String id) {
    _cartService.removeItem(id);
  }

  void _checkout() {
    if (_cartService.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your order has been placed successfully!'),
            const SizedBox(height: 16),
            Text(
              'Total: £${_cartService.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Items: ${_cartService.itemCount}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cartService.clear();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
                Header(activePage: 'cart', cartItemCount: _cartService.itemCount),
                
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 768;
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 80,
                        vertical: isMobile ? 24 : 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Page title
                          Text(
                            'Shopping Cart',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${_cartService.itemCount} ${_cartService.itemCount == 1 ? 'item' : 'items'}',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Cart items or empty state
                          _cartService.items.isEmpty
                              ? _buildEmptyCart(isMobile)
                              : Column(
                                  children: [
                                    // Cart items list
                                    ..._cartService.items.map((item) => 
                                      _buildCartItem(item, isMobile)
                                    ),
                                    
                                    const SizedBox(height: 40),
                                    
                                    // Cart summary
                                    _buildCartSummary(isMobile),
                                  ],
                                ),
                        ],
                      ),
                    );
                  },
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

  Widget _buildEmptyCart(bool isMobile) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: isMobile ? 80 : 120,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Add some products to get started!',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: const Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : 48,
                  vertical: isMobile ? 14 : 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'CONTINUE SHOPPING',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItemImage(item, isMobile),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildItemDetails(item, isMobile),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuantityControls(item, isMobile),
                    _buildItemPrice(item, isMobile),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemImage(item, isMobile),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildItemDetails(item, isMobile),
                ),
                const SizedBox(width: 20),
                _buildQuantityControls(item, isMobile),
                const SizedBox(width: 20),
                _buildItemPrice(item, isMobile),
              ],
            ),
    );
  }

  Widget _buildItemImage(CartItem item, bool isMobile) {
    return Container(
      width: isMobile ? 80 : 120,
      height: isMobile ? 80 : 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: item.imageUrl.isNotEmpty
          ? Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            )
          : Container(
              color: Colors.grey[200],
              child: const Icon(Icons.image, color: Colors.grey),
            ),
    );
  }

  Widget _buildItemDetails(CartItem item, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Size: ${item.size}',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            color: const Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Color: ${item.color}',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            color: const Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () => _removeItem(item.id),
          icon: const Icon(Icons.delete_outline, size: 18),
          label: const Text('Remove'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityControls(CartItem item, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _updateQuantity(item, item.quantity - 1),
          style: IconButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${item.quantity}',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _updateQuantity(item, item.quantity + 1),
          style: IconButton.styleFrom(
            side: BorderSide(color: Colors.grey[300]!),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  Widget _buildItemPrice(CartItem item, bool isMobile) {
    final lineTotal = item.price * item.quantity;
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        Text(
          '£${lineTotal.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4d2963),
          ),
        ),
        if (item.quantity > 1) ...[
          const SizedBox(height: 4),
          Text(
            '£${item.price.toStringAsFixed(2)} each',
            style: TextStyle(
              fontSize: isMobile ? 12 : 13,
              color: const Color(0xFF999999),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCartSummary(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                '£${_cartService.total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              Text(
                '£${_cartService.total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4d2963),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Checkout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Continue shopping button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4d2963),
                side: const BorderSide(color: Color(0xFF4d2963)),
                padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'CONTINUE SHOPPING',
                style: TextStyle(
                  fontSize: isMobile ? 15 : 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
