import 'package:flutter/material.dart';

import '../../../../../domain/models/skill_category.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/magnetic_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PageGutter(
      child: Reveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              tick: 'RG  RANGE',
              title: 'What I keep sharp',
              lede:
                  'A workshop inventory — the tools I reach for when the brief gets real.',
            ),
            const SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.profile.skills.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 340,
                mainAxisExtent: 240,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Reveal(
                  delay: Duration(milliseconds: 70 * index),
                  child: MagneticCard(
                    child: _SkillPlate(
                      category: viewModel.profile.skills[index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillPlate extends StatelessWidget {
  const _SkillPlate({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        color: AppColors.graphite,
        border: Border.fromBorderSide(BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.mark,
            style: text.titleMedium?.copyWith(color: AppColors.laterite),
          ),
          const SizedBox(height: 10),
          Text(
            category.title,
            style: text.headlineMedium?.copyWith(color: AppColors.bone),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in category.skills)
                  Text(
                    skill,
                    style: text.labelLarge?.copyWith(color: AppColors.ash),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}