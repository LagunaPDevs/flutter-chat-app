import 'package:flutter/material.dart';
import 'package:realtime_chat/themes/color_constants.dart';

// export theme
export 'light_theme.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: neutralWhite,
  fontFamily: 'Mulish',
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(color: defaultColor)))),
  textTheme: const TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontWeight: FontWeight.w300),
          bodySmall: TextStyle(fontWeight: FontWeight.w100),
          headlineSmall: TextStyle(color: neutralDisabled))
      .apply(
    bodyColor: neutralActive,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: defaultColor,
      textStyle: const TextStyle(color: neutralOffWhite),
    ),
  ),
);
