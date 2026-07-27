import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;

  const ParticleBackground({super.key, required this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();
  Offset? _pointerPosition;

  @override
  void initState() {
    super.initState();
    // Initialize 50 random particles
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(
        position: Offset(_random.nextDouble(), _random.nextDouble()),
        velocity: Offset((_random.nextDouble() - 0.5) * 0.002, (_random.nextDouble() - 0.5) * 0.002),
        size: _random.nextDouble() * 3 + 1,
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        _updateParticles();
      })..repeat();
  }

  void _updateParticles() {
    for (var particle in _particles) {
      particle.position += particle.velocity;

      // Bounce off walls
      if (particle.position.dx < 0 || particle.position.dx > 1) {
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }
      if (particle.position.dy < 0 || particle.position.dy > 1) {
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (details) {
        if (!mounted) return;
        final RenderBox box = context.findRenderObject() as RenderBox;
        setState(() {
          _pointerPosition = box.globalToLocal(details.position);
        });
      },
      onExit: (_) => setState(() => _pointerPosition = null),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlePainter(_particles, _pointerPosition),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class Particle {
  Offset position; // 0.0 to 1.0 relative
  Offset velocity;
  double size;

  Particle({required this.position, required this.velocity, required this.size});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? pointerPosition;

  ParticlePainter(this.particles, this.pointerPosition);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    for (var particle in particles) {
      final absolutePosition = Offset(
        particle.position.dx * size.width,
        particle.position.dy * size.height,
      );

      canvas.drawCircle(absolutePosition, particle.size, paint);

      // Draw lines to nearby particles
      for (var other in particles) {
        if (other == particle) continue;
        final otherAbsolute = Offset(
          other.position.dx * size.width,
          other.position.dy * size.height,
        );
        final distance = (absolutePosition - otherAbsolute).distance;
        if (distance < 100) {
          linePaint.color = AppColors.primary.withValues(alpha: (1 - distance / 100) * 0.2);
          canvas.drawLine(absolutePosition, otherAbsolute, linePaint);
        }
      }

      // Draw line to pointer if close
      if (pointerPosition != null) {
        final pointerDistance = (absolutePosition - pointerPosition!).distance;
        if (pointerDistance < 150) {
          linePaint.color = AppColors.accent.withValues(alpha: (1 - pointerDistance / 150) * 0.4);
          canvas.drawLine(absolutePosition, pointerPosition!, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
