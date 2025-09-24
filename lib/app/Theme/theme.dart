import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTheme {
  static const Color _lightBackground = Color(0xFFF7F6F3);

  static const Color _darkBackground = Color(0xFF0B0B0B);

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1565C0), // Deep Blue
      scaffoldBackgroundColor: _lightBackground,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1565C0),
        secondary: Color(0xFF00ACC1), // Teal accent
        surface: Colors.white,
        background: _lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black87,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF1565C0),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: Color(0xFF1565C0)),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: _lightBackground,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: _lightBackground,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.hintColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1565C0), // Deep Blue
      scaffoldBackgroundColor: _darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF1565C0),
        secondary: Color(0xFF00E5FF), // Cyan glow
        surface: Color(0xFF121212),
        background: _darkBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white70,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF00E5FF),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: Color(0xFF00E5FF)),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: _darkBackground,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF121212),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1565C0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Get.theme.hintColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00E5FF), width: 2),
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
