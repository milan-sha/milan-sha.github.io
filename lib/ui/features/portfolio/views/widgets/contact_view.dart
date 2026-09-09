import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/models/social_link.dart';
import '../../../../core/layout/breakpoints.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PageGutter(
      child: Reveal(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final stacked = Breakpoints.isCompact(constraints.maxWidth);
                final info = _Info(viewModel: viewModel);
                final form = _Form(viewModel: viewModel);

                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        tick: 'NT  NOTE',
                        title: 'Write me',
                        lede:
                            'A role, a brief, or a question. I read everything that lands.',
                      ),
                      const SizedBox(height: 36),
                      info,
                      const SizedBox(height: 36),
                      form,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(
                            tick: 'NT  NOTE',
                            title: 'Write me',
                            lede:
                                'A role, a brief, or a question. I read everything that lands.',
                          ),
                          const SizedBox(height: 36),
                          info,
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(flex: 2, child: form),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final profile = viewModel.profile;
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Line(label: 'Mail', value: profile.email),
        const SizedBox(height: 16),
        _Line(label: 'Base', value: profile.location),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          children: [
            for (final link in profile.socials)
              IconButton(
                tooltip: link.label,
                onPressed: () => viewModel.openUrl(link.url),
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.ash,
                  side: const BorderSide(color: AppColors.line),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                icon: FaIcon(_iconFor(link.kind), size: 16),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Prefer a file? Download the resume and reply from there.',
          style: text.bodyMedium,
        ),
      ],
    );
  }

  FaIconData _iconFor(SocialKind kind) {
    return switch (kind) {
      SocialKind.github => FontAwesomeIcons.github,
      SocialKind.linkedin => FontAwesomeIcons.linkedinIn,
      SocialKind.email => FontAwesomeIcons.envelope,
      SocialKind.resume => FontAwesomeIcons.fileLines,
    };
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.bone, fontSize: 18),
        ),
      ],
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        color: AppColors.graphite,
        border: Border.fromBorderSide(BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 520) {
                return Column(
                  children: [
                    _Field(
                      label: 'Name',
                      onChanged: (value) => viewModel.name = value,
                    ),
                    const SizedBox(height: 16),
                    _Field(
                      label: 'Email',
                      onChanged: (value) => viewModel.email = value,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _Field(
                      label: 'Name',
                      onChanged: (value) => viewModel.name = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _Field(
                      label: 'Email',
                      onChanged: (value) => viewModel.email = value,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          _Field(
            label: 'Subject',
            onChanged: (value) => viewModel.subject = value,
          ),
          const SizedBox(height: 16),
          _Field(
            label: 'Message',
            maxLines: 5,
            onChanged: (value) => viewModel.message = value,
          ),
          if (viewModel.formError != null) ...[
            const SizedBox(height: 16),
            Semantics(
              liveRegion: true,
              child: Text(
                viewModel.formError!,
                style: const TextStyle(color: AppColors.laterite),
              ),
            ),
          ],
          if (viewModel.formStatus != null) ...[
            const SizedBox(height: 16),
            Text(
              viewModel.formStatus!,
              style: const TextStyle(color: AppColors.ember),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: viewModel.sending ? null : viewModel.sendNote,
              child: Text(viewModel.sending ? 'Opening…' : 'Send a note'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.onChanged,
    this.maxLines = 1,
  });

  final String label;
  final ValueChanged<String> onChanged;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      style: const TextStyle(color: AppColors.bone),
      decoration: InputDecoration(labelText: label),
    );
  }
}