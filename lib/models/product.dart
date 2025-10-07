class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String category;
  final String subCategory;
  final String details;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.details,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['product_name'],
      imageUrl: 'assets/images/${json['image_url']}', 
      price: double.parse(json['price'].toString()),
      description: json['description'],
      category: json['category'],
      subCategory: json['sub_category'],
      details: json['details'] ?? '',
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': name,
      'image_url': imageUrl.split('/').last,
      'price': price,
      'description': description,
      'category': category,
      'sub_category': subCategory,
      'details': details,
    };
  }
}
