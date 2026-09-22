import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vibe_colors.dart';

/// Tipografía Vibe basada en Plus Jakarta Sans.
class VibeText {
  VibeText._();

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    required double height,
    double letterSpacing = 0,
    Color color = VibeColors.onSurface,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    height: height / size,
    letterSpacing: letterSpacing,
    color: color,
  );

  static TextStyle displayXl({Color? color}) => _base(
    size: 36,
    weight: FontWeight.w800,
    height: 42,
    letterSpacing: -0.72,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle headlineLg({Color? color}) => _base(
    size: 28,
    weight: FontWeight.w700,
    height: 34,
    letterSpacing: -0.28,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle headlineMd({Color? color}) => _base(
    size: 24,
    weight: FontWeight.w700,
    height: 30,
    letterSpacing: -0.24,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle headlineSm({Color? color}) => _base(
    size: 20,
    weight: FontWeight.w600,
    height: 26,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle bodyLg({Color? color}) => _base(
    size: 18,
    weight: FontWeight.w500,
    height: 28,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle bodyMd({Color? color}) => _base(
    size: 15,
    weight: FontWeight.w400,
    height: 22,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle bodySm({Color? color}) => _base(
    size: 13,
    weight: FontWeight.w400,
    height: 18,
    letterSpacing: 0.13,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle labelLg({Color? color}) => _base(
    size: 14,
    weight: FontWeight.w600,
    height: 20,
    letterSpacing: 0.28,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle labelMd({Color? color}) => _base(
    size: 12,
    weight: FontWeight.w600,
    height: 16,
    letterSpacing: 0.48,
    color: color ?? VibeColors.onSurface,
  );
  static TextStyle labelSm({Color? color}) => _base(
    size: 10,
    weight: FontWeight.w700,
    height: 14,
    letterSpacing: 0.8,
    color: color ?? VibeColors.onSurface,
  );
}

class VibeTheme {
  VibeTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: VibeColors.canvas,
      canvasColor: VibeColors.canvas,
      colorScheme: const ColorScheme.dark(
        primary: VibeColors.primary,
        onPrimary: VibeColors.onPrimary,
        primaryContainer: VibeColors.primaryContainer,
        secondary: VibeColors.secondary,
        onSecondary: VibeColors.onSecondary,
        secondaryContainer: VibeColors.secondaryContainer,
        tertiary: VibeColors.tertiary,
        surface: VibeColors.surface,
        onSurface: VibeColors.onSurface,
        error: Color(0xFFFFB4AB),
      ),
      textTheme: textTheme.apply(
        bodyColor: VibeColors.onSurface,
        displayColor: VibeColors.onSurface,
      ),
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      iconTheme: const IconThemeData(color: VibeColors.onSurface),
    );
  }
}
