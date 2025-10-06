import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/appbar.dart';
import '../widgets/product_card.dart';
import '../widgets/navbar.dart';
import '../controllers/product_controller.dart';

class CollectiblesScreen extends StatelessWidget {
  const CollectiblesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    final media = MediaQuery.of(context);
    final isPortrait = media.orientation == Orientation.portrait;
    final screenWidth = media.size.width;

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

    // ✅ Filter products by Figures category
    final products =
        productController.products.where((p) => p.category == 'Figures').toList();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Builder(
        builder: (_) {
          if (productController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productController.errorMessage != null && products.isEmpty) {
            return Center(
              child: Text(
                'Error: ${productController.errorMessage}\nNo cached products available.',
              ),
            );
          } else if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

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
      bottomNavigationBar: const CustomNavBar(currentPage: 'collectibles'),
    );
  }
}
