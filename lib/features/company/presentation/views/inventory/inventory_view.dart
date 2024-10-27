import 'package:ecofriendly_app/config/router/app_router.dart';
import 'package:ecofriendly_app/features/company/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecofriendly_app/features/company/presentation/providers/inventories_provider.riverpod.dart';
import 'package:go_router/go_router.dart';

class InventoryView extends ConsumerWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory =
        ref.watch(inventoriesProvider.notifier).getInventoriesStream();
    return StreamBuilder(
      stream: inventory,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final inventories = snapshot.data;
          if (inventories!.isNotEmpty) {
            return ListView.builder(
              itemCount: inventories.length,
              itemBuilder: (context, index) {
                final inventory = inventories[index];
                return ListTile(
                  onTap: () =>
                      context.pushNamed(ProductsScreen.name, pathParameters: {
                    'id_inventory': '${inventory.id}',
                  }),
                  leading: const Icon(Icons.inventory_rounded),
                  title: Text(inventory.name),
                  subtitle: Text(
                    inventory.description,
                    maxLines: 2,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                );
              },
            );
          }
        }
        return const Center(
          child: Text('Sin inventario'),
        );
      },
    );
  }
}
