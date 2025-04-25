import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://mocki.io/v1/1f4b5157-b88d-41d3-9caa-331c679a87ef'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}