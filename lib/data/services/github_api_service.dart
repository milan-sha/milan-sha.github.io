import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/github_user_dto.dart';

abstract class GithubApi {
  Future<GithubUserDto> fetchUser(String username);
  Future<int> fetchStarCount(String username);
}

class GithubApiService implements GithubApi {
  GithubApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _host = 'api.github.com';

  @override
  Future<GithubUserDto> fetchUser(String username) async {
    final response = await _client.get(
      Uri.https(_host, '/users/$username'),
      headers: const {'Accept': 'application/vnd.github+json'},
    );

    if (response.statusCode != 200) {
      throw GithubApiException('GitHub returned ${response.statusCode}');
    }

    return GithubUserDto.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<int> fetchStarCount(String username) async {
    final response = await _client.get(
      Uri.https(_host, '/users/$username/repos', {
        'per_page': '100',
        'type': 'owner',
      }),
      headers: const {'Accept': 'application/vnd.github+json'},
    );

    if (response.statusCode != 200) {
      throw GithubApiException('GitHub returned ${response.statusCode}');
    }

    final repos = (jsonDecode(response.body) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(GithubRepoDto.fromJson);
    return repos.fold<int>(0, (sum, repo) => sum + repo.stargazersCount);
  }
}

class GithubApiException implements Exception {
  const GithubApiException(this.message);
  final String message;

  @override
  String toString() => message;
}