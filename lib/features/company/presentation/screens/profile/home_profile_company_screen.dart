import 'package:ecofriendly_app/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProfileCompanyScreen extends ConsumerWidget {
  static const String name = 'home_profile_company_screen';
  const HomeProfileCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(us)
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonArrowBack(),
        title: const Text('Perfil'),
      ),
      body: const Placeholder(),
    );
  }
}
