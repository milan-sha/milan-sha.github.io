import 'package:flutter/widgets.dart';

@immutable
class Project {
  const Project({
    required this.title,
    required this.category,
    required this.summary,
    required this.stack,
    this.href,
  });

  final String title;
  final String category;
  final String summary;
  final List<String> stack;
  final String? href;
}