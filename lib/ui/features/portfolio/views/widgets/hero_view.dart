import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../domain/models/social_link.dart';
import '../../../../core/layout/breakpoints.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/portrait_plate.dart';
import '../../view_models/portfolio_view_model.dart';

class HeroView extends StatelessWidget {
  const HeroView({
    super.key,
    required this.viewModel,
    required this.onSeeWork,
  });

  final PortfolioViewModel viewModel;
  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = Breakpoints.isCompact(constraints.maxWidth);
        final profile = viewModel.profile;
        final text = Theme.of(context).textTheme;
        final reduce = MediaQuery.disableAnimationsOf(context);

        final minHeight = MediaQuery.sizeOf(context).height * (compact ? 0.72 : 0.82);

        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${profile.location.toUpperCase()}  ·  CEH',
              style: text.titleMedium?.copyWith(color: AppColors.laterite),
            ),
            const SizedBox(height: 28),
            Text(
              profile.name,
              style: compact ? text.displayMedium : text.displayLarge,
            ),
            const SizedBox(height: 18),
            _LockBar(reduce: reduce),
            const SizedBox(height: 28),
            ExcludeSemantics(
              child: SizedBox(
                height: compact ? 28 : 34,
                child: DefaultTextStyle(
                  style: GoogleFonts.ibmPlexMono(
                    color: AppColors.ember,
                    fontSize: compact ? 18 : 22,
                    fontWeight: FontWeight.w500,
                  ),
                  child: reduce
                      ? Text(profile.roles.first)
                      : IgnorePointer(
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1200),
                            animatedTexts: [
                              for (final role in profile.roles)
                                TypewriterAnimatedText(
                                  role,
                                  speed: const Duration(milliseconds: 42),
                                ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(profile.thesis, style: text.bodyLarge),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onSeeWork,
                  child: const Text('See the work'),
                ),
                OutlinedButton(
                  onPressed: viewModel.openResume,
                  child: const Text('Download resume'),
                ),
                for (final link in profile.socials)
                  _SocialDot(
                    link: link,
                    onTap: () => viewModel.openUrl(link.url),
                  ),
              ],
            ),
          ],
        );

        final plate = PortraitPlate(
          asset: profile.portraitAsset,
          caption: 'MS  ·  SIGNAL LOCK',
          aspectRatio: 4 / 5,
        );

        return PageGutter(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: compact
                ? copy
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 7, child: copy),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 4,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 360),
                          child: plate,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _LockBar extends StatelessWidget {
  const _LockBar({required this.reduce});

  final bool reduce;

  @override
  Widget build(BuildContext context) {
    final bar = Container(height: 2, color: AppColors.laterite);

    if (reduce) {
      return SizedBox(width: 120, child: bar);
    }

    return bar
        .animate()
        .scaleX(
          begin: 0,
          end: 1,
          alignment: Alignment.centerLeft,
          duration: 900.ms,
          delay: 280.ms,
          curve: Curves.easeOutCubic,
        )
        .custom(
          duration: 900.ms,
          delay: 280.ms,
          builder: (context, value, child) {
            return SizedBox(width: 40 + (value * 88), child: child);
          },
        );
  }
}

class _SocialDot extends StatelessWidget {
  const _SocialDot({required this.link, required this.onTap});

  final SocialLink link;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: link.label,
      onPressed: onTap,
      style: IconButton.styleFrom(
        foregroundColor: AppColors.ash,
        side: const BorderSide(color: AppColors.line),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        minimumSize: const Size(48, 48),
      ),
      icon: FaIcon(_iconFor(link.kind), size: 16),
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