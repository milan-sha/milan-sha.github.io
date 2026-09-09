import 'package:flutter_test/flutter_test.dart';
import 'package:profile_web/data/models/github_user_dto.dart';
import 'package:profile_web/data/repositories/github_repository.dart';
import 'package:profile_web/data/services/github_api_service.dart';
import 'package:profile_web/domain/models/result.dart';

class _OkApi implements GithubApi {
  @override
  Future<GithubUserDto> fetchUser(String username) async {
    return GithubUserDto(
      login: username,
      publicRepos: 12,
      followers: 4,
      following: 2,
      bio: 'builder',
    );
  }

  @override
  Future<int> fetchStarCount(String username) async => 7;
}

class _FailApi implements GithubApi {
  @override
  Future<GithubUserDto> fetchUser(String username) async {
    throw const GithubApiException('down');
  }

  @override
  Future<int> fetchStarCount(String username) async => 0;
}

void main() {
  test('maps GitHub user and stars into a domain profile', () async {
    final repository = GithubRepository(api: _OkApi());
    final result = await repository.getProfile('milan-sha');

    expect(result, isA<Ok>());
    final profile = (result as Ok).value;
    expect(profile.username, 'milan-sha');
    expect(profile.publicRepos, 12);
    expect(profile.stars, 7);
    expect(profile.bio, 'builder');
  });

  test('returns a usable error when GitHub fails', () async {
    final repository = GithubRepository(api: _FailApi());
    final result = await repository.getProfile('milan-sha');

    expect(result, isA<Err>());
    expect((result as Err).message, contains('GitHub is quiet'));
  });

  test('caches the first successful profile', () async {
    final repository = GithubRepository(api: _OkApi());
    final first = await repository.getProfile('milan-sha');
    final second = await repository.getProfile('milan-sha');

    expect(identical((first as Ok).value, (second as Ok).value), isTrue);
  });
}