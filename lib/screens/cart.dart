import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';

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

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: cartController.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartController.cartItems[index];
                return ListTile(
                  leading: Image.network(item['image_url'] ?? '', width: 50),
                  title: Text(item['product_name'] ?? 'Unknown'),
                  subtitle: Text('LKR ${(item['price']).toStringAsFixed(2)}'),
                  trailing: Text('x${item['quantity']}'),
                );
              },
            ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'cart'),
    );
  }
}
