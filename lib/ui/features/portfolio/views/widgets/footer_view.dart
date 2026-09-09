import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../view_models/portfolio_view_model.dart';

class FooterView extends StatelessWidget {
  const FooterView({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: [
          Text(
            '© ${DateTime.now().year} ${viewModel.profile.name}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.ash,
            ),
          ),
          Text(
            'Flutter web  ·  laterite signal',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.ash,
            ),
          ),
        ],
      ),
    );
  }
}