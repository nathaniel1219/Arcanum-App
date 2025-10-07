import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';


class ProductController with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  //pulls products from the ssp project (If offline it loads the json cache stuff)
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ProductService.fetchAllProducts();
    } catch (e) {
      _errorMessage = e.toString();
      _products = await ProductService.loadProductsFromCache();
    }

    _isLoading = false;
    notifyListeners();
  }
}
