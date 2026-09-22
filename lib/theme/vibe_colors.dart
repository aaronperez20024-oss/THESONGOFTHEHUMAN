import 'package:flutter/material.dart';

/// Vibe Design System — paleta "Atmospheric Glassmorphism + Luminous Dark Mode"
/// Extraída directamente del DESIGN.md del proyecto.
class VibeColors {
  VibeColors._();

  // ── Brand accents ────────────────────────────────────────────────
  /// Violeta eléctrico — acento primario / marca
  static const Color primary = Color(0xFFD0BCFF);
  static const Color primaryContainer = Color(0xFFA078FF);
  static const Color onPrimary = Color(0xFF3C0091);
  static const Color onPrimaryContainer = Color(0xFF340080);

  /// Cian neón — precisión digital, scrubbers, ecualizador
  static const Color secondary = Color(0xFF4CD7F6);
  static const Color secondaryContainer = Color(0xFF03B5D3);
  static const Color onSecondary = Color(0xFF003640);
  static const Color onSecondaryContainer = Color(0xFF00424E);

  /// Rosa vibrante — energía, favoritos, descubrimiento
  static const Color tertiary = Color(0xFFFFB0CD);
  static const Color tertiaryContainer = Color(0xFFF751A1);
  static const Color onTertiary = Color(0xFF640039);
  static const Color onTertiaryContainer = Color(0xFF570032);

  /// Esmeralda energética — offline, estado, colaborativo
  static const Color quaternary = Color(0xFF10B981);

  // ── Surfaces / Void scale ────────────────────────────────────────
  static const Color canvas = Color(0xFF0A0A0F); // Abyss
  static const Color surface = Color(0xFF13131B);
  static const Color surfaceDim = Color(0xFF13131B);
  static const Color surfaceBright = Color(0xFF393841);
  static const Color surfaceContainerLowest = Color(0xFF0D0D15);
  static const Color surfaceContainerLow = Color(0xFF1B1B23);
  static const Color surfaceContainer = Color(0xFF1F1F27);
  static const Color surfaceContainerHigh = Color(0xFF292932);
  static const Color surfaceContainerHighest = Color(0xFF34343D);
  static const Color surfaceVariant = Color(0xFF34343D);

  // ── Text & contrast ──────────────────────────────────────────────
  static const Color onSurface = Color(0xFFE4E1ED);
  static const Color onBackground = Color(0xFFE4E1ED);
  static const Color onSurfaceVariant = Color(0xFFCBC3D7);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textDim = Color(0xFF475569);
  static const Color outline = Color(0xFF958EA0);
  static const Color outlineVariant = Color(0xFF494454);

  // ── Glow / elevation ─────────────────────────────────────────────
  static const Color electricVioletGlow = Color(0x598B5CF6);
  static const Color neonCyanGlow = Color(0x6606B6D4);
  static const Color vibrantPinkGlow = Color(0x59EC4899);

  // ── Gradients ────────────────────────────────────────────────────
  /// Gradiente de marca principal (botón play radiante)
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
  );

  /// Portada gigante irradiante
  static const LinearGradient playerGlowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA078FF), Color(0xFF4CD7F6), Color(0xFFF751A1)],
  );

  /// Progreso del scrubber
  static const LinearGradient progressGradient = LinearGradient(
    colors: [Color(0xFFD0BCFF), Color(0xFF4CD7F6)],
  );

  /// Tarjeta destacada "Tus me gusta"
  static const LinearGradient likeCardGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFA078FF), Color(0xFF6D3BD7), Color(0xFF292932)],
  );

  /// Tarjeta Vibe Wrapped
  static const LinearGradient wrappedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x4DF751A1), Color(0xFF1F1F27), Color(0xFF292932)],
  );

  // ── Glass surfaces ───────────────────────────────────────────────
  /// Glass nivel 1 (tarjetas inmersas)
  static Color glassL1({double opacity = 0.65}) =>
      const Color(0xFF12121A).withValues(alpha: opacity);

  /// Glass nivel 2 (player flotante, modales)
  static Color glassL2({double opacity = 0.80}) =>
      const Color(0xFF1A1A24).withValues(alpha: opacity);

  static Color edgeLight = Colors.white.withValues(alpha: 0.12);
  static Color edgeSubtle = Colors.white.withValues(alpha: 0.05);
  static Color glowViolet = const Color(0xFF8B5CF6).withValues(alpha: 0.35);
  static Color glowCyan = const Color(0xFF06B6D4).withValues(alpha: 0.40);
  static Color glowPink = const Color(0xFFEC4899).withValues(alpha: 0.35);
}

/// Radios de borde (Level 3 — pill shape)
class VibeRadius {
  VibeRadius._();
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double full = 999;
}

/// Escala espacial de 8pt
class VibeSpace {
  VibeSpace._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;
}
