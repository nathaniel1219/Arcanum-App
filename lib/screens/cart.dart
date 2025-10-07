// lib/screens/cart.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../controllers/cart_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../models/theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartController>(context, listen: false).loadCart();
  }

  // current location
  Future<String> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

   
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions are permanently denied.';
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      return '${place.street}, ${place.locality}, ${place.country}';
    } else {
      return 'Unable to retrieve address.';
    }
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        width: 50,
        height: 50,
        color: Colors.grey.shade300,
        child: const Icon(Icons.image_not_supported),
      );
    }
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => Container(
          width: 50,
          height: 50,
          color: Colors.grey.shade300,
          child: const Icon(Icons.broken_image),
        ),
      );
    }
    return Image.asset(
      imagePath,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => Container(
        width: 50,
        height: 50,
        color: Colors.grey.shade300,
        child: const Icon(Icons.broken_image),
      ),
    );
  }

  double _parsePrice(dynamic p) {
    if (p == null) return 0.0;
    if (p is num) return p.toDouble();
    return double.tryParse(p.toString()) ?? 0.0;
  }

  int _parseQuantity(dynamic q) {
    if (q == null) return 1;
    if (q is int) return q;
    return int.tryParse(q.toString()) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    final isDark = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ||
        (Provider.of<ThemeProvider>(context).themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    final checkoutBg = Theme.of(context).cardColor;
    final textColor = isDark ? Colors.white : Colors.black;

    final cartItems = cartController.cartItems;
    final total = cartController.totalPrice;

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: const CustomAppBar(),
        body: const Center(child: Text('Your cart is empty.')),
        bottomNavigationBar: const CustomNavBar(currentPage: 'cart'),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 180),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final productName = (item['product_name'] ?? 'Unknown Product').toString();
              final imageUrl = item['image_url']?.toString();
              final quantity = _parseQuantity(item['quantity']);
              final price = _parsePrice(item['price']);
              final productId = item['product_id'];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildImage(imageUrl),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'LKR ${price.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      cartController.updateQuantity(index, quantity - 1);
                                    } else {
                                      cartController.removeFromCart(productId);
                                    }
                                  },
                                ),
                                Text('$quantity', style: const TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: Colors.grey),
                                  onPressed: () {
                                    cartController.updateQuantity(index, quantity + 1);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () {
                                    cartController.removeFromCart(productId);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: checkoutBg,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'LKR ${total.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Fetching your location...')),
                        );

                        String address = await _getCurrentLocation();

                        if (!mounted) return;

                        cartController.clearCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Delivering to: $address'),
                            duration: const Duration(seconds: 6),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBD59),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'cart'),
    );
  }
}
