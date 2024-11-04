import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../auth/presentation/riverpod/providers.dart';
import '../../riverpod/banners_provider.dart';
import '../../riverpod/products_provider.dart';
import '../../widgets/horizontal_products_listview.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final colors = Theme.of(context).colorScheme;
    final isDark = ref.watch(appThemeProvider);
    final listColors = ref.watch(listColorsProvider);
    final productStream = ref.watch(productsLoadingProvider);
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(productsProvider);
        ref.invalidate(bannersProvider);
      },
      child: CustomScrollView(
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
                              .update((state) =>
                                  (state >= listColors.length - 1)
                                      ? 0
                                      : state + 1),
                          color: colors.primary,
                        ),
                        IconButton(
                          onPressed: () =>
                              ref.read(appThemeProvider.notifier).update(
                                    (state) => !state,
                                  ),
                          icon: Icon(
                              !isDark ? Icons.light_mode : Icons.dark_mode),
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
                    !products.isLoading
                        ? HorizontalProductsListView(
                            products: products.products
                                .where((element) =>
                                    element.idproductdiscount.isNotEmpty)
                                .toList(),
                            title: 'Populares',
                            isPromotion: false,
                          )
                        : const _LoadingHorizontalProductsListView(),
                    !products.isLoading
                        ? HorizontalProductsListView(
                            products: products.products,
                            title: 'Oferta de productos',
                            isPromotion: true,
                          )
                        : const _LoadingHorizontalProductsListView(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _LoadingHorizontalProductsListView extends StatelessWidget {
  const _LoadingHorizontalProductsListView();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 360,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
