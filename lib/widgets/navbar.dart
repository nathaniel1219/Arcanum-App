// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/theme.dart';
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
    // Determine current brightness from ThemeProvider
    final isDark = Provider.of<ThemeProvider>(context).themeMode ==
        ThemeMode.dark ||
        (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.system &&
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    final bgColor = isDark ? Colors.black : Colors.white;
    final selectedColor = const Color(0xFFFFBD59);
    final unselectedColor = isDark ? Colors.grey.shade400 : Colors.grey;

    double iconSize(String page) => currentPage == page ? 32 : 24;
    Color iconColor(String page) =>
        currentPage == page ? selectedColor : unselectedColor;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: iconSize('home'),
            icon: Icon(Icons.home, color: iconColor('home')),
            onPressed: () {
              if (currentPage != 'home') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: iconSize('tcg'),
            icon: Icon(Icons.style, color: iconColor('tcg')),
            onPressed: () {
              if (currentPage != 'tcg') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => TcgScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: iconSize('collectibles'),
            icon: Icon(Icons.collections, color: iconColor('collectibles')),
            onPressed: () {
              if (currentPage != 'collectibles') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => CollectiblesScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: iconSize('cart'),
            icon: Icon(Icons.shopping_cart, color: iconColor('cart')),
            onPressed: () {
              if (currentPage != 'cart') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              }
            },
          ),
          IconButton(
            iconSize: iconSize('profile'),
            icon: Icon(Icons.person, color: iconColor('profile')),
            onPressed: () {
              if (currentPage != 'profile') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
