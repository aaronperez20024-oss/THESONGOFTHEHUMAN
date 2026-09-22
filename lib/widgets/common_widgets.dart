import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';

/// Contenedor con efecto "frosted glass" (BackdropFilter + blur).
class GlassCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final bool showBorder;
  final Gradient? gradient;

  const GlassCard({
    super.key,
    required this.child,
    this.radius = VibeRadius.md,
    this.opacity = 0.65,
    this.padding,
    this.color,
    this.showBorder = true,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null
            ? (color ?? VibeColors.glassL1(opacity: opacity))
            : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: VibeColors.edgeSubtle) : null,
      ),
      child: child,
    );
  }
}

/// Píldora / chip seleccionable.
class VibeChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? activeColor;
  final Color? activeTextColor;
  final bool glow;

  const VibeChip({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
    this.icon,
    this.activeColor,
    this.activeTextColor,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = active
        ? (activeColor ?? VibeColors.primary)
        : VibeColors.surfaceContainerHigh;
    final fg = active
        ? (activeTextColor ?? VibeColors.onPrimary)
        : VibeColors.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(VibeRadius.full),
          boxShadow: (active && glow)
              ? [
                  BoxShadow(
                    color: (activeColor ?? VibeColors.primary).withValues(
                      alpha: 0.4,
                    ),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: fg),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: VibeText.labelMd(
                color: fg,
              ).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Encabezado de sección con acción "Ver todo".
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: VibeText.headlineSm()),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: VibeText.bodySm(color: VibeColors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Row(
              children: [
                Text(
                  actionLabel!,
                  style: VibeText.labelMd(color: VibeColors.secondary),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: VibeColors.secondary,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Ecualizador animado de 3 barras (indicador "reproduciendo").
class EqualizerBars extends StatefulWidget {
  final Color color;
  final double height;
  const EqualizerBars({
    super.key,
    this.color = VibeColors.secondary,
    this.height = 16,
  });

  @override
  State<EqualizerBars> createState() => _EqualizerBarsState();
}

class _EqualizerBarsState extends State<EqualizerBars>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  final _delays = [0, 200, 100];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 700 + i * 150),
      );
    });
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: _delays[i]), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.height * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controllers[i],
            builder: (context, _) {
              final t = 0.25 + _controllers[i].value * 0.75;
              return Container(
                width: widget.height * 0.2,
                height: widget.height * t,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Resplandor atmosférico difuso usado como fondo.
class AmbientGlow extends StatelessWidget {
  final Color color;
  final double size;
  final Alignment alignment;
  const AmbientGlow({
    super.key,
    required this.color,
    this.size = 260,
    this.alignment = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: alignment,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color.withValues(alpha: 0.30), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

/// Barra de progreso/scrubber interactiva con degradado y halo.
class VibeScrubber extends StatelessWidget {
  final double progress;
  final double buffered;
  final ValueChanged<double> onSeek;
  final Color activeColor;

  const VibeScrubber({
    super.key,
    required this.progress,
    this.buffered = 0.78,
    required this.onSeek,
    this.activeColor = VibeColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        void handle(Offset local) {
          onSeek((local.dx / width).clamp(0.0, 1.0));
        }

        return GestureDetector(
          onTapDown: (d) => handle(d.localPosition),
          onHorizontalDragUpdate: (d) => handle(d.localPosition),
          child: SizedBox(
            height: 24,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: buffered.clamp(0.0, 1.0),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: VibeColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: VibeColors.progressGradient,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(color: VibeColors.glowCyan, blurRadius: 12),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(progress * 2 - 1, 0),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: VibeColors.onSurface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: activeColor,
                          blurRadius: 14,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: VibeColors.secondaryContainer,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Botón de reproducción principal con degradado y glow.
class PrimaryPlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;
  final double size;

  const PrimaryPlayButton({
    super.key,
    required this.isPlaying,
    required this.onTap,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: VibeColors.playerGlowGradient,
          boxShadow: [
            BoxShadow(
              color: VibeColors.primaryContainer.withValues(alpha: 0.6),
              blurRadius: 28,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: VibeColors.onPrimaryContainer,
          size: size * 0.5,
        ),
      ),
    );
  }
}

/// Miniatura de portada de álbum con recorte redondeado.
class CoverArt extends StatelessWidget {
  final String url;
  final double size;
  final double radius;
  final bool circle;

  const CoverArt({
    super.key,
    required this.url,
    required this.size,
    this.radius = VibeRadius.md,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circle ? size : radius),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: size,
            height: size,
            color: VibeColors.surfaceContainerHigh,
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: VibeColors.primary,
                ),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          color: VibeColors.surfaceContainerHigh,
          child: Icon(
            Icons.music_note,
            color: VibeColors.onSurfaceVariant,
            size: size * 0.4,
          ),
        ),
      ),
    );
  }
}

/// Icono vectorial simple rotado (para portadas de rejilla de género).
class RotatedThumb extends StatelessWidget {
  final String url;
  final double size;
  const RotatedThumb({super.key, required this.url, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 18,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(VibeRadius.md),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: CoverArt(url: url, size: size, radius: VibeRadius.md),
      ),
    );
  }
}
