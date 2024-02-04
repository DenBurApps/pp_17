import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Возвращает тему приложения
class DefaultThemeGetter {
  static ThemeData get() {
    const primary = Color(0xFF1562D4);
    const onPrimary = Color(0xFFFFFFFF);
    const surface = Color(0xFFFFFFFF);
    const onSurface = Color(0xFF1562D4);
    const background = Color(0xFFFFFFFF);
    const onBackground = Color(0xFF1D1D1D);

    return ThemeData(
      backgroundColor: background,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.istokWeb(
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
        ),
        displayMedium: GoogleFonts.istokWeb(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
        titleLarge: GoogleFonts.istokWeb(
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      ).apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              56.0,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return primary.withOpacity(0.3);
              }
              return primary;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(
                double.infinity,
                53.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(color: primary),
            )),
      ),
      colorScheme: const ColorScheme(
        primary: primary,
        secondary: Colors.white,
        surface: surface,
        onSurface: onSurface,
        background: background,
        secondaryContainer: Colors.white,
        onBackground: onBackground,
        error: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
        onPrimary: onPrimary,
        onSecondary: Colors.white,
      ),
    );
  }
}
