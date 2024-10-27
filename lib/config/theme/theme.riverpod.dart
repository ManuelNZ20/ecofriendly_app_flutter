import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<Color> colorsTheme = [
  MyColors.mainColor,
  Colors.pink.shade400,
  Colors.orange.shade400,
  Colors.cyan.shade400,
  Colors.teal.shade900,
  Colors.brown,
  Colors.indigo.shade900,
];

final appThemeProvider = StateProvider<bool>((ref) {
  return false;
});

final indexColorsProvider = StateProvider<int>((ref) {
  return 0;
});

final listColorsProvider = Provider<List<Color>>((ref) {
  return colorsTheme;
});
