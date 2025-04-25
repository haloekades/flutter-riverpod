import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/product_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final refreshProducts = ref.read(productRefreshProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(ref),
        child: products.when(
          data: (items) => ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading: Image.network(
                  items[index].urlImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, stack) => const Icon(Icons.image_not_supported),
                ),
                title: Text(items[index].name),
                subtitle: Text('\$${items[index].price.toStringAsFixed(2)}'),
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
