import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = List.generate(
    27,
    (index) => Product(
      name: 'Scarlet & Violet Booster Box ${index + 1}',
      description: 'Booster Display Box (36 Packs)',
      imageUrl: 'assets/images/24_gojo.png', // Use your actual image names
      price: 48165.65,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/ARCANUM.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth >= 900) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Color(0xFFFFBD59)), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.style, color: Color(0xFFFFBD59)), label: 'TCG'),
          BottomNavigationBarItem(icon: Icon(Icons.collections, color: Color(0xFFFFBD59)), label: 'Collectibles'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Color(0xFFFFBD59)), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Color(0xFFFFBD59)), label: 'Profile'),
        ],
      ),
    );
  }
}
