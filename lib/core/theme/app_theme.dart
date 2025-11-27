import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildThemeData {
  static const Color primaryGreen = Color(0xFF2447A3);
  static const Color lightBackground = Color(0xffEEEEEE);
  static const Color darkBackground = Color(0xff121212);

  // ✅ Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: primaryGreen,
      surface: Colors.white,
      background: lightBackground,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 40, height: 1.3),
        headlineMedium: TextStyle(fontSize: 34, height: 1.4),
        headlineSmall: TextStyle(fontSize: 24, height: 1.23),
        titleLarge: TextStyle(fontSize: 22),
        titleMedium: TextStyle(fontSize: 20),
        titleSmall: TextStyle(fontSize: 18),
        bodyLarge: TextStyle(fontSize: 16, height: 1.4),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );

  // 🌙 Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: primaryGreen,
      surface: Color(0xFF1E1E1E),
      background: darkBackground,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.latoTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 40, height: 1.3),
        headlineMedium: TextStyle(fontSize: 34, height: 1.4),
        headlineSmall: TextStyle(fontSize: 24, height: 1.23),
        bodyLarge: TextStyle(fontSize: 16, height: 1.4),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
