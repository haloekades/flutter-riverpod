import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterriverpod/features/home/data/product_repository.dart';
import '../domain/product.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.fetchProducts();
});

final productRefreshProvider = Provider<Future<void> Function(WidgetRef)>((ref) {
  return (WidgetRef innerRef) async {
    innerRef.invalidate(productListProvider);
  };
});