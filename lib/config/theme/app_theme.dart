import 'package:flutter/material.dart';
import 'package:ecofriendly_app/config/theme/styles/styles.dart';

class AppTheme {
  ThemeData themeData(bool isDark, Color primaryColor) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      textTheme: textTheme,
      appBarTheme: appBarTheme,
      brightness: !isDark ? Brightness.light : Brightness.dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedLabelStyle: labelStyle,
        selectedLabelStyle: labelStyle,
      ));
}
