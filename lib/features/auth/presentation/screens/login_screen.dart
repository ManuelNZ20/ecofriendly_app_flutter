import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ecofriendly_app/core/shared/shared.dart';
import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:ecofriendly_app/features/auth/presentation/riverpod/login_form_provider.riverpod.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height - 100,
                  child: const LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final titleLogin = Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: Image.asset(
              width: 180,
              // height: 200,
              'assets/images/img-logo.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          Text(
            '¡Bienvenido a Ecofrinedly!',
            style: titleLogin,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.email.errorMessage,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage: loginForm.email.errorMessage,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  '¿Olvidate tu contraseña?',
                  style: TextStyle(color: MyColors.password),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'INICIAR SESIÓN',
              onPressed: () {
                ref.read(loginFormProvider.notifier).onFormSubmit();
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: () => context.push('/business_option'),
                child: const Text('Registrate'),
              )
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
