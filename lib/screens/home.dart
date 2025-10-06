import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart';
import '../widgets/product_card.dart';
import '../widgets/navbar.dart';
import '../controllers/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Use ProductController from Provider
    final productController = Provider.of<ProductController>(context);

    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final isPortrait = media.orientation == Orientation.portrait;

    int crossAxisCount;
    if (isPortrait && screenWidth < 600) {
      crossAxisCount = 1;
    } else if (screenWidth >= 900) {
      crossAxisCount = 4;
    } else if (screenWidth >= 600) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Builder(
        builder: (_) {
          if (productController.isLoading) {
            // ✅ Show loading spinner while fetching
            return const Center(child: CircularProgressIndicator());
          } else if (productController.errorMessage != null &&
              productController.products.isEmpty) {
            // ✅ Show error if no cached products
            return Center(
              child: Text(
                'Error: ${productController.errorMessage}\nNo cached products available.',
              ),
            );
          } else if (productController.products.isEmpty) {
            // ✅ No products at all
            return const Center(child: Text('No products found.'));
          }

          final products = productController.products;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
    );
  }
}
