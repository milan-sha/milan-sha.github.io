import '../../domain/models/github_profile.dart';
import '../../domain/models/result.dart';
import '../services/github_api_service.dart';

class GithubRepository {
  GithubRepository({required GithubApi api}) : _api = api;

  final GithubApi _api;
  GithubProfile? _cache;

  Future<Result<GithubProfile>> getProfile(String username) async {
    if (_cache != null) return Ok(_cache!);

    try {
      final user = await _api.fetchUser(username);
      var stars = 0;
      try {
        stars = await _api.fetchStarCount(username);
      } catch (_) {
        stars = 0;
      }

      _cache = GithubProfile(
        username: user.login,
        publicRepos: user.publicRepos,
        followers: user.followers,
        following: user.following,
        stars: stars,
        bio: user.bio,
      );
      return Ok(_cache!);
    } catch (error) {
      return Err('GitHub is quiet right now. Open the profile instead.');
    }
  }
}