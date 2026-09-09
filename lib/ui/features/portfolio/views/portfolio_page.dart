import 'package:flutter/material.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/widgets/signal_field.dart';
import '../view_models/portfolio_view_model.dart';
import 'widgets/about_view.dart';
import 'widgets/certifications_view.dart';
import 'widgets/contact_view.dart';
import 'widgets/footer_view.dart';
import 'widgets/github_view.dart';
import 'widgets/hero_view.dart';
import 'widgets/projects_view.dart';
import 'widgets/site_nav.dart';
import 'widgets/skills_view.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, required this.viewModel});

  final PortfolioViewModel viewModel;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();
  final _keys = <String, GlobalKey>{
    'intro': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'work': GlobalKey(),
    'proof': GlobalKey(),
    'signal': GlobalKey(),
    'note': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    widget.viewModel.load();
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    String? current;
    for (final entry in _keys.entries) {
      final context = entry.value.currentContext;
      if (context == null) continue;
      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final offset = box.localToGlobal(Offset.zero).dy;
      if (offset < 220) current = entry.key;
    }
    if (current != null) widget.viewModel.setActiveSection(current);
  }

  Future<void> _scrollTo(String id) async {
    final key = _keys[id];
    final target = key?.currentContext;
    if (target == null) return;
    widget.viewModel.setActiveSection(id);
    await Scrollable.ensureVisible(
      target,
      duration: const Duration(milliseconds: 720),
      curve: Curves.easeInOutCubic,
      alignment: 0.08,
    );
  }

  void _openMenu() {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: true,
        pageBuilder: (context, animation, secondary) {
          return FadeTransition(
            opacity: animation,
            child: SiteMenu(viewModel: widget.viewModel, onSelect: _scrollTo),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return SectionShortcuts(
      destinations: vm.profile.destinations,
      onSelect: _scrollTo,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final expanded = Breakpoints.isExpanded(constraints.maxWidth);
            final content = _Content(
              keys: _keys,
              viewModel: vm,
              controller: _scroll,
              onSeeWork: () => _scrollTo('work'),
            );

            if (expanded) {
              return Row(
                children: [
                  SiteRail(viewModel: vm, onSelect: _scrollTo),
                  Expanded(child: content),
                ],
              );
            }

            return Column(
              children: [
                SiteTopBar(
                  viewModel: vm,
                  onOpenMenu: _openMenu,
                ),
                Expanded(child: content),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.keys,
    required this.viewModel,
    required this.controller,
    required this.onSeeWork,
  });

  final Map<String, GlobalKey> keys;
  final PortfolioViewModel viewModel;
  final ScrollController controller;
  final VoidCallback onSeeWork;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: SignalField()),
        Positioned.fill(
          child: CustomScrollView(
            controller: controller,
            slivers: [
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['intro'],
                  child: HeroView(viewModel: viewModel, onSeeWork: onSeeWork),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['about'],
                  child: AboutView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['skills'],
                  child: SkillsView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['work'],
                  child: ProjectsView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['proof'],
                  child: CertificationsView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['signal'],
                  child: GithubView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: keys['note'],
                  child: ContactView(viewModel: viewModel),
                ),
              ),
              SliverToBoxAdapter(child: FooterView(viewModel: viewModel)),
            ],
          ),
        ),
      ],
    );
  }
}