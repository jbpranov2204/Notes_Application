import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: const Color(0xFF1A73E8),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1A73E8),
      primary: const Color(0xFF1A73E8),
      secondary: const Color(0xFF4285F4),
      tertiary: const Color(0xFF34A853),
      background: Colors.grey[50]!,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.grey[900],
      ),
      bodyLarge: GoogleFonts.roboto(fontSize: 16, color: Colors.grey[800]),
      bodyMedium: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
      labelSmall: GoogleFonts.roboto(fontSize: 12, color: Colors.grey[600]),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
    ),
  );
}
