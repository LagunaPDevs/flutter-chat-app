import 'package:flutter/material.dart';
import 'package:realtime_chat/themes/color_constants.dart';

// export theme
export 'dark_theme.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: neutralActive,
  fontFamily: 'Mulish',
  textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          textStyle:
              WidgetStatePropertyAll(TextStyle(color: neutralOffWhite)))),
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
      backgroundColor: darkModeColor,
      textStyle: const TextStyle(color: neutralOffWhite),
    ),
  ),
);
