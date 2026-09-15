import 'package:flutter/material.dart';

class WhatsAppColors {
  static const Color primaryGreen = Color(0xFF075E54);
  static const Color lightGreen = Color(0xFF128C7E);
  static const Color accentGreen = Color(0xFF25D366);
  static const Color chatBubbleGreen = Color(0xFFDCF8C6);

  static const Color darkBackground = Color(0xFF111B21);
  static const Color darkSurface = Color(0xFF202C33);
  static const Color darkAppBar = Color(0xFF1F2C34);
  static const Color darkBubble = Color(0xFF005C4B);

  static const Color lightBackground = Color(0xFFEFEAE2);
  static const Color lightSurface = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: WhatsAppColors.primaryGreen,
      scaffoldBackgroundColor: WhatsAppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: WhatsAppColors.primaryGreen,
        secondary: WhatsAppColors.accentGreen,
        surface: WhatsAppColors.lightSurface,
        onPrimary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: WhatsAppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: WhatsAppColors.accentGreen,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: WhatsAppColors.darkAppBar,
      scaffoldBackgroundColor: WhatsAppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: WhatsAppColors.darkAppBar,
        secondary: WhatsAppColors.accentGreen,
        surface: WhatsAppColors.darkSurface,
        onPrimary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: WhatsAppColors.darkAppBar,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: WhatsAppColors.accentGreen,
        foregroundColor: Colors.white,
      ),
    );
  }
}
