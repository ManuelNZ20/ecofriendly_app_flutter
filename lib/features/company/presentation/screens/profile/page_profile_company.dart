import 'package:flutter/material.dart';

class PageProfileCompany extends StatelessWidget {
  static const String name = 'page_profile_company';
  const PageProfileCompany({
    super.key,
    required this.idCompany,
  });

  final String idCompany;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(idCompany),
      ),
      body: const Placeholder(),
    );
  }
}
