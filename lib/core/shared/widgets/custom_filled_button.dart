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
    return FilledButton(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(MyColors.mainColor),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
