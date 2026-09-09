import 'package:flutter/material.dart';

import '../../../../../domain/models/project.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/magnetic_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PageGutter(
      child: Reveal(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final projects = viewModel.visibleProjects;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  tick: 'WK  WORK',
                  title: 'Built, then tested',
                  lede:
                      'Products, utilities, and one experiment that listens to a room through radio.',
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final category in viewModel.profile.projectCategories)
                      _FilterChip(
                        label: category,
                        selected: viewModel.projectFilter == category,
                        onTap: () => viewModel.setProjectFilter(category),
                      ),
                  ],
                ),
                const SizedBox(height: 36),
                if (projects.isEmpty)
                  Text(
                    'Nothing in this drawer. Try another filter.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 520,
                          mainAxisExtent: 280,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemBuilder: (context, index) {
                      return Reveal(
                        delay: Duration(milliseconds: 80 * index),
                        child: MagneticCard(
                          child: _ProjectPlate(
                            project: projects[index],
                            onOpen: projects[index].href == null
                                ? null
                                : () =>
                                      viewModel.openUrl(projects[index].href!),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? AppColors.laterite : Colors.transparent,
        foregroundColor: selected ? AppColors.bone : AppColors.ash,
        side: BorderSide(
          color: selected ? AppColors.laterite : AppColors.line,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _ProjectPlate extends StatelessWidget {
  const _ProjectPlate({required this.project, this.onOpen});

  final Project project;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        color: AppColors.graphite,
        border: Border.fromBorderSide(BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.category.toUpperCase(),
            style: text.titleMedium?.copyWith(color: AppColors.laterite),
          ),
          const SizedBox(height: 12),
          Text(
            project.title,
            style: text.headlineMedium?.copyWith(color: AppColors.bone),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(project.summary, style: text.bodyMedium),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    for (final item in project.stack)
                      Text(item, style: text.labelLarge),
                  ],
                ),
              ),
              if (onOpen != null)
                TextButton(onPressed: onOpen, child: const Text('Open')),
            ],
          ),
        ],
      ),
    );
  }
}