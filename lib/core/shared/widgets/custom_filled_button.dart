import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    final colors = Theme.of(context).colorScheme;
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.primary),
        textStyle: WidgetStatePropertyAll(textStyle),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
