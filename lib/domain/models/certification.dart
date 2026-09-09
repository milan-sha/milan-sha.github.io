import 'package:flutter/widgets.dart';

@immutable
class Certification {
  const Certification({
    required this.title,
    required this.issuer,
    required this.mark,
  });

  final String title;
  final String issuer;
  final String mark;
}