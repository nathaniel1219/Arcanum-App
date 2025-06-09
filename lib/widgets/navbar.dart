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
    final provider = Provider.of<ThemeProvider>(context);
    final isDark = provider.themeMode == ThemeMode.dark ||
        (provider.themeMode == ThemeMode.system &&
         MediaQuery.of(context).platformBrightness == Brightness.dark);

    final bgColor = isDark ? Colors.black : Colors.white;
    final selectedColor = const Color(0xFFFFBD59);
    final unselectedColor = isDark ? Colors.grey.shade400 : Colors.grey;

    Widget navItem(String page, IconData iconData, String label, Widget screen) {
      final bool selected = currentPage == page;
      final color = selected ? selectedColor : unselectedColor;
      final size = selected ? 32.0 : 24.0;

      return InkWell(
        onTap: () {
          if (!selected) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: color, size: size),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      );
    }

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem('home', Icons.home, 'Home', HomeScreen()),
          navItem('tcg', Icons.catching_pokemon, 'TCG', TcgScreen()),
          navItem('collectibles', Icons.toys, 'Collectibles', CollectiblesScreen()),
          navItem('cart', Icons.shopping_cart, 'Cart', const CartScreen()),
          navItem('profile', Icons.person, 'Profile', const ProfileScreen()),
        ],
      ),
    );
  }
}
