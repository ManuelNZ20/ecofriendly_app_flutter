import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/screens.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/business_option',
        builder: (context, state) {
          return const BusinessOptionScreen();
        },
      ),
      GoRoute(
        path: '/register_user',
        builder: (context, state) {
          return const RegisterUserScreen();
        },
      ),
      GoRoute(
        path: '/register_company',
        builder: (context, state) {
          return const RegisterCompanyScreen();
        },
      ),
    ],
  );
});
