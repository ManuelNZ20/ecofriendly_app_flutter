import 'package:ecofriendly_app/features/auth/presentation/riverpod/auth_provider.riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenClient extends ConsumerWidget {
  const HomeScreenClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen Client'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authProvider.notifier).logout(),
            icon: const Icon(Icons.exit_to_app_rounded),
          )
        ],
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
