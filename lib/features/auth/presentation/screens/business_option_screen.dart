import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:ecofriendly_app/core/shared/shared.dart';

enum BusinessOption { users, ecofrinedly }

class BusinessOptionScreen extends StatefulWidget {
  static const String name = 'business_option_screen';
  const BusinessOptionScreen({super.key});

  @override
  State<BusinessOptionScreen> createState() => _BusinessOptionScreenState();
}

class _BusinessOptionScreenState extends State<BusinessOptionScreen> {
  BusinessOption selectedBusiness = BusinessOption.users;

  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              const Icon(
                Icons.eco_outlined,
                color: MyColors.mainColor,
                size: 50,
              ),
              Text(
                'Elige un Perfil Digital',
                style: title,
              ),
              RadioListTile(
                title: const Text('Usuario'),
                subtitle: const Text('Compras y feedback'),
                value: BusinessOption.users,
                groupValue: selectedBusiness,
                secondary: const Icon(Icons.person),
                onChanged: (value) => setState(
                  () {
                    selectedBusiness = BusinessOption.users;
                  },
                ),
              ),
              RadioListTile(
                value: BusinessOption.ecofrinedly,
                title: const Text('Ecofriendly'),
                secondary: const Icon(Icons.business_outlined),
                subtitle:
                    const Text('Crea tu propia empresa ecologíco digital'),
                groupValue: selectedBusiness,
                onChanged: (value) => setState(
                  () {
                    selectedBusiness = BusinessOption.ecofrinedly;
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Continuar',
                  onPressed: () {
                    if (selectedBusiness == BusinessOption.ecofrinedly) {
                      context.push('/register_user');
                      return;
                    }
                    context.push('/register_company');
                  },
                ),
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Volver'),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
