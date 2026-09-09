class GithubUserDto {
  const GithubUserDto({
    required this.login,
    required this.publicRepos,
    required this.followers,
    required this.following,
    this.bio,
  });

  final String login;
  final int publicRepos;
  final int followers;
  final int following;
  final String? bio;

  factory GithubUserDto.fromJson(Map<String, dynamic> json) {
    return GithubUserDto(
      login: json['login'] as String? ?? '',
      publicRepos: json['public_repos'] as int? ?? 0,
      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
      bio: json['bio'] as String?,
    );
  }
}

class GithubRepoDto {
  const GithubRepoDto({required this.stargazersCount});

  final int stargazersCount;

  factory GithubRepoDto.fromJson(Map<String, dynamic> json) {
    return GithubRepoDto(
      stargazersCount: json['stargazers_count'] as int? ?? 0,
    );
  }
}