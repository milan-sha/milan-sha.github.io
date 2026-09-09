import 'package:flutter/material.dart';

import '../../../../core/layout/breakpoints.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/portrait_plate.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final profile = viewModel.profile;

    return PageGutter(
      child: Reveal(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = Breakpoints.isCompact(constraints.maxWidth);
            final copy = _Copy(viewModel: viewModel);
            final portrait = PortraitPlate(
              asset: profile.portraitAsset,
              caption: '${profile.shortName}  ·  ${profile.location.toUpperCase()}  ·  LOCK',
            );

            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    tick: 'AB  ABOUT',
                    title: 'The workbench',
                    lede:
                        'A builder in Ernakulam. Flutter, .NET, and a habit of listening for weak signals.',
                  ),
                  const SizedBox(height: 36),
                  portrait,
                  const SizedBox(height: 36),
                  copy,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        tick: 'AB  ABOUT',
                        title: 'The workbench',
                        lede:
                            'A builder in Ernakulam. Flutter, .NET, and a habit of listening for weak signals.',
                      ),
                      const SizedBox(height: 36),
                      copy,
                    ],
                  ),
                ),
                const SizedBox(width: 56),
                Expanded(flex: 4, child: portrait),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final profile = viewModel.profile;
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.aboutLead,
          style: text.headlineMedium?.copyWith(color: AppColors.bone),
        ),
        const SizedBox(height: 24),
        for (final paragraph in profile.aboutBody) ...[
          Text(paragraph, style: text.bodyLarge),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}