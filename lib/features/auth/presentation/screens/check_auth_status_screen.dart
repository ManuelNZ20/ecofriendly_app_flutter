import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CheckAuthStatusScreen extends ConsumerWidget {
  static const String name = 'check_auth_status';
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authProvider,
      (previous, next) {
        if (next.user != null) {
          print(next.user!.idTypeUser);
          if (next.user!.idTypeUser == 1) {
            context.go('/home_client');
            return;
          }
        }
        if (next.company != null) {
          print(next.company!.idTypeUser);
          if (next.company!.idTypeUser == 3) {
            context.go('/home_company');
            return;
          }
        }
        context.go('/login');
      },
    );
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
