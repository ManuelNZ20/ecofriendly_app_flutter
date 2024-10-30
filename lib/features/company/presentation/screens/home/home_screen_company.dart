import 'package:ecofriendly_app/features/company/presentation/riverpod/company_provider.riverpod.dart';
import 'package:ecofriendly_app/features/company/presentation/views/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:ecofriendly_app/features/company/presentation/screens/profile/home_profile_company_screen.dart';
import '../../../../../config/theme/theme.dart';
import '../../riverpod/tab_controller_provider.riverpod.dart';

class HomeScreenCompany extends ConsumerWidget {
  const HomeScreenCompany({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabProvider);
    final isDark = ref.watch(appThemeProvider);
    final listColors = ref.watch(listColorsProvider);
    final colors = Theme.of(context).colorScheme;
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 300),
      length: 3,
      initialIndex: tabIndex,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.eco_outlined),
            onPressed: () => ref.read(indexColorsProvider.notifier).update(
                (state) => (state >= listColors.length - 1) ? 0 : state + 1),
            color: colors.primary,
          ),
          title: const Text('Ecofriendly'),
          actions: [
            IconButton(
              onPressed: () => ref.read(appThemeProvider.notifier).update(
                    (state) => !state,
                  ),
              icon: Icon(!isDark ? Icons.light_mode : Icons.dark_mode),
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
            )
          ],
        ),
        body: const _ContainerTabs(),
        floatingActionButton: tabIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () => context.push('/home_company/product/new'),
                label: const Text('Producto'),
                icon: const Icon(Icons.add),
              )
            : tabIndex == 1
                ? FloatingActionButton.extended(
                    onPressed: () {},
                    label: const Text('Avisos'),
                    icon: const Icon(Icons.add),
                  )
                : null,
      ),
    );
  }
}

class _ContainerTabs extends ConsumerWidget {
  const _ContainerTabs();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final company = ref.watch(getCompanyDataProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          company.when(
            data: (data) => ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(company.value!.imgPresentation!),
              ),
              title: Text(data.nameCompany),
              subtitle: Text(
                data.email,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () => context.pushNamed(
                  HomeProfileCompanyScreen.name,
                  pathParameters: {'id_company': data.idCompany},
                ),
                icon: Icon(
                  Icons.settings,
                  color: colors.primary,
                ),
              ),
            ),
            error: (error, stackTrace) {
              return ListTile(
                leading: const CircleAvatar(
                  radius: 35,
                ),
                title: const Text('Sin Datos'),
                subtitle: Text(
                  'Error: $error',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            loading: () => ListTile(
              leading: const CircleAvatar(
                radius: 35,
              ),
              title: Container(
                width: 100,
                height: 15,
                color: Colors.grey,
              ),
              subtitle: Container(
                width: 100,
                height: 15,
                color: Colors.grey,
              ),
            ),
          ),
          TabBar(
            onTap: ref.read(tabProvider.notifier).setTabIndex,
            labelColor: colors.primary,
            tabs: const [
              Tab(
                icon: Icon(Icons.inventory_rounded),
                text: 'Mi Inventarío',
              ),
              Tab(
                icon: Icon(Icons.satellite),
                text: 'Mis Aviso',
              ),
              Tab(
                icon: Icon(Icons.notifications_active_rounded),
                text: 'Ordenes',
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(), // Desactiva el swipe
              children: [
                ProductsView(),
                Icon(Icons.notification_add),
                Icon(Icons.message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
