import 'package:flutter/material.dart';

import '../../../../../domain/models/certification.dart';
import '../../../../core/layout/page_gutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/magnetic_card.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../view_models/portfolio_view_model.dart';

class CertificationsView extends StatelessWidget {
  const CertificationsView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return PageGutter(
      child: Reveal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              tick: 'PF  PROOF',
              title: 'Paper that matters',
              lede: 'Credentials I actually use when I sit down to write software.',
            ),
            const SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.profile.certifications.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 340,
                mainAxisExtent: 180,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return Reveal(
                  delay: Duration(milliseconds: 80 * index),
                  child: MagneticCard(
                    child: _CertPlate(
                      cert: viewModel.profile.certifications[index],
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

class _CertPlate extends StatelessWidget {
  const _CertPlate({required this.cert});

  final Certification cert;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.graphite,
        border: Border.fromBorderSide(BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cert.mark,
            style: text.headlineLarge?.copyWith(
              color: AppColors.laterite,
              fontSize: 28,
            ),
          ),
          const Spacer(),
          Text(
            cert.title,
            style: text.headlineMedium?.copyWith(
              color: AppColors.bone,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          Text(cert.issuer, style: text.labelLarge?.copyWith(color: AppColors.ash)),
        ],
      ),
    );
  }
}