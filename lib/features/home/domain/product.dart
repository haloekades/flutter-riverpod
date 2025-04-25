class Product {
  final String name;
  final double price;
  final String urlImage;

  Product({required this.name, required this.price, required this.urlImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      urlImage: json['url_image'] ?? '',
    );
  }
}