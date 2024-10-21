import 'package:ecofriendly_app/config/router/app_router.dart';
import 'package:ecofriendly_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final appTheme = AppTheme().themeData();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ecofriendly App',
      routerConfig: appRouter,
      theme: appTheme,
    );
  }
}
