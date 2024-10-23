import 'package:ecofriendly_app/config/theme/styles/colors.dart';
import 'package:flutter/material.dart';

import 'package:ecofriendly_app/config/theme/styles/styles.dart';

class AppTheme {
  ThemeData themeData() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: MyColors.mainColor,
        textTheme: textTheme,
        appBarTheme: appBarTheme,
      );
}
