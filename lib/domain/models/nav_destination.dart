import 'package:flutter/widgets.dart';

@immutable
class NavDestination {
  const NavDestination({
    required this.id,
    required this.label,
    required this.tick,
  });

  final String id;
  final String label;
  final String tick;
}