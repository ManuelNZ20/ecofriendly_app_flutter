import 'package:ecofriendly_app/config/router/app_router.dart';
import 'package:ecofriendly_app/features/company/presentation/providers/products_provider.riverpod.dart';
import 'package:ecofriendly_app/features/company/presentation/screens/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/shared/shared.dart';
import '../../widgets/grid_view_products_all.dart';

class ProductsScreen extends ConsumerWidget {
  static const String name = 'products_screen';
  const ProductsScreen({
    super.key,
    required this.idInventory,
  });
  final int idInventory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider.notifier).getProductsStream();

    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Productos'),
        actions: const [
          SizedBox(width: 5),
          Icon(
            Icons.store,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        child: StreamBuilder(
          stream: products,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final products = snapshot.data;
              return GridViewProductsAll(
                products: products!,
                isPromocion: false,
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Sin productos'),
              );
            }
            return const Center(
              child: Text('Cargando...'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          ProductCompanyScreen.name,
          pathParameters: {
            'id_product': 'new',
            'id_inventory': idInventory.toString(),
          },
          extra: {
            'id_data': idInventory,
          },
        ),
        label: const Text('Producto'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
