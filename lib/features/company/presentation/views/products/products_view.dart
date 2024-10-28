import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/products_provider.riverpod.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsByCompanyProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(productsByCompanyProvider);
      },
      child: products.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No tiene productos'),
            );
          }
          final products = data;
          return GridViewProductsAll(
            products: products,
            isPromocion: false,
            isFavorite: true,
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text('Se presento el siguiente error $error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }
}
