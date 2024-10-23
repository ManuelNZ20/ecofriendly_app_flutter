import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../riverpod/providers.dart';
import 'package:ecofriendly_app/core/shared/shared.dart';
import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:ecofriendly_app/core/utils/functions/show_snackbar.dart';

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
    final textChangedPassword =
        Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: MyColors.password,
            );
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
      if (next.messageRegister.isNotEmpty) {
        showSnackbar(context, next.messageRegister);
      }
    });
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
            '¡Bienvenido a Ecofriendly!',
            style: titleLogin,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Contraseña',
            obscureText: loginForm.obscureText,
            onPressed: ref.read(loginFormProvider.notifier).onViewPassword,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  '¿Olvidate tu contraseña?',
                  style: textChangedPassword,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'INICIAR SESIÓN',
              onPressed: ref.read(loginFormProvider.notifier).onFormSubmit,
            ),
          ),
          // const SizedBox(height: 20),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿No tienes cuenta?',
                style: textChangedPassword.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextButton(
                onPressed: () => context.push('/business_option'),
                child: Text(
                  'Registrate',
                  style: textChangedPassword.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          // const Spacer(flex: 1),
        ],
      ),
    );
  }
}
