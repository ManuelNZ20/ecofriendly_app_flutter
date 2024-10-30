import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../config/theme/theme.dart';
import '../../../../company/presentation/riverpod/tab_controller_provider.riverpod.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/horizontal_products_listview.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final colors = Theme.of(context).colorScheme;
    final tabIndex = ref.watch(tabProvider);
    final isDark = ref.watch(appThemeProvider);
    final listColors = ref.watch(listColorsProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.eco_outlined),
                        onPressed: () => ref
                            .read(indexColorsProvider.notifier)
                            .update((state) => (state >= listColors.length - 1)
                                ? 0
                                : state + 1),
                        color: colors.primary,
                      ),
                      IconButton(
                        onPressed: () =>
                            ref.read(appThemeProvider.notifier).update(
                                  (state) => !state,
                                ),
                        icon:
                            Icon(!isDark ? Icons.light_mode : Icons.dark_mode),
                        color: !isDark
                            ? MyColors.themeColors.lightMode
                            : MyColors.themeColors.darkMode,
                      ),
                      IconButton(
                        onPressed: ref.read(authProvider.notifier).logout,
                        icon: const Icon(
                          Icons.exit_to_app_rounded,
                          color: MyColors.password,
                        ),
                      ),
                    ],
                  ),
                  const CustomSlideShow(),
                  HorizontalProductsListView(
                    products: products.products
                        .where((element) => element.productDiscount != null)
                        .toList(),
                    title: 'Populares',
                    isPromotion: false,
                  ),
                  HorizontalProductsListView(
                    products: products.products,
                    title: 'Oferta de productos',
                    isPromotion: true,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
