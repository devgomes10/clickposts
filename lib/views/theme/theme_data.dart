import 'package:clickposts/views/theme/color_scheme.dart';
import 'package:clickposts/views/theme/theme_colors.dart';
import 'package:clickposts/views/theme/theme_fonts.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  textTheme: TextTheme(
    bodyLarge: ThemeFonts.large,
    bodyMedium: ThemeFonts.medium,
    bodySmall: ThemeFonts.small,
  ),
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ThemeColors.black,
        fontSize: 26,
      )),

  // Form
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ThemeColors.blue),
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: ThemeColors.black),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: ThemeColors.errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: ThemeColors.errorColor),
    ),
    labelStyle: const TextStyle(color: ThemeColors.black),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ThemeColors.black,
  ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ThemeColors.blue,
      elevation: 2,
      textStyle: ThemeFonts.small,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: ThemeColors.ghostWhite,
      textStyle: ThemeFonts.medium,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ThemeColors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: ThemeColors.blue,
    foregroundColor: ThemeColors.white,
  ),
  cardTheme: const CardTheme(
    color: ThemeColors.ghostWhite,
    elevation: 5,
  ),
);
