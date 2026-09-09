import 'package:flutter/widgets.dart';

@immutable
class SocialLink {
  const SocialLink({
    required this.label,
    required this.url,
    required this.kind,
  });

  final String label;
  final String url;
  final SocialKind kind;
}

enum SocialKind { github, linkedin, email, resume }