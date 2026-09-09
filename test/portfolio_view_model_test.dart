import 'package:flutter_test/flutter_test.dart';
import 'package:profile_web/data/models/github_user_dto.dart';
import 'package:profile_web/data/repositories/github_repository.dart';
import 'package:profile_web/data/repositories/profile_repository.dart';
import 'package:profile_web/data/services/github_api_service.dart';
import 'package:profile_web/data/services/url_launch_service.dart';
import 'package:profile_web/ui/features/portfolio/view_models/portfolio_view_model.dart';

class _OkApi implements GithubApi {
  @override
  Future<GithubUserDto> fetchUser(String username) async {
    return GithubUserDto(
      login: username,
      publicRepos: 9,
      followers: 3,
      following: 1,
    );
  }

  @override
  Future<int> fetchStarCount(String username) async => 5;
}

class _FailApi implements GithubApi {
  @override
  Future<GithubUserDto> fetchUser(String username) async {
    throw const GithubApiException('down');
  }

  @override
  Future<int> fetchStarCount(String username) async => 0;
}

class _FakeUrls extends UrlLaunchService {
  String? opened;
  Map<String, String>? lastMail;

  @override
  Future<bool> open(String url) async {
    opened = url;
    return true;
  }

  @override
  Future<bool> mail({
    required String to,
    required String subject,
    required String body,
  }) async {
    lastMail = {'to': to, 'subject': subject, 'body': body};
    return true;
  }
}

PortfolioViewModel _vm({GithubApi? api, UrlLaunchService? urls}) {
  return PortfolioViewModel(
    profileRepository: const ProfileRepository(),
    githubRepository: GithubRepository(api: api ?? _OkApi()),
    urlLaunchService: urls ?? _FakeUrls(),
  );
}

void main() {
  test('load hydrates GitHub stats', () async {
    final vm = _vm();
    await vm.load();

    expect(vm.githubLoading, isFalse);
    expect(vm.github?.publicRepos, 9);
    expect(vm.github?.stars, 5);
    expect(vm.githubError, isNull);
  });

  test('load records a quiet GitHub error', () async {
    final vm = _vm(api: _FailApi());
    await vm.load();

    expect(vm.github, isNull);
    expect(vm.githubError, contains('GitHub is quiet'));
  });

  test('project filter narrows visible work', () {
    final vm = _vm();
    vm.setProjectFilter('Security');

    expect(vm.projectFilter, 'Security');
    expect(vm.visibleProjects, isNotEmpty);
    expect(
      vm.visibleProjects.every((project) => project.category == 'Security'),
      isTrue,
    );
  });

  test('sendNote validates before opening mail', () async {
    final urls = _FakeUrls();
    final vm = _vm(urls: urls);

    await vm.sendNote();
    expect(vm.formError, 'Add your name.');
    expect(urls.lastMail, isNull);

    vm
      ..name = 'Ada'
      ..email = 'ada@example.com'
      ..subject = 'Hello'
      ..message = 'Want to talk.';

    await vm.sendNote();
    expect(vm.formError, isNull);
    expect(urls.lastMail?['to'], 'milanshamon@gmail.com');
    expect(urls.lastMail?['subject'], 'Hello');
    expect(vm.formStatus, 'Opening your mail app.');
  });
}