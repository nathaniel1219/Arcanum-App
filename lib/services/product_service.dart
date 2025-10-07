import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../db/sqflite_helper.dart';

class ProductService {
  static const String baseUrl =
      'https://arcanumweb-production.up.railway.app/api';
  /* 'http://127.0.0.1:8000/api'; */ //only use this link if the online site doesnt work

  // Fetch all products with caching and SQLite integration
  static Future<List<Product>> fetchAllProducts({
    bool updateCache = true,
  }) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((item) => Product.fromJson(item)).toList();

        if (updateCache) {
          await saveProductsToCache(products);
          print('Products fetched from online and cached locally.');

          // Save products to SQLite database
          final db = SQFLiteHelper();
          await db.clearProducts(); 
          for (var product in products) {
            await db.insertProduct(product.toJson());
          }
          print('Products saved to SQLite database.');
        }

        return products;
      } else {
        print('Failed to load products online: ${response.statusCode}');
        final cachedProducts = await loadProductsFromCache();
        if (cachedProducts.isNotEmpty) {
          print(
            'Loaded ${cachedProducts.length} products from local cache.',
          );
          return cachedProducts;
        } else {
          throw Exception('No cached products available.');
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
      final cachedProducts = await loadProductsFromCache();
      if (cachedProducts.isNotEmpty) {
        print('Loaded ${cachedProducts.length} products from local cache.');
        return cachedProducts;
      } else {
        throw Exception('No cached products available.');
      }
    }
  }

  // Fetch products by subcategory
  static Future<List<Product>> fetchByCategory(
    String subCategory, {
    String? token,
  }) async {
    final endpoint =
        subCategory.toLowerCase() == 'pokemon'
            ? 'products/pokemon'
            : subCategory.toLowerCase() == 'ygo'
            ? 'products/ygo'
            : 'products/funko';

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception(
        'Failed to load $subCategory products: ${response.statusCode}',
      );
    }
  }

  // Get local file for cached products
  static Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/products_cache.json');
  }

  // Save products list to JSON file
  static Future<void> saveProductsToCache(List<Product> products) async {
    final file = await _getLocalFile();
    final jsonList =
        products.map((p) => p.toJson()).toList();
    await file.writeAsString(
      json.encode(jsonList),
    ); 
    print('Products cached locally at ${file.path}');
  }

  // Load products from cached JSON file
  static Future<List<Product>> loadProductsFromCache() async {
    try {
      final file = await _getLocalFile();
      if (!await file.exists()) {
        print('No cache file found.');
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> data = json.decode(contents);
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('Error loading cached products: $e');
      return [];
    }
  }
}
