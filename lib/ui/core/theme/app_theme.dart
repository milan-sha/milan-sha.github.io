import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get night {
    final display = GoogleFonts.frauncesTextTheme();
    final body = GoogleFonts.ibmPlexSansTextTheme();
    final mono = GoogleFonts.ibmPlexMonoTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.night,
      primaryColor: AppColors.laterite,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.laterite,
        secondary: AppColors.ember,
        surface: AppColors.graphite,
        error: AppColors.laterite,
        onPrimary: AppColors.bone,
        onSurface: AppColors.bone,
      ),
      textTheme: body.copyWith(
        displayLarge: display.displayLarge?.copyWith(
          color: AppColors.bone,
          fontWeight: FontWeight.w600,
          fontSize: 88,
          height: 0.92,
          letterSpacing: -2.2,
        ),
        displayMedium: display.displayMedium?.copyWith(
          color: AppColors.bone,
          fontWeight: FontWeight.w600,
          fontSize: 56,
          height: 0.96,
          letterSpacing: -1.4,
        ),
        headlineLarge: display.headlineLarge?.copyWith(
          color: AppColors.bone,
          fontWeight: FontWeight.w600,
          fontSize: 36,
          height: 1.1,
          letterSpacing: -0.6,
        ),
        headlineMedium: body.headlineMedium?.copyWith(
          color: AppColors.bone,
          fontWeight: FontWeight.w500,
          fontSize: 22,
          height: 1.3,
        ),
        titleMedium: mono.titleMedium?.copyWith(
          color: AppColors.ash,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          letterSpacing: 1.6,
        ),
        bodyLarge: body.bodyLarge?.copyWith(
          color: AppColors.ash,
          fontSize: 18,
          height: 1.65,
        ),
        bodyMedium: body.bodyMedium?.copyWith(
          color: AppColors.ash,
          fontSize: 16,
          height: 1.6,
        ),
        labelLarge: mono.labelLarge?.copyWith(
          color: AppColors.bone,
          fontWeight: FontWeight.w500,
          fontSize: 13,
          letterSpacing: 0.4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.laterite,
          foregroundColor: AppColors.bone,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.ibmPlexMono(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            letterSpacing: 0.6,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.bone,
          side: const BorderSide(color: AppColors.line, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.ibmPlexMono(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            letterSpacing: 0.6,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.ash,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: GoogleFonts.ibmPlexMono(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.graphite,
        labelStyle: GoogleFonts.ibmPlexMono(color: AppColors.ash, fontSize: 12),
        hintStyle: GoogleFonts.ibmPlexSans(color: AppColors.ash),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.line),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.line),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.laterite, width: 1.4),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.laterite),
        ),
      ),
      dividerColor: AppColors.line,
      focusColor: AppColors.laterite.withValues(alpha: 0.24),
    );
  }
}