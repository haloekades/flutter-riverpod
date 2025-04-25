import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../domain/product.dart';

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse('https://mocki.io/v1/1f4b5157-b88d-41d3-9caa-331c679a87ef'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

final productRefreshProvider = Provider<Future<void> Function(WidgetRef)>((ref) {
  return (WidgetRef innerRef) async {
    innerRef.invalidate(productListProvider);
  };
});