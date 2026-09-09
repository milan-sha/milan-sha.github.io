import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class GithubView extends StatelessWidget {
  const GithubView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PageGutter(
      child: Reveal(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  tick: 'SG  SIGNAL',
                  title: 'Live from GitHub',
                  lede:
                      'Public repos, stars, and the people watching the work.',
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: AppColors.graphite,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.line),
                    ),
                  ),
                  child: _body(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final text = Theme.of(context).textTheme;

    if (viewModel.githubLoading) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.laterite),
        ),
      );
    }

    if (viewModel.github == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.githubError ??
                'GitHub is quiet right now. Open the profile instead.',
            style: text.bodyLarge,
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => viewModel.openUrl(
              'https://github.com/${viewModel.profile.githubUsername}',
            ),
            child: const Text('Open GitHub'),
          ),
        ],
      );
    }

    final stats = viewModel.github!;
    return Column(
      children: [
        const FaIcon(FontAwesomeIcons.github, color: AppColors.bone, size: 36),
        const SizedBox(height: 12),
        Text(
          '@${stats.username}',
          style: text.titleMedium?.copyWith(color: AppColors.ember),
        ),
        if (stats.bio != null) ...[
          const SizedBox(height: 12),
          Text(stats.bio!, style: text.bodyMedium, textAlign: TextAlign.center),
        ],
        const SizedBox(height: 36),
        Wrap(
          spacing: 40,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: [
            _Stat(label: 'Repos', value: stats.publicRepos),
            _Stat(label: 'Stars', value: stats.stars),
            _Stat(label: 'Followers', value: stats.followers),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () =>
              viewModel.openUrl('https://github.com/${stats.username}'),
          child: const Text('Open GitHub'),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value.toDouble()),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, animated, _) {
            return Text(
              animated.round().toString(),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.bone,
                fontSize: 40,
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}