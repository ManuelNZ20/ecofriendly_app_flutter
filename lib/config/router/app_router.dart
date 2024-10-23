import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/screens.dart';
import 'package:ecofriendly_app/features/cart/presentation/screens/home/home_screen_company.dart';
import 'package:ecofriendly_app/features/client/presentation/screens/home/home_screen_client.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return const CheckAuthStatusScreen();
        },
      ),
      // Auth Routes
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
      GoRoute(
        path: '/verify_otp_user/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyUserOtpScreen(
            email: email,
          );
        },
      ),
      GoRoute(
        path: '/verify_otp_company/:email',
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyCompanyOtpScreen(
            email: email,
          );
        },
      ),
      // HOME
      GoRoute(
        path: '/home_client',
        builder: (context, state) {
          return const HomeScreenClient();
        },
      ),
      GoRoute(
        path: '/home_company',
        builder: (context, state) {
          return const HomeScreenCompany();
        },
      ),
    ],
    redirect: (context, state) {
      print(state);
      return null;
    },
  );
});
