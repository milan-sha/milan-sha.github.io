import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'breakpoints.dart';

class PageGutter extends StatelessWidget {
  const PageGutter({super.key, required this.child, this.maxWidth});

  final Widget child;
  final double? maxWidth;

  static EdgeInsets paddingFor(double width) {
    if (Breakpoints.isCompact(width)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 72);
    }
    if (Breakpoints.isMedium(width)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 88);
    }
    return const EdgeInsets.symmetric(horizontal: 48, vertical: 104);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? AppSpacing.contentMax,
            ),
            child: Padding(
              padding: paddingFor(width),
              child: child,
            ),
          ),
        );
      },
    );
  }
}