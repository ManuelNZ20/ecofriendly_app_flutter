import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecofriendly_app/app/app.dart';
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.initEnvironment();

  await SupabaseInit.initSupabase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
