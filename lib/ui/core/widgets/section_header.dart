import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.tick,
    required this.title,
    this.lede,
  });

  final String tick;
  final String title;
  final String? lede;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tick,
          style: text.titleMedium?.copyWith(color: AppColors.laterite),
        ),
        const SizedBox(height: 12),
        Text(title, style: text.headlineLarge),
        if (lede != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(lede!, style: text.bodyLarge),
          ),
        ],
        const SizedBox(height: 28),
        const SizedBox(
          width: 48,
          child: Divider(color: AppColors.laterite, thickness: 1.4, height: 1),
        ),
      ],
    );
  }
}