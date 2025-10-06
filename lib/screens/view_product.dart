import 'package:arcanum/widgets/appbar.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/navbar.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class ViewProductScreen extends StatelessWidget {
  final Product product;

  const ViewProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const Color peachColor = Color(0xFFFFBD59);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                product.imageUrl,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'LKR ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: ''),
    );
  }
}
