// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/tcg.dart';
import '../screens/collectibles.dart';
import '../screens/cart.dart'; 
import '../screens/profile.dart'; 

class CustomNavBar extends StatelessWidget {
  final String currentPage;

  const CustomNavBar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    // Determine icon size and color based on current page
    double getIconSize(String page) => currentPage == page ? 32 : 24;
    Color getIconColor(String page) => currentPage == page ? const Color(0xFFFFBD59) : Colors.black;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: getIconSize('home'),
            icon: Icon(Icons.home, color: getIconColor('home')), // Use dynamic color
            onPressed: () {
              if (currentPage != 'home') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: getIconSize('tcg'),
            icon: Icon(Icons.style, color: getIconColor('tcg')), // Use dynamic color
            onPressed: () {
              if (currentPage != 'tcg') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TcgScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: getIconSize('collectibles'),
            icon: Icon(Icons.collections, color: getIconColor('collectibles')), // Use dynamic color
            onPressed: () {
              if (currentPage != 'collectibles') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CollectiblesScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: getIconSize('cart'),
            icon: Icon(Icons.shopping_cart, color: getIconColor('cart')), // Use dynamic color
            onPressed: () {
              if (currentPage != 'cart') { // Add navigation logic for CartScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: getIconSize('profile'),
            icon: Icon(Icons.person, color: getIconColor('profile')), // Use dynamic color
            onPressed: () {
              if (currentPage != 'profile') { // Add navigation logic for ProfileScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}