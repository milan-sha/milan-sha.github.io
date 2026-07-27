import 'package:flutter/material.dart';

class Hover3dCard extends StatefulWidget {
  final Widget child;
  final double depth;

  const Hover3dCard({
    super.key,
    required this.child,
    this.depth = 15.0,
  });

  @override
  State<Hover3dCard> createState() => _Hover3dCardState();
}

class _Hover3dCardState extends State<Hover3dCard> {
  double _x = 0;
  double _y = 0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _x = 0;
        _y = 0;
      }),
      onHover: (details) {
        if (!mounted) return;
        final RenderBox box = context.findRenderObject() as RenderBox;
        final size = box.size;
        final localPosition = box.globalToLocal(details.position);

        setState(() {
          // Calculate rotation based on pointer position relative to center
          // Values will be between -1.0 and 1.0
          _x = (localPosition.dx - size.width / 2) / (size.width / 2);
          _y = (localPosition.dy - size.height / 2) / (size.height / 2);
        });
      },
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        tween: Tween<double>(begin: 0, end: _isHovered ? 1.0 : 0.0),
        builder: (context, value, child) {
          // When hovered, rotate based on _x and _y.
          // We invert _y for the X axis rotation so that moving up tilts the top back.
          final matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateX(-_y * (widget.depth / 100) * value)
            ..rotateY(_x * (widget.depth / 100) * value);

          // Add a subtle scale effect
          // ignore: deprecated_member_use
          matrix.scale(1.0 + (0.02 * value));

          return Transform(
            alignment: FractionalOffset.center,
            transform: matrix,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
