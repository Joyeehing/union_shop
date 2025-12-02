import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/footer.dart';
import 'sale_detail_page.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Featured';

  List<SaleItem> get filteredAndSortedItems {
    List<SaleItem> items = List.from(saleItems);

    // Apply filter
    if (_selectedFilter != 'All') {
      items = items.where((item) {
        switch (_selectedFilter) {
          case 'Under £15':
            return item.salePrice < 15;
          case '£15 - £30':
            return item.salePrice >= 15 && item.salePrice <= 30;
          case 'Over £30':
            return item.salePrice > 30;
          case '20% Off or More':
            return item.discountPercentage >= 20;
          case '30% Off or More':
            return item.discountPercentage >= 30;
          default:
            return true;
        }
      }).toList();
    }

    // Apply sort
    switch (_selectedSort) {
      case 'Price: Low to High':
        items.sort((a, b) => a.salePrice.compareTo(b.salePrice));
        break;
      case 'Price: High to Low':
        items.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      case 'Discount: High to Low':
        items.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
        break;
      case 'Name: A to Z':
        items.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name: Z to A':
        items.sort((a, b) => b.name.compareTo(a.name));
        break;
      default:
        // Featured - keep original order
        break;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(activePage: 'sale'),
            
            // Page Title
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 80),
              child: const Text(
                'SALE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  letterSpacing: 2,
                ),
              ),
            ),

            // Filter and Sort Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                children: [
                  _buildFilterDropdown(),
                  const SizedBox(width: 16),
                  _buildSortDropdown(),
                  const Spacer(),
                  Text(
                    '${filteredAndSortedItems.length} Products',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sale Items Grid
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
                  
                  final items = filteredAndSortedItems;
                  
                  if (items.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'No items match your filters',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    );
                  }
                  
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildSaleItem(context, item);
                    },
                  );
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

  Widget _buildFilterDropdown() {
    return Row(
      children: [
        const Text(
          'Filter By:',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: _selectedFilter,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            isExpanded: false,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
            ),
            items: const [
              DropdownMenuItem(value: 'All', child: Text('All')),
              DropdownMenuItem(value: 'Under £15', child: Text('Under £15')),
              DropdownMenuItem(value: '£15 - £30', child: Text('£15 - £30')),
              DropdownMenuItem(value: 'Over £30', child: Text('Over £30')),
              DropdownMenuItem(value: '20% Off or More', child: Text('20% Off or More')),
              DropdownMenuItem(value: '30% Off or More', child: Text('30% Off or More')),
            ],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFilter = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    return Row(
      children: [
        const Text(
          'Sort By:',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: _selectedSort,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            isExpanded: false,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
            ),
            items: const [
              DropdownMenuItem(value: 'Featured', child: Text('Featured')),
              DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
              DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
              DropdownMenuItem(value: 'Discount: High to Low', child: Text('Discount: High to Low')),
              DropdownMenuItem(value: 'Name: A to Z', child: Text('Name: A to Z')),
              DropdownMenuItem(value: 'Name: Z to A', child: Text('Name: Z to A')),
            ],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedSort = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaleItem(BuildContext context, SaleItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaleDetailPage(item: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: item.imageUrl != null
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image, size: 80, color: Colors.grey),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '£${item.salePrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4d2963),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '£${item.originalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Save ${item.discountPercentage}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sale Item Model
class SaleItem {
  final String id;
  final String name;
  final double originalPrice;
  final double salePrice;
  final String? imageUrl;
  final String description;
  
  int get discountPercentage => 
    (((originalPrice - salePrice) / originalPrice) * 100).round();

  SaleItem({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.salePrice,
    this.imageUrl,
    this.description = '',
  });
}

// Sample sale items data
final List<SaleItem> saleItems = [
  SaleItem(
    id: '1',
    name: 'University Hoodie',
    originalPrice: 35.00,
    salePrice: 24.99,
    description: 'Comfortable cotton hoodie with university logo',
  ),
  SaleItem(
    id: '2',
    name: 'Student Backpack',
    originalPrice: 45.00,
    salePrice: 29.99,
    description: 'Spacious backpack perfect for students',
  ),
  SaleItem(
    id: '3',
    name: 'Campus T-Shirt',
    originalPrice: 18.00,
    salePrice: 12.99,
    description: 'Classic campus t-shirt in various colors',
  ),
  SaleItem(
    id: '4',
    name: 'Notebook Set',
    originalPrice: 15.00,
    salePrice: 9.99,
    description: 'Set of 3 premium notebooks',
  ),
  SaleItem(
    id: '5',
    name: 'Water Bottle',
    originalPrice: 12.00,
    salePrice: 7.99,
    description: 'Reusable stainless steel water bottle',
  ),
  SaleItem(
    id: '6',
    name: 'Varsity Jacket',
    originalPrice: 65.00,
    salePrice: 45.99,
    description: 'Classic varsity jacket with embroidered logo',
  ),
  SaleItem(
    id: '7',
    name: 'Laptop Sleeve',
    originalPrice: 25.00,
    salePrice: 16.99,
    description: 'Protective laptop sleeve for 13-15 inch laptops',
  ),
  SaleItem(
    id: '8',
    name: 'Baseball Cap',
    originalPrice: 20.00,
    salePrice: 13.99,
    description: 'Adjustable baseball cap with university branding',
  ),
];
