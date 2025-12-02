import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'sale_page.dart';

class SaleDetailPage extends StatefulWidget {
  final SaleItem item;

  const SaleDetailPage({super.key, required this.item});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  int _quantity = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(activePage: 'sale'),
            
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
          ? Image.network(
              widget.item.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.image, size: 150, color: Colors.grey),
                );
              },
            )
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
        
        // Sale badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'SAVE ${widget.item.discountPercentage}%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Prices
        Row(
          children: [
            Text(
              '£${widget.item.salePrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '£${widget.item.originalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        
        // Description
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.item.description.isNotEmpty 
              ? widget.item.description 
              : 'High quality product on sale. Limited time offer!',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        
        // Quantity selector
        Row(
          children: [
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementQuantity,
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    constraints: const BoxConstraints(minWidth: 40),
                    child: Text(
                      '$_quantity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementQuantity,
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$_quantity x ${widget.item.name} added to cart!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
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
        const SizedBox(height: 16),
        
        // Back to sale button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4d2963),
              side: const BorderSide(color: Color(0xFF4d2963)),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'BACK TO SALE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
