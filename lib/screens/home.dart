import 'package:arcanum/widgets/appbar.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/navbar.dart';
import '../models/product_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = [
    ...ProductList.tcg,
    ...ProductList.collectibles,
  ]..shuffle();

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
      appBar: const CustomAppBar(),
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
      bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
    );
  }
}