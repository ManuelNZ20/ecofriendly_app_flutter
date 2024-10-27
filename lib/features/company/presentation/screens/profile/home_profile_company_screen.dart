import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProfileCompanyScreen extends ConsumerWidget {
  static const String name = 'home_profile_company_screen';
  const HomeProfileCompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: const Placeholder(),
    );
  }
}
