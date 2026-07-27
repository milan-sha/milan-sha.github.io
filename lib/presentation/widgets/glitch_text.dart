import 'dart:math';
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const GlitchText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Only glitch 10% of the time to make it look realistic
        bool isGlitching = _random.nextDouble() < 0.1;
        
        if (!isGlitching) {
          return Text(widget.text, style: widget.style);
        }

        double offsetX = (_random.nextDouble() - 0.5) * 4;
        double offsetY = (_random.nextDouble() - 0.5) * 4;

        return Stack(
          children: [
            // Cyan channel
            Transform.translate(
              offset: Offset(offsetX, offsetY),
              child: Text(
                widget.text,
                style: widget.style?.copyWith(color: Colors.cyan.withValues(alpha: 0.8)),
              ),
            ),
            // Red channel
            Transform.translate(
              offset: Offset(-offsetX, -offsetY),
              child: Text(
                widget.text,
                style: widget.style?.copyWith(color: Colors.red.withValues(alpha: 0.8)),
              ),
            ),
            // Original text
            Text(widget.text, style: widget.style),
          ],
        );
      },
    );
  }
}
