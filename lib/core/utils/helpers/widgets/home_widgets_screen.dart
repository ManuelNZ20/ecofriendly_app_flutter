import 'package:ecofriendly_app/core/utils/helpers/data/items_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWidgetsScreen extends StatelessWidget {
  static const String name = 'home_widgets_screen';
  const HomeWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen Test'),
      ),
      body: ListView.builder(
        itemCount: itemMenuList.length,
        itemBuilder: (context, index) {
          final itemMenu = itemMenuList[index];
          return ListTile(
            title: Text(itemMenu.name),
            subtitle: Text(itemMenu.description),
            leading: Icon(itemMenu.iconData),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.go(itemMenu.location),
          );
        },
      ),
    );
  }
}
