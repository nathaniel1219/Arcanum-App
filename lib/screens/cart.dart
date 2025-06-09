// lib/screens/cart.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final Product? addedProduct;

  const CartScreen({super.key, this.addedProduct});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ||
        (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    // Build initial placeholder items
    final List<Map<String, dynamic>> cartItems = [
      {
        'image': 'assets/images/20_icespice.png',
        'name': '2pcs Rectangle Plastic Frame Mirror...',
        'variant': 'Black And White / One Size',
        'originalPrice': 1088.74,
        'discountedPrice': 882.36,
        'quantity': 2,
      },
      {
        'image': 'assets/images/21_nezuko.png',
        'name': '1 Set Ukulele Strings, Colorful Nylon...',
        'variant': 'Nylon',
        'originalPrice': 559.32,
        'discountedPrice': 475.58,
        'quantity': 2,
      },
    ];

    // Add the passed product
    if (addedProduct != null) {
      cartItems.add({
        'image': addedProduct!.imageUrl,
        'name': addedProduct!.name,
        'variant': 'Default Variant',
        'originalPrice': addedProduct!.price,
        'discountedPrice': addedProduct!.price,
        'quantity': 1,
      });
    }

    final double total = cartItems.fold(
      0,
      (sum, item) => sum + item['discountedPrice'] * item['quantity'],
    );

    // Use the theme's cardColor for the checkout summary background
    final checkoutBg = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 180),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['variant'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'LKR ${item['discountedPrice'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'LKR ${item['originalPrice'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                  constraints: BoxConstraints.tight(Size(36, 36)),
                                  padding: EdgeInsets.zero,
                                ),
                                Text(
                                  '${item['quantity']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                  constraints: BoxConstraints.tight(Size(36, 36)),
                                  padding: EdgeInsets.zero,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                  constraints: BoxConstraints.tight(Size(36, 36)),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Checkout summary
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: checkoutBg,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text('Total:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                      const Spacer(),
                      Text('LKR ${total.toStringAsFixed(2)}', style: TextStyle(color: Colors.red, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Products have been checked out!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBD59),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'cart'),
    );
  }
}
