import 'package:arcanum/models/product_list.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/navbar.dart'; 

class CollectiblesScreen extends StatelessWidget {
  CollectiblesScreen({super.key});

  final List<Product> products = [
    ...ProductList.collectibles,
  ];

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/ARCANUM.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
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
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'collectibles'),
    );
  }
}
