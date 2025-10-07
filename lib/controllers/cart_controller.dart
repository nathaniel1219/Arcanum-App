import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      final price = (item['price'] is int)
          ? (item['price'] as int).toDouble()
          : (item['price'] ?? 0.0) as double;
      final quantity = (item['quantity'] ?? 1) as int;
      total += price * quantity;
    }
    return total;
  }

  // uses the local storage` to load stuff in the cart with shareed preferences
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCart = prefs.getString('cart');
    if (savedCart != null) {
      _cartItems = List<Map<String, dynamic>>.from(json.decode(savedCart));
    }
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', json.encode(_cartItems));
  }

 
  void addToCart(Map<String, dynamic> product) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item['product_id'] == product['product_id'],
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex]['quantity'] =
          (_cartItems[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      _cartItems.add({
        'product_id': product['product_id'],
        'product_name': product['product_name'],
        'price': product['price'],
        'image_url': product['image_url'],
        'quantity': 1,
      });
    }
    _saveCart();
    notifyListeners();
  }

  
  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item['product_id'] == productId);
    _saveCart();
    notifyListeners();
  }

  
  void clearCart() {
    _cartItems.clear();
    _saveCart();
    notifyListeners();
  }

  
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index]['quantity'] = newQuantity;

      // Save updated cart
      _saveCart();
      notifyListeners();
    }
  }
}
