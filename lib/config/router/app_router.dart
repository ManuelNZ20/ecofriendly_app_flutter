import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecofriendly_app/core/utils/helpers/widgets/card_product_screen.dart';
import 'package:ecofriendly_app/core/utils/helpers/widgets/screens_widgets.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomeWidgetsScreen();
        },
      ),
      GoRoute(
        path: '/card_product',
        builder: (context, state) {
          return const CardProductScreen();
        },
      ),
    ],
  );
});
