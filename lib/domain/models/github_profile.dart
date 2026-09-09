import 'package:flutter/widgets.dart';

@immutable
class GithubProfile {
  const GithubProfile({
    required this.username,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.stars,
    this.bio,
  });

  final String username;
  final int publicRepos;
  final int followers;
  final int following;
  final int stars;
  final String? bio;
}