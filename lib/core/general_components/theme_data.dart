import 'package:flutter/material.dart';

import 'ColorHelper.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: ColorHelper.mainColor),
    //scaffoldBackgroundColor: ColorHelper.darkColor,
    drawerTheme: const DrawerThemeData(
       // backgroundColor: ColorHelper.darkColor,
        //surfaceTintColor: ColorHelper.darkColor
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: ColorHelper.mainColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: const WidgetStatePropertyAll(ColorHelper.mainColor),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        textStyle:
            const WidgetStatePropertyAll(TextStyle(color: Colors.white)),
        overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(.1)),
      ),
    ),
  );
}
