import 'package:flutter/material.dart';
import 'design_tokens.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: Tokens.primary,
      scaffoldBackgroundColor: Tokens.background,
      appBarTheme: const AppBarTheme(centerTitle: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Tokens.primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: Tokens.h2, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: Tokens.body),
      ),
    );
  }
}
