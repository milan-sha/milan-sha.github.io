import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SignalField extends StatefulWidget {
  const SignalField({super.key});

  @override
  State<SignalField> createState() => _SignalFieldState();
}

class _SignalFieldState extends State<SignalField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  Offset? _pointer;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);

    return MouseRegion(
      onHover: (event) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        setState(() => _pointer = box.globalToLocal(event.position));
      },
      onExit: (_) => setState(() => _pointer = null),
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, _) {
          return CustomPaint(
            painter: _SignalPainter(
              t: reduce ? 0 : _pulse.value,
              pointer: _pointer,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _SignalPainter extends CustomPainter {
  _SignalPainter({required this.t, required this.pointer});

  final double t;
  final Offset? pointer;

  @override
  void paint(Canvas canvas, Size size) {
    final origin = pointer ?? Offset(size.width * 0.18, size.height * 0.22);
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 7; i++) {
      final radius = 48.0 + i * 92 + sin((t * 2 * pi) + i) * 6;
      ring.color = AppColors.laterite.withValues(alpha: 0.045 + (i * 0.008));
      canvas.drawCircle(origin, radius, ring);
    }

    final bar = Paint()..strokeWidth = 1;
    const rows = 28;
    for (var i = 0; i < rows; i++) {
      final y = size.height * (i / (rows - 1));
      final dist = pointer == null ? 1.0 : (y - pointer!.dy).abs() / size.height;
      final amp = (1 - dist.clamp(0, 1)) * 18 + 2;
      bar.color = AppColors.bone.withValues(alpha: 0.03 + (1 - dist) * 0.05);
      canvas.drawLine(Offset(0, y), Offset(amp + size.width * 0.08, y), bar);
      canvas.drawLine(
        Offset(size.width - amp - size.width * 0.08, y),
        Offset(size.width, y),
        bar,
      );
    }

    final tick = Paint()
      ..color = AppColors.laterite.withValues(alpha: 0.22)
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(origin.dx - 10, origin.dy),
      Offset(origin.dx + 10, origin.dy),
      tick,
    );
    canvas.drawLine(
      Offset(origin.dx, origin.dy - 10),
      Offset(origin.dx, origin.dy + 10),
      tick,
    );
  }

  @override
  bool shouldRepaint(covariant _SignalPainter oldDelegate) {
    return oldDelegate.t != t || oldDelegate.pointer != pointer;
  }
}