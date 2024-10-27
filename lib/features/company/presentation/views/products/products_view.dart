import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/products_provider.riverpod.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsStream =
        ref.watch(productsProvider.notifier).getProductsStream();
    return StreamBuilder(
      stream: productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final products = snapshot.data;
          return GridViewProductsAll(
            products: products!,
            isPromocion: false,
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        ));
      },
    );
  }
}
