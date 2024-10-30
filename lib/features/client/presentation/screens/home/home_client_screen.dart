import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class HomeClientScreen extends StatelessWidget {
  static const String name = 'home_client_screen';
  const HomeClientScreen({
    super.key,
    required this.childView,
  });
  final Widget childView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: childView,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
