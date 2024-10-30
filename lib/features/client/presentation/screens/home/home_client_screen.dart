import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../company/presentation/riverpod/tab_controller_provider.riverpod.dart';

class HomeClientScreen extends ConsumerWidget {
  static const String name = 'home_client_screen';
  const HomeClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabProvider);
    final isDark = ref.watch(appThemeProvider);
    final listColors = ref.watch(listColorsProvider);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => ref.read(indexColorsProvider.notifier).update(
              (state) => (state >= listColors.length - 1) ? 0 : state + 1),
          icon: const Icon(Icons.eco_rounded),
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
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
