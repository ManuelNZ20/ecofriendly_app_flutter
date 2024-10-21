import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? enable;
  final Function()? onPressed;
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.enable,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(),
      borderRadius: BorderRadius.circular(10),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 20, /* color: Colors.black54 */
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(borderSide: const BorderSide()),
          focusedErrorBorder: border.copyWith(borderSide: const BorderSide()),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          errorText: errorMessage,
          enabled: enable ?? true,
          suffixIcon: onPressed != null
              ? IconButton(
                  onPressed: onPressed,
                  icon: obscureText
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                )
              : null,
        ),
      ),
    );
  }
}
