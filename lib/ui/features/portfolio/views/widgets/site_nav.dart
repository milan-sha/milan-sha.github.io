import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../domain/models/nav_destination.dart';
import '../../../../core/theme/app_colors.dart';
import '../../view_models/portfolio_view_model.dart';

class SiteRail extends StatelessWidget {
  const SiteRail({
    super.key,
    required this.viewModel,
    required this.onSelect,
  });

  final PortfolioViewModel viewModel;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Container(
          width: 220,
          padding: const EdgeInsets.fromLTRB(28, 36, 20, 28),
          decoration: const BoxDecoration(
            color: AppColors.night,
            border: Border(right: BorderSide(color: AppColors.line)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (final item in viewModel.profile.destinations)
                      _RailItem(
                        item: item,
                        active: viewModel.activeSection == item.id,
                        onPressed: () => onSelect(item.id),
                      ),
                  ],
                ),
              ),
              Text(
                viewModel.profile.location.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RailItem extends StatefulWidget {
  const _RailItem({
    required this.item,
    required this.active,
    required this.onPressed,
  });

  final NavDestination item;
  final bool active;
  final VoidCallback onPressed;

  @override
  State<_RailItem> createState() => _RailItemState();
}

class _RailItemState extends State<_RailItem> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowFocusHighlight: (show) => setState(() => _focused = show),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onPressed();
            return null;
          },
        ),
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: InkWell(
          onTap: widget.onPressed,
          hoverColor: AppColors.laterite.withValues(alpha: 0.06),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: widget.active || _focused
                      ? AppColors.laterite
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Text(
                    widget.item.tick,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: widget.active
                          ? AppColors.laterite
                          : AppColors.ash,
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  widget.item.label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: widget.active ? AppColors.bone : AppColors.ash,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SiteTopBar extends StatelessWidget {
  const SiteTopBar({
    super.key,
    required this.viewModel,
    required this.onOpenMenu,
  });

  final PortfolioViewModel viewModel;
  final VoidCallback onOpenMenu;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.night.withValues(alpha: 0.92),
            border: const Border(bottom: BorderSide(color: AppColors.line)),
          ),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                tooltip: 'Open sections',
                onPressed: onOpenMenu,
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.bone,
                  side: const BorderSide(color: AppColors.line),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  minimumSize: const Size(44, 44),
                ),
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SiteMenu extends StatelessWidget {
  const SiteMenu({
    super.key,
    required this.viewModel,
    required this.onSelect,
  });

  final PortfolioViewModel viewModel;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Material(
          color: AppColors.graphite,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.bone),
                  ),
                ),
                for (final item in viewModel.profile.destinations)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        final id = item.id;
                        Navigator.of(context).pop();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          onSelect(id);
                        });
                      },
                      child: Text(
                        '${item.tick}   ${item.label}',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: viewModel.activeSection == item.id
                                  ? AppColors.laterite
                                  : AppColors.bone,
                            ),
                      ),
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

class SectionShortcuts extends StatelessWidget {
  const SectionShortcuts({
    super.key,
    required this.child,
    required this.destinations,
    required this.onSelect,
  });

  final Widget child;
  final List<NavDestination> destinations;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    const digits = [
      LogicalKeyboardKey.digit1,
      LogicalKeyboardKey.digit2,
      LogicalKeyboardKey.digit3,
      LogicalKeyboardKey.digit4,
      LogicalKeyboardKey.digit5,
      LogicalKeyboardKey.digit6,
      LogicalKeyboardKey.digit7,
      LogicalKeyboardKey.digit8,
      LogicalKeyboardKey.digit9,
    ];

    return CallbackShortcuts(
      bindings: {
        for (var i = 0; i < destinations.length && i < digits.length; i++)
          SingleActivator(digits[i]): () => onSelect(destinations[i].id),
      },
      child: Focus(autofocus: true, child: child),
    );
  }
}