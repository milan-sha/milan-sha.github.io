import 'package:flutter/material.dart';

class MagneticCard extends StatefulWidget {
  const MagneticCard({super.key, required this.child, this.strength = 6});

  final Widget child;
  final double strength;

  @override
  State<MagneticCard> createState() => _MagneticCardState();
}

class _MagneticCardState extends State<MagneticCard> {
  Offset _shift = Offset.zero;
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() {
        _hover = false;
        _shift = Offset.zero;
      }),
      onHover: (event) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final local = box.globalToLocal(event.position);
        final dx = ((local.dx / box.size.width) - 0.5) * widget.strength;
        final dy = ((local.dy / box.size.height) - 0.5) * widget.strength;
        setState(() => _shift = Offset(dx, dy));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(_shift.dx, _shift.dy, 0, 1)
          ..multiply(
            Matrix4.diagonal3Values(
              _hover ? 1.012 : 1.0,
              _hover ? 1.012 : 1.0,
              1,
            ),
          ),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}