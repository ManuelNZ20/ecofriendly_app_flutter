import 'package:ecofriendly_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
    ],
  );
});
