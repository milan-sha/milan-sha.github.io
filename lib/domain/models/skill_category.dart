import 'package:flutter/widgets.dart';

@immutable
class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.mark,
    required this.skills,
  });

  final String title;
  final String mark;
  final List<String> skills;
}