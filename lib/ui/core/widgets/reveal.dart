import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 18,
  });

  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);

    return VisibilityDetector(
      key: Key('reveal-${identityHashCode(this)}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: reduce
          ? widget.child
          : widget.child
                .animate(target: _visible ? 1 : 0)
                .fadeIn(duration: 700.ms, delay: widget.delay)
                .moveY(
                  begin: widget.offset,
                  end: 0,
                  duration: 800.ms,
                  delay: widget.delay,
                  curve: Curves.easeOutCubic,
                ),
    );
  }
}