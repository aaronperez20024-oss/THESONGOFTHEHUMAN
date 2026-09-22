import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/vibe_colors.dart';
import '../theme/vibe_theme.dart';

/// Logotipo de Vibe dibujado vectorialmente: un círculo con ondas
/// de audio y ondas concéntricas, con gradiente violeta→cian.
class VibeLogo extends StatelessWidget {
  final double size;
  const VibeLogo({super.key, this.size = 36});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF141420),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: CustomPaint(painter: _LogoPainter()),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    const violet = Color(0xFFA078FF);
    const cyan = Color(0xFF4CD7F6);

    final grad = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [violet, cyan],
    ).createShader(Rect.fromCircle(center: center, radius: r));

    // Anillo exterior
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05
      ..shader = grad;
    canvas.drawCircle(center, r * 0.78, ring);

    // Ondas concéntricas (interior, atenuado)
    final inner = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03
      ..color = cyan.withValues(alpha: 0.35);
    for (var i = 1; i <= 3; i++) {
      canvas.drawArc(
        Rect.fromCircle(
          center: center.translate(r * 0.18, 0),
          radius: r * 0.78,
        ),
        -math.pi / 3,
        math.pi * 1.2,
        false,
        inner,
      );
    }

    // Onda sinusoidal central
    final wave = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.085
      ..strokeCap = StrokeCap.round
      ..shader = grad;

    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * 0.22, h * 0.58);
    path.cubicTo(w * 0.32, h * 0.30, w * 0.40, h * 0.85, w * 0.50, h * 0.55);
    path.cubicTo(w * 0.60, h * 0.25, w * 0.68, h * 0.72, w * 0.78, h * 0.42);
    canvas.drawPath(path, wave);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Marca "Vibe" con texto en gradiente (logotipo en cabeceras).
class VibeWordmark extends StatelessWidget {
  final double size;
  const VibeWordmark({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => VibeColors.brandGradient.createShader(rect),
      blendMode: BlendMode.srcIn,
      child: Text(
        'Vibe',
        style: VibeText.headlineMd(
          color: Colors.white,
        ).copyWith(fontSize: size, fontWeight: FontWeight.w800),
      ),
    );
  }
}
