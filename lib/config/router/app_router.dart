import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/riverpod/providers.dart';
import '../../core/shared/infrastructure/infrastructure.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/company/presentation/screens/screens.dart';
import '../../features/client/presentation/screens/screens.dart';
import 'app_router_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
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
        name: LoginScreen.name,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/business_option',
        name: BusinessOptionScreen.name,
        builder: (context, state) {
          return const BusinessOptionScreen();
        },
      ),
      GoRoute(
        path: '/register_user',
        name: RegisterUserScreen.name,
        builder: (context, state) {
          return const RegisterUserScreen();
        },
      ),
      GoRoute(
        path: '/register_company',
        name: RegisterCompanyScreen.name,
        builder: (context, state) {
          return const RegisterCompanyScreen();
        },
      ),
      GoRoute(
        path: '/verify_otp_user/:email',
        name: VerifyUserOtpScreen.name,
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyUserOtpScreen(
            email: email,
          );
        },
      ),
      GoRoute(
        path: '/verify_otp_company/:email',
        name: VerifyCompanyOtpScreen.name,
        builder: (context, state) {
          final email = state.pathParameters['email']!;
          return VerifyCompanyOtpScreen(
            email: email,
          );
        },
      ),
      // HOME - CLIENT
      GoRoute(
        path: '/home_client',
        name: HomeClientScreen.name,
        builder: (context, state) {
          return const HomeClientScreen();
        },
      ),
      // HOME - COMPANY
      GoRoute(
        path: '/home_company',
        builder: (context, state) {
          return const HomeScreenCompany();
        },
        routes: [
          GoRoute(
            path: 'inventory_screen/:id',
            name: InventoryScreen.name,
            builder: (context, state) {
              final idInventory = state.pathParameters['id'] ?? 'no-id';
              return InventoryScreen(
                idInventory: int.parse(idInventory),
              );
            },
          ),
          GoRoute(
            path: 'products/:id_inventory',
            name: ProductsScreen.name,
            builder: (context, state) {
              final id = state.pathParameters['id_inventory'] ?? 'no-id';
              return ProductsScreen(
                idInventory: int.parse(id),
              );
            },
            routes: [
              GoRoute(
                path: 'product/:id_product',
                name: ProductCompanyScreen.name,
                builder: (context, state) {
                  final id = state.pathParameters['id_product'] ?? 'no-id';
                  final data = state.extra as Map<String, dynamic>;
                  return ProductCompanyScreen(
                    idProduct: id,
                    idInventory: data['id_data'] as int,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'profile',
            name: HomeProfileCompanyScreen.name,
            builder: (context, state) {
              return const HomeProfileCompanyScreen();
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.noAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          final keyValueStorageService = KeyValueStorageImpl();
          final typeUser =
              await keyValueStorageService.getValue<int>('type_user');
          if (typeUser == 1) {
            return '/home_client';
          }
          return '/home_company';
        }
      }
      return null;
    },
  );
});
