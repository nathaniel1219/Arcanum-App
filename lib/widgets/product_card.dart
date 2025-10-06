import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/view_product.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const double buttonFont = 13.0;
    const Color peachColor = Color(0xFFFFBD59);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(product.imageUrl, fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'LKR ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                //Navigates to view the product details
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewProductScreen(product: product),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(
                        color: peachColor,
                        fontSize: buttonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                //Adds the product object to the card
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final cart = Provider.of<CartController>(
                        context,
                        listen: false,
                      );
                      cart.addToCart({
                        'product_id': product.id,
                        'product_name': product.name,
                        'price': product.price,
                        'image_url': product.imageUrl,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart!')),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: peachColor,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: buttonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
